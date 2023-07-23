// ignore_for_file: overridden_fields

part of 'authentication_cubit.dart';

class AuthenticationState {
  final bool obscureText;
  final Icon icon;
  final Widget appScreen;
  final bool obscureTextSup;
  final Icon iconSup;
  final bool isLoading;
  final String authError;

  const AuthenticationState({
    required this.obscureText,
    required this.icon,
    required this.appScreen,
    required this.obscureTextSup,
    required this.iconSup,
    required this.isLoading,
    required this.authError,
  });

  AuthenticationState copyWith({
    bool? obscureTextAuth,
    bool? obscureTextSignUp,
    Icon? iconSignUp,
    Widget? appScreenIn,
    Icon? iconAuth,
    bool? isLoadingState,
    String? authErrorState,
  }) {
    return AuthenticationState(
      obscureText: obscureTextAuth ?? obscureText,
      obscureTextSup: obscureTextSignUp ?? obscureTextSup,
      iconSup: iconSignUp ?? iconSup,
      appScreen: appScreenIn ?? appScreen,
      icon: iconAuth ?? icon,
      isLoading: isLoadingState ?? isLoading,
      authError: authErrorState ?? authError,
    );
  }
}
