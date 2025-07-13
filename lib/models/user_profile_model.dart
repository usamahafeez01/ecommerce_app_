// lib/models/user_profile_model.dart
class UserProfile {
  final int id;
  final String email;
  final String username;
  final String firstName;
  final String lastName;
  final String phone;
  final Address address;

  const UserProfile({
    required this.id,
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.address,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    final nameJson    = json['name']    as Map<String, dynamic>? ?? {};
    final addressJson = json['address'] as Map<String, dynamic>? ?? {};

    return UserProfile(
      id        : json['id']       as int,
      email     : json['email']    as String? ?? '',
      username  : json['username'] as String? ?? '',
      firstName : nameJson['firstname'] as String? ?? '',
      lastName  : nameJson['lastname']  as String? ?? '',
      phone     : json['phone']    as String? ?? '',
      address   : Address.fromJson(addressJson),
    );
  }
}

/* ───────────────────────── Address helper ───────────────────────── */

class Address {
  final String street;
  final int    number;
  final String city;
  final String zipcode;
  final Geo    geo;

  const Address({
    required this.street,
    required this.number,
    required this.city,
    required this.zipcode,
    required this.geo,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    final geoJson = json['geolocation'] as Map<String, dynamic>? ?? {};
    return Address(
      street  : json['street']  as String? ?? '',
      number  : json['number']  as int?    ?? 0,
      city    : json['city']    as String? ?? '',
      zipcode : json['zipcode'] as String? ?? '',
      geo     : Geo.fromJson(geoJson),
    );
  }
}

class Geo {
  final String lat;
  final String long;

  const Geo({required this.lat, required this.long});

  factory Geo.fromJson(Map<String, dynamic> json) => Geo(
        lat : json['lat']  as String? ?? '',
        long: json['long'] as String? ?? '',
      );
}
