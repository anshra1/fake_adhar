import 'dart:io';

import 'package:fake_adhar/src/core/extension/date.dart';
import 'package:fake_adhar/src/core/extension/language.dart';
import 'package:fake_adhar/src/core/extension/string.dart';
import 'package:fake_adhar/src/features/dashboard/presentation/cubit/document_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';

class FrontCoverWidget extends HookWidget {
  const FrontCoverWidget({
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

    final hindiName = useState(state.frontCover?.fullName ?? 'Ansh Raj');

    useEffect(
      () {
        state.frontCover?.fullName.toHindi().then((value) {
          hindiName.value = value;
        });
        return null;
      },
      [state.frontCover?.fullName],
    );
    print('hindiName: ${hindiName.value}');
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
                left: w * 0.339,
                top: w * 0.13,
                child: Text(
                  hindiName.value,
                  style: GoogleFonts.notoSansDevanagari(
                    textStyle: style.copyWith(fontSize: w * .023),
                    fontWeight: FontWeight.w500,
                  ),
                  //    style: style.copyWith(fontSize: fontSize * 1.34),
                ),
              ),
              Positioned(
                left: w * 0.339,
                top: w * 0.162,
                child: Text(
                  state.frontCover?.fullName.toTitleCase ?? 'Ansh Raj',
                  style: style.copyWith(
                    fontSize: w * .022,
                    fontFamily: 'arial',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              Positioned(
                left: w * 0.5,
                top: w * 0.206,
                child: Text(
                  state.frontCover?.dateOfBirth.formatDate() ?? '01/01/2000',
                  style: GoogleFonts.notoSerifTamil(
                    textStyle: style.copyWith(fontSize: w * .023),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              Positioned(
                left: w * 0.340,
                top: w * 0.245,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: state.frontCover?.gender == 'Male' ? 'पुरुष' : 'महिला',
                        style: GoogleFonts.notoSansDevanagari(
                          textStyle: style.copyWith(fontSize: w * .023),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: '/ ',
                        style: style.copyWith(fontSize: w * .023),
                      ),
                      TextSpan(
                        text: state.frontCover?.gender == 'Male' ? 'MALE' : 'FEMALE',
                        style: GoogleFonts.tinos(
                          textStyle: style.copyWith(fontSize: w * .023),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                left: w * 0.11,
                top: w * 0.126,
                child: Image.file(
                  state.frontCover?.file ?? File(''),
                  width: w * 0.195,
                  // height: w * 0.36,
                  fit: BoxFit.fitWidth,
                ),
              ),
              // Add more positioned text/QR code/images here
            ],
          );
        },
      ),
    );
  }
}
