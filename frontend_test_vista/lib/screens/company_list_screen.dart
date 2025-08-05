import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/company.dart';
import 'create_company_screen.dart';
import 'create_service_screen.dart';

class CompanyListScreen extends StatefulWidget {
  @override
  _CompanyListScreenState createState() => _CompanyListScreenState();
}

class _CompanyListScreenState extends State<CompanyListScreen> {
  late Future<List<Company>> companies;

  @override
  void initState() {
    super.initState();
    companies = ApiService.getCompanies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Companies')),
      body: FutureBuilder<List<Company>>(
        future: companies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No companies found.'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final company = snapshot.data![index];
              return ExpansionTile(
                title: Text('${company.name} (${company.registrationNumber})'),
                children: company.services.map((service) => Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  color: Colors.grey[100],
                  child: ListTile(
                    title: Text(service.name),
                    subtitle: Text('${service.description} - RM${service.price}'),
                  ),
                )).toList(),
              );
            },
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "addCompany",
            onPressed: () async {
              bool? added = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateCompanyScreen()),
              );
              if (added == true) {
                setState(() {
                  companies = ApiService.getCompanies();
                });
              }
            },
            child: Icon(Icons.business),
            tooltip: "Add Company",
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            heroTag: "addService",
            onPressed: () async {
              var currentCompanies = await ApiService.getCompanies();
              bool? added = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateServiceScreen(companies: currentCompanies),
                ),
              );
              if (added == true) {
                setState(() {
                  companies = ApiService.getCompanies();
                });
              }
            },
            child: Icon(Icons.add),
            tooltip: "Add Service",
          ),
        ],
      ),
    );
  }
}