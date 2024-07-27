import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneauthViewModel extends ChangeNotifier {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  String _verificationId = '';
  String? _errorMessage;
  bool _isVerificationSuccessful = false;
  bool _isLoading = false;

  String get verificationId => _verificationId;
  String? get errorMessage => _errorMessage;
  bool get isVerificationSuccessful => _isVerificationSuccessful;
  bool get isLoading => _isLoading;

  Future<void> verifyPhonenumber(BuildContext context) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneController.text,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException error) {
          _errorMessage = error.message;
          _isVerificationSuccessful = false;
          _isLoading = false;
          notifyListeners();
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          _verificationId = verificationId;
          _isVerificationSuccessful = true;
          _isLoading = false;
          notifyListeners();
          Navigator.pushNamed(context, '/otp');
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
          _isLoading = false;
          notifyListeners();
        },
      );
    } catch (e) {
      _errorMessage = "An unexpected error occurred: $e";
      _isVerificationSuccessful = false;
      _isLoading = false;
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
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      _errorMessage = "An unexpected error occurred: $e";
      notifyListeners();
    }
  }
}
