
extension StringCapitalization on String {
  String get toCapitalized => 
      this.isNotEmpty ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String get toTitleCase => 
      replaceAll(RegExp(' +'), ' ')
          .split(' ')
          .map((str) => str.toCapitalized)
          .join(' ');
}
