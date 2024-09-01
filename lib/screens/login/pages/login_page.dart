import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validation_bloc/screens/login/bloc/login_bloc.dart';
import 'package:form_validation_bloc/screens/login/bloc/login_event.dart';
import 'package:form_validation_bloc/screens/login/bloc/login_state.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is LoginErrorState) {
                  return Text(
                    state.errorMessage,
                    style: const TextStyle(color: Colors.red),
                  );
                } else {
                  return Container();
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: emailController,
              onChanged: (val) {
                BlocProvider.of<LoginBloc>(context).add(SignInTextChangedEvent(
                    emailController.text, passwordController.text));
              },
              decoration: const InputDecoration(
                hintText: 'Email',
              ),
            ),
            TextField(
              controller: passwordController,
              onChanged: (val) {
                BlocProvider.of<LoginBloc>(context).add(SignInTextChangedEvent(
                    emailController.text, passwordController.text));
              },
              decoration: const InputDecoration(hintText: 'Password'),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              height: 36,
              child: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  if (state is LoginLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ElevatedButton(
                      onPressed: () {
                        if (state is LoginValidState) {
                          BlocProvider.of<LoginBloc>(context).add(
                              SignInSubmittedEvent(emailController.text,
                                  passwordController.text));
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor: (state is LoginValidState)
                              ? const WidgetStatePropertyAll(Colors.blue)
                              : const WidgetStatePropertyAll(Colors.grey),
                          foregroundColor:
                              const WidgetStatePropertyAll(Colors.white)),
                      child: const Text('Submit'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
