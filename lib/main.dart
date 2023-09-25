import 'package:flutter/material.dart';
import 'package:google_pay_task/constants/app_constants.dart';
import 'package:google_pay_task/constants/app_generated_routes.dart';
import 'package:google_pay_task/constants/app_routes.dart';
import 'package:google_pay_task/resources/app_colors.dart';
import 'package:google_pay_task/resources/app_text_styles.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Pay Task',
      theme: ThemeData(
        primaryColor: Colors.white,
        useMaterial3: true,
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: Colors.white,
            textStyle: AppTextStyles.fontMediumNormal,
            minimumSize: const Size(
              double.infinity,
              48,
            ),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
        ),
        expansionTileTheme: ExpansionTileThemeData(
          shape: const Border(),
          collapsedTextColor: Colors.black,
          collapsedBackgroundColor: Colors.grey.shade400,
          textColor: Colors.black,
          backgroundColor: Colors.grey.shade400,
          iconColor: Colors.black,
          collapsedIconColor: Colors.black,
          tilePadding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
        ),
      ),
      scaffoldMessengerKey: AppConstants.scaffoldMessengerKey,
      navigatorKey: AppConstants.navigationKey,
      initialRoute: AppRoutes.homePage,
      onGenerateRoute: AppGeneratedRoutes.onGenerateRoute,
    );
  }
}
