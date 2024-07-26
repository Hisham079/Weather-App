import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/view_models/phoneauth_view_model.dart';

class PhoneauthView extends StatelessWidget {
  const PhoneauthView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<PhoneauthViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.amber.shade600,
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.amber,
        title: Text(
          'Authentication',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              controller: viewModel.phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Phone number',
                hintStyle: TextStyle(color: Colors.white),
                suffixIcon: const Icon(
                  Icons.phone,
                  color: Colors.white,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          if (viewModel.errorMessage != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                viewModel.errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
            ),
          ElevatedButton(
            onPressed: () async {
              await viewModel.verifyPhonenumber(context);
              Navigator.pushNamed(context, '/otp');
            },
            child: const Text('Verify phone number'),
          ),
        ],
      ),
    );
  }
}
