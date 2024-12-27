import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:my_app_123/ui/common/app_colors.dart';
import 'package:my_app_123/ui/views/home/home_viewmodel.dart';
import 'package:my_app_123/ui/widgets/home_action_buttons.dart';
import 'package:my_app_123/ui/widgets/home_feature_card.dart';
import 'package:my_app_123/ui/widgets/home_header.dart';
import 'package:my_app_123/ui/widgets/home_stats_widget.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeHeader(username: viewModel.username),
              const Gap(20),
              HomeStatsWidget(counter: viewModel.counter),
              const Gap(20),
              Text(
                'Quick Actions',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kcDarkGreyColor,
                ),
              ),
              const Gap(12),
              HomeActionButtons(
                onShowDialog: viewModel.showDialog,
                onShowBottomSheet: viewModel.showBottomSheet,
              ),
              const Gap(20),
              HomeFeatureCard(
                title: 'Patient Records',
                description: 'View and manage patient records',
                icon: Icons.medical_services,
                onTap: viewModel.navigateToPatientRecords,
              ),
              if (viewModel.hasError) ...[
                const Gap(20),
                Text(
                  viewModel.modelError.toString(),
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kcPrimaryColor,
        onPressed: viewModel.incrementCounter,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
