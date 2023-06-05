import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_list_users/data/network/api_service.dart';
import 'package:riverpod_list_users/model/user_model.dart';

class UserViewModel {
  final Ref ref;

  UserViewModel(this.ref);

  Future<List<UserModel>> getUsers() async {
    // Making the API call
    List<dynamic> response = await ref
        .read(apiServiceProvider)
        .getUsers(Uri.parse("https://reqres.in/api/users?page=2"));

    // Preparing the data to be rendered in UI
    List<UserModel> userList =
        response.map((user) => UserModel.fromJson(user)).toList();

    return userList;
  }
}

final userViewModelProvider =
    Provider<UserViewModel>((ref) => UserViewModel(ref));
final userDataProvider = FutureProvider<List<UserModel>>((ref) async {
  return ref.read(userViewModelProvider).getUsers();
});
