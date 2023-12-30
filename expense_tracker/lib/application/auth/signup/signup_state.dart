// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'signup_cubit.dart';

enum SignupStatus { initial, submitting, success, error }

class SignupState extends Equatable {
  final String username;
  final String password;
  final SignupStatus status;

  const SignupState({
    required this.username,
    required this.password,
    required this.status,
  });

  factory SignupState.initial() {
    return const SignupState(
      username: "",
      password: "",
      status: SignupStatus.initial,
    );
  }

  SignupState copyWith({
    String? username,
    String? password,
    SignupStatus? status,
  }) {
    return SignupState(
      username: username ?? this.username,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        username,
        password,
        status,
      ];
}
