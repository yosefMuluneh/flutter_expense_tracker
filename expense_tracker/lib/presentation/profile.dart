// ignore_for_file: use_build_context_synchronously

import 'package:expense_tracker/application/auth/login/login_cubit.dart';
import 'package:expense_tracker/presentation/collabsible.dart';
import 'package:expense_tracker/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _oldPassController = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final _changePassGlobalKey = GlobalKey<FormState>();
  final bool _forceCollapse = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account setting"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Card(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.person,
                          size: 35,
                        ),
                        const SizedBox(width: 10),
                        Text(
                            "Username  ${BlocProvider.of<LoginCubit>(context).state.user.username}"),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                child: Container(
                  padding: const EdgeInsets.all(7),
                  child: Collapsible(
                    forceCollapse: [_forceCollapse],
                    title: "Change passowrd",
                    child: Form(
                      key: _changePassGlobalKey,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _oldPassController,
                              validator: (value) {
                                if (value!.isEmpty || value == "") {
                                  return "Please fill your old password";
                                } else if (_oldPassController.text.length < 6) {
                                  return "passowrd should be at least 6 characters";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                labelText: "Old Password",
                              ),
                            ),
                            TextFormField(
                              controller: _newPassController,
                              validator: (value) {
                                if (value!.isEmpty || value == "") {
                                  return "Please fill your new password";
                                } else if (_newPassController.text.length < 6) {
                                  return "passowrd should be at least 6 characters";
                                }

                                return null;
                              },
                              decoration: const InputDecoration(
                                labelText: "New password",
                              ),
                            ),
                            TextFormField(
                              controller: _confirmPassController,
                              validator: (value) {
                                if (value!.isEmpty || value == "") {
                                  return "Please confirm your password";
                                } else if (_newPassController.text !=
                                    _confirmPassController.text) {
                                  return "Password do not match";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                labelText: "Confirm password",
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Card(
                              child: SizedBox(
                                width: double.infinity,
                                child: TextButton(
                                    onPressed: () async {
                                      if (_changePassGlobalKey.currentState!
                                          .validate()) {
                                        String result =
                                            await BlocProvider.of<LoginCubit>(
                                                    context)
                                                .changePassowrd(
                                                    _oldPassController.text,
                                                    _newPassController.text,
                                                    BlocProvider.of<LoginCubit>(
                                                            context)
                                                        .state
                                                        .user
                                                        .id);
                                        if (result == "OK") {
                                          showSnackBar(context,
                                              "password changed successfully");
                                          setState(() {});
                                        } else {
                                          showSnackBar(context, result);
                                        }
                                      }
                                    },
                                    child: const Text("Change Password")),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                  child: Collapsible(
                      forceCollapse: [_forceCollapse],
                      title: "Sign out",
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Flexible(
                              child: Text(
                                "Do you really want to sign out?",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      setState(() {});
                                    },
                                    child: const Flexible(child: Text("No"))),
                                TextButton(
                                    onPressed: () {
                                      BlocProvider.of<LoginCubit>(context)
                                          .logout();
                                      GoRouter.of(context).go("/");
                                    },
                                    child: const Flexible(child: Text("Sure"))),
                              ],
                            )
                          ],
                        ),
                      )),
                ),
              ),
              Card(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                  child: Collapsible(
                      forceCollapse: [_forceCollapse],
                      title: "Delete account",
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Flexible(
                                child: Text(
                              "Your account will be permanently deleted",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      setState(() {});
                                    },
                                    child:
                                        const Flexible(child: Text("Cancel"))),
                                TextButton(
                                    onPressed: () async {
                                      bool result =
                                          await BlocProvider.of<LoginCubit>(
                                                  context)
                                              .deleteProfile(
                                                  BlocProvider.of<LoginCubit>(
                                                          context)
                                                      .state
                                                      .user
                                                      .id);
                                      if (result) {
                                        BlocProvider.of<LoginCubit>(context)
                                            .logout();
                                        GoRouter.of(context).go("/");
                                        showSnackBar(context,
                                            "Account has been deleted successfully");
                                      } else {
                                        GoRouter.of(context).go("/");
                                        showSnackBar(context,
                                            "Unable to delelte account");
                                      }
                                    },
                                    child: const Flexible(child: Text("Sure"))),
                              ],
                            )
                          ],
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
