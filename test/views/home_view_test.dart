import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:riverpod_list_users/model/user_model.dart';
import 'package:riverpod_list_users/views/home_view.dart';

void main() {
  testWidgets('Home  ...', (tester) async {
    // Arrange
    AsyncValue<List<UserModel>> userData =
        const AsyncLoading<List<UserModel>>();

    await tester.pumpWidget(MaterialApp(
      home: HomeView(
        userData: userData,
      ),
    ));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    String json = ''' [
        {
            "id": 7,
            "email": "michael.lawson@reqres.in",
            "first_name": "Michael",
            "last_name": "Lawson",
            "avatar": "https://reqres.in/img/faces/7-image.jpg"
        },
        {
            "id": 8,
            "email": "lindsay.ferguson@reqres.in",
            "first_name": "Lindsay",
            "last_name": "Ferguson",
            "avatar": "https://reqres.in/img/faces/8-image.jpg"
        },
        {
            "id": 9,
            "email": "tobias.funke@reqres.in",
            "first_name": "Tobias",
            "last_name": "Funke",
            "avatar": "https://reqres.in/img/faces/9-image.jpg"
        }]''';
    List<UserModel> data =
        (jsonDecode(json) as List).map((e) => UserModel.fromJson(e)).toList();

    userData = AsyncData<List<UserModel>>(data);
    await mockNetworkImagesFor(
      () => tester.pumpWidget(MaterialApp(
        home: HomeView(
          userData: userData,
        ),
      )),
    );

    expect(find.byType(ListView), findsOneWidget);

    userData = AsyncError<List<UserModel>>(Error(), StackTrace.current);
    await mockNetworkImagesFor(
      () => tester.pumpWidget(MaterialApp(
        home: HomeView(
          userData: userData,
        ),
      )),
    );

    expect(find.byKey(const Key("error_message")), findsOneWidget);
  });
}
