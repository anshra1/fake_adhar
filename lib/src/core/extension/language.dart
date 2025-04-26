import 'package:translator/translator.dart';

extension TranslationExt on String {
  Future<String> toHindi() async {
    final translator = GoogleTranslator();

    final translation = await translator.translate(
      this,
      from: 'en',
      to: 'hi',
    );
    return translation.text;
  }
}
