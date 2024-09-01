import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validation_bloc/screens/login/bloc/login_event.dart';
import 'package:form_validation_bloc/screens/login/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState()) {
    on<SignInTextChangedEvent>(
      (event, emit) {
        if (EmailValidator.validate(event.emailValue) == false) {
          emit(LoginErrorState('Please enter valid Email Address'));
        } else if (event.passwordValue.length < 8) {
          emit(LoginErrorState('Please enter valid password'));
        } else {
          emit(LoginValidState());
        }
      },
    );
    on<SignInSubmittedEvent>(
      (event, emit) => emit(LoginLoadingState()),
    );
  }
}
