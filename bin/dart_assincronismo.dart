import 'dart:convert';

import 'package:http/http.dart' as http;

void main() {
  requestDataAsync();
  print("ola mundo");
}

void requestDate() async {
  String url =
      "https://gist.githubusercontent.com/geovannifranca/57933551e45ee9457e561c89daee0715/raw/6f75faa4b77d0568b8ef88454242dcb26f0bb9e0/accounts.json";
  Future<http.Response> futureResponse = http.get(Uri.parse(url));
  await futureResponse.then((value) {
    List<dynamic> listAccounts = json.decode(value.body);
    Map<String, dynamic> carla = listAccounts.firstWhere(
      (element) => element["name"] == "Carla",
    );
    print(carla["balance"]);
  });
}

void requestDataAsync() async {
  String url =
      "https://gist.githubusercontent.com/geovannifranca/57933551e45ee9457e561c89daee0715/raw/6f75faa4b77d0568b8ef88454242dcb26f0bb9e0/accounts.json";
  http.Response response = await http.get(Uri.parse(url));
  print(json.decode(response.body)[0]);
}
