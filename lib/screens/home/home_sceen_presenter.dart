import 'package:edumarshal/data/rest_ds.dart';
import 'package:edumarshal/models/user.dart';
import 'package:edumarshal/models/user_batch.dart';
import 'package:edumarshal/models/GetStudentByBatch.dart';
import 'package:edumarshal/models/LeaveEntity.dart';

abstract class HomeScreenContract {
  void setUserBatch(UserBatch userBatch);
  void onBatchError(String errorTxt);
  void setStudentsDetails(GetStudentByBatch getStudentByBatch);
  void setLeaveDetails(LeaveEntity leaveEntity);
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
  getStudentsData(LogedInUser user ,var _batchId) {
    api.getStudentsDetails(user,_batchId).then((GetStudentByBatch getStudentByBatch){
      _view.setStudentsDetails(getStudentByBatch);
    }

    ).catchError((Exception error) => _view.onBatchError(error.toString()));

  }

  doLeaveRequest(LogedInUser user , Map postDetails) {
    api.postLeaveRequest(user,postDetails).then((LeaveEntity leaveEntity){
      _view.setLeaveDetails(leaveEntity);
    }

    ).catchError((Exception error) => _view.onBatchError(error.toString()));

  }
}