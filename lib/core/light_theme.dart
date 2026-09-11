import 'package:flutter/material.dart';

final Color primaryColor = Color(0xFF1E56FF);
final Color backgroundColor = Color(0xFFF8FAFC);
final Color textPrimary = Color(0xFF0F172A);
final Color textSecondary = Color(0xFF64748B);

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: primaryColor,
  scaffoldBackgroundColor: backgroundColor,

  appBarTheme: AppBarTheme(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
    ),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    toolbarTextStyle: TextStyle(color: Colors.white, fontSize: 10),
  ),

  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(color: textSecondary),
    filled: true,
    fillColor: Colors.white,
    prefixIconColor: textSecondary,
    suffixIconColor: textSecondary,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      borderSide: BorderSide(color: Color(0xFFE2E8F0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      borderSide: BorderSide(color: primaryColor, width: 2),
    ),
  ),

  // Estilo para las tarjetas (Cards) de las tareas
  cardTheme: CardThemeData(
    color: Colors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide(color: Color(0xFFE2E8F0), width: 1),
    ),
  ),

  // Estilo para los textos
  textTheme: TextTheme(
    titleLarge: TextStyle(
      color: textPrimary,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    bodyLarge: TextStyle(color: textPrimary, fontSize: 16),
    bodyMedium: TextStyle(color: textSecondary, fontSize: 14),
  ),

  // Estilo para el botón principal de Login
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      minimumSize: Size(double.infinity, 54),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  //Estilo para el botón de agregar todo (y todos los FloatingActionButtons futuros)
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    elevation: 4, // Uma sombra sutil para dar efeito de flutuação
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(
        16,
      ), // Cantos modernos combinando com os cards
    ),
  ),
);
