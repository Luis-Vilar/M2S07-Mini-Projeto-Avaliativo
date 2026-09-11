import 'package:flutter/material.dart';

final Color darkPrimaryColor = Color(0xFF0D3A81);
final Color darkBackgroundColor = Color(0xFF0F172A);
final Color darkSurfaceColor = Color(0xFF1E293B);
final Color darkTextPrimary = Color(0xFFF8FAFC);
final Color darkTextSecondary = Color(0xFF94A3B8);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: darkPrimaryColor,
  scaffoldBackgroundColor: darkBackgroundColor,

  // AppBar escura com bordas arredondadas igual ao light
  appBarTheme: AppBarTheme(
    backgroundColor: darkSurfaceColor,
    foregroundColor: darkTextPrimary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
    ),
    titleTextStyle: TextStyle(
      color: darkTextPrimary,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    toolbarTextStyle: TextStyle(color: darkTextSecondary, fontSize: 10),
  ),

  // Inputs adaptados para o fundo escuro
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(color: darkTextSecondary),
    filled: true,
    fillColor: darkSurfaceColor,
    prefixIconColor: darkTextSecondary,
    suffixIconColor: darkTextSecondary,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      borderSide: BorderSide(color: Color(0xFF334155)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      borderSide: BorderSide(color: darkPrimaryColor, width: 2),
    ),
  ),

  // Cards no modo escuro usam a cor de superfície (darkSurfaceColor)
  cardTheme: CardThemeData(
    color: darkSurfaceColor,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide(color: Color(0xFF334155), width: 1),
    ),
  ),

  // Cores de texto invertidas para leitura no escuro
  textTheme: TextTheme(
    titleLarge: TextStyle(
      color: darkTextPrimary,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    bodyLarge: TextStyle(color: darkTextPrimary, fontSize: 16),
    bodyMedium: TextStyle(color: darkTextSecondary, fontSize: 14),
  ),

  // Botão adaptado para se destacar no escuro
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: darkPrimaryColor,
      foregroundColor: Colors.white,
      minimumSize: Size(double.infinity, 54),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  //Estilo para el botón de agregar todo (y todos los FloatingActionButtons futuros)
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: darkPrimaryColor,
    foregroundColor: Colors.white,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(
        16,
      ), // Mesma forma, mas com as cores escuras
    ),
  ),
);
