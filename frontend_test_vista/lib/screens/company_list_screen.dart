import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/company_provider.dart';
import 'create_company_screen.dart';
import 'create_service_screen.dart';

class CompanyListScreen extends StatefulWidget {
  @override
  _CompanyListScreenState createState() => _CompanyListScreenState();
}

class _CompanyListScreenState extends State<CompanyListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<CompanyProvider>(context, listen: false).fetchCompanies();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CompanyProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Companies')),
      body: provider.isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: provider.companies.length,
              itemBuilder: (context, index) {
                final company = provider.companies[index];
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
              if (added == true) provider.fetchCompanies();
            },
            child: Icon(Icons.business),
            tooltip: "Add Company",
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            heroTag: "addService",
            onPressed: () async {
              bool? added = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateServiceScreen(companies: provider.companies),
                ),
              );
              if (added == true) provider.fetchCompanies();
            },
            child: Icon(Icons.add),
            tooltip: "Add Service",
          ),
        ],
      ),
    );
  }
}
