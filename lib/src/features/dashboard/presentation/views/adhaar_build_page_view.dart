import 'package:fake_adhar/src/features/dashboard/presentation/cubit/document_cubit.dart';
import 'package:fake_adhar/src/features/dashboard/presentation/widgets/adharr_back_cover.dart';
import 'package:fake_adhar/src/features/dashboard/presentation/widgets/adhaar_front_cover.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class AdhaarBuildPageView extends HookWidget {
  const AdhaarBuildPageView({required this.state, super.key});

  final DocumentState state;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight / 2.9;
        final fontSize = height * 0.025;

        return SingleChildScrollView(
          child: Column(
            spacing: 24,
            children: [
              const Gap(16),
              FrontCoverWidget(
                width: width,
                height: height,
                fontSize: fontSize,
                state: state,
                imagePath: 'asset/images/front.png',
              ),
              BackCoverWidget(
                width: width,
                height: height,
                fontSize: fontSize,
                state: state,
                imagePath: 'asset/images/back.png',
              ),
            ],
          ),
        );
      },
    );
  }
}
