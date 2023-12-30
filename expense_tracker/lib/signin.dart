import 'package:expense_tracker/application/auth/login/login_cubit.dart';
import 'package:expense_tracker/common.dart';
import 'package:expense_tracker/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: LoginScreen());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign in'),
        centerTitle: true,
      ),
      body: const Padding(padding: EdgeInsets.all(20.0), child: LoginForm()),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _signInFormKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.error) {
          showSnackBar(context, state.error);
        }
      },
      child: SingleChildScrollView(
        child: Form(
          key: _signInFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Welcome again",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 30,
              ),
              UserName(controller: _userNameController),
              const SizedBox(height: 15),
              PasswordInput(controller: _passwordController),
              const SizedBox(height: 5),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    GoRouter.of(context).go('/signup');
                  },
                  child: const Text.rich(
                    TextSpan(
                      text: "Don't have an account?  ",
                      style: TextStyle(fontSize: 15),
                      children: [
                        TextSpan(
                          text: "Create a new one",
                          style: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 116, 14, 10),
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              LoginButton(
                passControler: _passwordController,
                userNameControler: _userNameController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
