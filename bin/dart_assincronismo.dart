import 'dart:convert';

import 'package:http/http.dart' as http;

void main() {
  // print("ola mundo");
  requestDate();
}

void requestDate(){
  String url = 
    "https://gist.githubusercontent.com/geovannifranca/57933551e45ee9457e561c89daee0715/raw/6f75faa4b77d0568b8ef88454242dcb26f0bb9e0/accounts.json";
  Future<http.Response> futureResponse = http.get(Uri.parse(url));
  futureResponse.then((value) {
    print(json.decode(value.body)[0]["id"]);
  });
}