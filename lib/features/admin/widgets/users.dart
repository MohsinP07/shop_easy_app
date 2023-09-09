// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shop_easy_ecommerce/common/widgets/loader.dart';
import 'package:shop_easy_ecommerce/features/admin/services/admin_services.dart';
import 'package:shop_easy_ecommerce/models/user.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  List<User>? users;
  List<User> filteredUsers = [];
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();

    fetchAllUsers();
  }

  fetchAllUsers() async {
    users = await adminServices.fetchAllUsers(context);
    filteredUsers = users!.where((user) => user.type != 'admin').toList();
    print(users);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return users == null
        ? Loader()
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Total Users ( ${filteredUsers.length} )"),
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: filteredUsers.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    final usersData = filteredUsers[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue.shade500,
                        child: Text(usersData.name.toString().substring(0, 1)),
                      ),
                      title: Text(usersData.name),
                      subtitle: Text(usersData.email),
                    );

                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.pushNamed(context, OrderDetailScreen.routeName,
                    //         arguments: usersData);
                    //   },
                    //   child: SizedBox(
                    //     height: 140,
                    //     child: SingleProduct(image: usersData.products[0].images[0]),
                    //   ),
                    // );
                  },
                ),
              ),
            ],
          );
  }
}
