import 'package:flutter/material.dart';
import 'package:jake_wharton_github/helper/local_auth_api.dart';
import 'package:jake_wharton_github/screens/homepage.dart';
import 'package:jake_wharton_github/utils/constVar.dart';
import 'package:local_auth/local_auth.dart';

class FingerprintPage extends StatefulWidget {
  const FingerprintPage({Key? key}) : super(key: key);

  @override
  State<FingerprintPage> createState() => _FingerprintPageState();
}

class _FingerprintPageState extends State<FingerprintPage> {
  bool showBiometric = false;
  bool isAuthenticated = false;

  @override
  void initState() {
    isBiometricsAvailable();
    super.initState();
  }

  isBiometricsAvailable() async {
    showBiometric = await BiometricHelper().hasEnrolledBiometrics();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(appBarTitle),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (showBiometric)
                ElevatedButton(
                  child: const Text(
                    'Biometric Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () async {
                    isAuthenticated = await BiometricHelper().authenticate();
                    setState(() {});
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                ),
            ],
          ),
        ),
      );
}
