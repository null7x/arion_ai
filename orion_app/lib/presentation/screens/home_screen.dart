import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';
import '../../core/providers/connectivity_provider.dart';
import '../widgets/bottom_navigation_widget.dart';
import '../widgets/webview_loading_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late WebViewController _webViewController;
  int _selectedIndex = 0;
  bool _webError = false;
  String _webErrorDescription = '';

  @override
  void initState() {
    super.initState();
    _initWebView();
  }

  void _initWebView() {
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setUserAgent("ArionAI-Mobile/1.0 (WebView)")
      ..clearCache()
      ..addJavaScriptChannel(
        'ArionAI',
        onMessageReceived: (JavaScriptMessage message) {
          _handleJSMessage(message.message);
        },
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            // Page loading started
            if (_webError) {
              setState(() {
                _webError = false;
                _webErrorDescription = '';
              });
            }
          },
          onPageFinished: (url) {
            _injectionJavaScriptBridge();
          },
          onWebResourceError: (error) async {
            // Пытаемся fallback на index.html
            try {
              await _webViewController.loadRequest(
                _freshIndexUrl(),
                headers: {
                  'Cache-Control': 'no-cache, no-store, must-revalidate',
                  'Pragma': 'no-cache',
                  'Expires': '0',
                },
              );
            } catch (_) {
              setState(() {
                _webError = true;
                _webErrorDescription = error.description;
              });
            }
          },
          onNavigationRequest: (request) {
            // Allow all navigation
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        _freshUrl(),
        headers: {
          'Cache-Control': 'no-cache, no-store, must-revalidate',
          'Pragma': 'no-cache',
          'Expires': '0',
        },
      );
  }

  Uri _freshUrl() {
    final base = AppConstants.websiteUrl.endsWith('/')
        ? AppConstants.websiteUrl
        : '${AppConstants.websiteUrl}/';
    final ts = DateTime.now().millisecondsSinceEpoch;
    return Uri.parse('${base}?_ts=${ts}');
  }

  Uri _freshIndexUrl() {
    final base = AppConstants.websiteUrl.endsWith('/')
        ? AppConstants.websiteUrl
        : '${AppConstants.websiteUrl}/';
    final ts = DateTime.now().millisecondsSinceEpoch;
    return Uri.parse('${base}index.html?_ts=${ts}');
  }

  /// Инжектируем JavaScript bridge и CSS для мобильной оптимизации
  Future<void> _injectionJavaScriptBridge() async {
    await _webViewController.runJavaScript('''
      // Мобильная оптимизация - улучшение отображения текста
      const style = document.createElement('style');
      style.textContent = `
        * {
          box-sizing: border-box;
        }
        body {
          word-wrap: break-word;
          overflow-wrap: break-word;
          font-size: 16px;
          line-height: 1.5;
        }
        p, span, div, h1, h2, h3, h4, h5, h6 {
          max-width: 100%;
          word-break: break-word;
          word-wrap: break-word;
          white-space: normal;
          overflow-wrap: break-word;
        }
        pre, code {
          white-space: pre-wrap;
          word-break: break-word;
        }
        img {
          max-width: 100%;
          height: auto;
          display: block;
        }
        textarea, input {
          max-width: 100%;
          width: 100%;
        }
      `;
      document.head.appendChild(style);
      
      // ArionAI Bridge
      window.ArionAI = window.ArionAI || {};
      
      // Bridge для отправки сообщений на Flutter
      window.ArionAI.sendMessageToFlutter = function(message, data) {
        console.log('Sending to Flutter:', message, data);
        window.ArionAI.postMessage(JSON.stringify({ message, data }));
      };
      
      // Функция для правильного POST запроса к /chat endpoint
      window.ArionAI.sendChat = async function(message) {
        try {
          const response = await fetch('/chat', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: JSON.stringify({
              message: message,
              timestamp: new Date().toISOString(),
              client: 'mobile_app'
            })
          });
          
          if (!response.ok) {
            console.error('Chat API error:', response.status, response.statusText);
            return { success: false, status: response.status };
          }
          
          const data = await response.json();
          return { success: true, data: data };
        } catch(error) {
          console.error('Chat fetch error:', error);
          return { success: false, error: error.message };
        }
      };
      
      console.log('ArionAI Bridge initialized with mobile optimization');
    ''');
  }

  void _handleJSMessage(String message) {
    debugPrint('JS Message: $message');
    try {
      // Обработка сообщений от JavaScript
      // Можно добавить логику для различных типов сообщений
    } catch (e) {
      debugPrint('Error handling JS message: $e');
    }
  }

  void _onNavigationItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // Home - already here
        break;
      case 1:
        context.push('/profile');
        break;
      case 2:
        context.push('/settings');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final connectivityProvider = context.watch<ConnectivityProvider>();

    if (!connectivityProvider.isConnected) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.wifi_off, size: 64, color: AppColors.neonPurple),
              SizedBox(height: 16),
              Text(
                'No Internet Connection',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 8),
              Text(
                'Please check your connection',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => setState(() {}),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Arion AI'),
        elevation: 0,
        actions: [
          // Кнопки управления WebView
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'reload') {
                _webViewController.clearCache();
                _webViewController.loadRequest(
                  _freshUrl(),
                  headers: {
                    'Cache-Control': 'no-cache, no-store, must-revalidate',
                    'Pragma': 'no-cache',
                    'Expires': '0',
                  },
                );
              } else if (value == 'back') {
                _webViewController.goBack();
              } else if (value == 'forward') {
                _webViewController.goForward();
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(value: 'back', child: Text('Back')),
              PopupMenuItem(value: 'forward', child: Text('Forward')),
              PopupMenuItem(value: 'reload', child: Text('Reload')),
            ],
          ),
        ],
      ),
      body: Stack(
        children: [
          if (!_webError)
            WebViewWidget(controller: _webViewController)
          else
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.cloud_off, size: 72, color: AppColors.neonBlue),
                    const SizedBox(height: 16),
                    Text(
                      'Не удалось загрузить страницу',
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _webErrorDescription.isEmpty ? 'Ошибка загрузки. Попробуйте обновить.' : _webErrorDescription,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _webError = false;
                          _webErrorDescription = '';
                        });
                        _webViewController.clearCache();
                        _webViewController.loadRequest(
                          _freshUrl(),
                          headers: {
                            'Cache-Control': 'no-cache, no-store, must-revalidate',
                            'Pragma': 'no-cache',
                            'Expires': '0',
                          },
                        );
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Повторить'),
                    ),
                  ],
                ),
              ),
            ),
          
          // Loading Indicator
          WebViewLoadingIndicator(),
        ],
      ),
      bottomNavigationBar: BottomNavigationWidget(
        currentIndex: _selectedIndex,
        onTap: _onNavigationItemTapped,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
