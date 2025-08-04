import 'package:dio/dio.dart';
import 'package:oauth2/oauth2.dart' as oauth2;

final dio = Dio(BaseOptions(baseUrl: "http://192.168.1.206"));

// curl "192.168.1.206/auth?grant_type=authorization_code&state=128&response_type=code&client_id=foobar&client_secret=foobar2"
// got lazy lol
