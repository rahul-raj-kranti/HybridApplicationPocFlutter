import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:edumarshal/data/database_helper.dart';
import 'package:edumarshal/models/user_batch.dart';
import 'dart:convert';
import 'package:edumarshal/screens/home/home_sceen_presenter.dart';
import 'package:edumarshal/models/user.dart';

class HomeScreen extends StatefulWidget {
  @override
  _homeScreen createState() => _homeScreen();
}

class _homeScreen extends State<HomeScreen> implements HomeScreenContract {
  DatabaseHelper db = new DatabaseHelper();
  LogedInUser logedInUser = new LogedInUser();
  Map postDetails = new Map();
  //UserBatch userBatch = new UserBatch();
  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  HomeScreenPresenter _presenter;
  var UserCredential;
  Map batchIdAgainstBatchName;
  Map userIdAgainstStudentsName;
  List<String> _batchList = [];
  var selectedBatch = "Select Batch"; //default value
  //List<String> studentList = [];
  List<String> studentList =[];
  var selectedStudent = "Student Name"; //default value

  @override
  void initState() {
    super.initState();
  }

  _homeScreen() {
    _presenter = new HomeScreenPresenter(this);
    loadItemData();
  }

  @override
  Widget build(BuildContext context) {
    //if (batchList.length == 0) {
    //loadItemData();
    //}

    final _batchLabel = Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      child: Container(
          margin: EdgeInsets.only(top: 10.0),
          color: Colors.yellow,
          width: 400.0,
          height: 20.0,
          child: Text(
            "Batch*",
            style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontFamily: "Raleway",
                fontWeight: FontWeight.w700),
          )),
    );
    var _selectBatchDropDownButton = new Container(
        margin: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
        color: Colors.white,
        child: DropdownButtonHideUnderline(
            child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<String>(
            hint: Text(
              this.selectedBatch,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                  fontFamily: "Raleway",
                  fontWeight: FontWeight.w700),
            ),
            items: _batchList.map((String dropDownItem) {
              return DropdownMenuItem<String>(
                value: dropDownItem,
                child: Text(dropDownItem, style: TextStyle(color: Colors.red)),
              );
            }).toList(),
            onChanged: (String _selectedBatch) {
              int id =_getBatchId(_selectedBatch);

              if(id!=null){
                this._submit(id);

              }
              setState(() {
                this.selectedBatch = _selectedBatch;
              });
            },
          ),
        )));

    final _studentNameLabel = Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
      child: Container(
          margin: EdgeInsets.only(top: 10.0),
          color: Colors.yellow,
          width: 400.0,
          height: 20.0,
          child: Text(
            "Student Name*",
            style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontFamily: "Raleway",
                fontWeight: FontWeight.w700),
          )),
    );
    var _StudentNameDropDownButton = new Container(
        margin: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
        color: Colors.white,
        child: DropdownButtonHideUnderline(
            child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<String>(
            hint: Text(
              this.selectedStudent,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                  fontFamily: "Raleway",
                  fontWeight: FontWeight.w700),
            ),
            items: studentList.map((String dropDownItem) {
              return DropdownMenuItem<String>(
                value: dropDownItem,
                child: Text(dropDownItem, style: TextStyle(color: Colors.red)),
              );
            }).toList(),
            onChanged: (String _selectedStudent) {

              int id =_userId(_selectedStudent);

              if(id!=null){
                String  userId = id.toString();
                postDetails["userId"] = userId;
                print("PostDetails");
                print(postDetails);

              }else{
                //TODO code
              }
              setState(() {
                this.selectedStudent = _selectedStudent;
              });
            },
          ),
        )));
    var _reasonLable = Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
      child: Container(
          margin: EdgeInsets.only(top: 10.0),
          color: Colors.yellow,
          width: 400.0,
          height: 20.0,
          child: Text(
            "Reason*",
            style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontFamily: "Raleway",
                fontWeight: FontWeight.w700),
          )),
    );
    var _reasonLableFields = Container(
      margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        autofocus: true,
        textAlign: TextAlign.start,
        textDirection: TextDirection.ltr,
        obscureText: false,
        maxLines: null,
        style: TextStyle(
          color: Colors.black,
        ),
        onSaved: null,
        decoration: new InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: new EdgeInsets.fromLTRB(10.0, 80.0, 100.0, 10.0),
          border:
              new OutlineInputBorder(borderRadius: BorderRadius.horizontal()),
        ),
      ),
    );

    var _submit = Padding(
      padding: new EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: Container(
        margin: EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 0.0),
        width: 250.0,
        height: 50.0,
        child: RaisedButton(
            color: Theme.of(context).buttonColor,
            child: Text(
              'SUBMIT',
              style: TextStyle(
                  color: Theme.of(context).highlightColor,
                  fontSize: 25.0,
                  fontFamily: "Raleway",
                  fontWeight: FontWeight.w700),
            ),
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(5.0)),
            elevation: 6.0,
            onPressed: null),
      ),
    );

    return new Scaffold(
      //key: scaffoldKey,
      backgroundColor: Theme.of(context).buttonColor,
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: new Text("Apply Student Leave"),
        leading: IconButton(
          icon: const Icon(Icons.dehaze, color: Colors.white),
          onPressed: null,
        ),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.drag_handle, color: Colors.white),
              onPressed: null),
        ],
      ),
      body: Container(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            _batchLabel,
            _selectBatchDropDownButton,
            _studentNameLabel,
            _StudentNameDropDownButton,
            _reasonLable,
            _reasonLableFields,
            _submit
          ],
        ),
      ),
    );
  }
  void _submit(int id){
    String  batchId = id.toString();
    _presenter.getStudentsData(logedInUser , batchId);
  }
  loadItemData() async {
    UserCredential = await db.getStoreData("User");
    //print(UserCredential);

    logedInUser.accessToken = UserCredential[0]["accessToken"];
    logedInUser.XContextId = UserCredential[0]["xContextId"];
    logedInUser.XRX = UserCredential[0]["xRX"];
    _presenter.getBatchForLogInUser(logedInUser);
  }

  int _getBatchId(String _selectedBatchName) {
     var id = batchIdAgainstBatchName[_selectedBatchName];
     print(id);
    return id;
  }
  int _userId(String _selectedStudentName) {
    var id = userIdAgainstStudentsName[_selectedStudentName];
    print(id);
    return id;
  }
  @override
  void onBatchError(String errorTxt) {
    _showSnackBar(errorTxt);
  }

  @override
  void setUserBatch(userBatch) async {
    _batchList = userBatch.batchList;
    //print(_batchList);
    batchIdAgainstBatchName = userBatch.batchId;
   // print(batchIdAgainstBatchName);
    if(!await db.isExistingData("BatchList")){
        await db.saveBatchList(userBatch);
    }
  }
  @override
  void setStudentsDetails(getStudentByBatch) async {
    studentList.add("TEST A");
    studentList.add("TEST B");
    studentList = getStudentByBatch.studentsList;
   // print(studentList);
    userIdAgainstStudentsName = getStudentByBatch.studentUserId;
   // print(userIdAgainstStudentsName);
    if(!await db.isExistingData("StudentDetails")){
      await db.saveStudentDetails(getStudentByBatch);
    }
  }
  void _showSnackBar(String text) {
    const Duration _kSnackBarDisplayDuration = Duration(milliseconds: 400);
    scaffoldKey.currentState.showSnackBar(
      new SnackBar(
          duration: _kSnackBarDisplayDuration,
          backgroundColor: Colors.red,
          content: new Text(
            text,
            textAlign: TextAlign.center,
          )),
    );
  }
//  void main() {
//     var map = json.encode(_batches);
//     print("voidaMain");
//     print(_batches.toString());
//    print(map);

//for (var value in map.values) print(value);
//for (int i = 0; i < map.length; i++) {
//final list = map.toList(growable: true);
//     // print(list);
//    //for (var value in map.values) print(value);
//    //}
//        for (var x = 0; x < _batches.length; x++) {
//      var courseName = _batches[x]["courseName"];
//      if (_batches[x]["batchs"].length > 0) {
//        for (var i = x; i < _batches[x]["batchs"].length; i++) {
//          var _batchname = courseName + _batches[x]["batchs"][i]["batchName"];
//          var _batchId = _batches[x]["batchs"][i]["id"];
//          parsjsonToBatchlist.add(_batchname);
//          mapAgainstBatchNameIdPairs[_batchname] = _batchId;
//        }
//      }
//    }
//}
}
