import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:test_mock_app/utils/emulator_checker.dart';
import 'package:test_mock_app/utils/shared_prefs.dart';
import 'package:test_mock_app/view/pages/start_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool hasInternetConnection = true;
  final PreferencesDataSource _preferencesDataSource = PreferencesDataSource();

  @override
  void initState() {
    super.initState();
    _configureUrl();
  }

  _navigateFurther(bool showWebView, String? url) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(showWebView: showWebView, url: url),
      ),
    );
  }

  _configureUrl() async {
    final result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      setState(() {
        hasInternetConnection = false;
      });
      return;
    } else if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      setState(() {
        hasInternetConnection = true;
      });
      final url = await _preferencesDataSource.getUrl();
      if (url != null) {
        _navigateFurther(true, url);
      } else {
        try {
          final remoteConfig = FirebaseRemoteConfig.instance;
          await remoteConfig.setConfigSettings(RemoteConfigSettings(
            fetchTimeout: const Duration(minutes: 1),
            minimumFetchInterval: const Duration(hours: 1),
          ));
          await remoteConfig.fetchAndActivate();
          final str = remoteConfig.getString('url');
          if (str.isNotEmpty && !await EmulatorChecker.isEmulator()) {
            _preferencesDataSource.saveUrl(str);
            _navigateFurther(true, str);
          } else {
            _navigateFurther(false, null);
          }
        } catch (e) {
          hasInternetConnection = false;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: hasInternetConnection ? logo() : noInternetInfo(),
      ),
    );
  }

  Widget logo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(),
        SizedBox(
          width: 150,
          height: 150,
          child: Image.asset('assets/logo_quiz_app.jpg'),
        ),
        const Spacer(),
        Text(
          'Loading data..',
          style: GoogleFonts.mavenPro(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16.0),
        LoadingAnimationWidget.staggeredDotsWave(
          color: Colors.black,
          size: 50,
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }

  Widget noInternetInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: Image.asset('assets/no_internet.png'),
          ),
          const SizedBox(height: 16.0),
          Text(
            'For further correct performance of the application, please turn on the Internet',
            style: GoogleFonts.mavenPro(
              color: Colors.black,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16.0),
          TextButton(
            onPressed: () => _configureUrl(),
            child: const Text('Reload'),
          ),
        ],
      ),
    );
  }
}
