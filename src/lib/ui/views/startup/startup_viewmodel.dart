import 'package:my_app_123/app/app.locator.dart';
import 'package:my_app_123/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  Future<void> runStartupLogic() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      await _navigationService.replaceWithHomeView();
    } catch (e) {
      setError('Failed to initialize app: Please try again');
    }
  }
}
