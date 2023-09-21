import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_pay_task/constants/app_routes.dart';
import 'package:google_pay_task/models/upi_model.dart';
import 'package:google_pay_task/models/user_model.dart';
import 'package:google_pay_task/modules/home/home_page.dart';
import 'package:google_pay_task/modules/payment/initiate_payment/bloc/initiate_payment_bloc.dart';
import 'package:google_pay_task/modules/payment/initiate_payment/initiate_page.dart';
import 'package:google_pay_task/modules/payment/ongoing/bloc/payment_ongoing_bloc.dart';
import 'package:google_pay_task/modules/payment/ongoing/payment_ongoing_page.dart';
import 'package:google_pay_task/modules/payment/success/payment_success_page.dart';

class AppGeneratedRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.homePage:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      case AppRoutes.paymentInitialPage:
        if (settings.arguments != null) {
          final user = settings.arguments as UserModel?;
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) => InitiatePaymentBloc(
                user!,
              ),
              child: const InitiatePage(),
            ),
          );
        }
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      case AppRoutes.paymentOngoingPage:
        if (settings.arguments != null) {
          final upi = settings.arguments as UpiModel?;
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) => PaymentOngoingBloc(upi!),
              child: const PaymentOngoingPage(),
            ),
          );
        }
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      case AppRoutes.paymentSuccessPage:
        if (settings.arguments != null) {
          final upi = settings.arguments as UpiModel?;
          return MaterialPageRoute(
            builder: (_) => PaymentSuccessPage(
              upi: upi!,
            ),
          );
        }
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
    }
  }
}
