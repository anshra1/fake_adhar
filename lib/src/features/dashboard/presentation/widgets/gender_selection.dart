import 'package:fake_adhar/src/core/design_system/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

// GenderSelection Widget
class GenderSelection extends HookWidget {
  const GenderSelection({
    required this.label,
    required this.onGenderSelected,
    this.labelTextColor,
    super.key,
  });

  final String label;
  final Color? labelTextColor;
  final ValueNotifier<String?> onGenderSelected;

  @override
  Widget build(BuildContext context) {
    final selectedGender =
        useState<String?>(onGenderSelected.value ?? 'Male'); // Track selected gender

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: labelTextColor ?? Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
        ),
        const Gap(8),
        Row(
          children: [
            BuildGenderOption(
              gender: 'Male',
              isSelected: selectedGender.value == 'Male',
              onTap: () {
                selectedGender.value = 'Male';
                onGenderSelected.value = 'Male'; // Notify parent
              },
            ),
            const Gap(8), // Space between options
            BuildGenderOption(
              gender: 'Female',
              isSelected: selectedGender.value == 'Female',
              onTap: () {
                selectedGender.value = 'Female';
                onGenderSelected.value = 'Female'; // Notify parent
              },
            ),
          ],
        ),
      ],
    );
  }
}

// Stateless Widget for Gender Option
class BuildGenderOption extends StatelessWidget {
  const BuildGenderOption({
    required this.gender,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final String gender;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textColor = isSelected ? Colors.white : AppColors.neutral600;
    final backgroundColor = isSelected ? AppColors.secondary : AppColors.neutral200;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24), // Circular border
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8), // Pill-shaped design
            boxShadow: [
              BoxShadow(
                color: isSelected
                    ? AppColors.secondary.withOpacity(0.3)
                    : Colors.transparent,
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.circle_outlined,
                color: textColor,
                size: 18,
              ),
              const Gap(8),
              Text(
                gender,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
