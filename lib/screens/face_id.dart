import 'package:local_auth/local_auth.dart';

class Authentication {
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> authenticateWithBiometrics() async {
    final isAvailable = await auth.canCheckBiometrics;

    if (isAvailable) {
      try {
        return await auth.authenticate(
          localizedReason: 'Scan your fingerprint (or face or whatever) to authenticate',
          options: const AuthenticationOptions(biometricOnly: true),
        );
      } catch (e) {
        print('Error using biometric authentication: $e');
        return false;
      }
    } else {
      print('Biometric authentication is not available.');
      return false;
    }
  }
}
