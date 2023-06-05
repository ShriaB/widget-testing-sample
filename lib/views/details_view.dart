import 'package:flutter/material.dart';
import 'package:riverpod_list_users/model/user_model.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({super.key, required this.user});
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: Center(
          child: Column(children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user.avatar),
              radius: 100.0,
            ),
            Divider(
              height: 50.0,
              color: Colors.blue[200],
              thickness: 2.0,
            ),
            Text("${user.firstName} ${user.lastName}"),
            const SizedBox(
              height: 10.0,
            ),
            Text(user.email),
          ]),
        ),
      ),
    );
  }
}
