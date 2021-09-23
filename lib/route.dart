import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:avocat/Screen/Home.dart';

import 'Middleware/LoginMiddleware.dart';

import 'Screen/Auth/Login.dart';
import 'Screen/IntroScreen.dart';
import 'Screen/Profile.dart';

final List<GetPage> routes = [
  GetPage(name: '/', page: () => IntroScreen()),
  GetPage(name: '/login', page: () => Login()),
  GetPage(name: '/home', page: () => Home(), middlewares: [LoginMiddleware()]),
  GetPage(name: '/profile', page: () => Profile()),
];
