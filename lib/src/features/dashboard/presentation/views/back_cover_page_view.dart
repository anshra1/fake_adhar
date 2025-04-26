import 'package:baby_package/baby_package.dart';
import 'package:fake_adhar/src/features/dashboard/domain/entities/entities.dart';
import 'package:fake_adhar/src/features/dashboard/presentation/cubit/document_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:uuid/uuid.dart';

class BackCoverPageView extends HookWidget {
  const BackCoverPageView({required this.data, super.key});

  final DocumentState data;

  @override
  Widget build(BuildContext context) {
    final fathersNameController = useTextEditingController(
      text: data.backCover?.fatherName ?? '',
    );
    final vidNoController = useTextEditingController(
      text: data.backCover?.vidNo ?? '6517 8064 0518',
    );
    final wardNoController = useTextEditingController(
      text: data.backCover?.wardNo ?? '',
    );
    final localAddressController = useTextEditingController(
      text: data.backCover?.localAddress ?? '',
    );
    final subDistrictController = useTextEditingController(
      text: data.backCover?.subDistrict ?? '',
    );
    final poController = useTextEditingController(
      text: data.backCover?.po ?? '',
    );
    final districtController = useTextEditingController(
      text: data.backCover?.district ?? '',
    );
    final stateController = useTextEditingController(
      text: data.backCover?.state ?? '',
    );
    final pinCodeController = useTextEditingController(
      text: data.backCover?.pinCode ?? '',
    );

    final formKey = useMemoized(GlobalKey<FormState>.new, []);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Input Fields
                  AppTextField(
                    label: "Father's Name",
                    controller: fathersNameController,
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        return null;
                      }
                      return "Please fill in Father's Name";
                    },
                  ),
                  const Gap(16),

                  AppTextField(
                    label: 'VID No',
                    controller: vidNoController,
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        return null;
                      }
                      return 'Please fill in VID No';
                    },
                  ),

                  const Gap(16),

                  AppTextField(
                    label: 'Ward No',
                    controller: wardNoController,
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        return null;
                      }
                      return 'Please fill in Ward No';
                    },
                  ),
                  const Gap(16),

                  AppTextField(
                    label: 'Local Address',
                    controller: localAddressController,
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        return null;
                      }
                      return 'Please fill in Local Address';
                    },
                  ),
                  const Gap(16),

                  AppTextField(
                    label: 'Sub District',
                    controller: subDistrictController,
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        return null;
                      }
                      return 'Please fill in Sub District';
                    },
                  ),
                  const Gap(16),

                  AppTextField(
                    label: 'PO',
                    controller: poController,
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        return null;
                      }
                      return 'Please fill in PO';
                    },
                  ),
                  const Gap(16),

                  AppTextField(
                    label: 'District',
                    controller: districtController,
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        return null;
                      }
                      return 'Please fill in District';
                    },
                  ),
                  const Gap(16),

                  AppTextField(
                    label: 'State',
                    controller: stateController,
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        return null;
                      }
                      return 'Please fill in State';
                    },
                  ),
                  const Gap(16),

                  AppTextField(
                    label: 'PIN Code',
                    controller: pinCodeController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        return null;
                      }
                      return 'Please fill in PIN Code';
                    },
                  ),
                  const Gap(16),
                ],
              ),
            ),

            // Buttons Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: AppButton(
                    text: 'Next',
                    shape: ButtonShape.stadium,
                    size: ButtonSize.large,
                    onPressed: () {
                      if (formKey.currentState != null &&
                          formKey.currentState!.validate()) {
                        final backCoverEntity = BackCoverEntity(
                          uuid: const Uuid().v4(),
                          fatherName: fathersNameController.text,
                          vidNo: vidNoController.text,
                          wardNo: wardNoController.text,
                          localAddress: localAddressController.text,
                          subDistrict: subDistrictController.text,
                          po: poController.text,
                          district: districtController.text,
                          state: stateController.text,
                          pinCode: pinCodeController.text,
                        );

                        context.read<DocumentCubit>().updateTheDocumentData(
                              frontCover: data.frontCover,
                              backCover: backCoverEntity,
                              isSuccess: true,
                            );
                      }
                    },
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: AppButton(
                    text: 'Skip',
                    shape: ButtonShape.stadium,
                    size: ButtonSize.large,
                    backgroundColor: Colors.grey,
                    onPressed: () {
                      final frontcoverEntity =
                          data.frontCover?.copyWith(uuid: const Uuid().v4());
                      context.read<DocumentCubit>().updateTheDocumentData(
                            frontCover: frontcoverEntity,
                            isSuccess: true,
                          );
                    },
                  ),
                ),
              ],
            ),
            const Gap(16),
          ],
        ),
      ),
    );
  }
}
