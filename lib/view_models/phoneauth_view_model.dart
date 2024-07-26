import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneauthViewModel extends ChangeNotifier {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  String _verificationId = '';
  String? _errorMessage;
  bool _isVerificationSuccessful = false;

  String get verificationId => _verificationId;
  String? get errorMessage => _errorMessage;
  bool get isVerificationSuccessful => _isVerificationSuccessful;

  Future<void> verifyPhonenumber(BuildContext context) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneController.text,
        verificationCompleted: (PhoneAuthCredential credential) {
          // Optionally handle automatic sign-in
        },
        verificationFailed: (FirebaseAuthException error) {
          _errorMessage = error.message;
          _isVerificationSuccessful = false;
          notifyListeners();
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          _verificationId = verificationId;
          _isVerificationSuccessful = true;
          notifyListeners();
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
          notifyListeners();
        },
      );
    } catch (e) {
      _errorMessage = "An unexpected error occurred: $e";
      _isVerificationSuccessful = false;
      notifyListeners();
    }
  }

  Future<void> getOtp(BuildContext context) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: otpController.text.trim(),
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      Navigator.pushNamed(context, '/home');
    } catch (e) {
      _errorMessage = "An unexpected error occurred: $e";
      notifyListeners();
    }
  }
}
