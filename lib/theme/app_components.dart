import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_theme.dart';

class AppButtons {
  // Botão primário com estilo moderno
  static Widget primaryButton({
    required String label,
    required VoidCallback onPressed,
    bool isLoading = false,
    double? width,
  }) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(label),
      ),
    );
  }

  // Botão secundário com estilo moderno
  static Widget secondaryButton({
    required String label,
    required VoidCallback onPressed,
    double? width,
  }) {
    return SizedBox(
      width: width,
      child: OutlinedButton(
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }

  // Botão com ícone
  static Widget iconButton({
    required IconData icon,
    required VoidCallback onPressed,
    Color? backgroundColor,
    Color? foregroundColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        icon: Icon(icon),
        color: foregroundColor ?? AppTheme.primaryColor,
        onPressed: onPressed,
      ),
    );
  }
}

class AppCards {
  // Card com gradient
  static Widget gradientCard({
    required Widget child,
    Color? color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

class AppLoaders {
  // Skeleton loader
  static Widget skeleton({
    double width = double.infinity,
    double height = 20,
    BorderRadius? borderRadius,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppTheme.dividerColor,
        borderRadius: borderRadius ?? BorderRadius.circular(8),
      ),
    );
  }
}
