import 'package:flutter/material.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';

const url =
    "http://192.168.1.58/auth?grant_type=authorization_code&state=128&response_type=code&client_id=foobar&client_secret=foobar2";

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("OAuth2 Testing")),
      body: Center(
        child: TextButton(
          child: Text('testing'),
          onPressed: () async {
            final result = await FlutterWebAuth2.authenticate(
              url: url,
              callbackUrlScheme: 'http',
            );

            debugPrint("HELLLOOO");
            debugPrint(result);
          },
        ),
      ),
    );
  }
}
