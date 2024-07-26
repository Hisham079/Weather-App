import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/view_models/phoneauth_view_model.dart';

class PhoneauthView extends StatelessWidget {
  const PhoneauthView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<PhoneauthViewModel>(context);
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Colors.amber.shade600,
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.amber,
        title: const Text(
          'Authentication',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextFormField(
                controller: viewModel.phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Phone number (e.g., +1234567890)',
                  hintStyle: const TextStyle(color: Colors.white),
                  suffixIcon: const Icon(
                    Icons.phone,
                    color: Colors.white,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  // Validate phone number with country code
                  final regex = RegExp(r'^\+[1-9]\d{1,14}$');
                  if (!regex.hasMatch(value)) {
                    return 'Please enter a valid phone number with country code';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 30),
            if (viewModel.errorMessage != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Text(
                  viewModel.errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await viewModel.verifyPhonenumber(context);
                  Navigator.pushNamed(context, '/otp');
                }
              },
              child: const Text('Verify phone number'),
            ),
          ],
        ),
      ),
    );
  }
}
