import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImprintScreen extends StatefulWidget {
  @override
  _ImprintScreenState createState() => _ImprintScreenState();
}

class _ImprintScreenState extends State<ImprintScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = prefs.getString('name') ?? '';
      _contactController.text = prefs.getString('contact') ?? '';
      _addressController.text = prefs.getString('address') ?? '';
      _emailController.text = prefs.getString('email') ?? '';
      _phoneController.text = prefs.getString('phone') ?? '';
    });
  }

  Future<void> _savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _nameController.text);
    await prefs.setString('contact', _contactController.text);
    await prefs.setString('address', _addressController.text);
    await prefs.setString('email', _emailController.text);
    await prefs.setString('phone', _phoneController.text);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Data Saved'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Imprint'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Your Name',
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _contactController,
                decoration: InputDecoration(
                  labelText: 'Contact Information',
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Address',
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone',
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _savePreferences,
                child: Text('Save'),
              ),
              SizedBox(height: 16),
              Text(
                'Saved Information:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Name: ${_nameController.text}',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Contact: ${_contactController.text}',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Address: ${_addressController.text}',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Email: ${_emailController.text}',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Phone: ${_phoneController.text}',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}
