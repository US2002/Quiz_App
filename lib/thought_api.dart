import 'dart:convert';

import 'package:http/http.dart' as http;

Quotes quotesFromJson(String str) => Quotes.fromJson(json.decode(str));

String quotesToJson(Quotes data) => json.encode(data.toJson());

//API to call Quotes on results screen
class Api {
  static Future<Quotes?> getQuotes() async {
    Uri url = Uri.parse(
        'https://api.forismatic.com/api/1.0/?method=getQuote&lang=en&format=json&jsonp=\n');
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      print("success");
      return Quotes.fromJson(jsonDecode((response.body)));
    } else {
      print("error in getting data");
    }
  }
}

class Quotes {
  Quotes({
    this.content = '',
    this.author = '',
  });

  factory Quotes.fromJson(Map<String, dynamic> json) => Quotes(
        content: json["quoteText"],
        author: json["quoteAuthor"],
      );

  String author;
  String content;

  Map<String, dynamic> toJson() => {
        "content": content,
        "author": author,
      };
}
