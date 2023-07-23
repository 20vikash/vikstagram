// ignore_for_file: depend_on_referenced_packages, unnecessary_import

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/main.dart';
import 'package:instagram/presentation/screens/feed_page.dart';

part 'authentication_state.dart';

final firebaseAuth = FirebaseAuth.instance;

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit()
      : super(
          AuthenticationState(
            obscureText: true,
            isLoading: false,
            obscureTextSup: true,
            authError: "",
            iconSup: Icon(
              Icons.visibility_off_outlined,
              color: Colors.white.withOpacity(0.5),
            ),
            appScreen: const HomePage(),
            icon: Icon(
              Icons.visibility_off_outlined,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
        ) {
    StreamSubscription _ = firebaseAuth.authStateChanges().listen(
      (snapShots) {
        if (snapShots == null) {
          emit(
            state.copyWith(
              appScreenIn: const HomePage(),
            ),
          );
        } else {
          emit(
            state.copyWith(
              appScreenIn: const FeedScreen(),
            ),
          );
        }
      },
    );
  }

  void passwordObscureText() {
    if (state.obscureText) {
      emit(
        state.copyWith(
          iconAuth: Icon(
            Icons.visibility,
            color: Colors.blue.withOpacity(0.7),
          ),
          obscureTextAuth: false,
        ),
      );
    } else {
      emit(
        state.copyWith(
          iconAuth: Icon(
            Icons.visibility_off_outlined,
            color: Colors.white.withOpacity(0.5),
          ),
          obscureTextAuth: true,
        ),
      );
    }
  }

  Future<void> signUp(String email, String password) async {
    emit(
      state.copyWith(
        isLoadingState: true,
        authErrorState: "",
      ),
    );
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(
        state.copyWith(
          isLoadingState: false,
        ),
      );
    } on FirebaseAuthException catch (error) {
      emit(
        state.copyWith(
          authErrorState: error.message,
          isLoadingState: false,
        ),
      );
    }
  }

  Future<void> logIn(String email, String password) async {
    emit(
      state.copyWith(
        isLoadingState: true,
        authErrorState: "",
      ),
    );
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(
        state.copyWith(
          isLoadingState: false,
        ),
      );
    } on FirebaseAuthException catch (error) {
      emit(
        state.copyWith(
          authErrorState: error.message,
          isLoadingState: false,
        ),
      );
    }
  }

  void passwordObscureTextSignUp() {
    if (state.obscureTextSup) {
      emit(
        state.copyWith(
          iconSignUp: Icon(
            Icons.visibility,
            color: Colors.blue.withOpacity(0.7),
          ),
          obscureTextSignUp: false,
        ),
      );
    } else {
      emit(
        state.copyWith(
          obscureTextSignUp: true,
          iconSignUp: Icon(
            Icons.visibility_off_outlined,
            color: Colors.white.withOpacity(0.5),
          ),
        ),
      );
    }
  }
}
