import 'package:edumarshal/data/rest_ds.dart';
import 'package:edumarshal/models/user.dart';
import 'package:edumarshal/models/user_batch.dart';

abstract class HomeScreenContract {
  void setUserBatch(UserBatch userBatch);
  void onBatchError(String errorTxt);
}

class HomeScreenPresenter {
  HomeScreenContract _view;
  RestDatasource api = new RestDatasource();
  HomeScreenPresenter(this._view);

  getBatchForLogInUser(LogedInUser user) {
    api.getBatch(user).then((UserBatch userBatch){
      _view.setUserBatch(userBatch);
    }

    ).catchError((Exception error) => _view.onBatchError(error.toString()));


  }
}