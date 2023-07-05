// ignore_for_file: public_member_api_docs, sort_constructors_first
class Weather {
  final String cityName;
  final int temperture;
  Weather({required this.cityName, required this.temperture});

  @override
  bool operator ==(covariant Weather other) {
    if (identical(this, other)) return true;

    return other.cityName == cityName && other.temperture == temperture;
  }

  @override
  int get hashCode => cityName.hashCode ^ temperture.hashCode;
}
