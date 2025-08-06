import 'package:flutter/material.dart';
import '../services/api_service.dart';

class CreateCompanyScreen extends StatefulWidget {
  @override
  _CreateCompanyScreenState createState() => _CreateCompanyScreenState();
}

class _CreateCompanyScreenState extends State<CreateCompanyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _regNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Company',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black54,
      ),
      backgroundColor: Colors.grey,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Company Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a company name' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _regNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Registration Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter registration number';
                }
                if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                  return 'Only numbers are allowed';
                }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await ApiService.createCompany(
                      _nameController.text,
                      _regNumberController.text,
                    );
                    Navigator.pop(context, true);
                  }
                },
                child: Text(
                  'Save',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
