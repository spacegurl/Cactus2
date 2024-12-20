import 'package:cactus/core/core.dart';
import 'package:cactus/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc.dart';

final _formKey = GlobalKey<FormState>();

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Регистрация'),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            UiUtils.showSnackBar(
              context,
              ExceptionUtils.clearMessage(state.error),
              color: Colors.red,
            );
            return;
          }

          if (state is AuthSuccess) {
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTextField(
                      controller: nameController,
                      hintText: 'Иван',
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.sentences,
                      validator: Validators.validateName,
                    ),
                    CustomTextField(
                      controller: emailController,
                      hintText: 'ivan@yandex.ru',
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      validator: Validators.validateEmail,
                    ),
                    CustomTextField(
                      controller: passwordController,
                      hintText: '***',
                      keyboardType: TextInputType.visiblePassword,
                      validator: Validators.validatePassword,
                      obscureText: true,
                      marginBottom: 0,
                    ),
                    const SizedBox(height: 50),
                    CustomElevatedButton(
                      onPressed: () {
                        if (!_validate()) return;

                        _register();
                      },
                      title: 'Создать аккаунт',
                      isLoading: state is AuthLoading,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  bool _validate() {
    if (!_formKey.currentState!.validate()) return false;
    _formKey.currentState!.save();

    return true;
  }

  void _register() {
    context.read<AuthBloc>().add(
          AuthRegistered(
            name: nameController.text,
            email: emailController.text,
            password: passwordController.text,
          ),
        );
  }
}
