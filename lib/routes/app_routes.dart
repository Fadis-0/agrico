import 'package:flutter/material.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/registration_screen/registration_screen.dart';
import '../presentation/discover_screen/discover_screen.dart';
import '../presentation/worker_profile_screen/worker_profile_screen.dart';
import '../presentation/equipment_detail_screen/equipment_detail_screen.dart';
import '../presentation/terrain_detail_screen/terrain_detail_screen.dart';

class AppRoutes {
  // TODO: Add your routes here
  static const String initial = '/';
  static const String loginScreen = '/login-screen';
  static const String registrationScreen = '/registration-screen';
  static const String discoverScreen = '/discover-screen';
  static const String workerProfileScreen = '/worker-profile-screen';
  static const String equipmentDetailScreen = '/equipment-detail-screen';
  static const String terrainDetailScreen = '/terrain-detail-screen';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => LoginScreen(),
    loginScreen: (context) => LoginScreen(),
    registrationScreen: (context) => RegistrationScreen(),
    discoverScreen: (context) => DiscoverScreen(),
    workerProfileScreen: (context) => WorkerProfileScreen(),
    equipmentDetailScreen: (context) => EquipmentDetailScreen(),
    terrainDetailScreen: (context) => TerrainDetailScreen(),
    // TODO: Add your other routes here
  };
}
