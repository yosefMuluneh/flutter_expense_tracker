import 'package:expense_tracker/application/auth/login/login_cubit.dart';
import 'package:expense_tracker/application/expense_bloc/expense_bloc.dart';
import 'package:expense_tracker/expense.dto.dart';
import 'package:expense_tracker/presentation/choose_catagory.dart';
import 'package:expense_tracker/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({Key? key}) : super(key: key);

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  String selectedCategory = "Food";
  String selectedType = "expense";
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
      selectedCategory = category;
      selectedType = type;
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
        showSnackBar(context, "Expense Added Succussfully");
      }
    });

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 239, 239),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Add new Expense",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          Form(
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
                            catagory[selectedCategory],
                            const SizedBox(height: 6),
                            Text(
                              selectedCategory,
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
                                      selectedType == "income" ? "+" : "-",
                                      style: TextStyle(
                                          color: selectedType == 'expense'
                                              ? const Color.fromARGB(
                                                  255, 255, 21, 21)
                                              : Colors.green,
                                          fontSize: 30),
                                    ),
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
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
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
                              amount =
                                  value.isEmpty ? 0.0 : double.parse(value);
                            });
                          },
                          controller: _amountController,
                          keyboardType: TextInputType
                              .number, // Set keyboard to number only
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
                                  return CategoryList(
                                      onCategorySelected: setCategory);
                                },
                              );
                            },
                            child: const Text('Choose Category'),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                if (_amountGlobalKey.currentState!.validate()) {
                                  BlocProvider.of<ExpenseBloc>(context).add(
                                    AddExpense(
                                      expense: ExpenseDto(
                                          user_id: BlocProvider.of<LoginCubit>(
                                                  context)
                                              .state
                                              .user
                                              .id,
                                          type: selectedType,
                                          category: selectedCategory,
                                          date: _selectedDate,
                                          amount: amount),
                                    ),
                                  );
                                  GoRouter.of(context).pop();
                                }
                              },
                              child: const Text("Save"))
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
