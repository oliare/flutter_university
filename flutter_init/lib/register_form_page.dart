import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_init/models/user.dart';
import 'package:flutter_init/user_info_page.dart';

class RegisterFormPage extends StatefulWidget {
  const RegisterFormPage({super.key});

  @override
  _RegisterFormPageState createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _storyController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _hidePassword = true;
  String? _selectedCountry;

  final List<String> _countries = [
    'Ukraine',
    'USA',
    'Germany',
    'France',
    'Italy',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _storyController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool _validatorPhoneNumber(String input) {
    final _phoneExp = RegExp(r'^\(\d{3}\)\d{3}-\d{4}$');
    return _phoneExp.hasMatch(input);
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      User user = User(
        name: _nameController.text,
        phone: _phoneController.text,
        email: _emailController.text,
        country: _selectedCountry ?? '',
        story: _storyController.text,
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserInfoPage(user: user)),
      );

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Text(
              "Успіх!",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: const Text(
              "Реєстрація успішна!",
              style: TextStyle(fontSize: 16),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK", style: TextStyle(fontSize: 16)),
              ),
            ],
          );
        },
      );
    }
  }

  InputDecoration _inputDecoration(
    String label,
    IconData icon, {
    Widget? suffix,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
      prefixIcon: Icon(icon),
      suffixIcon: suffix,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: BorderSide(color: Colors.black54, width: 1.4),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: BorderSide(
          color: const Color.fromARGB(255, 57, 91, 151),
          width: 2.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Register Form",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            // FULL NAME
            TextFormField(
              controller: _nameController,
              decoration: _inputDecoration(
                'Full Name *',
                Icons.person,
                suffix: IconButton(
                  icon: Icon(
                    Icons.delete_outline,
                    color: Color.fromARGB(255, 157, 25, 16),
                  ),
                  onPressed: () {
                    _nameController.clear();
                    setState(() {});
                  },
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Full Name!';
                }
                return null;
              },
            ),
            SizedBox(height: 12),

            // PHONE
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter(
                  RegExp(r'^[()\d -]{1,15}$'),
                  allow: true,
                ),
              ],
              decoration:
                  _inputDecoration(
                    'Phone Number *',
                    Icons.call,
                    suffix: IconButton(
                      icon: Icon(
                        Icons.delete_outline,
                        color: Color.fromARGB(255, 157, 25, 16),
                      ),
                      onPressed: () {
                        _phoneController.clear();
                        setState(() {});
                      },
                    ),
                  ).copyWith(
                    hintText: '(XXX)XXX-XXXX',
                    helperText: 'Phone format: (XXX)XXX-XXXX',
                  ),
              validator: (value) {
                if (value != null && _validatorPhoneNumber(value)) return null;
                return "Input number, for example (123)456-7890";
              },
            ),
            SizedBox(height: 10),

            // EMAIL
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: _inputDecoration('Email Address *', Icons.mail),
              validator: (value) {
                if (value == null || value.isEmpty) return 'Enter email';
                if (!value.contains('@')) return 'Enter valid email';
                return null;
              },
            ),
            SizedBox(height: 10),

            // COUNTRY
            DropdownButtonFormField<String>(
              value: _selectedCountry,
              items: _countries
                  .map(
                    (country) =>
                        DropdownMenuItem(value: country, child: Text(country)),
                  )
                  .toList(),
              onChanged: (value) => setState(() => _selectedCountry = value),
              decoration: InputDecoration(
                labelText: 'Country *',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return 'Select a country';
                return null;
              },
            ),
            SizedBox(height: 10),

            // STORY
            TextFormField(
              controller: _storyController,
              maxLines: 3,
              inputFormatters: [LengthLimitingTextInputFormatter(200)],
              decoration: InputDecoration(
                labelText: 'Life Story',
                hintText: 'Tell us about yourself',
                helperText: 'Max 200 characters',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            // PASSWORD
            TextFormField(
              controller: _passwordController,
              obscureText: _hidePassword,
              decoration: _inputDecoration(
                'Password *',
                Icons.security,
                suffix: IconButton(
                  icon: Icon(
                    _hidePassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () =>
                      setState(() => _hidePassword = !_hidePassword),
                ),
              ).copyWith(hintText: 'Enter your password'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter password!';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
            ),
            SizedBox(height: 10),

            // CONFIRM PASSWORD
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: _hidePassword,
              decoration: _inputDecoration(
                'Confirm Password *',
                Icons.border_color,
                suffix: IconButton(
                  icon: Icon(
                    _hidePassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () =>
                      setState(() => _hidePassword = !_hidePassword),
                ),
              ).copyWith(hintText: 'Re-enter your password'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Confirm your password!';
                }
                if (value != _passwordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),
            SizedBox(height: 20),

            // SUBMIT BUTTON
            ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: const Color.fromARGB(225, 86, 123, 185),
                elevation: 4,
                shadowColor: Colors.blueAccent.withOpacity(0.5),
              ),
              child: Text(
                "Register",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
