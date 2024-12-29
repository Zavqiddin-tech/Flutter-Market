import 'package:market/dialog/client_add_page.dart';
import 'package:market/dialog/contract_add_page.dart';
import 'package:market/dialog/home_add_page.dart';
import 'package:market/pages/dashboard_page.dart';
import 'package:market/pages/menu/client_page.dart';
import 'package:market/pages/menu/contract_page.dart';
import 'package:market/pages/menu/home_page.dart';
import 'package:market/pages/notification_page.dart';

final routes = {
  '/dashboard_page': (context) => DashboardPage(),
  '/client_page': (context) => ClientPage(),
  '/contract_page': (context) => ContractPage(),
  '/home_page': (context) => HomePage(),
  '/client_add_page': (context) => ClientAddPage(),
  '/contract_add_page': (context) => ContractAddPage(),
  '/home_add_page': (context) => HomeAddPage(),
  '/notification_page': (context) => NotificationPage(),
};
