import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_list_users/model/user_model.dart';
import 'package:riverpod_list_users/view_models/user_view_model.dart';
import 'package:riverpod_list_users/views/details_view.dart';

class HomeView extends ConsumerWidget {
  HomeView({super.key, required this.userData});

  late AsyncValue<List<UserModel>> userData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("All Users"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: userData.when(
              data: (users) {
                return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (_, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DetailsView(
                                    user: users[index],
                                  )));
                        },
                        child: Card(
                          color: Colors.blue[600],
                          child: ListTile(
                            title: Text(
                                "${users[index].firstName} ${users[index].lastName}"),
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(users[index].avatar),
                            ),
                            textColor: Colors.white,
                          ),
                        ),
                      );
                    });
              },
              error: (e, s) => const Center(
                      child: Text(
                    "Some Error occured",
                    key: Key("error_message"),
                  )),
              loading: () => const Center(child: CircularProgressIndicator())),
        ));
  }
}
