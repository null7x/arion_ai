import 'package:flutter/material.dart';

/// API и URL константы
class AppConstants {
  // API Configuration
  static const String baseUrl = 'https://arion-ai.onrender.com/';
  static const String websiteUrl = 'https://arion-ai.onrender.com/';
  static const Duration apiTimeout = Duration(seconds: 30);
  
  // API Endpoints
  static const String chatEndpoint = '/chat';
  static const String apiChatEndpoint = '/api/chat';
  
  // Cache Keys
  static const String cacheKeyUserData = 'user_data';
  static const String cacheKeyThemeMode = 'theme_mode';
  static const String cacheKeyCookies = 'cookies';
  
  // WebView Configuration
  static const bool webViewJavaScriptEnabled = true;
  static const bool webViewDomStorageEnabled = true;
  static const bool webViewCacheEnabled = true;
  static const bool webViewCookiesEnabled = true;
  
  // App Information
  static const String appName = 'Arion AI';
  static const String appVersion = '1.0.0';
  static const String appBuildNumber = '1';
  
  // Timeouts
  static const Duration splashScreenDuration = Duration(seconds: 2);
  static const Duration webViewLoadTimeout = Duration(seconds: 30);
}

/// Цветовая палитра для минималистичного дизайна с неоновыми элементами
class AppColors {
  // Light Theme
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightSurface = Color(0xFFF5F5F5);
  static const Color lightText = Color(0xFF1A1A1A);
  static const Color lightTextSecondary = Color(0xFF666666);
  
  // Dark Theme
  static const Color darkBackground = Color(0xFF0A0E27);
  static const Color darkSurface = Color(0xFF151932);
  static const Color darkText = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFB0B0B0);
  
  // Neon/Aurora Colors
  static const Color neonCyan = Color(0xFF00D9FF);
  static const Color neonPurple = Color(0xFF9D4EDD);
  static const Color neonPink = Color(0xFFFF006E);
  static const Color neonBlue = Color(0xFF3A86FF);
  static const Color neonGreen = Color(0xFF00F77D);
  
  // Aurora Borealis
  static const Color auroraGreen = Color(0xFF00FF88);
  static const Color auroraBlue = Color(0xFF0088FF);
  static const Color auroraPurple = Color(0xFF8800FF);
  
  // Neutral
  static const Color transparent = Colors.transparent;
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey = Color(0xFF808080);
  static const Color lightGrey = Color(0xFFE0E0E0);
  static const Color darkGrey = Color(0xFF303030);
  
  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFFF6B6B);
  static const Color warning = Color(0xFFFFB74D);
  static const Color info = Color(0xFF2196F3);
  
  // Gradient Colors
  static const List<Color> neonGradient = [neonCyan, neonPurple, neonPink];
  static const List<Color> auroraGradient = [auroraGreen, auroraBlue, auroraPurple];
}

/// Typography Constants
class AppTypography {
  static const String fontFamily = 'Roboto';
  
  // Font Sizes
  static const double h1 = 32.0;
  static const double h2 = 28.0;
  static const double h3 = 24.0;
  static const double h4 = 20.0;
  static const double h5 = 18.0;
  static const double h6 = 16.0;
  static const double body = 14.0;
  static const double caption = 12.0;
  static const double tiny = 10.0;
  
  // Font Weights
  static const FontWeight thin = FontWeight.w100;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semibold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extrabold = FontWeight.w800;
}

/// Размеры и Spacing
class AppSizes {
  // Padding & Margins
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  
  // Border Radius
  static const double radiusSmall = 4.0;
  static const double radiusMedium = 8.0;
  static const double radiusLarge = 16.0;
  static const double radiusXLarge = 24.0;
  static const double radiusCircle = 50.0;
  
  // Icon Sizes
  static const double iconSmall = 16.0;
  static const double iconMedium = 24.0;
  static const double iconLarge = 32.0;
  static const double iconXLarge = 48.0;
  
  // Button Sizes
  static const double buttonHeightSmall = 36.0;
  static const double buttonHeightMedium = 44.0;
  static const double buttonHeightLarge = 52.0;
  
  // Navigation Bar
  static const double bottomNavHeight = 64.0;
  
  // Shadows
  static const BoxShadow shadowSmall = BoxShadow(
    color: Color(0x0D000000),
    blurRadius: 4.0,
    offset: Offset(0, 2),
  );
  
  static const BoxShadow shadowMedium = BoxShadow(
    color: Color(0x1A000000),
    blurRadius: 8.0,
    offset: Offset(0, 4),
  );
  
  static const BoxShadow shadowLarge = BoxShadow(
    color: Color(0x26000000),
    blurRadius: 16.0,
    offset: Offset(0, 8),
  );
}
