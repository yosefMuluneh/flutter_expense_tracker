import 'package:equatable/equatable.dart';
import 'package:expense_tracker/fetcher.dart';
import 'package:expense_tracker/user_dto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final Fetcher _fetcher;

  SignupCubit(this._fetcher) : super(SignupState.initial());

  void userNameChanged(String value) {
    emit(
      state.copyWith(
        username: value,
        status: SignupStatus.initial,
      ),
    );
  }

  void passwordChanged(String value) {
    emit(
      state.copyWith(
        password: value,
        status: SignupStatus.initial,
      ),
    );
  }

  Future<void> signupFormSubmitted() async {
    if (state.status == SignupStatus.submitting) return;
    emit(state.copyWith(status: SignupStatus.submitting));
    try {
      print("===========submitting == ${state.username}}");
      User? user = await _fetcher.signUpUser(
        username: state.username,
        password: state.password,
      );
      print("===========Completed == ${state.username}}");

      if (user != User.empty) {
        emit(state.copyWith(status: SignupStatus.success));
      }
    } catch (_) {}
  }
}
