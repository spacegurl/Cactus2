import 'package:cactus/features/features.dart';
import 'package:cactus/generated/assets.dart';
import 'package:cactus/ui/ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/core.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<AuthBloc, AuthState>(
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
          final lastEvent = context.read<AuthBloc>().lastEvent;

          if (lastEvent is AuthLogoutRequested) {
            context.read<HistoryBloc>().add(HistoryCacheClean());
            return;
          }

          context.read<WikipediaPlantsBloc>().add(WikipediaPlantsFetched());

          if (lastEvent is AuthLogged) {
            context.read<HistoryBloc>().add(HistoryFetched());
          }
        }
      },
      builder: (context, state) {
        final user = FirebaseAuth.instance.currentUser;
        final userName = user?.displayName;
        final userEmail = user?.email;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(Assets.assetsLogo),
                  const SizedBox(height: 20),
                  Text(
                    'Добро пожаловать, ${userName ?? 'Гость'}!',
                    style: theme.textTheme.bodyLarge,
                  ),
                  if (userEmail != null) ...[
                    const SizedBox(height: 3),
                    Text(
                      userEmail,
                      style: theme.textTheme.bodyMedium!.copyWith(
                        color: AppColors.kDescriptionColor,
                      ),
                    ),
                  ],
                  const SizedBox(height: 50),
                  if (user == null) ...[
                    CustomElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(RouteNames.login);
                      },
                      title: 'Авторизация',
                    ),
                    const SizedBox(height: 10),
                    CustomElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(RouteNames.register);
                      },
                      title: 'Регистрация',
                    ),
                  ] else
                    CustomElevatedButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(AuthLogoutRequested());
                      },
                      title: 'Выйти из аккаунта',
                    ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
