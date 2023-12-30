import 'package:expense_tracker/application/auth/login/login_cubit.dart';
import 'package:expense_tracker/application/expense_bloc/expense_bloc.dart';
import 'package:expense_tracker/expense.dto.dart';
import 'package:expense_tracker/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    final expenseBloc = BlocProvider.of<ExpenseBloc>(context);
    final authBloc = BlocProvider.of<LoginCubit>(context);
    expenseBloc.add(LoadExpense(id: authBloc.state.user.id));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseBloc, ExpenseState>(
      builder: (context, state) {
        if (state is ExpenseInitial) {
          return DefaultTabController(
            length: 3,
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.purple,
                  title: const Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                    child: Text(
                      "Balance: 0\$",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  bottom: const TabBar(
                      indicatorColor: Colors.white,
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.yellow,
                      tabs: [
                        Tab(
                          text: "Daily",
                        ),
                        Tab(
                          text: "Monthly",
                        ),
                        Tab(
                          text: "Yearly",
                        )
                      ]),
                ),
                // body: const Center(child: CircularProgressIndicator()));
                body: (const TabBarView(children: [
                  Center(child: CircularProgressIndicator()),
                  Center(child: CircularProgressIndicator()),
                  Center(child: CircularProgressIndicator()),
                ]))),
          );
        } else if (state is ExpenseError) {
          return const Center(
            child: Text("Error While Fetching"),
          );
        } else if (state is ExpenseLoaded) {
          double balance = state.balance["balance"];
          return DefaultTabController(
            length: 3,
            child: Scaffold(
              floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    GoRouter.of(context).push("/home/addExpense");
                  },
                  child: const Icon(Icons.add)),
              appBar: AppBar(
                backgroundColor: Colors.purple,
                title: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: Text(
                    "Balance:  $balance \$",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.logout),
                    color: Colors.white,
                    onPressed: () {
                      BlocProvider.of<LoginCubit>(context).logout();
                      GoRouter.of(context).go("/");
                    },
                  )
                ],
                bottom: const TabBar(
                    indicatorColor: Colors.white,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.yellow,
                    tabs: [
                      Tab(
                        text: "Daily",
                      ),
                      Tab(
                        text: "Monthly",
                      ),
                      Tab(
                        text: "Yearly",
                      )
                    ]),
              ),
              body: const TabBarView(children: [
                TimeFrame(timeFrame: "groupByDay"),
                TimeFrame(timeFrame: "groupByMonth"),
                TimeFrame(timeFrame: "groupByYear"),
              ]),
            ),
          );
        }
        return const Column();
      },
    );
  }
}

class TimeFrame extends StatefulWidget {
  final String timeFrame;
  const TimeFrame({Key? key, required this.timeFrame}) : super(key: key);

  @override
  State<TimeFrame> createState() => _TimeFrameState();
}

class _TimeFrameState extends State<TimeFrame> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseBloc, ExpenseState>(builder: (context, state) {
      if (state is ExpenseLoaded) {
        return ListView.separated(
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 35,
            );
          },
          itemCount: state.expenses[widget.timeFrame].length,
          itemBuilder: (context, index) {
            Map group = {
              "groupByDay": DateFormat('MMMM d, yyyy'),
              "groupByMonth": DateFormat('MMMM, yyyy'),
              "groupByYear": DateFormat('yyyy')
            };
            final DateFormat formatter = group[widget.timeFrame];
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 7, 15, 7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color.fromARGB(255, 234, 234, 234)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formatter
                            .format(state.expenses[widget.timeFrame][index][0]),
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              const Text("Expense ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Colors.blue)),
                              Text(
                                state.expenses[widget.timeFrame][index][1]
                                    .toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const SizedBox(width: 20),
                          Row(
                            children: [
                              const Text("Income ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Colors.blue)),
                              Text(
                                state.expenses[widget.timeFrame][index][2]
                                    .toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                if (state.expenses[widget.timeFrame][index][3] != null &&
                    state.expenses[widget.timeFrame][index][3].isNotEmpty)
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount:
                        state.expenses[widget.timeFrame][index][3].length,
                    itemBuilder: (context, index1) {
                      String amount = state
                          .expenses[widget.timeFrame][index][3][index1].amount
                          .toString();
                      String type = state
                          .expenses[widget.timeFrame][index][3][index1].type;
                      ExpenseDto expenseDetail =
                          state.expenses[widget.timeFrame][index][3][index1];

                      return Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                catagory[state
                                    .expenses[widget.timeFrame][index][3]
                                        [index1]
                                    .category],
                                const SizedBox(width: 10),
                                Text(
                                  state
                                      .expenses[widget.timeFrame][index][3]
                                          [index1]
                                      .category
                                      .toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      type == "income"
                                          ? "+ $amount"
                                          : "-$amount",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const Text(" \$"),
                                    widget.timeFrame == "groupByDay"
                                        ? IconButton(
                                            onPressed: () {
                                              BlocProvider.of<ExpenseBloc>(
                                                      context)
                                                  .add(DeleteExpense(
                                                      expense: expenseDetail));
                                            },
                                            icon: const Icon(Icons.delete),
                                            color: const Color.fromARGB(
                                                255, 75, 12, 7),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
              ],
            );
          },
        );
      } else if (state is ExpenseError) {
        return Center(child: Text(state.message));
      } else {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.purple,
                title: const Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: Text(
                    "Balance: 0\$",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                bottom: const TabBar(
                    indicatorColor: Colors.white,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.yellow,
                    tabs: [
                      Tab(
                        text: "Daily",
                      ),
                      Tab(
                        text: "Monthly",
                      ),
                      Tab(
                        text: "Yearly",
                      )
                    ]),
              ),
              // body: const Center(child: CircularProgressIndicator()));
              body: (const TabBarView(children: [
                Center(child: CircularProgressIndicator()),
                Center(child: CircularProgressIndicator()),
                Center(child: CircularProgressIndicator()),
              ]))),
        );
      }
    });
  }
}
