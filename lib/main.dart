import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:happy_request_test/conf.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'haha',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MainPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String? data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Request Panel'),
            Text(
              data ?? "null",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await FlutterWebAuth2.authenticate(
            url:
                "http://192.168.1.206/auth?grant_type=authorization_code&state=128&response_type=code&client_id=foobar&client_secret=foobar2",
            callbackUrlScheme: "com.oauth2.example",
          );
          final callbackUrl = Uri.parse(result);
          final authCode = callbackUrl.queryParameters['code'];
          final tokenUrl = Uri.http('192.168.1.206', 'token');
          dio
              .postUri(
                tokenUrl,
                data: {
                  'client_id': 'foobar',
                  'code': authCode,
                  'grant_type': 'authorization_code',
                  'redirect_uri': 'com.oauth2.example://redirect',
                  'client_secret': 'foobar2',
                },
                options: Options(
                  contentType: Headers.formUrlEncodedContentType,
                ),
              )
              .then((val) {
                debugPrint(val.toString());
              })
              .catchError((e) {
                if (e is DioException) {
                  debugPrint(e.response.toString());
                  return;
                }
              });
          // try {
          //   final resp = await dio.get("/");
          //   setState(() {
          //     data = resp.data.toString();
          //   });
          // } catch (e) {
          //   debugPrint(e.toString());
          //   if (e is DioException) {
          //     // TODO:
          //   }
          // }
        },
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
