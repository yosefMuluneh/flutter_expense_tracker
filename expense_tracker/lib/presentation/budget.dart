import 'package:expense_tracker/application/auth/login/login_cubit.dart';
import 'package:expense_tracker/application/expense_bloc/expense_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class Budget extends StatefulWidget {
  const Budget({Key? key}) : super(key: key);

  @override
  State<Budget> createState() => _BudgetState();
}

class _BudgetState extends State<Budget> {
  @override
  void initState() {
    final expenseBloc = BlocProvider.of<ExpenseBloc>(context);
    final authBloc = BlocProvider.of<LoginCubit>(context);
    expenseBloc.add(LoadExpense(id: authBloc.state.user.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              GoRouter.of(context).push("/home/addbudget");
            },
            child: const Icon(Icons.add)),
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: const Text(
            "Expense Tracker",
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.w400),
          ),
          bottom: const TabBar(
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.yellow,
              tabs: [
                Tab(
                  text: "Monthly",
                ),
                Tab(
                  text: "Yearly",
                )
              ]),
        ),
        body: const TabBarView(children: [
          TimeFrameBudget(timeFrame: "groupByMonth"),
          TimeFrameBudget(timeFrame: "groupByYear"),
        ]),
      ),
    );
  }
}

class TimeFrameBudget extends StatefulWidget {
  final String timeFrame;
  const TimeFrameBudget({Key? key, required this.timeFrame}) : super(key: key);

  @override
  State<TimeFrameBudget> createState() => _TimeFrameBudgetState();
}

class _TimeFrameBudgetState extends State<TimeFrameBudget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseBloc, ExpenseState>(builder: (context, state) {
      if (state is ExpenseLoaded) {
        List items = state.budgets[widget.timeFrame];
        return ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              String dateFormat = widget.timeFrame == "groupByMonth"
                  ? DateFormat.yMMMM().format(items[index].date)
                  : DateFormat.y().format(items[index].date);
              double amount =
                  double.parse(items[index].amount.toStringAsFixed(2));
              double expense =
                  double.parse(items[index].expense.toStringAsFixed(2));
              double income =
                  double.parse(items[index].income.toStringAsFixed(2));
              return Container(
                padding: const EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(2, 3, 0, 3),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromARGB(255, 238, 238, 238),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            dateFormat,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                          IconButton(
                            onPressed: () {
                              BlocProvider.of<ExpenseBloc>(context)
                                  .add(DeleteBudget(budget: items[index]));
                            },
                            icon: const Icon(Icons.delete),
                            color: Color.fromARGB(255, 75, 12, 7),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 3),

                    TextStyling(
                        text: "Amount Budgeted", text2: amount, type: 1),
                    const SizedBox(height: 3),
                    TextStyling(text: "Amount Spent", text2: expense, type: 2),
                    const SizedBox(height: 3),

                    TextStyling(
                        text: "Amount Saved", text2: amount - expense, type: 3),
                    // TextStyling(
                    //     text: "Expected Saving",
                    //     text2: income - amount,
                    //     type: 4),
                  ],
                ),
              );
            });
      } else if (state is ExpenseError) {
        return Center(child: Text(state.message));
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    });
  }
}

class TextStyling extends StatelessWidget {
  final String text;
  final double text2;
  final int type;
  final Map colors = {1: Colors.green, 2: Colors.red, 3: Colors.blue};
  // final Map saving = {1: FontAwesomeIcons.medkit, 2: FontAwesomeIcons.expe, 3: Colors.blue};

  TextStyling(
      {Key? key, required this.text, required this.text2, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 2, 25, 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                FontAwesomeIcons.arrowCircleRight,
                color: colors[type],
                size: 15,
              ),
              const SizedBox(width: 5),
              Text(
                text,
                style: textStyling,
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "$text2",
                style: textStyling,
              ),
              const Icon(Icons.attach_money, size: 15),
            ],
          )
        ],
      ),
    );
  }
}

TextStyle textStyling = const TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w400,
);
