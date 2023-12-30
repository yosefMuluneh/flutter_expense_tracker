part of 'login_cubit.dart';

enum LoginStatus { initial, submitting, success, error }

class LoginState extends Equatable {
  final String username;
  final String password;
  final LoginStatus status;
  final User user;
  final String error;

  const LoginState({
    required this.error,
    required this.username,
    required this.password,
    required this.status,
    required this.user,
  });

  factory LoginState.initial() {
    return LoginState(
      user: User.empty,
      error: '',
      username: '',
      password: '',
      status: LoginStatus.initial,
    );
  }

  LoginState copyWith({
    String? username,
    String? password,
    LoginStatus? status,
    User? user,
    String? error,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      status: status ?? this.status,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [username, password, status];
}
