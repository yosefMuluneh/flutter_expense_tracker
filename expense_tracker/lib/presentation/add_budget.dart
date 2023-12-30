import 'package:expense_tracker/application/auth/login/login_cubit.dart';
import 'package:expense_tracker/application/expense_bloc/expense_bloc.dart';
import 'package:expense_tracker/budget.dto.dart';
import 'package:expense_tracker/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class AddBudgetPage extends StatefulWidget {
  const AddBudgetPage({Key? key}) : super(key: key);

  @override
  State<AddBudgetPage> createState() => _AddBudgetPageState();
}

class _AddBudgetPageState extends State<AddBudgetPage> {
  String selectedTimeFrame = "Monthly";

  final _amountController = TextEditingController();
  final _amountGlobalKey = GlobalKey<FormState>();
  double amount = 0.0;

  @override
  void initState() {
    // final expenseBloc = BlocProvider.of<ExpenseBloc>(context);
    super.initState();
  }

  void setCategory(String category, String type) {
    setState(() {
      selectedTimeFrame = category;
    });
  }

  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('MMMM d, yyyy');
    BlocListener(listener: (context, state) {
      if (state is ExpenseError) {
        showSnackBar(context, state.message);
      } else {
        showSnackBar(context, "Budget Created Successfully");
      }
    });
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 239, 239),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Add new Budjet",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Form(
        key: _amountGlobalKey,
        child: Column(
          children: [
            Container(
              height: 120,
              color: Colors.purple,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 35, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 129, 37, 145),
                            shape: BoxShape.circle,
                          ),
                          child: const FaIcon(FontAwesomeIcons.solidCalendarAlt,
                              color: Colors.white),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          selectedTimeFrame,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "$amount",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 30),
                                ),
                              ],
                            ),
                            const Icon(
                              Icons.attach_money,
                              color: Colors.white,
                              size: 40,
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          "amount",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.date_range_outlined),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "Date",
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                formatter.format(_selectedDate),
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Color.fromARGB(255, 130, 130, 130),
                            size: 18,
                          )
                        ],
                      ),
                      onTap: () => _selectDate(context),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          amount = value.isEmpty ? 0.0 : double.parse(value);
                        });
                      },
                      controller: _amountController,
                      keyboardType:
                          TextInputType.number, // Set keyboard to number only
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an amount';
                        }
                        return null;
                      }, // Add input validation
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        hintText: "Amount",
                        // labelText: 'Amount', // Add label text
                        prefixIcon:
                            Icon(Icons.attach_money), // Add icon on left
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return TimeFrameChoice(
                                  onCategorySelected: setCategory);
                            },
                          );
                        },
                        child: const Text('Choose Time Frame'),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (_amountGlobalKey.currentState!.validate()) {
                              BlocProvider.of<ExpenseBloc>(context).add(
                                AddBudjet(
                                  budget: BudgetDto(
                                      user_id:
                                          BlocProvider.of<LoginCubit>(context)
                                              .state
                                              .user
                                              .id,
                                      type: selectedTimeFrame,
                                      date: _selectedDate,
                                      amount: amount),
                                ),
                              );
                              GoRouter.of(context).pop();
                            }
                          },
                          child: const Text("Done"))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TimeFrameChoice extends StatefulWidget {
  final Function(String, String) onCategorySelected;
  const TimeFrameChoice({super.key, required this.onCategorySelected});

  @override
  State<TimeFrameChoice> createState() => _TimeFrameChoiceState();
}

class _TimeFrameChoiceState extends State<TimeFrameChoice> {
  final List<String> timeFrame = [
    'Monthly',
    'Yearly',
  ];

  void _handleCategoryTap(BuildContext context, String category, String type) {
    widget.onCategorySelected(category, type);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Choose Time Frame",
            style: TextStyle(fontSize: 18),
          ),
          automaticallyImplyLeading: false,
        ),
        body: ListView.builder(
          itemCount: timeFrame.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(6),
              child: GestureDetector(
                onTap: () =>
                    _handleCategoryTap(context, timeFrame[index], "expense"),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 5, 50, 5),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 218, 218, 218),
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        timeFrame[index],
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
