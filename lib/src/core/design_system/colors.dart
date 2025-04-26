import 'package:flutter/material.dart';

class AppColors {
  // Primary Brand Colors
  static const Color primaryMain = Color(0xFF2563EB); // Default primary
  static const Color primaryLight = Color(0xFF42A5F5); // Light mode
  static const Color primaryDark = Color(0xFF1565C0); // Dark mode

  // Secondary Brand Colors
  static const Color secondary = Color(0xFF26A69A); // Default secondary
  static const Color secondaryLight = Color(0xFF4DB6AC); // Light mode
  static const Color secondaryDark = Color(0xFF00897B); // Dark mode

  // Semantic Colors
  static const Color success = Color(0xFF43A047);
  static const Color warning = Color(0xFFFFA000);
  static const Color error = Color(0xFFD32F2F);
  static const Color info = Color(0xFF1976D2);

  // Neutral Colors (Light Mode)
  static const Color neutral0 = Color(0xFFFFFFFF); // White
  static const Color neutral50 = Color(0xFFFAFAFA);
  static const Color neutral100 = Color(0xFFF5F5F5);
  static const Color neutral200 = Color(0xFFEEEEEE);
  static const Color neutral300 = Color(0xFFE0E0E0);
  static const Color neutral400 = Color(0xFFBDBDBD);
  static const Color neutral500 = Color(0xFF9E9E9E);
  static const Color neutral600 = Color(0xFF757575);
  static const Color neutral700 = Color(0xFF616161);
  static const Color neutral800 = Color(0xFF424242);
  static const Color neutral900 = Color(0xFF212121);
  static const Color neutral1000 = Color(0xFF000000); // Black

  // Neutral Colors (Dark Mode)
  static const Color darkNeutral0 = Color(0xFF121212); // Dark gray
  static const Color darkNeutral50 = Color(0xFF1E1E1E);
  static const Color darkNeutral100 = Color(0xFF222222);
  static const Color darkNeutral200 = Color(0xFF242424);
  static const Color darkNeutral300 = Color(0xFF272727);
  static const Color darkNeutral400 = Color(0xFF2C2C2C);
  static const Color darkNeutral500 = Color(0xFF2F2F2F);
  static const Color darkNeutral600 = Color(0xFF333333);
  static const Color darkNeutral700 = Color(0xFF373737);
  static const Color darkNeutral800 = Color(0xFF3B3B3B);
  static const Color darkNeutral900 = Color(0xFF424242);
  static const Color darkNeutral1000 = Color(0xFFFFFFFF); // White

  // Text Colors (Light Mode)
  static const Color lightTextPrimary = neutral900;
  static const Color lightTextSecondary = neutral600;
  static const Color lightTextDisabled = neutral400;
  static const Color lightTextInverse = neutral0;

  // Text Colors (Dark Mode)
  static const Color darkTextPrimary = Color(0xFFE0E0E0); // Light gray
  static const Color darkTextSecondary = Color(0xFF9E9E9E); // Medium gray
  static const Color darkTextDisabled = Color(0xFF616161); // Dark gray
  static const Color darkTextInverse = Color(0xFF121212); // Almost black

  // Background Colors (Light Mode)
  static const Color lightBackgroundPrimary = neutral0;
  static const Color lightBackgroundSecondary = neutral50;
  static const Color lightBackgroundTertiary = neutral100;

  // Background Colors (Dark Mode)
  static const Color darkBackgroundPrimary = darkNeutral0;
  static const Color darkBackgroundSecondary = darkNeutral50;
  static const Color darkBackgroundTertiary = darkNeutral100;

  // Surface Colors (Light Mode)
  static const Color lightSurface = neutral0;
  static const Color lightSurfaceHighlight = neutral50;
  static const Color lightSurfaceOverlay = Color(0x80000000);

  // Surface Colors (Dark Mode)
  static const Color darkSurface = darkNeutral0;
  static const Color darkSurfaceHighlight = darkNeutral50;
  static const Color darkSurfaceOverlay = Color(0x80FFFFFF);

  // Border Colors (Light Mode)
  static const Color lightBorder = neutral600;
  static const Color lightBorderFocus = primaryLight;
  static const Color lightBorderError = error;

  // Border Colors (Dark Mode)
  static const Color darkBorder = Color(0xFF373737);
  static const Color darkBorderFocus = primaryLight;
  static const Color darkBorderError = error;

  // Shadow Colors (Light Mode)
  static const Color lightShadowLight = Color(0x1F000000);
  static const Color lightShadowDark = Color(0x3D000000);

  // Shadow Colors (Dark Mode)
  static const Color darkShadowLight = Color(0x3DFFFFFF);
  static const Color darkShadowDark = Color(0x66000000);

  // Overlay Colors (Light Mode)
  static const Color lightOverlay = Color(0x80000000);
  static const Color lightOverlayLight = Color(0x1F000000);
  static const Color lightOverlayDark = Color(0xB3000000);

  // Overlay Colors (Dark Mode)
  static const Color darkOverlay = Color(0x80FFFFFF);
  static const Color darkOverlayLight = Color(0x1FFFFFFF);
  static const Color darkOverlayDark = Color(0xB3000000);

  // Interactive States (Light Mode)
  static const Color lightHoverOverlay = Color(0x0A000000);
  static const Color lightFocusOverlay = Color(0x1F000000);
  static const Color lightPressedOverlay = Color(0x14000000);
  static const Color lightSelectedOverlay = Color(0x0F000000);
  static const Color lightDraggedOverlay = Color(0x0A000000);

  // Interactive States (Dark Mode)
  static const Color darkHoverOverlay = Color(0x0AFFFFFF);
  static const Color darkFocusOverlay = Color(0x1FFFFFFF);
  static const Color darkPressedOverlay = Color(0x14FFFFFF);
  static const Color darkSelectedOverlay = Color(0x0FFFFFFF);
  static const Color darkDraggedOverlay = Color(0x0AFFFFFF);
}
