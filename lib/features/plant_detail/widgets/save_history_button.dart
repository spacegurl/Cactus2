import 'dart:io';

import 'package:cactus/core/core.dart';
import 'package:cactus/repo/repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_imagekit/flutter_imagekit.dart';

import '../../../ui/ui.dart';
import '../../features.dart';

class SaveHistoryButton extends StatefulWidget {
  const SaveHistoryButton({super.key, this.plant, required this.scannedFile});

  final PlantModel? plant;
  final File scannedFile;

  @override
  State<SaveHistoryButton> createState() => _SaveHistoryButtonState();
}

class _SaveHistoryButtonState extends State<SaveHistoryButton> {
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final user = FirebaseAuth.instance.currentUser;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 50),
            CustomElevatedButton(
              onPressed: widget.plant == null || user == null
                  ? null
                  : () async => _createHistory(user),
              title: 'Сохранить в историю',
              isLoading: isLoading,
            ),
            if (user == null)
              const Center(
                child: Text(
                  'Для сохранения в историю, необходимо быть авторизованным',
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        );
      },
    );
  }

  Future<void> _createHistory(User user) async {
    final historyBloc = context.read<HistoryBloc>();
    final navigator = Navigator.of(context);

    setState(() {
      isLoading = true;
    });

    try {
      final String url = await ImageKit.io(
        widget.scannedFile,
        privateKey: "private_w8b7dUgHXW8fekYtsw8AFfcroS8=",
        onUploadProgress: (progressValue) {},
      );

      historyBloc.add(
        HistoryCreated(
          history: HistoryModel(
            id: '',
            plantId: widget.plant!.id,
            ownerId: user.uid,
            imageUrl: url,
            scannedAt: DateTime.now(),
          ),
        ),
      );

      setState(() {
        isLoading = false;
      });

      navigator.pop();
    } catch (e) {
      UiUtils.showSnackBar(context, 'Ошибка при добавлении изображения: $e');
    }
  }
}
