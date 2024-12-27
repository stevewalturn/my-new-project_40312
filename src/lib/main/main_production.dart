import 'package:my_app_123/main/bootstrap.dart';
import 'package:my_app_123/models/enums/flavor.dart';
import 'package:my_app_123/ui/views/app/app_view.dart';

void main() {
  bootstrap(
    builder: () => const AppView(),
    flavor: Flavor.production,
  );
}
