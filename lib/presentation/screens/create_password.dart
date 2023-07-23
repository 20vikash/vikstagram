import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/logic/cubit/authentication_cubit.dart';

class CreatePassword extends StatelessWidget {
  const CreatePassword({super.key, this.email});
  final String? email;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Create a password",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 13),
            Padding(
              padding: const EdgeInsets.only(
                left: 35,
                right: 35,
              ),
              child: Text(
                "For security, your password must be six characters or more.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Form(
                key: formKey,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color.fromARGB(255, 77, 76, 76),
                  ),
                  child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
                    builder: (context, state) {
                      return TextFormField(
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
                        onSaved: (newValue) async {
                          await BlocProvider.of<AuthenticationCubit>(context)
                              .signUp(email!, newValue!);

                          if (context.mounted) {
                            Navigator.pushReplacementNamed(context, "/");
                          }
                        },
                        autocorrect: false,
                        obscureText: state.obscureTextSup,
                        style: const TextStyle(color: Colors.white),
                        cursorColor: const Color.fromARGB(255, 179, 179, 179),
                        decoration: InputDecoration(
                          hintText: "Password",
                          suffixIcon: IconButton(
                            icon: state.iconSup,
                            onPressed: () {
                              BlocProvider.of<AuthenticationCubit>(context)
                                  .passwordObscureTextSignUp();
                            },
                          ),
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 17),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
                builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    child: FloatingActionButton.extended(
                      backgroundColor: const Color.fromARGB(255, 5, 136, 243),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                        }
                      },
                      label: state.isLoading
                          ? const CircularProgressIndicator()
                          : const Text(
                              "Next",
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
            ),
          ],
        ),
      ),
    );
  }
}
