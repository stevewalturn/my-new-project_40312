import 'package:my_app_123/app/app.locator.dart';
import 'package:my_app_123/models/tamagochi.dart';
import 'package:my_app_123/services/shared_preferences_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class TamagotchiViewModel extends BaseViewModel {
  final _sharedPreferencesService = locator<SharedPreferencesService>();
  final _dialogService = locator<DialogService>();

  static const String _tamagotchiKey = 'current_tamagotchi';

  Tamagotchi? _tamagotchi;
  Tamagotchi? get tamagotchi => _tamagotchi;

  Future<void> initialize() async {
    try {
      setBusy(true);
      final savedTamagotchi =
          await _sharedPreferencesService.getData(_tamagotchiKey);
      if (savedTamagotchi != null) {
        _tamagotchi =
            Tamagotchi.fromJson(savedTamagotchi as Map<String, dynamic>);
        _checkStatus();
      }
    } catch (e) {
      setError('Failed to load your Tamagotchi. Please try again.');
    } finally {
      setBusy(false);
    }
  }

  Future<void> createNewTamagotchi(String name) async {
    try {
      if (name.isEmpty) {
        throw Exception('Please enter a name for your Tamagotchi');
      }
      _tamagotchi = Tamagotchi.create(name);
      await _saveTamagotchi();
      notifyListeners();
    } catch (e) {
      setError('Failed to create Tamagotchi. Please try again.');
    }
  }

  Future<void> feed() async {
    try {
      if (_tamagotchi == null || !_tamagotchi!.isAlive) return;

      final newHunger = (_tamagotchi!.hunger + 30).clamp(0, 100);
      _tamagotchi = _tamagotchi!.copyWith(
        hunger: newHunger,
        lastFed: DateTime.now(),
      );
      await _saveTamagotchi();
      _checkStatus();
    } catch (e) {
      setError('Failed to feed your Tamagotchi. Please try again.');
    }
  }

  Future<void> play() async {
    try {
      if (_tamagotchi == null || !_tamagotchi!.isAlive) return;

      final newHappiness = (_tamagotchi!.happiness + 20).clamp(0, 100);
      _tamagotchi = _tamagotchi!.copyWith(
        happiness: newHappiness,
        lastPlayed: DateTime.now(),
      );
      await _saveTamagotchi();
      _checkStatus();
    } catch (e) {
      setError('Failed to play with your Tamagotchi. Please try again.');
    }
  }

  Future<void> heal() async {
    try {
      if (_tamagotchi == null || !_tamagotchi!.isAlive) return;

      final newHealth = (_tamagotchi!.health + 25).clamp(0, 100);
      _tamagotchi = _tamagotchi!.copyWith(health: newHealth);
      await _saveTamagotchi();
      _checkStatus();
    } catch (e) {
      setError('Failed to heal your Tamagotchi. Please try again.');
    }
  }

  Future<void> _saveTamagotchi() async {
    if (_tamagotchi == null) return;
    await _sharedPreferencesService.saveData(
      _tamagotchiKey,
      _tamagotchi!.toJson(),
    );
    notifyListeners();
  }

  void _checkStatus() {
    if (_tamagotchi == null) return;

    final now = DateTime.now();
    final hoursSinceLastFed = now.difference(_tamagotchi!.lastFed).inHours;
    final hoursSinceLastPlayed =
        now.difference(_tamagotchi!.lastPlayed).inHours;

    var newHunger = _tamagotchi!.hunger - (hoursSinceLastFed * 5);
    var newHappiness = _tamagotchi!.happiness - (hoursSinceLastPlayed * 3);
    var newHealth = _tamagotchi!.health;

    if (newHunger <= 0 || newHappiness <= 0) {
      newHealth = (newHealth - 10).clamp(0, 100);
    }

    newHunger = newHunger.clamp(0, 100);
    newHappiness = newHappiness.clamp(0, 100);

    final isAlive = newHealth > 0;

    if (_tamagotchi!.isAlive && !isAlive) {
      _showDeathDialog();
    }

    _tamagotchi = _tamagotchi!.copyWith(
      hunger: newHunger.toInt(),
      happiness: newHappiness.toInt(),
      health: newHealth.toInt(),
      isAlive: isAlive,
    );

    _saveTamagotchi();
  }

  Future<void> _showDeathDialog() async {
    await _dialogService.showDialog(
      title: 'Oh no!',
      description:
          'Your Tamagotchi has passed away. Would you like to start a new one?',
      buttonTitle: 'Create New',
      cancelTitle: 'Later',
    );
  }
}
