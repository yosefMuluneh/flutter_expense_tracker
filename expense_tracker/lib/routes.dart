import 'package:expense_tracker/application/auth/login/login_cubit.dart';
import 'package:expense_tracker/application/auth/signup/signup_cubit.dart';
import 'package:expense_tracker/fetcher.dart';
import 'package:expense_tracker/presentation/add_budget.dart';
import 'package:expense_tracker/presentation/add_expense.dart';
import 'package:expense_tracker/presentation/starting.dart';
import 'package:expense_tracker/signin.dart';
import 'package:expense_tracker/signup.dart';
import 'package:expense_tracker/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final signUpBloc = SignupCubit(Fetcher());

GoRouter router = GoRouter(
  errorBuilder: ((context, state) => ErrorScreen(
        error: state.error,
      )),
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const Initial(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const Starting(),
      routes: [
        GoRoute(
          path: 'addExpense',
          builder: (context, state) => const AddExpensePage(),
        ),
        GoRoute(
          path: 'addbudget',
          builder: (context, state) => const AddBudgetPage(),
        ),
      ],
    ),
  ],
);

class Initial extends StatefulWidget {
  const Initial({Key? key}) : super(key: key);

  @override
  State<Initial> createState() => _InitialState();
}

class _InitialState extends State<Initial> {
  @override
  void initState() {
    final authBloc = BlocProvider.of<LoginCubit>(context);
    authBloc.loadCachedUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(listener: ((context, state) {
      if (state.status == LoginStatus.success) {
        GoRouter.of(context).go("/home");
      }
    }), builder: (context, state) {
      return const LoginScreen();
    });
  }
}
