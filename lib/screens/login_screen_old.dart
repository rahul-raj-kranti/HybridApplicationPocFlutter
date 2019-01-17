/*
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            _welcomeText(),
            _logoImageAsset(),
            SizedBox(height: 18.0),
            _userNameLabel(),
            SizedBox(height: 18.0),
            _passwordLabel(),
            _RaisedButton(),
            _forgotPassword()
          ],
        ),
      ),
    );
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

class _userNameLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _userEmail = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: true,
      obscureText: true,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.all(0.0),
          child: Icon(Icons.group, color: Theme.of(context).highlightColor),
        ),
        hintText: 'User Name',
      ),
    );
    return _userEmail;
  }
}

class _passwordLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final password = TextFormField(
      autofocus: true,
      obscureText: true,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.all(0.0),
          child: Icon(Icons.vpn_key, color: Theme.of(context).highlightColor),
        ),
        hintText: 'Password',
      ),
    );
    return password;
  }
}

class _RaisedButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final button = Container(
      margin: EdgeInsets.only(top: 80.0),
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
          Navigator.of(context).pushNamed("/home");
        },
      ),
    );

    return button;
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
*/
// secound Code Snipet

/*
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
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
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Required Fields";
                  }
                },
                decoration: InputDecoration(
                  errorStyle: TextStyle(
                      color: Theme
                          .of(context)
                          .errorColor,
                      fontSize: 15.0
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(0.0),

                    child: Icon(Icons.group, color: Theme
                        .of(context)
                        .highlightColor),
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
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Required Fields";
                    }
                  },
                  decoration: InputDecoration(
                    errorStyle: TextStyle(
                        color: Theme
                            .of(context)
                            .errorColor,
                        fontSize: 15.0
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Icon(Icons.vpn_key, color: Theme
                          .of(context)
                          .highlightColor),
                    ),
                    hintText: 'Password',
                  ),
                )
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child:
              Container(
                margin: EdgeInsets.only(top: 80.0),
                width: 250.0,
                height: 80.0,
                child: RaisedButton(
                  color: Theme
                      .of(context)
                      .buttonColor,
                  child: Text(
                    'SIGN IN',
                    style: TextStyle(
                        color: Theme
                            .of(context)
                            .highlightColor,
                        fontSize: 25.0,
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.w700),
                  ),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(5.0)),
                  elevation: 6.0,
                  onPressed: () {
                    setState(() {
                      if (_formKey.currentState.validate()) {
                        Navigator.of(context).pushNamed("/home");
                      }
                    });
                  },
                ),
              ),
            ),
            _forgotPassword()
          ],
        ),
      ),
    );
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
              color: Theme
                  .of(context)
                  .highlightColor,
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
              color: Theme
                  .of(context)
                  .highlightColor,
              decoration: TextDecoration.underline,
              fontSize: 15.0,
              fontFamily: "Raleway",
              fontWeight: FontWeight.w400),
        ),
        onPressed: null);
    return forgotLabel;
  }
}
*/
