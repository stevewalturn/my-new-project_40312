import 'package:flutter/material.dart';
import 'package:my_app_123/services/analytic_service.dart';
import 'package:my_app_123/app/app.locator.dart';

/// The [ScreenObserver] is a [NavigatorObserver] that
/// tracks screen views using the [AnalyticService].
class ScreenObserver extends NavigatorObserver {
  final _analyticService = locator<AnalyticService>();

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (_defaultRouteFilter(route)) {
      _trackScreenView(route);
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute != null && _defaultRouteFilter(newRoute)) {
      _trackScreenView(newRoute);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute != null &&
        _defaultRouteFilter(previousRoute) &&
        _defaultRouteFilter(route)) {
      _trackScreenView(previousRoute);
    }
  }

  void _trackScreenView(Route<dynamic> route) {
    try {
      final screenName = _defaultNameExtractor(route.settings);
      if (screenName != null) {
        _analyticService.init();
      }
    } catch (e) {
      debugPrint('Failed to track screen view: ${e.toString()}');
    }
  }
}

bool _defaultRouteFilter(Route<dynamic>? route) {
  final routeName = route?.settings.name;
  return routeName != null && routeName.isNotEmpty;
}

String? _defaultNameExtractor(RouteSettings settings) {
  final routeName = settings.name;
  if (routeName?.isEmpty ?? true) {
    return null;
  }

  if (routeName!.contains('BottomSheet')) {
    final sheetName = routeName.split('.').last.split('_').first;
    return '$sheetName-bottom-sheet';
  }

  return routeName.replaceAll('/', '');
}
