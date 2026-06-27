import 'dart:convert';
import 'package:http/http.dart' as http;

/// A simple AI Agent class that connects to Google Gemini API.
/// Replace `YOUR_API_KEY` with your actual key from Google AI Studio.
class AiAgent {
  final String apiKey;

  AiAgent(this.apiKey);

  /// Sends a prompt to Gemini and returns the response.
  Future<String> askGemini(String prompt) async {
    final url = Uri.parse(
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=$apiKey");

    final body = jsonEncode({
      "contents": [
        {
          "parts": [
            {"text": prompt}
          ]
        }
      ]
    });

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["candidates"][0]["content"]["parts"][0]["text"];
    } else {
      throw Exception("Failed to connect to Gemini: ${response.body}");
    }
  }
}
