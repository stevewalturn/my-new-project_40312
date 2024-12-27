import 'package:stacked/stacked.dart';

class NoticeSheetModel extends BaseViewModel {
  void handleNoticeAction() {
    try {
      // Handle notice action
    } catch (e) {
      setError('Failed to process notice action');
    }
  }
}
