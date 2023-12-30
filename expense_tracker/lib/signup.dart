import 'package:expense_tracker/application/auth/signup/signup_cubit.dart';
import 'package:expense_tracker/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  final _signUpFormKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign up'),
        centerTitle: true,
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<SignupCubit, SignupState>(listener: (context, state) {
            if (state.status == SignupStatus.success) {
              GoRouter.of(context).go('/');
            }
          }),
        ],
        child: SingleChildScrollView(
          child: Column(
            children: [
              SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: _signUpFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 50),
                            const Center(
                              child: Text(
                                "Welcome, Sign up for free",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 66, 66, 66),
                                ),
                              ),
                            ),
                            const SizedBox(height: 50),

                            const SizedBox(height: 10),
                            UserName(controller: _userNameController),
                            const SizedBox(height: 10),
                            PasswordInputSignup(
                                controller: _passwordController),
                            const SizedBox(height: 10),
                            // confirm
                            const SizedBox(height: 30),
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  GoRouter.of(context).push('/');
                                },
                                child: const Text.rich(
                                  TextSpan(
                                    text: "Already have an account? ",
                                    style: TextStyle(fontSize: 15),
                                    children: [
                                      TextSpan(
                                        text: "Sign in",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 100),
                            SignupButton(
                                password: _passwordController,
                                username: _userNameController),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
