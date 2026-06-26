import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meditrack/config/api_config.dart';

class OpenRouterService {
  static const _headers = {
    'Authorization': 'Bearer ${ApiConfig.openRouterApiKey}',
    'Content-Type': 'application/json',
    'HTTP-Referer': 'https://meditrack.app',
  };

  static Future<Map<String, String>?> parseVitalFromSpeech(String transcript) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.openRouterBaseUrl}/chat/completions'),
      headers: _headers,
      body: jsonEncode({
        'model': ApiConfig.model,
        'messages': [
          {
            'role': 'system',
            'content': '''You are a health data extractor. Extract vital health information from the user's speech transcript.

The transcript may be in English, Hindi, or Hinglish.

Return ONLY a JSON object with these fields:
- "type": one of "bp", "sugar", "oxygen", "temperature", or "none"
- "value": the numeric value(s) found

Examples:
- "mera BP 120/80 hai" → {"type":"bp","value":"120/80"}
- "sugar 98 thi aaj subah" → {"type":"sugar","value":"98"}
- "oxygen 99 percent" → {"type":"oxygen","value":"99%"}
- "temperature 98.6 degree" → {"type":"temperature","value":"98.6°F"}
- "open medicines screen" → {"type":"none","value":""}

If no vital info is found, return {"type":"none","value":""}
Respond with ONLY the JSON, no other text.''',
          },
          {'role': 'user', 'content': transcript},
        ],
        'temperature': 0.1,
        'max_tokens': 50,
      }),
    );

    if (response.statusCode != 200) {
      return null;
    }

    final body = jsonDecode(response.body);
    final content = body['choices']?[0]?['message']?['content'] as String?;
    if (content == null) return null;

    try {
      final parsed = jsonDecode(content.trim()) as Map<String, dynamic>;
      final type = parsed['type'] as String?;
      final value = parsed['value'] as String?;

      if (type == null || type == 'none' || value == null) return null;

      return {'type': type, 'value': value};
    } catch (_) {
      return null;
    }
  }
}
