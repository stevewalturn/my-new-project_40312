import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app_123/app/app.bottomsheets.dart';
import 'package:my_app_123/app/app.dialogs.dart';
import 'package:my_app_123/app/app.locator.dart';
import 'package:my_app_123/models/enums/flavor.dart';
import 'package:my_app_123/utils/flavors/flavors.dart';

Future<void> bootstrap({
  required FutureOr<Widget> Function() builder,
  required Flavor flavor,
}) async {
  await runZonedGuarded(
    () async {
      try {
        Flavors.flavor = flavor;
        WidgetsFlutterBinding.ensureInitialized();

        await SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);

        await setupLocator();
        setupDialogUi();
        setupBottomSheetUi();

        runApp(await builder());
      } catch (e, s) {
        debugPrint('Error during app initialization: $e\n$s');
        runApp(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text(
                  'Failed to start app: Please try again',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          ),
        );
      }
    },
    (error, stack) {
      debugPrint('Unhandled error: $error\n$stack');
    },
  );
}
