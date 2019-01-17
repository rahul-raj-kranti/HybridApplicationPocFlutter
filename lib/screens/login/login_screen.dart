import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:edumarshal/auth.dart';
import 'package:edumarshal/data/database_helper.dart';
import 'package:edumarshal/screens/login/login_screen_presenter.dart';
import 'package:edumarshal/models/user.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    implements LoginScreenContract, AuthStateListener {
  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  LogedInUser logedInUser = new LogedInUser();

  bool _isLoading = false;
  LoginScreenPresenter _presenter;

  @override
  void initState() {
    super.initState();
  }

  _LoginScreenState() {
    _presenter = new LoginScreenPresenter(this);
    var authStateProvider = new AuthStateProvider();
    authStateProvider.subscribe(this);
  }

  void _submit() {
    final form = _formKey.currentState;

    if (form.validate()) {
      setState(() => _isLoading = true);
      form.save();
      _presenter.goForLogin(logedInUser.username, logedInUser.password);
    }
  }

  void _showSnackBar(String text) {
    const Duration _kSnackBarDisplayDuration = Duration(milliseconds: 400);
    scaffoldKey.currentState.showSnackBar(
        new SnackBar(
            duration:_kSnackBarDisplayDuration,
              backgroundColor: Colors.red,
              content: new Text(text,textAlign: TextAlign.center,)
          ),
        );

  }

  @override
  onAuthStateChanged(AuthState state) {
    if (state == AuthState.LOGGED_IN) Navigator.of(context).pushNamed("/home");
  }

  @override
  Widget build(BuildContext context) {
    var loginBtn = Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        margin: EdgeInsets.only(top: 50.0),
        width: 250.0,
        height: 80.0,
        child: RaisedButton(
          color: Theme.of(context).buttonColor,
          child: Text(
            'SIGN IN',
            style: TextStyle(
                color: Theme.of(context).highlightColor,
                fontSize: 25.0,
                fontFamily: "Raleway",
                fontWeight: FontWeight.w700),
          ),
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(5.0)),
          elevation: 6.0,
          onPressed: () {
            _submit();
          },
        ),
      ),
    );

    final loginForm = new Form(
      key: _formKey,
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(left: 24.0, right: 24.0),
        children: <Widget>[
          _welcomeText(),
          _logoImageAsset(),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextFormField(
              keyboardType: TextInputType.text,
              autofocus: true,
              obscureText: false,
              onSaved: (val) => logedInUser.username = val,
              validator: (val) {
                if (val.isEmpty) {
                  return "Required Field";
                }
              },
              decoration: InputDecoration(
                errorStyle: TextStyle(
                    color: Theme.of(context).errorColor, fontSize: 15.0),
                prefixIcon: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Icon(Icons.group,
                      color: Theme.of(context).highlightColor),
                ),
                hintText: 'User Name',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextFormField(
              autofocus: true,
              obscureText: true,
              onSaved: (val) => logedInUser.password = val,
              validator: (val) {
                if (val.isEmpty) {
                  return "Required Field";
                }
              },
              decoration: InputDecoration(
                errorStyle: TextStyle(
                    color: Theme.of(context).errorColor, fontSize: 15.0),
                prefixIcon: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Icon(Icons.vpn_key,
                      color: Theme.of(context).highlightColor),
                ),
                hintText: 'Password',
              ),
            ),
          ),
          _isLoading
              ? Center(child: new CircularProgressIndicator())
              : loginBtn,
          _forgotPassword()
        ],
      ),
    );

    return Scaffold(key: scaffoldKey, body: loginForm);
  }

  @override
  void onLoginError(String errorTxt) {
    _showSnackBar(errorTxt);
    setState(() => _isLoading = false);
  }

  @override
  void onLoginSuccess(LogedInUser user) async {

    //_showSnackBar(user.toString());
    var authStateProvider = new AuthStateProvider();
    if (user.accessToken != null) {
      setState(() => _isLoading = false);
      var db = new DatabaseHelper();
      await db.saveUser(user);
      //await db.deleteUsers();
      authStateProvider.notify(AuthState.LOGGED_IN);
    }else{
    this.onLoginError(user.error_description);
    authStateProvider.notify(AuthState.LOGGED_OUT);
    }

  }
}

class _welcomeText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final welcomeText = Center(
      child: Container(
        padding: EdgeInsets.only(top: 45.0, bottom: 35.0),
        child: Text(
          "Welcome to",
          textDirection: TextDirection.ltr,
          style: TextStyle(
              decoration: TextDecoration.none,
              color: Theme.of(context).highlightColor,
              fontSize: 35.0,
              fontFamily: "Raleway",
              fontWeight: FontWeight.w400),
        ),
      ),
    );
    return welcomeText;
  }
}

class _logoImageAsset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = new AssetImage("images/edu.png");
    Image image = new Image(
      image: assetImage,
      width: 256.0,
      height: 136.0,
    );
    return Container(padding: EdgeInsets.only(bottom: 40.0), child: image);
  }
}

class _forgotPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final forgotLabel = FlatButton(
        child: Text(
          'Forgot password?',
          style: TextStyle(
              color: Theme.of(context).highlightColor,
              decoration: TextDecoration.underline,
              fontSize: 15.0,
              fontFamily: "Raleway",
              fontWeight: FontWeight.w400),
        ),
        onPressed: null);
    return forgotLabel;
  }
}
