```dart
Future<void> fetchData() async {
  try {
    final response = await http.get(Uri.parse('https://api.example.com/data'));
    if (response.statusCode == 200) {
      // Assuming the response is a JSON array
      final data = jsonDecode(response.body) as List<dynamic>;
      // Process the data
      for (var item in data) {
        print(item['name']); // Example: Accessing 'name' field
      }
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    // Handle error cases, but don't just print the error!
    print('Error fetching data: $e'); // This is insufficient error handling
    rethrow; // Re-throw to let calling functions handle it
  }
}
```