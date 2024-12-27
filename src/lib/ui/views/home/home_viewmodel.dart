import 'package:my_app_123/app/app.bottomsheets.dart';
import 'package:my_app_123/app/app.dialogs.dart';
import 'package:my_app_123/app/app.locator.dart';
import 'package:my_app_123/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _navigationService = locator<NavigationService>();

  String get username => 'Steve';
  int get counter => _counter;

  int _counter = 0;

  void incrementCounter() {
    _counter++;
    rebuildUi();
  }

  void navigateToPatientRecords() {
    try {
      _navigationService.navigateToPatientView();
    } catch (e) {
      setError('Failed to navigate to patient records. Please try again.');
    }
  }

  void showDialog() {
    try {
      _dialogService.showCustomDialog(
        variant: DialogType.infoAlert,
        title: 'Counter Stats',
        description: 'Current count: $_counter\nLevel: ${(_counter ~/ 10 + 1)}',
      );
    } catch (e) {
      setError('Failed to show dialog. Please try again.');
    }
  }

  void showBottomSheet() {
    try {
      _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.notice,
        title: 'Your Progress',
        description:
            'You\'ve clicked the counter $_counter times! Keep going to reach the next level!',
      );
    } catch (e) {
      setError('Failed to show bottom sheet. Please try again.');
    }
  }
}
