import 'package:flutter/material.dart';
import 'ai_agent.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AiAgent agent = AiAgent("YOUR_API_KEY");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Flutter AI Agent")),
        body: Center(
          child: FutureBuilder<String>(
            future: agent.askGemini("Hello AI, introduce yourself!"),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else {
                return Text(snapshot.data ?? "No response");
              }
            },
          ),
        ),
      ),
    );
  }
}
