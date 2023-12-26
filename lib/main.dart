import 'package:flutter/material.dart';

import 'view/speech_to_text_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SpeechRecongitionView(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
    );
  }
}
