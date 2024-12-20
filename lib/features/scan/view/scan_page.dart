import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

import '../../../core/core.dart';
import '../../../repo/repo.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CameraAwesomeBuilder.awesome(
      onMediaCaptureEvent: (event) {
        switch ((event.status, event.isPicture, event.isVideo)) {
          case (MediaCaptureStatus.capturing, true, false):
            debugPrint('Capturing picture...');
          case (MediaCaptureStatus.success, true, false):
            event.captureRequest.when(
              single: (single) async {
                debugPrint('Picture saved: ${single.file?.path}');

                if (single.file == null) {
                  return;
                }
                final scannedFile = File(single.file!.path);

                final navigator = Navigator.of(context);
                final plantsRepo = context.read<PlantRepo>();

                final scannedPlant = await plantsRepo.getScannedPlant();
                _showFullScreenDialog(navigator, scannedPlant, scannedFile);
              },
            );
          case (MediaCaptureStatus.failure, true, false):
            debugPrint('Failed to capture picture: ${event.exception}');
          default:
            debugPrint('Unknown event: $event');
        }
      },
      saveConfig: SaveConfig.photoAndVideo(
        initialCaptureMode: CaptureMode.photo,
        photoPathBuilder: (sensors) async {
          final Directory extDir = await getTemporaryDirectory();
          final testDir =
              await Directory('${extDir.path}/cactus2').create(recursive: true);

          final String filePath =
              '${testDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

          return SingleCaptureRequest(filePath, sensors.first);

          // final Directory extDir = await getTemporaryDirectory();
          // final testDir = await Directory(
          //   '${extDir.path}/cactus2',
          // ).create(recursive: true);
          // if (sensors.length == 1) {
          //   final String filePath =
          //       '${testDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
          //   return SingleCaptureRequest(filePath, sensors.first);
          // }
          // // Separate pictures taken with front and back camera
          // return MultipleCaptureRequest(
          //   {
          //     for (final sensor in sensors)
          //       sensor:
          //           '${testDir.path}/${sensor.position == SensorPosition.front ? 'front_' : "back_"}${DateTime.now().millisecondsSinceEpoch}.jpg',
          //   },
          // );
        },
      ),
      sensorConfig: SensorConfig.single(
        sensor: Sensor.position(SensorPosition.back),
        flashMode: FlashMode.none,
        aspectRatio: CameraAspectRatios.ratio_1_1,
        zoom: 0.0,
      ),
      enablePhysicalButton: true,
      previewAlignment: Alignment.center,
      previewFit: CameraPreviewFit.contain,
      availableFilters: [AwesomeFilter.None],
      topActionsBuilder: (state) => AwesomeTopActions(
        padding: EdgeInsets.zero,
        state: state,
        children: const [],
      ),
      bottomActionsBuilder: (state) => AwesomeBottomActions(state: state),
      middleContentBuilder: (state) {
        return Column(
          children: [
            const Spacer(),
            Builder(
              builder: (context) => Container(
                color: AwesomeThemeProvider.of(context)
                    .theme
                    .bottomActionsBackgroundColor,
                height: 8,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showFullScreenDialog(
    NavigatorState navigator,
    PlantModel? plant,
    File scannedFile,
  ) async {
    await navigator.pushNamed(
      RouteNames.plantDetail,
      arguments: {
        'scannedFile': scannedFile,
        'plant': plant,
      },
    );
  }
}
