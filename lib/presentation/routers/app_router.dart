import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/logic/cubit/authentication_cubit.dart';
import 'package:instagram/presentation/screens/choose_username.dart';
import 'package:instagram/presentation/screens/create_password.dart';

class AppRouter {
  Route onGeneratedRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (ctx) =>
              BlocBuilder<AuthenticationCubit, AuthenticationState>(
            builder: (context, state) {
              return state.appScreen;
            },
          ),
        );
      case '/chooseUserName':
        return MaterialPageRoute(
          builder: (ctx) => const ChooseUserName(),
        );
      case '/createPassword':
        var d = settings.arguments as String;
        return MaterialPageRoute(
          builder: (ctx) => CreatePassword(email: d),
        );
      default:
        return MaterialPageRoute(
          builder: (ctx) => const Scaffold(
            body: Center(
              child: Text("Page not found"),
            ),
          ),
        );
    }
  }
}
