import 'package:expense_tracker/application/auth/login/login_cubit.dart';
import 'package:expense_tracker/application/auth/signup/signup_cubit.dart';
import 'package:expense_tracker/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserName extends StatefulWidget {
  final TextEditingController controller;
  const UserName({super.key, required this.controller});

  @override
  State<UserName> createState() => _UserNameState();
}

class _UserNameState extends State<UserName> {
  bool _isFocused = false;
  bool _isTouched = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return Focus(
          onFocusChange: (hasFocus) {
            setState(() {
              _isFocused = hasFocus;
            });
          },
          child: TextFormField(
            autovalidateMode: _isTouched
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return 'Enter a your username';
              }
              return null;
            },
            controller: widget.controller,
            onChanged: (username) {
              if (widget.controller.text.isNotEmpty) {
                setState(() {
                  _isTouched = true;
                });
              } else {
                setState(() {
                  _isTouched = false;
                });
              }
              context.read<LoginCubit>().userNameChanged(username);
              context.read<SignupCubit>().userNameChanged(username);
            },
            decoration: InputDecoration(
              labelText: 'Username',
              prefixStyle: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: _isFocused
                      ? Colors.blue
                      : const Color.fromARGB(255, 143, 143, 143),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: _isFocused
                      ? Colors.blue
                      : const Color.fromARGB(255, 143, 143, 143),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class PasswordInput extends StatefulWidget {
  final TextEditingController controller;
  const PasswordInput({super.key, required this.controller});

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool _obscureText = true;
  bool _isFocused = false;
  bool _isTouched = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Focus(
          onFocusChange: (hasFocus) {
            setState(() {
              _isFocused = hasFocus;
            });
          },
          child: TextFormField(
            autovalidateMode: _isTouched
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            controller: widget.controller,
            onChanged: (password) {
              if (widget.controller.text.isNotEmpty) {
                setState(() {
                  _isTouched = true;
                });
              } else {
                setState(() {
                  _isTouched = false;
                });
              }
              context.read<LoginCubit>().passwordChanged(password);
            },
            validator: (val) {
              if (val == null || val.isEmpty) {
                return 'Enter your password';
              } else if (widget.controller.text.length < 6) {
                return 'Password should be at least 6 characters';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: 'password',
              border: OutlineInputBorder(
                // borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                  color: _isFocused
                      ? Colors.blue
                      : const Color.fromARGB(255, 143, 143, 143),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                // borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                  color: _isFocused
                      ? Colors.blue
                      : const Color.fromARGB(255, 143, 143, 143),
                ),
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                ),
              ),
            ),
            obscureText: _obscureText,
          ),
        );
      },
    );
  }
}

class LoginButton extends StatelessWidget {
  final TextEditingController userNameControler;
  final TextEditingController passControler;
  const LoginButton(
      {super.key,
      required this.userNameControler,
      required this.passControler});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status == LoginStatus.submitting
            ? const CircularProgressIndicator()
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () async {
                  if (userNameControler.text.isNotEmpty &&
                      passControler.text.isNotEmpty &&
                      passControler.text.length >= 6) {
                    await BlocProvider.of<LoginCubit>(context)
                        .logInWithCredentials();
                  } else if (userNameControler.text.isEmpty) {
                    showSnackBar(context, "Input your phone number");
                  } else if (passControler.text.isEmpty) {
                    showSnackBar(context, "Input your password");
                  }
                },
                child: const Text('LOGIN'),
              );
      },
      listener: (context, state) {
        // if (state.user.role == "doctor") {
        //   GoRouter.of(context).go('/doctor');
        // } else if (state.user.role == "patient") {
        //   GoRouter.of(context).go('/patient');
        // } else if (state.user.role == "admin") {
        //   GoRouter.of(context).go('/admin');
        // }
      },
    );
  }
}

class PasswordInputSignup extends StatefulWidget {
  final TextEditingController controller;
  const PasswordInputSignup({super.key, required this.controller});

  @override
  State<PasswordInputSignup> createState() => _PasswordInputSignupState();
}

class _PasswordInputSignupState extends State<PasswordInputSignup> {
  bool _obscureText = true;
  bool _isFocused = false;
  bool _isTouched = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Focus(
          onFocusChange: (hasFocus) {
            setState(() {
              _isFocused = hasFocus;
            });
          },
          child: TextFormField(
            autovalidateMode: _isTouched
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return 'Enter your password';
              } else if (widget.controller.text.length < 6) {
                return 'Password should be at least 6 characters';
              }
              return null;
            },
            controller: widget.controller,
            onChanged: (password) {
              if (widget.controller.text.isNotEmpty) {
                setState(() {
                  _isTouched = true;
                });
              } else {
                setState(() {
                  _isTouched = false;
                });
              }
              context.read<SignupCubit>().passwordChanged(password);
            },
            decoration: InputDecoration(
              labelText: 'password',
              border: OutlineInputBorder(
                // borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                  color: _isFocused
                      ? Colors.blue
                      : const Color.fromARGB(255, 143, 143, 143),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                // borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                  color: _isFocused
                      ? Colors.blue
                      : const Color.fromARGB(255, 143, 143, 143),
                ),
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                ),
              ),
            ),
            obscureText: _obscureText,
          ),
        );
      },
    );
  }
}

class SignupButton extends StatelessWidget {
  final TextEditingController username;
  final TextEditingController password;
  const SignupButton({
    Key? key,
    required this.username,
    required this.password,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status == SignupStatus.submitting
            ? const CircularProgressIndicator()
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {
                  if (username.text.isEmpty) {
                    showSnackBar(context, "User name is required");
                  } else if (password.text.isEmpty) {
                    showSnackBar(context, "Password is required");
                  } else if (password.text.length >= 6) {
                    context.read<SignupCubit>().signupFormSubmitted();
                    showSnackBar(context, "Account created succesfully.");
                  }
                },
                child: const Text(
                  'SIGNUP',
                  style: TextStyle(color: Colors.blue),
                ),
              );
      },
    );
  }
}
