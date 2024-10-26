// lib/background_worker.dart
import 'package:workmanager/workmanager.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    // Implement logic to check for new messages in Firebase
    // Show notification if new messages arrive
    return Future.value(true);
  });
}


