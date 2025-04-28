import 'package:baby_package/baby_package.dart';
import 'package:fake_adhar/src/core/extension/language.dart';
import 'package:fake_adhar/src/core/extension/string.dart';
import 'package:fake_adhar/src/features/dashboard/presentation/cubit/document_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';

class BackCoverWidget extends HookWidget {
  const BackCoverWidget({
    required this.width,
    required this.height,
    required this.state,
    required this.fontSize,
    required this.imagePath,
    super.key,
  });

  final double width;
  final double height;
  final double fontSize;
  final String imagePath;
  final DocumentState state;

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontSize: fontSize * 1.33,
      height: 1.1,
      color: Colors.black,
      fontWeight: FontWeight.w500,
      fontFamily: 'arial',
    );
    final bc = state.backCover;

    final address = 'संबोधित: ${bc?.fatherName}, ${bc?.wardNo}, ${bc?.localAddress},';
    final address2 =
        '${bc?.po}, ${bc?.subDistrict}, ${bc?.district}, ${bc?.state}, - ${bc?.pinCode}';

    final engAddress =
        'S/O: ${bc?.fatherName.capitalize}, ${bc?.wardNo}, ${bc?.localAddress.toCapitalized}, ${bc?.subDistrict.toCapitalized}, PO: ${bc?.po.toCapitalized}, DIST: ${bc?.district.toCapitalized}, ${bc?.state.toCapitalized}, - ${bc?.pinCode}';

    final hindiName = useState<String>('');

    useMemoized(
      () async {
        final a1 = await address.toHindi();
        final a2 = await address2.toHindi();
        hindiName.value = '$a1 $a2';

        return null;
      },
      [hindiName],
    );

    

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: width),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final w = constraints.maxWidth;
          return Stack(
            children: [
              Align(
                child: SizedBox(
                  width: width - width * 0.04,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: w * 0.048,
                top: w * 0.148,
                child: SizedBox(
                  height: w * 0.08,
                  width: w * 0.495,
                  child: Text(
                    hindiName.value,
                    style: GoogleFonts.notoSerifTamil(
                      textStyle: style.copyWith(fontSize: w * .02),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: w * 0.048,
                top: w * 0.262,
                child: SizedBox(
                  height: w * 0.08,
                  width: w * 0.495,
                  child: Text(
                    engAddress,
                    style:
                        style.copyWith(fontSize: w * .021, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Positioned(
                left: w * 0.33,
                top: w * 0.5,
                child: Text(
                  state.frontCover?.aadhaarNumber ?? '01/01/2000',
                  style: GoogleFonts.notoSerifTamil(
                    textStyle: style.copyWith(fontSize: w * .0350),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Positioned(
                left: w * 0.4,
                top: w * 0.547,
                child: Text(
                  state.backCover?.vidNo ?? '01/01/2000',
                  style: GoogleFonts.notoSerifTamil(
                    textStyle: style.copyWith(fontSize: w * .025),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
