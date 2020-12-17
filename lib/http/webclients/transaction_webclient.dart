import 'dart:convert';

import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/transaction.model.dart';
import 'package:http/http.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    final Response response = await client.get(baseUrl).timeout(Duration(seconds: 5));
    return this._toTransactions(response);
  }

  List<Transaction> _toTransactions(Response response) {
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson.map((e) => Transaction.fromJson(e)).toList();
  }

  Future<Transaction> save(Transaction transaction) async {
    final Response response = await client.post(
      baseUrl,
      headers: {
        'Content-Type': 'application/json',
        'password': '1000',
      },
      body: jsonEncode(transaction.toJson()),
    );
    return Transaction.fromJson(jsonDecode(response.body));
  }
}
