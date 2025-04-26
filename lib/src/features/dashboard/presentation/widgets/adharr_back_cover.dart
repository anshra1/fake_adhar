import 'package:fake_adhar/src/core/extension/language.dart';
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
      color: Colors.black,
      fontWeight: FontWeight.w500,
      fontFamily: 'arial',
    );

    final hindiName = useState<String>('${state.backCover?.fatherName}' ?? 'Ansh Raj');

    useEffect(
      () {
        state.frontCover?.fullName.toHindi().then((value) {
          hindiName.value = value;
        });
        return null;
      },
      [state.frontCover?.fullName],
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
                top: w * 0.144,
                child: Container(
                  color: Colors.red,
                  height: w * 0.08,
                  width: w * 0.495, 
                ),
              ),
              Positioned(
                left: w * 0.048,
                top: w * 0.262,
                child: Container(
                  color: Colors.red,
                  height: w * 0.08,
                  width: w * 0.495,
                ),
              ),
              Positioned(
                left: w * 0.33,
                top: w * 0.483,
                child: Text(
                  state.backCover?.vidNo ?? '01/01/2000',
                  style: GoogleFonts.notoSerifTamil(
                    textStyle: style.copyWith(fontSize: w * .0350),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Positioned(
                left: w * 0.4,
                top: w * 0.541,
                child: Text(
                  state.frontCover?.aadhaarNumber ?? '01/01/2000',
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
