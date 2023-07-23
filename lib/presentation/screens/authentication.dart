import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instagram/logic/cubit/authentication_cubit.dart';

class Authentication extends StatelessWidget {
  const Authentication({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String email = "";
    String password = "";

    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "Vikstagram",
              style: GoogleFonts.pangolin(
                color: Colors.white,
                fontSize: 41,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 25),
            BlocBuilder<AuthenticationCubit, AuthenticationState>(
              builder: (context, state) {
                return Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                    ),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color.fromARGB(255, 77, 76, 76),
                          ),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.trim().isEmpty ||
                                  !(value.contains("@"))) {
                                return "Please enter a valid email";
                              } else {
                                return null;
                              }
                            },
                            onSaved: (newValue) {
                              email = newValue!;
                            },
                            autocorrect: false,
                            style: const TextStyle(color: Colors.white),
                            cursorColor:
                                const Color.fromARGB(255, 179, 179, 179),
                            decoration: InputDecoration(
                              hintText: "Your email",
                              hintStyle: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color.fromARGB(255, 77, 76, 76),
                          ),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.trim().isEmpty ||
                                  value.length < 6) {
                                return "Password must be atleast 6 charecters";
                              } else {
                                return null;
                              }
                            },
                            onSaved: (newValue) {
                              password = newValue!;
                            },
                            style: const TextStyle(color: Colors.white),
                            obscureText: state.obscureText,
                            enableSuggestions: false,
                            autocorrect: false,
                            cursorColor:
                                const Color.fromARGB(255, 179, 179, 179),
                            decoration: InputDecoration(
                              hintText: "Password",
                              hintStyle: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  BlocProvider.of<AuthenticationCubit>(context)
                                      .passwordObscureText();
                                },
                                icon: state.icon,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        BlocConsumer<AuthenticationCubit, AuthenticationState>(
                          listener: (context, state) {
                            if (state.authError.length > 1 && context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    state.authError,
                                  ),
                                ),
                              );
                            }
                          },
                          builder: (context, state) {
                            return SizedBox(
                              width: double.infinity,
                              child: FloatingActionButton.extended(
                                backgroundColor:
                                    const Color.fromARGB(255, 5, 136, 243),
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();
                                    await BlocProvider.of<AuthenticationCubit>(
                                            context)
                                        .logIn(email, password);
                                  }
                                },
                                label: state.isLoading
                                    ? const CircularProgressIndicator()
                                    : const Text(
                                        "Log in",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Forgotten your login details?",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 12,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Get help with logging in.",
                    style: TextStyle(
                      color: Color.fromARGB(255, 150, 206, 251),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 7),
            Row(
              children: [
                const SizedBox(width: 15),
                Expanded(
                  child: Container(
                    height: 1,
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                    right: 8,
                  ),
                  child: Text(
                    "OR",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 1,
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
                const SizedBox(width: 15),
              ],
            ),
            const SizedBox(height: 15),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.facebook,
                color: Color.fromARGB(255, 5, 140, 250),
                size: 30,
              ),
              label: const Text(
                "Log in With Facebook",
                style: TextStyle(
                  color: Color.fromARGB(255, 39, 160, 246),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 8,
            ),
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 1,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/chooseUserName");
                      },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                          color: Color.fromARGB(255, 150, 206, 251),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
