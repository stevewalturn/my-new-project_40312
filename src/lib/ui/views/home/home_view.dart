import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:my_app_123/ui/common/app_colors.dart';
import 'package:my_app_123/ui/views/home/home_viewmodel.dart';
import 'package:my_app_123/ui/views/home/widgets/action_button.dart';
import 'package:my_app_123/ui/views/home/widgets/feature_card.dart';
import 'package:my_app_123/ui/views/home/widgets/home_header.dart';
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(40),
              const HomeHeader(),
              const Gap(40),
              Text(
                'Features',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: kcMediumGrey,
                ),
              ),
              const Gap(20),
              ...viewModel.features.map(
                (feature) => Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: FeatureCard(
                    title: feature.title,
                    description: feature.description,
                    icon: feature.icon,
                  ),
                ),
              ),
              const Gap(40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ActionButton(
                    title: 'Show Dialog',
                    onTap: viewModel.showDialog,
                  ),
                  ActionButton(
                    title: 'Show Bottom Sheet',
                    onTap: viewModel.showBottomSheet,
                  ),
                ],
              ),
              const Gap(40),
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
