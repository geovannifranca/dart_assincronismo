import 'dart:async';
import 'dart:convert';
import 'package:dart_assincronismo/api_key.dart';
import '../models/account.dart';
import 'package:http/http.dart' as http;

class AccountServce {
  final StreamController<String> _streamController = StreamController<String>();
  Stream<String> get streamInfos => _streamController.stream;
  String url = "https://api.github.com/gists/57933551e45ee9457e561c89daee0715";

  Future<List<Account>> getAll() async {
    http.Response response = await http.get(Uri.parse(url));
    _streamController.add("${DateTime.now()} || requisição de leitura.");
    Map<String, dynamic> mapResponse = json.decode(response.body);
    List<dynamic> listDynamic = json.decode(
      mapResponse["files"]["account.json"]["content"],
    );
    List<Account> listAccount = [];
    for (dynamic dyn in listDynamic) {
      Map<String, dynamic> mapAccount = dyn as Map<String, dynamic>;
      Account account = Account.fromMap(mapAccount);
      listAccount.add(account);
    }
    return listAccount;
  }

  Future<String> addAccount(Account account) async {
    List<Account> listAccounts = await getAll();
    listAccounts.add(account);

    List<Map<String, dynamic>> listContent = [];
    for (Account account in listAccounts) {
      listContent.add(account.toMap());
    }

    String content = json.encode(listContent);

    http.Response response = await http.post(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $gitHubApiKey"},
      body: json.encode({
        "description": "account.json",
        "public": true,
        "files": {
          "accounts.json": {"content": content},
        },
      }),
    );
    if (response.statusCode.toString()[0] == "2") {
      _streamController.add(
        "${DateTime.now()} || requisição adição bem sucedida (${account.name}).",
      );
    } else {
      _streamController.add(
        "${DateTime.now()} || requisição falho. (${account.name}).",
      );
    }
    return content;
  }
}
