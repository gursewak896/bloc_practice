abstract class LoginEvent {}

class SignInTextChangedEvent extends LoginEvent {
  final String emailValue;
  final String passwordValue;

  SignInTextChangedEvent(this.emailValue, this.passwordValue);
}

class SignInSubmittedEvent extends LoginEvent {
  final String email;
  final String password;

  SignInSubmittedEvent(this.email, this.password);
}
