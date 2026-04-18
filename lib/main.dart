import 'package:flutter/widgets.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'src/app/app.dart';
import 'src/app/app_scope.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ru');

  final scope = await AppScope.bootstrap();
  runApp(ProductiveHabitsApp(scope: scope));
}
