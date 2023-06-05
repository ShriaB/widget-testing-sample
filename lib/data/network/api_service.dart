import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:http/http.dart';

abstract class ApiService {
  Future<List<dynamic>> getUsers(Uri uri);
}

class ApiServiceImpl extends ApiService {
  @override
  Future<List<dynamic>> getUsers(Uri uri) async {
    try {
      Response response = await get(uri);
      List<dynamic> res = [];
      if (response.statusCode == 200) {
        res = jsonDecode(response.body)['data'];
      }
      return res;
    } on SocketException {
      rethrow;
    }
  }
}

final apiServiceProvider = Provider<ApiService>(((ref) => ApiServiceImpl()));
