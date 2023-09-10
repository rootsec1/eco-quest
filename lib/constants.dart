import 'package:dio/dio.dart';

const String appName = 'EcoQuest';

const double standardSeparation = 16.0;
const String logMealApiToken = "08cd6ff46aff842add0e1675c7f3eff6a4d2fd1b";
final dioClientGlobal = Dio();

const String baseApiUrl = "http://192.168.1.4:8000/api/";
