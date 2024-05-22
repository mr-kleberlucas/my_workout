import 'dart:math';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/exercise.dart';

import '../exceptions/api_exception.dart';

class ExerciseProvider with ChangeNotifier {
  // final String token;
  final dynamic token;

  ExerciseProvider(this.token);

  final String baseUrl =
      'https://workoutapp-e9e25-default-rtdb.firebaseio.com/exercise';

  // Future<void> get(String workoutId) async {
  Future<List<Exercise>> get(String workoutId) async {
    List<Exercise> exercises = [];
    final response = await http.get(
      Uri.parse(
          '$baseUrl.json?auth=$token&orderBy="workoutId"&equalTo="$workoutId"'),
    );

    final decoded = json.decode(response.body) as Map<String, dynamic>;

    if (decoded != null) {
      decoded.forEach(
        (key, value) {
          exercises.add(
            Exercise(
              key,
              value['name'],
              value['description'],
              value['imageUrl'],
              value['wotkoutId'],
            ),
          );
        },
      );
    }

    return exercises;

    // List<Exercise> filtered = [];
    // _list.forEach(
    //   (element) {
    //     if (element.workoutId == workoutId) {
    //       filtered.add(element);
    //     }
    //   },
    // );

    // return filtered;
  }

  Future<void> add(Exercise e) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl.json?auth=$token'),
        body: json.encode(
          {
            'name': e.name,
            'description': e.description,
            'imageUrl': e.imageUrl,
            'workoutId': e.workoutId,
          },
        ),
      );

      // e.id = Random().nextInt(100).toString();
      // _list.add(e);

      // if (response.statusCode > 400) {

      // }
      if (response.statusCode != 200) {
        // final message = json.decode(response.body);
        // throw ApiException(response.statusCode, message['error']);
        throw ApiException(response.statusCode, response.body);
      }
      notifyListeners();
    } on ApiException catch (api) {
      throw '${api.code} - ${api.message}';
    } catch (e) {
      // throw e.message;
      rethrow;
    }
  }

  Future<void> delete(String id) async {
    final response =
        await http.delete(Uri.parse('$baseUrl/$id.json?auth=$token'));

    // _list.removeWhere((element) => element.id == id);

    notifyListeners();
  }
}
