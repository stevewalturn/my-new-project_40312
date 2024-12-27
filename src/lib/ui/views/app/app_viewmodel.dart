import 'package:stacked/stacked.dart';

class AppViewModel extends BaseViewModel {
  Future<void> init() async {
    try {
      // Initialize app-level services here
      await Future.wait([
        // Add initialization of services
      ]);
    } catch (e) {
      setError('Failed to initialize app: Please restart the application');
    }
  }
}
