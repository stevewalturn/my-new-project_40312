import 'package:my_app_123/services/shared_preferences_service.dart';
import 'package:my_app_123/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:my_app_123/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:my_app_123/ui/views/home/home_view.dart';
import 'package:my_app_123/ui/views/patient/patient_view.dart';
import 'package:my_app_123/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: PatientView),
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: SharedPreferencesService),
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
  ],
)
class App {}
