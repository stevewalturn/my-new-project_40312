import 'package:flutter/material.dart';
import 'package:my_app_123/app/app.router.dart';
import 'package:my_app_123/l10n/supported_locales.dart';
import 'package:my_app_123/observer/screen_observer.dart';
import 'package:my_app_123/ui/views/app/app_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppViewModel>.reactive(
      viewModelBuilder: AppViewModel.new,
      builder: (context, viewModel, child) {
        if (viewModel.modelError != null) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text(
                  'Error initializing app: ${viewModel.modelError.toString()}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ),
          );
        }
        return const _App();
      },
    );
  }
}

class _App extends ViewModelWidget<AppViewModel> {
  const _App();

  @override
  Widget build(BuildContext context, AppViewModel viewModel) {
    return MediaQuery.withClampedTextScaling(
      maxScaleFactor: 1.5,
      minScaleFactor: 0.5,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: MaterialApp(
          title: 'My App 123',
          initialRoute: Routes.startupView,
          onGenerateRoute: StackedRouter().onGenerateRoute,
          navigatorKey: StackedService.navigatorKey,
          navigatorObservers: [
            StackedService.routeObserver,
            ScreenObserver(),
          ],
          localizationsDelegates: localizationsDelegates,
          supportedLocales: supportedLocales,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child!,
            );
          },
        ),
      ),
    );
  }
}
