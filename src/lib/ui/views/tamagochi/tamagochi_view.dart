import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:my_app_123/ui/common/app_colors.dart';
import 'package:my_app_123/ui/views/tamagochi/tamagochi_viewmodel.dart';
import 'package:my_app_123/ui/widgets/tamagochi_action_buttons.dart';
import 'package:my_app_123/ui/widgets/tamagochi_status_card.dart';
import 'package:stacked/stacked.dart';

class TamagotchiView extends StackedView<TamagotchiViewModel> {
  const TamagotchiView({super.key});

  @override
  Widget builder(
    BuildContext context,
    TamagotchiViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tamagotchi'),
        backgroundColor: kcPrimaryColor,
      ),
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : _buildContent(context, viewModel),
    );
  }

  Widget _buildContent(BuildContext context, TamagotchiViewModel viewModel) {
    if (viewModel.hasError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            viewModel.modelError.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 16,
            ),
          ),
        ),
      );
    }

    if (viewModel.tamagotchi == null) {
      return _buildCreateNew(context, viewModel);
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TamagotchiStatusCard(tamagotchi: viewModel.tamagotchi!),
          const Gap(24),
          TamagotchiActionButtons(
            onFeed: viewModel.feed,
            onPlay: viewModel.play,
            onHeal: viewModel.heal,
            isAlive: viewModel.tamagotchi!.isAlive,
          ),
          if (!viewModel.tamagotchi!.isAlive) ...[
            const Gap(24),
            const Center(
              child: Text(
                '💔 Your Tamagotchi has passed away',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCreateNew(BuildContext context, TamagotchiViewModel viewModel) {
    final nameController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Create Your Tamagotchi',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: kcPrimaryColor,
            ),
          ),
          const Gap(16),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
          ),
          const Gap(16),
          ElevatedButton(
            onPressed: () => viewModel.createNewTamagotchi(nameController.text),
            style: ElevatedButton.styleFrom(
              backgroundColor: kcPrimaryColor,
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 16,
              ),
            ),
            child: const Text(
              'Create',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  TamagotchiViewModel viewModelBuilder(BuildContext context) =>
      TamagotchiViewModel();

  @override
  void onViewModelReady(TamagotchiViewModel viewModel) =>
      viewModel.initialize();
}
