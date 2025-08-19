import 'dart:async';
import 'dart:convert';
import 'package:dart_assincronismo/api_key.dart';
import 'package:http/http.dart' as http;

StreamController<String> streamController = StreamController<String>();

void main() {
  StreamSubscription streamSubscription = streamController.stream.listen((
    String info,
  ) {
    print(info);
  });
  requestDate();
  requestDataAsync();
  sendDataAsync({
    "id": "NEW001",
    "name": "flutter",
    "lastName": "dart",
    "balance": 5000,
  });
}

void requestDate() async {
  String url =
      "https://gist.githubusercontent.com/geovannifranca/57933551e45ee9457e561c89daee0715/raw/6f75faa4b77d0568b8ef88454242dcb26f0bb9e0/accounts.json";
  Future<http.Response> futureResponse = http.get(Uri.parse(url));
  await futureResponse.then((http.Response response) {
    streamController.add(
      "${DateTime.now()} || requisição de leitura (usando o then).",
    );
  });
}

Future<List<dynamic>> requestDataAsync() async {
  String url =
      "https://gist.githubusercontent.com/geovannifranca/57933551e45ee9457e561c89daee0715/raw/6f75faa4b77d0568b8ef88454242dcb26f0bb9e0/accounts.json";
  http.Response response = await http.get(Uri.parse(url));
  streamController.add("${DateTime.now()} || requisição de leitura.");
  return json.decode(response.body);
}

Future<String> sendDataAsync(Map<String, dynamic> mapAccount) async {
  List<dynamic> listAccounts = await requestDataAsync();
  listAccounts.add(mapAccount);
  String countent = json.encode(listAccounts);

  String url = "https://api.github.com/gists/57933551e45ee9457e561c89daee0715";

  http.Response response = await http.post(
    Uri.parse(url),
    headers: {"Authorization": "Bearer $gitHubApiKey"},
    body: json.encode({
      "description": "account.json",
      "public": true,
      "files": {
        "accounts.json": {"content": countent},
      },
    }),
  );
  if (response.statusCode.toString()[0] == "2") {
    streamController.add(
      "${DateTime.now()} || requisição adição bem sucedida (${mapAccount["name"]}).",
    );
  } else {
    streamController.add(
      "${DateTime.now()} || requisição falho. (${mapAccount["name"]}).",
    );
  }
  return countent;
}
