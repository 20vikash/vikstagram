import 'package:flutter/material.dart';

class ChooseUserName extends StatelessWidget {
  const ChooseUserName({super.key});

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
              "Choose email",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 13),
            Text(
              "You can always change it later",
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 14,
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
                  child: TextFormField(
                    key: const ValueKey("signup"),
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
                      Navigator.pushNamed(context, "/createPassword",
                          arguments: newValue);
                    },
                    autocorrect: false,
                    style: const TextStyle(color: Colors.white),
                    cursorColor: const Color.fromARGB(255, 179, 179, 179),
                    decoration: InputDecoration(
                      hintText: "Email",
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
              ),
            ),
            const SizedBox(height: 17),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: SizedBox(
                width: double.infinity,
                child: FloatingActionButton.extended(
                  key: const ValueKey("signup"),
                  backgroundColor: const Color.fromARGB(255, 5, 136, 243),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                    }
                  },
                  label: const Text(
                    "Next",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
