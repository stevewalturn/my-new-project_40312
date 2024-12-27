import 'package:my_app_123/app/app.bottomsheets.dart';
import 'package:my_app_123/app/app.dialogs.dart';
import 'package:my_app_123/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();

  String get counterLabel => 'Counter is: $_counter';
  int _counter = 0;

  List<FeatureItem> get features => [
        FeatureItem(
          title: 'Stacked Architecture',
          description:
              'This app uses Stacked Architecture for clean, maintainable code',
          icon: '🏗️',
        ),
        FeatureItem(
          title: 'State Management',
          description: 'Built-in reactive state management for smooth updates',
          icon: '⚡',
        ),
        FeatureItem(
          title: 'Navigation',
          description: 'Easy-to-use navigation with full type safety',
          icon: '🧭',
        ),
        FeatureItem(
          title: 'Service Layer',
          description: 'Dedicated service layer for business logic separation',
          icon: '🔧',
        ),
      ];

  void incrementCounter() {
    _counter++;
    rebuildUi();
  }

  void showDialog() {
    _dialogService.showCustomDialog(
      variant: DialogType.infoAlert,
      title: 'Welcome to Stacked!',
      description: 'This is a powerful architecture with $_counter features',
    );
  }

  void showBottomSheet() {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.notice,
      title: 'Stacked Architecture',
      description: 'Building scalable apps made easy',
    );
  }
}

class FeatureItem {
  final String title;
  final String description;
  final String icon;

  FeatureItem({
    required this.title,
    required this.description,
    required this.icon,
  });
}
