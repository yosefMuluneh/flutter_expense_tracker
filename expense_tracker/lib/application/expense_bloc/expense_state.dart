part of 'expense_bloc.dart';

@immutable
abstract class ExpenseState {}

class ExpenseInitial extends ExpenseState {}

class ExpenseLoaded extends ExpenseState {
  final Map expenses;
  final Map budgets;
  final Map balance;

  ExpenseLoaded(
      {required this.expenses, required this.budgets, required this.balance});
}

class ExpenseError extends ExpenseState {
  final String message;

  ExpenseError({required this.message});
}
