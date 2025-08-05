import 'package:flutter/material.dart';
import '../models/company.dart';
import '../services/api_service.dart';

class CompanyProvider with ChangeNotifier {
  List<Company> _companies = [];
  bool _isLoading = false;

  List<Company> get companies => _companies;
  bool get isLoading => _isLoading;

  Future<void> fetchCompanies() async {
    _isLoading = true;
    notifyListeners();
    _companies = await ApiService.getCompanies();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addCompany(String name, String regNumber) async {
    await ApiService.createCompany(name, regNumber);
    await fetchCompanies();
  }

  Future<void> addService(String name, String desc, double price, int companyId) async {
    await ApiService.createService(name, desc, price, companyId);
    await fetchCompanies();
  }
}
