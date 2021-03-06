import 'package:edumarshal/data/rest_ds.dart';
import 'package:edumarshal/models/user.dart';

abstract class LoginScreenContract {
  void onLoginSuccess(LogedInUser user);
  void onLoginError(String errorTxt);
  //void setUserBatch(UserBatch userBatch);
}

class LoginScreenPresenter {
  LoginScreenContract _view;
  RestDatasource api = new RestDatasource();
  LoginScreenPresenter(this._view);

  goForLogin(String username, String password) {
    api.login(username, password).then(
            (LogedInUser user) {_view.onLoginSuccess(user);}
    ).catchError((Exception error) => _view.onLoginError(error.toString()));
  }

// getBatchForLogInUser(LogedInUser user) {
//    api.getBatch(user).then((UserBatch userBatch){
//       _view.setUserBatch(userBatch);
//    }
//
//    ).catchError((Exception error) => _view.onLoginError(error.toString()));
//
//
//  }
}