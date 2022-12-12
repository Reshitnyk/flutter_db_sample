import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:test_db/bloc/bloc.dart';
import 'package:test_db/bloc/events.dart';
import 'package:test_db/bloc/states.dart';
import 'package:test_db/datasource/ds_users.dart';
import 'package:test_db/model/user.dart';
import 'package:test_db/ui/list_user.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController userName = TextEditingController();
  TextEditingController userAge = TextEditingController(text: '0');

  @override
  Widget build(BuildContext context) {
    // BlocBuilder, BlocConsumer

    return BlocListener<UsersBloc, UsersState>(
      listener: (BuildContext context, state) {
        if (state is UsersLoadedState) {
          print(state.users);
        }
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: userName,
              decoration: InputDecoration(hintText: "User name"),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: userAge,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: "User age"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _deleteUsers,
              child: const Text('Delete users'),
            ),
            ElevatedButton(onPressed: _addTestValues, child: Text('Add User')),
            ElevatedButton(
              onPressed: _printUsers,
              child: const Text('Print users'),
            ),
            UserList()
          ],
        ),
      ),
    );
  }

  void _addTestValues() {
    final bloc = BlocProvider.of<UsersBloc>(context);
    bloc.add(
      AddUserEvent(
        User(
          name: userName.text,
          age: int.parse(userAge.text),
        ),
      ),
    );
    userName.clear();
    userAge.clear();
  }

  void _printUsers() {
    final bloc = BlocProvider.of<UsersBloc>(context);
    bloc.add(LoadUsersEvent());
  }

  void _deleteUsers() {
    final bloc = BlocProvider.of<UsersBloc>(context);
    bloc.add(DeleteUsersEvent());
  }
}
