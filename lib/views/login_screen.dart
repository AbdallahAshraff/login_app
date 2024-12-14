import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_app/widgets/login_model.dart';
import '../cubit/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Let’s Sing you in.",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text("Welcome back.", style: TextStyle(fontSize: 24)),
                const Text("You’ve been missed!",
                    style: TextStyle(fontSize: 24)),
                const SizedBox(height: 30),
                CustomFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  controller: emailController,
                  labelText: "Email",
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 15),
                CustomFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  controller: passwordController,
                  labelText: "Password",
                  obscureText: passwordVisible ? false : true,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                    icon: passwordVisible ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                ),
                Expanded(child: const SizedBox(height: 20)),
                BlocConsumer<LoginCubit, String?>(
                  listener: (context, state) {
                    if (state == "Success") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Login Successful!")),
                      );
                    } else if (state != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state)),
                      );
                    }

                  },
                  builder: (context, state) {
                    return Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 132, 12, 218),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            )),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            final email = emailController.text.trim();
                            final password = passwordController.text.trim();
                            LoginCubit.get(context).login(email, password);
                          }
                        },
                        child: const Text(
                          "Sign In",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to Register Screen
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don’t have an account?",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        "Register",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
