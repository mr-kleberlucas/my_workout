// import 'dart:math';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart'
    as http; //* Criamos um "alias" para o pacote http

import '../models/workout.dart';

import '../exceptions/api_exception.dart';

class WorkoutProvider with ChangeNotifier {
  // final String userId;
  // final String token;

  final dynamic userId;
  final dynamic token;

  WorkoutProvider(this.userId, this.token);

  List<Workout> workouts = [];

  final String baseUrl =
      'https://workoutapp-e9e25-default-rtdb.firebaseio.com/workout';

  Future<List<Workout>> get() async {
    try {
      print('GET');
      workouts = [];
      final response = await http.get(
        Uri.parse(
          '$baseUrl.json?auth=$token&orderBy="userId"&equalTo="$userId"',
        ),
      );

      if (response.statusCode != 200) {
        final message = json.decode(response.body) as Map<String, dynamic>;
        throw ApiException(response.statusCode, message['error']);
      }
      final decoded = json.decode(response.body) as Map<String, dynamic>;

      print(response.statusCode);
      if (decoded != null) {
        decoded.forEach(
          (key, value) {
            workouts.add(
              Workout(
                key,
                value['name'],
                value['imageUrl'],
                value['weekDay'],
              ),
            );
          },
        );
      }

      return workouts;
    } on ApiException catch (api) {
      throw '${api.code} - ${api.message}';
    } catch (e) {
      // throw e.message;
      rethrow;
      // throw ScaffoldMessenger.of(ctx).showSnackBar(
      //   const SnackBar(
      //     // content: Text('$e'),
      //     content: Text('Erro, favor tentar novamente!'),
      //   ),
      // );
    }
  }

  Future<void> add(Workout w) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl.json?auth=$token'),
        body: json.encode(
          {
            'name': w.name,
            'imageUrl': w.imageUrl,
            'weekDay': w.weekDay,
            'userId': userId,
          },
        ),
      );
      // w.id = Random().nextInt(100).toString();
      w.id = json.decode(response.body)['name'];
      workouts.add(w);

      print(response.statusCode);
      print(response.body);

      notifyListeners();
    } catch (e) {
      // throw e.message;
      rethrow;
    }
  }

  Future<void> update(Workout w) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${w.id}.json?auth=$token'),
      body: json.encode(
        {
          'name': w.name,
          'imageUrl': w.imageUrl,
          'weekDay': w.weekDay,
          'userId': userId,
        },
      ),
    );

    print(response.statusCode);

    final index = workouts.indexWhere((element) => element.id == w.id);
    workouts[index] = w;

    notifyListeners();
  }

  Future<void> delete(String id) async {
    final response =
        await http.delete(Uri.parse('$baseUrl/$id.json?auth=$token'));
    print(response.statusCode);

    workouts.removeWhere((element) => element.id == id);

    notifyListeners();
  }

  Workout getById(String id) {
    return workouts.firstWhere((element) => element.id == id);
  }
}
