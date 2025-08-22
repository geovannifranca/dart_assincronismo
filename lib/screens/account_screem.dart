import 'dart:io';

import 'package:dart_assincronismo/models/account.dart';
import 'package:dart_assincronismo/services/account_servce.dart';

class AccountScreem {
  final AccountServce _accountServce = AccountServce();

  void initializeScreem() async {
    _accountServce.streamInfos.listen((e) {
      print(e);
    });
  }

  void runChatBot() async {
    print("Bom dia sou Lerry, assistente do banco D'ouro!");
    print("Que bom te ter aqui com a gente.\n");

    bool isRunning = true;
    while (isRunning) {
      print("Como é que eu posso te ajudar? \n (Digite o número desejado)");
      print("1 - Ver todas as Contas.");
      print("2 - Adicionar nova conta.");
      print("3 - sair\n");

      String? input = stdin.readLineSync();
      if (input != null) {
        switch (input) {
          case "1":
            {
              await _getAllAccount();
              break;
            }
          case "2":
            {
              await _addExemploAccount();
              break;
            }
          case "3":
            {
              isRunning = false;
              print("Até mais!");
              break;
            }
          default:
            {
              print("Digite um número válido");
            }
        }
      }
    }
  }

  Future<void> _getAllAccount() async {
    List<Account> listAccount = await _accountServce.getAll();
    print(listAccount);
  }

  Future<void> _addExemploAccount() async {
    Account exemplo = Account(
      id: "iID666",
      name: "Dart",
      lastName: "Google",
      balance: 500,
    );
    await _accountServce.addAccount(exemplo);
    await _getAllAccount();
  }
}
