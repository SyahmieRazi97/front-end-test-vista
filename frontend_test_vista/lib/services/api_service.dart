import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/company.dart';
import '../models/service.dart';

class ApiService {
  static const String baseUrl = 'https://<codespace-name>-5000.app.github.dev';

  static Future<List<Company>> getCompanies() async {
    final response = await http.get(Uri.parse('$baseUrl/companies'));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((c) => Company.fromJson(c)).toList();
    } else {
      throw Exception('Failed to load companies');
    }
  }

  static Future<void> createCompany(String name, String regNumber) async {
    await http.post(Uri.parse('$baseUrl/companies'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'name': name, 'registrationNumber': regNumber}));
  }

  static Future<void> createService(
      String name, String description, double price, int companyId) async {
    await http.post(Uri.parse('$baseUrl/services'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': name,
          'description': description,
          'price': price,
          'companyId': companyId
        }));
  }
}