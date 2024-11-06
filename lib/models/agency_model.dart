// class Agency {
//   final String agencyName;
//   final String address;
//
//   Agency({required this.agencyName, required this.address});
//
//   factory Agency.fromMap(Map<String, dynamic> data) {
//     return Agency(
//       agencyName: data['agencyName'],
//       address: data['address'],
//     );
//   }
// }

class TravelAgency {
  String id;
  final String name;
  final String address;
  final String phone;
  final List<String> buses; // List of Bus objects

  TravelAgency({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.buses,
  });

  factory TravelAgency.fromJson(Map<String, dynamic> json, String docId) {
    return TravelAgency(
      id: docId,
      name: json['name'],
      address: json['address'],
      phone: json['phone'],
      buses: List<String>.from(json['buses'] as List<dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'phone': phone,
      'buses': buses.map((busId) => busId).toList(),
    };
  }
}
