import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<Map<String, dynamic>>> fetchData() async {
    const String url = "https://www.cheapshark.com/api/1.0/deals";
    // Simulate a network call
    final result = await http.get(Uri.parse(url));
    if (result.statusCode == 200) {
      print("Data fetched successfully: ${result.body}");
      final List<dynamic> jsonList = jsonDecode(result.body);
      return List<Map<String, dynamic>>.from(jsonList);
    } else {
      print("Failed to fetch data: ${result.statusCode}");
      return [
        {"Error": "${result.statusCode}"},
      ];
    }
  }

  Future<List<Map<String, dynamic>>> fetchDataByTitle(String title) async {
    
     String url =
        "https://www.cheapshark.com/api/1.0/deals?storeID=1&title=$title";
    // Simulate a network call
    final result = await http.get(Uri.parse(url));
    if (result.statusCode == 200) {
      print("Data fetched successfully: ${result.body}");
      final List<dynamic> jsonList = jsonDecode(result.body);
      return List<Map<String, dynamic>>.from(jsonList);
    } else {
      print("Failed to fetch data: ${result.statusCode}");
      return [
        {"Error": "${result.statusCode}"},
      ];
    }
  }
}
