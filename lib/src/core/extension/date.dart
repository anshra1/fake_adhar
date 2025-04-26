import 'package:intl/intl.dart';

class DateFormatter {
  static String formatDate(String inputDate) {
    // Define the input and output formats
    final inputFormat = DateFormat('dd-MM-yyyy');
    final outputFormat = DateFormat('dd/MM/yyyy');

    // Parse the input date
    final parsedDate = inputFormat.parse(inputDate);

    // Format the date in the desired output format
    return outputFormat.format(parsedDate);
  }
}

extension Date on String {
  String formatDate() {
    return DateFormatter.formatDate(this);
  }
}


// Assuming you have a Translator class with a translate method
class Translator {
  Future<String> translate(String text, {required String from, required String to}) async {
    // Simulate translation logic here
    // For demonstration purposes, we'll just return the original text
    return text;
  }
}

// Extension on String to add translate functionality
extension TranslateExtension on String {
  Future<String> translateWith({required Translator translator, required String from, required String to}) async {
    return await translator.translate(this, from: from, to: to);
  }
}

void main() async {
  var translator = Translator();
  var translatedText = await 'Hello'.translateWith(translator: translator, from: 'en', to: 'hi');
  print(translatedText); // Output will be "Hello" based on the dummy implementation
}