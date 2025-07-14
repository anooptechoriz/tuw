import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color_manager.dart';
import 'styles_manager.dart';

ThemeData getApplicationTheme(BuildContext context) {
  return ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor: ColorManager.background,
        iconTheme: IconThemeData(color: ColorManager.primary, size: 30),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: GoogleFonts.lexendDeca().fontFamily,
      scaffoldBackgroundColor: ColorManager.background,
      primaryColor: ColorManager.primary,
      // colorScheme: const ColorScheme.dark(
      //   primary: ColorManager.primary,
      //   secondary: ColorManager.secondary,
      //   surface: ColorManager.background,
      //   onSurface: ColorManager.whiteText,
      // ),
      // canvasColor: ColorManager.background,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        foregroundColor: ColorManager.whiteText,
        // fixedSize: const Size.fromHeight(100),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        backgroundColor: ColorManager.primary,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        textStyle: getRegularStyle(
          color: ColorManager.black,
        ),
      )),
      textTheme: TextTheme(
        displayLarge: getBoldtStyle(
          color: ColorManager.black,
          fontSize: 24,
        ),
        displayMedium: getMediumtStyle(
          color: ColorManager.black,
          fontSize: 28,
        ),
        displaySmall: getMediumtStyle(
          color: ColorManager.black,
          fontSize: 20,
        ),
        titleMedium: getRegularStyle(
          color: ColorManager.black,
          fontSize: 16,
        ),
        titleSmall: getRegularStyle(
          color: ColorManager.black,
          fontSize: 16,
        ),
        bodyLarge: getRegularStyle(
          color: ColorManager.black,
          fontSize: 14,
        ),
        bodyMedium: getRegularStyle(
          color: ColorManager.black,
          fontSize: 14,
        ),
      ),
      disabledColor: ColorManager.disabledColor,
      inputDecorationTheme: InputDecorationTheme(
        // contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
        filled: true,
        fillColor: ColorManager.whiteColor,
        hintStyle: getRegularStyle(
            color: const Color.fromARGB(255, 173, 173, 173), fontSize: 15),
        labelStyle:
            getSemiBoldtStyle(color: ColorManager.tertiary.withOpacity(.5)),
        floatingLabelStyle:
            getSemiBoldtStyle(color: ColorManager.primary.withOpacity(.8)),

        focusColor: ColorManager.primary,
        contentPadding: const EdgeInsets.only(
          left: 10,
          right: 10,
        ),

        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide:
              const BorderSide(color: ColorManager.whiteColor, width: .5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: ColorManager.whiteColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: ColorManager.errorRed,
          ),
        ),
      ),
      iconTheme: const IconThemeData(
        color: ColorManager.grayLight,
        size: 18,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: ColorManager.grayLight,
        foregroundColor: ColorManager.whiteText,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ));
}
