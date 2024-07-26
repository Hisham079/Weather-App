import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/view_models/phoneauth_view_model.dart';

class OtpView extends StatelessWidget {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<PhoneauthViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Screen'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              controller: viewModel.otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter the OTP',
                suffixIcon: const Icon(Icons.sms),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () async {
              await viewModel.getOtp(context);
              Navigator.pushNamed(context, '/home');
            },
            child: const Text('Submit OTP'),
          ),
        ],
      ),
    );
  }
}
