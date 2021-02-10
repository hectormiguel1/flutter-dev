extension StringExtension on String {
  String capitalize() {
    if (this.isEmpty) {
      return this;
    } else if (this.length == 1) {
      return this[0].toUpperCase();
    }else{
      return "${this[0].toUpperCase()}${this.substring(1)}";
    }
  }
}

extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';
  String get allInCaps => this.toUpperCase();
  String get capitalizeFirstofEach =>
      this.split(" ").map((str) => str.capitalize).join(" ");
}
