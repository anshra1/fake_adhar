import 'package:fake_adhar/src/features/dashboard/presentation/cubit/document_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Register DocumentCubit as a singleton (only one instance)
  sl.registerLazySingleton<DocumentCubit>(DocumentCubit.new);
}
