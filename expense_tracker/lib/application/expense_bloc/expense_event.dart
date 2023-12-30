part of 'expense_bloc.dart';

@immutable
abstract class ExpenseEvent {}

class LoadExpense extends ExpenseEvent {
  final int id;
  LoadExpense({required this.id});
}

class AddExpense extends ExpenseEvent {
  final ExpenseDto expense;
  AddExpense({required this.expense});
}

class UpdateExpense extends ExpenseEvent {
  final ExpenseDto expense;
  UpdateExpense({required this.expense});
}

class DeleteExpense extends ExpenseEvent {
  final ExpenseDto expense;
  DeleteExpense({required this.expense});
}

class AddBudjet extends ExpenseEvent {
  final BudgetDto budget;
  AddBudjet({required this.budget});
}


class DeleteBudget extends ExpenseEvent {
  final BudgetDto budget;
  DeleteBudget({required this.budget});
}