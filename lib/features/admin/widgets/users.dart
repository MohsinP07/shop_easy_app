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

  void _showUserDetailsDialog(User user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(user.name),
          content: Container(
            width: MediaQuery.of(context).size.width * 80 / 100,
            height: MediaQuery.of(context).size.height * 60 / 100,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Email: ${user.email}', style: TextStyle(fontSize: 14)),
                SizedBox(
                  height: 12,
                ),
                Text('Address: ${user.address}',
                    style: TextStyle(fontSize: 14)),
                SizedBox(
                  height: 12,
                ),
                Text('Phone: ${user.phone}', style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
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
                      onTap: () {
                        _showUserDetailsDialog(usersData); // Show dialog on tap
                      },
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
