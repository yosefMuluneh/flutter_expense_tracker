import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:expense_tracker/application/expense_bloc/expense_fetcher.dart';
import 'package:expense_tracker/budget.dto.dart';
import 'package:expense_tracker/expense.dto.dart';
import 'package:meta/meta.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  ExpenseBloc() : super(ExpenseInitial()) {
    on<LoadExpense>(_onLoadExpense);
    on<AddExpense>(_onAddExpense);
    on<UpdateExpense>(__onUpdateExpense);
    on<DeleteExpense>(_onDeleteExpense);
    on<AddBudjet>(_onAddBudget);
    on<DeleteBudget>(_onDeleteBudget);
  }

  FutureOr<void> starter(int id) async {
    List<ExpenseDto> expenses = await ExpenseFetcher.getExpense(id);
    List<BudgetDto> budgets = await ExpenseFetcher.getBudget(id);

    Map balance = await ExpenseFetcher.getBalance(id);

    Map dateIndexes = {"groupByDay": {}, "groupByMonth": {}, "groupByYear": {}};
    Map organized = organizer(expenses, dateIndexes);
    Map organizedBudget = organizeBudget(budgets, organized, dateIndexes);
    dividing(organized["groupByMonth"]);
    dividing(organized["groupByYear"]);
    
    emit(ExpenseLoaded(
        expenses: organized, budgets: organizedBudget, balance: balance));
  }

  FutureOr<void> _onLoadExpense(
      LoadExpense event, Emitter<ExpenseState> emit) async {
    emit(ExpenseInitial());
    try {
      starter(event.id);
    } catch (e) {
      emit(ExpenseError(message: e.toString()));
    }
  }

  FutureOr<void> _onAddExpense(
      AddExpense event, Emitter<ExpenseState> emit) async {
    emit(ExpenseInitial());
    try {
      await ExpenseFetcher.addExpense(event.expense);
      starter(event.expense.user_id);
    } catch (e) {
      emit(ExpenseError(message: e.toString()));
    }
  }

  FutureOr<void> __onUpdateExpense(
      UpdateExpense event, Emitter<ExpenseState> emit) {}

  FutureOr<void> _onDeleteExpense(
      DeleteExpense event, Emitter<ExpenseState> emit) {
    emit(ExpenseInitial());
    try {
      ExpenseFetcher.deleteExpense(event.expense.id);
      starter(event.expense.user_id);
    } catch (e) {
      emit(ExpenseError(message: e.toString()));
    }
  }

  FutureOr<void> _onAddBudget(
      AddBudjet event, Emitter<ExpenseState> emit) async {
    emit(ExpenseInitial());
    try {
      await ExpenseFetcher.addBudjet(event.budget);
      starter(event.budget.user_id);
    } catch (e) {
      emit(ExpenseError(message: e.toString()));
    }
  }

  FutureOr<void> _onDeleteBudget(
      DeleteBudget event, Emitter<ExpenseState> emit) {
    emit(ExpenseInitial());
    try {
      ExpenseFetcher.deleteBudget(event.budget.id);
      starter(event.budget.user_id);
    } catch (e) {
      emit(ExpenseError(message: e.toString()));
    }
  }

  Map organizer(List<ExpenseDto> expenses, Map dataIndexes) {
    List groupByDay = [];
    List groupByMonth = [];
    List groupByYear = [];
    expenses.sort((a, b) => b.date.compareTo(a.date));
    int lastDay = -1;
    int lastMonth = -1;
    int lastYear = -1;
    Map types = {"expense": 1, "income": 2};

    for (var expense in expenses) {
      int dateNumber = expense.date.day;
      int monthNumber = expense.date.month;
      int yearNumber = expense.date.year;

      DateTime daily = DateTime(yearNumber, monthNumber, dateNumber);
      DateTime monthly = DateTime(yearNumber, monthNumber);
      DateTime yearly = DateTime(yearNumber);

      double income = expense.type == "income" ? expense.amount : 0;
      double expend = expense.type == "expense" ? expense.amount : 0;

      if (groupByDay.isNotEmpty && groupByDay[lastDay][0] == daily) {
        groupByDay[lastDay][types[expense.type]] += expense.amount;
        groupByDay[lastDay][3].add(expense);
      } else {
        groupByDay.add([
          daily,
          expend,
          income,
          [expense]
        ]);
        lastDay++;
      }

      if (groupByMonth.isNotEmpty && groupByMonth[lastMonth][0] == monthly) {
        groupByMonth[lastMonth][types[expense.type]] += expense.amount;
        groupByMonth[lastMonth][3].add(expense);
      } else {
        groupByMonth.add([
          monthly,
          expend,
          income,
          [expense]
        ]);
        lastMonth++;
      }

      if (groupByYear.isNotEmpty && groupByYear[lastYear][0] == yearly) {
        groupByYear[lastYear][types[expense.type]] += expense.amount;
        groupByYear[lastYear][3].add(expense);
      } else {
        groupByYear.add([
          yearly,
          expend,
          income,
          [expense]
        ]);
        lastYear++;
      }
    }

    for (var i = 0; i < groupByDay.length; i++) {
      dataIndexes["groupByDay"][groupByDay[i][0]] = i;
    }
    for (var i = 0; i < groupByMonth.length; i++) {
      dataIndexes["groupByMonth"][groupByMonth[i][0]] = i;
    }
    for (var i = 0; i < groupByYear.length; i++) {
      dataIndexes["groupByYear"][groupByYear[i][0]] = i;
    }

    return {
      'groupByDay': groupByDay,
      'groupByMonth': groupByMonth,
      'groupByYear': groupByYear,
    };
  }

  void dividing(grouped) {
    for (var group in grouped) {
      List dtos = group[3];
      Map category = {};

      for (var dto in dtos) {
        if (category.containsKey(dto.category)) {
          category[dto.category][0] += dto.amount;
        } else {
          category[dto.category] = [
            dto.amount,
            dto.type,
            dto.user_id,
            dto.date
          ];
        }
      }

      List categories = [];
      for (var key in category.keys) {
        categories.add(ExpenseDto(
            user_id: category[key][2],
            type: category[key][1],
            category: key,
            date: category[key][3],
            amount: category[key][0]));
      }
      group[3] = categories;
    }
  }

  Map organizeBudget(List<BudgetDto> budgets, Map organized, Map dataIndexes) {
    List groupByDay = [];
    List groupByMonth = [];
    List groupByYear = [];
    budgets.sort((a, b) => b.date.compareTo(a.date));
    for (var budget in budgets) {
      int dateNumber = budget.date.day;
      int monthNumber = budget.date.month;
      int yearNumber = budget.date.year;

      DateTime daily = DateTime(yearNumber, monthNumber, dateNumber);
      DateTime monthly = DateTime(yearNumber, monthNumber);
      DateTime yearly = DateTime(yearNumber);

      if (budget.type == "monthly") {
        if (dataIndexes["groupByMonth"].containsKey(monthly)) {
          int index = dataIndexes["groupByMonth"][monthly];
          double expend = organized["groupByMonth"][index][1];
          double income = organized["groupByMonth"][index][2];
          budget.income = income;
          budget.expense = expend;
        }
        groupByMonth.add(budget);
      } else if (budget.type == "yearly") {
        if ((dataIndexes["groupByYear"]).containsKey(yearly)) {
          int index = dataIndexes["groupByYear"][yearly];
          double expend = organized["groupByYear"][index][1];
          double income = organized["groupByYear"][index][2];
          budget.income = income;
          budget.expense = expend;
        }
        groupByYear.add(budget);
      }
    }
    return {
      'groupByDay': groupByDay,
      'groupByMonth': groupByMonth,
      'groupByYear': groupByYear,
    };
  }
}
