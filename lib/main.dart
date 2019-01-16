import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

void main() => runApp(MaterialApp(
  home: MyMainPage(),
));

class MyMainPage extends StatefulWidget {
  @override
  _MyMainPageState createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MyMainPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLogged=false;
  
  FirebaseUser myUser;

  Future<FirebaseUser> _loginWithFacebook() async{
    final facebookLogin = new FacebookLogin();
    final result = await facebookLogin.logInWithReadPermissions(['email']);

    debugPrint(result.status.toString());
    if (result.status == FacebookLoginStatus.loggedIn){
      FirebaseUser user = await _auth.signInWithFacebook(accessToken: result.accessToken.token);
      return user;
    }
    return null;
  }

  void _logOut() async{
    await _auth.signOut().then((response){
      isLogged = false;
      setState(() {});
    });
  }
  void _logIn(){
    _loginWithFacebook().then((response){
      if(response != null ){
        myUser = response;
        isLogged=true;
        setState(() {});
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isLogged?"toma por wacoh" : "hola"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.power_settings_new),
            onPressed: _logOut,
          )
        ],
    ),
    body: Center(
      child: isLogged
        ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("huacho"+ myUser.displayName),
            Image.network(myUser.photoUrl),
          ],
        )
          : FacebookSignInButton (
              onPressed: _logIn,
      ),
    ),
    );
  }
}

