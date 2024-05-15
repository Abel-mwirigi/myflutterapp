import 'package:http/http.dart' as http;
import 'dart:convert';

class TransactionService {
  static const String baseUrl = 'http://127.0.0.1:8000/';

  static Future<bool> deleteTransaction(int id) async {
    final response =
        await http.delete(Uri.parse('$baseUrl/user/transactions/$id/'));
    return response.statusCode == 204;
  }

  static Future<bool> updateTransaction(
      int id, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/user/transactions/$id/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    return response.statusCode == 200;
  }
}
