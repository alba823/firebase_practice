import 'package:firebase_practice/data/services/firebase_service.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory<FirebaseService>(() => FirebaseServiceImpl());
}