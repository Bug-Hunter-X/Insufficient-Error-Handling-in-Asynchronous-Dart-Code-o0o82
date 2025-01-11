```dart
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> fetchData() async {
  try {
    final response = await http.get(Uri.parse('https://api.example.com/data'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;
      for (var item in data) {
        print('Item Name: ${item['name']}');
      }
    } else {
      // Throw a custom exception with more context
      throw ApiException('Failed to load data: ${response.statusCode}', response.body);
    }
  } on http.ClientException catch (e) {
    print('Network Error: ${e.message}');
  } on FormatException catch (e) {
    print('JSON Decoding Error: $e');
  } on ApiException catch (e) {
    print('API Error: ${e.message} - Raw Response: ${e.responseBody}');
  } catch (e, stacktrace) {
    print('Unexpected error: $e, stacktrace: $stacktrace');
  }
}

// Custom exception class for better error reporting
class ApiException implements Exception {
  final String message;
  final String responseBody;

  ApiException(this.message, this.responseBody);
}
```