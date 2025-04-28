import 'dart:io';

import 'package:baby_package/baby_package.dart';
import 'package:fake_adhar/src/core/utils/date_picker.dart';
import 'package:fake_adhar/src/features/dashboard/domain/entities/entities.dart';
import 'package:fake_adhar/src/features/dashboard/presentation/cubit/document_cubit.dart';
import 'package:fake_adhar/src/features/dashboard/presentation/widgets/gender_selection.dart';
import 'package:fake_adhar/src/features/dashboard/presentation/widgets/image_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:uuid/uuid.dart';

class FrontPageView extends HookWidget {
  const FrontPageView({required this.data, super.key});

  final FrontCoverEntity? data;

  @override
  Widget build(BuildContext context) {
    final fullNameController = useTextEditingController(text: data?.fullName);
    final aadhaarController =
        useTextEditingController(text: data?.aadhaarNumber ?? '3445 4453 4524');
    final dateOfBirthController = useTextEditingController(text: data?.dateOfBirth);
    final imageNotifier = useValueNotifier<File?>(data?.file);
    final formKey = useMemoized(
      GlobalKey<FormState>.new,
      [],
    );

    final genderNotifier = useState<String?>(data?.gender);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Gap(4),
              AppTextField(
                label: 'Full Name',
                controller: fullNameController,
                inputFormatters: [
                  TextInputFormatterHelper.alphabeticWithSpaces(),
                  TextInputFormatterHelper.maxLength(32),
                ],
                overrideValidator: true,
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    return null;
                  }
                  return 'Please fill the fullName';
                },
              ),
              const Gap(16),
              AppTextField(
                label: 'Aadhaar Number',
                controller: aadhaarController,
                onTap: aadhaarController.clear,
                keyboardType: TextInputType.number,
                labelTextColor: Colors.black87,
                inputFormatters: [
                  TextInputFormatterHelper.spaceAfterEveryFour(maxCharacters: 12),
                ],
                overrideValidator: true,
                validator: (value) {
                  if (value != null && value.length > 12) {
                    return null;
                  }
                  return 'Please fill Aadhar Number';
                },
              ),
              const Gap(16),
              DateOfBirth(dateOfBirthController: dateOfBirthController),
              const Gap(16),
              GenderSelection(label: 'Gender', onGenderSelected: genderNotifier),
              const Gap(16),
              ImagePickerWidget(onImageSelected: imageNotifier),
              const Gap(16),
              AppButton(
                text: 'Next',
                shape: ButtonShape.stadium,
                size: ButtonSize.large,
                onPressed: () {
                  if (formKey.currentState != null && formKey.currentState!.validate()) {
                    final frontCoverEntity = FrontCoverEntity(
                      fullName: fullNameController.text,
                      aadhaarNumber: aadhaarController.text,
                      dateOfBirth: dateOfBirthController.text,
                      gender: genderNotifier.value ?? 'Male',
                      file: imageNotifier.value ?? File(''),
                      uuid: const Uuid().v4(),
                    );

                    context.read<DocumentCubit>().updateTheDocumentData(
                          frontCover: frontCoverEntity,
                          isSuccess: true,
                        );
                  }
                },
              ),
              //  Form(child: null,),
            ],
          ),
        ),
      ),
    );
  }
}

class DateOfBirth extends StatelessWidget {
  const DateOfBirth({
    required this.dateOfBirthController,
    super.key,
  });

  final TextEditingController dateOfBirthController;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      disableTextField: true,
      label: 'Date Of Birth',
      controller: dateOfBirthController,
      readOnly: true,
      labelTextColor: Colors.black87,
      overrideValidator: true,
      suffixIcon: const Icon(Icons.date_range),
      validator: (value) {
        if (value != null && value.isNotEmpty) {
          return null;
        }
        return 'Please fill the date of birth';
      },
      onTap: () async {
        final date = await DatePickerHelper.showDatePickerDialog(
          context,
          minDate: DateTime(1950),
          maxDate: DateTime.now(),
        );

        if (date != null) {
          dateOfBirthController.text = date.toString().toDDMMYYYY();
        }
      },
    );
  }
}
