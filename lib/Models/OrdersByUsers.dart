import 'package:cake_mania_admin/services/AuthenticationService.dart';

class OrdersByUsers {
  List<LocalUser> users;
  OrdersByUsers({
    required this.users,
  });

  factory OrdersByUsers.fromJson(json) =>
      OrdersByUsers(users: LocalUser.jsonToLocalUserList(json));

 
}
