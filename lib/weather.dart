// ignore_for_file: public_member_api_docs, sort_constructors_first
class Weather {
  final String cityName;
  final double tempeture;
  Weather({required this.cityName, required this.tempeture});

  @override
  bool operator ==(covariant Weather other) {
    if (identical(this, other)) return true;

    return other.cityName == cityName && other.tempeture == tempeture;
  }

  @override
  int get hashCode => cityName.hashCode ^ tempeture.hashCode;
}
