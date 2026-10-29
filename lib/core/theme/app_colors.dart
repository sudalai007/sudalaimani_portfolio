import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Brand Accents
  static const Color primary = Color(0xFF3B82F6); // Electric Blue
  static const Color primaryDark = Color(0xFF2563EB);
  static const Color secondary = Color(0xFF6366F1); // Indigo Accent
  static const Color secondaryDark = Color(0xFF4F46E5);
  static const Color tertiary = Color(0xFF06B6D4); // Cyan Glow
  static const Color accentGreen = Color(0xFF10B981); // Emerald
  static const Color accentAmber = Color(0xFFF59E0B); // Amber
  static const Color accentRose = Color(0xFFF43F5E); // Rose

  // Dark Theme Palette
  static const Color darkBackground = Color(0xFF0A0F1D);
  static const Color darkSurface = Color(0xFF111827);
  static const Color darkSurfaceElevated = Color(0xFF1F2937);
  static const Color darkCard = Color(0xFF161F36);
  static const Color darkBorder = Color(0x1FFFFFFF); // 12% white
  static const Color darkBorderSubtle = Color(0x0FFFFFFF); // 6% white
  static const Color darkTextPrimary = Color(0xFFF8FAFC);
  static const Color darkTextSecondary = Color(0xFF94A3B8);
  static const Color darkTextMuted = Color(0xFF64748B);

  // Light Theme Palette
  static const Color lightBackground = Color(0xFFF8FAFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceElevated = Color(0xFFF1F5F9);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightBorder = Color(0x14000000); // 8% black
  static const Color lightBorderSubtle = Color(0x0A000000); // 4% black
  static const Color lightTextPrimary = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF475569);
  static const Color lightTextMuted = Color(0xFF94A3B8);

  // Linear Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF3B82F6), Color(0xFF6366F1)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Human-Engaging Cosmic Aurora Full-Body Gradients
  // A captivating blend of deep obsidian, twilight indigo, and midnight slate
  static const LinearGradient darkBodyGradient = LinearGradient(
    colors: [
      Color(0xFF060913), // Deep cosmic obsidian
      Color(0xFF090E22), // Twilight midnight indigo
      Color(0xFF0D1530), // Deep space sapphire
      Color(0xFF0A0F21), // Midnight navy
      Color(0xFF050811), // Bottom obsidian
    ],
    stops: [0.0, 0.28, 0.58, 0.82, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Luminous Silk Light Gradient for day mode
  static const LinearGradient lightBodyGradient = LinearGradient(
    colors: [
      Color(0xFFFFFFFF), // Pure crisp white
      Color(0xFFF6F8FD), // Soft sky mist
      Color(0xFFEEF2FF), // Ethereal lavender indigo
      Color(0xFFF1F5F9), // Light pearl slate
      Color(0xFFF8FAFC), // Off-white base
    ],
    stops: [0.0, 0.25, 0.55, 0.8, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroGlowGradient = LinearGradient(
    colors: [Color(0x333B82F6), Color(0x1A6366F1), Colors.transparent],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient darkCardGradient = LinearGradient(
    colors: [Color(0xFF161F36), Color(0xFF111827)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient lightCardGradient = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFF8FAFC)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

