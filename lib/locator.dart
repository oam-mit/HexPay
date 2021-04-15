import 'package:get_it/get_it.dart';
import 'package:hexpay/backend/views/authview.dart';
import 'package:hexpay/backend/views/paymentView.dart';
import 'package:hexpay/backend/views/storageView.dart';
import 'package:hexpay/services/dialogService.dart';
import 'package:hexpay/services/navigator.dart';

final getIt = GetIt.instance;

void initialize() {
  getIt.registerLazySingleton(() => StorageView());
  getIt.registerLazySingleton(() => NavigationService());
  getIt.registerLazySingleton(() => DialogService());
  getIt.registerLazySingleton(() => AuthView.checkLoggedIn());

  getIt.registerLazySingleton(() => PaymentView.initialize());
}
