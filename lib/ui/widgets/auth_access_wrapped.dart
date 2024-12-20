import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/features.dart';

class AuthAccessWrapped extends StatelessWidget {
  const AuthAccessWrapped({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final user = FirebaseAuth.instance.currentUser;

        if (user == null) {
          return Center(
            child: Text(
              'Для доступа к данным необходимо быть авторизованным',
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          );
        }

        return child;
      },
    );
  }
}
