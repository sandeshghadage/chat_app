import 'package:chatapp_flutter_firebase2/pages/auth/login_page.dart';
import 'package:chatapp_flutter_firebase2/pages/home_page/local_widget/burger_menu.dart';
import 'package:chatapp_flutter_firebase2/pages/profile_page.dart';
import 'package:chatapp_flutter_firebase2/pages/search_page.dart';
import 'package:chatapp_flutter_firebase2/service/auth_service.dart';
import 'package:chatapp_flutter_firebase2/widgets/widgets.dart';
import 'package:flutter/material.dart';
import '../../helper/helper_function.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthService authService = AuthService();
  String userName = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    gettingUserData();
  }

  gettingUserData() async {
    await HelperFunctions.getUserNameFromSF().then((value) {
      setState(() {
        userName = value!;
      });
    });
    await HelperFunctions.getUserEmailFromSF().then((value) {
      setState(() {
        email = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: const Text('Groups'),
        actions: [
          IconButton(
              onPressed: () {
                nextScreen(context, const SearchPage());
              },
              icon: Icon(Icons.search))
        ],
      ),
      drawer: BurgerMenu(authService: authService, userName: userName, email: email,),
    );
  }
}
