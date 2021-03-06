import 'dart:convert';

import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    final Response response = await client.get(baseUrl);
    return this._toTransactions(response);
  }

  List<Transaction> _toTransactions(Response response) {
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson.map((e) => Transaction.fromJson(e)).toList();
  }

  Future<Transaction> save(Transaction transaction, String password) async {
    final Response response = await client.post(
      baseUrl,
      headers: {
        'Content-Type': 'application/json',
        'password': password,
      },
      body: jsonEncode(transaction.toJson()),
    );
    if (response.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(response.body));
    }
    throw HttpException(_getMessage(response.statusCode));
  }

  String _getMessage(int statusCode) {
    if (_statusCodeResponses.containsKey(statusCode)) {
      return _statusCodeResponses[statusCode];
    }
    return 'Unknown error';
  }

  static Map<int, String> _statusCodeResponses = {
    400: 'there was an error submitting transaction',
    401: 'authentication failed',
    409: 'transaction already exists',
  };
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}
