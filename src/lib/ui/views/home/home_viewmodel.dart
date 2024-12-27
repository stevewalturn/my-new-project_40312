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

  void incrementCounter() {
    try {
      _counter++;
      notifyListeners();
    } catch (e) {
      setError('Failed to increment counter');
    }
  }

  Future<void> showDialog() async {
    try {
      await _dialogService.showCustomDialog(
        variant: DialogType.infoAlert,
        title: 'Steve Rocks!',
        description: 'Give steve $_counter stars on Github',
      );
    } catch (e) {
      setError('Failed to show dialog');
    }
  }

  Future<void> showBottomSheet() async {
    try {
      await _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.notice,
        title: 'Notice',
        description: 'This is a notice bottom sheet',
      );
    } catch (e) {
      setError('Failed to show bottom sheet');
    }
  }
}
