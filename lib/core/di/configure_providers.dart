import 'package:app_firebase_auth/services/firebase/auth_service.dart';
import 'package:app_firebase_auth/services/app/file_storage_service.dart';
import 'package:app_firebase_auth/services/app/geolocator_service.dart';
import 'package:app_firebase_auth/services/firebase/cloud_firestore_service.dart';
import 'package:app_firebase_auth/services/firebase/firebase_storage_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';


class ConfigureProviders {

  final List<SingleChildWidget> providers;

  ConfigureProviders({required this.providers});

  static Future<ConfigureProviders> createDependencyTree() async {

    final authService = AuthService();
    final storeService = CloudFiretoreService();
    final fileStorageService = FileStorageService();
    final geoLocatorService = GeoLocatorService();
    final firebaseStorageService = FirebaseStorageService();

    return ConfigureProviders(providers: [
      Provider<AuthService>.value(value: authService),
      Provider<CloudFiretoreService>.value(value: storeService),
      Provider<FileStorageService>.value(value: fileStorageService),
      Provider<GeoLocatorService>.value(value: geoLocatorService),
      Provider<FirebaseStorageService>.value(value: firebaseStorageService)
    ]);
  }
}