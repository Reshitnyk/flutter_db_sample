import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';
import '../bloc/states.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List listItems = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UsersBloc, UsersState>(listener: (context, state) {
      if (state is UsersLoadedState) {
        listItems = state.users;
      }
    }, builder: (context, state) {
      return Expanded(
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: listItems.length,
                itemBuilder: (context, index) {
                  final item = listItems[index];
                  return ListTile(
                      minVerticalPadding: 5,
                      minLeadingWidth: 5,
                      tileColor: Colors.lightBlue,
                      title: Text('$item'));
                })),
      );
    });
  }
}
