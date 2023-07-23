import 'package:amazon/common/widgets/bottombar.dart';
import 'package:amazon/features/Admin/Screens/admin_screen.dart';
import 'package:amazon/features/auth/services/authservices.dart';
import 'package:amazon/provider/user_provider.dart';
import 'package:amazon/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Constant/global_variable.dart';
import 'features/auth/screens/auth_screen.dart';
import 'features/auth/services/authservices.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Authservices authservices = Authservices();
  @override
  void initState() {
    authservices.getuserData(context);
    super.initState();

  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        title: 'Amazon Clone',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme:
              ColorScheme.light(primary: Globalariables.secondaryColor),
          scaffoldBackgroundColor: Globalariables.backgroundColor,
          appBarTheme: AppBarTheme(
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
          ),
        ),
        onGenerateRoute: (settings) => generateroute(settings),
        home: Provider.of<UserProvider>(context).user.token.isNotEmpty?
        Provider.of<UserProvider>(context).user.type=='user'? const Bottombar():const AdminScreen(): const AuthScreen());
  }
}
