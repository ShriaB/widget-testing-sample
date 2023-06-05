import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_list_users/model/user_model.dart';
import 'package:riverpod_list_users/views/details_view.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('User details Screen', (tester) async {
    // Arrange
    UserModel user = UserModel(
        1,
        "dummy@email.com",
        "Test firstname",
        "Test lastname",
        "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541");

    await mockNetworkImagesFor(
      () => tester.pumpWidget(MaterialApp(
        home: DetailsView(
          user: user,
        ),
      )),
    );
    expect(find.byType(CircleAvatar), findsOneWidget);
    expect(find.byType(Text), findsNWidgets(3));
  });
}
