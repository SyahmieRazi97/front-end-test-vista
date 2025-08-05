import 'service.dart';

class Company {
  final int id;
  final String name;
  final String registrationNumber;
  final List<Service> services;

  Company({
    required this.id,
    required this.name,
    required this.registrationNumber,
    required this.services,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    var list = json['services'] as List? ?? [];
    List<Service> servicesList =
        list.map((s) => Service.fromJson(s)).toList();

    return Company(
      id: json['id'],
      name: json['name'],
      registrationNumber: json['registrationNumber'],
      services: servicesList,
    );
  }
}
