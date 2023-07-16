import 'dart:convert';
import 'dart:io';

import 'package:todoapp/app/logger.dart';
import 'package:todoapp/providers/models/task.dart';

class ApiClient {
  static const _baseUrl = 'https://beta.mrdekk.ru/todobackend';
  static const _authKey = 'Bearer bonnetless';

  final client = HttpClient();
  int revision = 0;

  Future<List<Task>> getTasks() async {
    final resp = await _request('/list');
    return Task.listFromJson(resp['list']);
  }

  Future<List<Task>> updateTasks(List<Task> tasks) async {
    final resp = await _request('/list', method: 'PATCH', body: {
      'status': 'ok',
      'list': tasks,
    });
    return Task.listFromJson(resp['list']);
  }

  Future<Task> putTask(Task task) async {
    final resp = await _request('/list', method: 'POST', body: {
      'status': 'ok',
      'element': task,
    });
    return Task.fromJson(resp['element']);
  }

  Future<Task> updateTask(Task task) async {
    final resp = await _request('/list/${task.id}', method: 'PATCH', body: {
      'status': 'ok',
      'element': task,
    });
    return Task.fromJson(resp['element']);
  }

  Future<bool> deleteTask(String taskId) async {
    final resp = await _request('/list/$taskId', method: 'DELETE');
    return resp['status'] == 'ok';
  }

  Future<Map<String, dynamic>> _request(
    String url, {
    String method = 'GET',
    Object body = Null,
  }) async {
    logger.i('API> $method $_baseUrl$url');
    final req = await client.openUrl(method, Uri.parse('$_baseUrl$url'));
    req.headers.set('content-type', 'application/json; charset=utf-8');
    req.headers.add('authorization', _authKey);
    req.headers.add('X-Last-Known-Revision', revision);
    logger.d('API> *** REQUEST-HEADERS:\n${req.headers.toString()}');
    if (body != Null) {
      req.write(jsonEncode(body));
    }
    final resp = await req.close();
    if (resp.statusCode != 200) {
      logger.e('API> http-error: http-status: ${resp.statusCode}');
      throw 'http-error: http-status is ${resp.statusCode}';
    }
    final cont = await (resp.transform(utf8.decoder)).join();
    logger.d('API> RESPONSE-BODY: $cont\n');

    final data = jsonDecode(cont) as Map<String, dynamic>;
    if (data['status'] != 'ok') {
      logger.e('API> http-response-status is not OK (${data['status']})');
      throw 'http-response-status is not OK (${data['status']})';
    }
    // update revision
    revision = data['revision'] as int;
    return data;
  }
}
