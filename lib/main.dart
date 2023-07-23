import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/logic/cubit/authentication_cubit.dart';
import 'package:instagram/presentation/routers/app_router.dart';
import 'firebase_options.dart';

import 'package:instagram/presentation/screens/authentication.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    BlocProvider(
      create: (context) => AuthenticationCubit(),
      child: MaterialApp(
        onGenerateRoute: AppRouter().onGeneratedRoutes,
        initialRoute: '/',
      ),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Authentication(),
    );
  }
}
