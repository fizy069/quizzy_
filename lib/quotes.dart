// quotes.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class QuoteService {
  Future<String> getRandomQuote() async {
    try {
      final response = await http.get(Uri.parse('https://api.quotable.io/random'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final String content = data['content'];
        final String author = data['author'];
        final String fullQuote = '"$content" - $author';
        return fullQuote;
      } else {
        return 'Failed to fetch a quote.';
      }
    } catch (e) {
      return 'Error fetching a quote: $e';
    }
  }
}
