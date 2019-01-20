import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:edumarshal/data/database_helper.dart';
import 'package:edumarshal/models/user_batch.dart';
import 'dart:convert';
import 'package:edumarshal/screens/home/home_sceen_presenter.dart';
import 'package:edumarshal/models/user.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class HomeScreen extends StatefulWidget {
  @override
  _homeScreen createState() => _homeScreen();
}

class _homeScreen extends State<HomeScreen> implements HomeScreenContract {
  final dateFormat = DateFormat("yyyy-MM-dd");
  var formatter = new DateFormat('yyyy-MM-dd');
  DateTime date;
  var reasonForLeave;
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
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  _homeScreen() {
    _presenter = new HomeScreenPresenter(this);
    loadItemData();
  }
 void _submitLeave() async{
   final form = _formKey.currentState;

   if (postDetails.isNotEmpty) {
     setState(() => _isLoading = true);
     _presenter.doLeaveRequest(logedInUser, postDetails);
   }else{
     this.onBatchError("All are mendetory fields");
   }

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
    var _StudentNameDropDownButton  = new Container(
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
      child: TextField(
        keyboardType: TextInputType.text,
        autofocus: true,
        textAlign: TextAlign.start,
        //textDirection: TextDirection.ltr,
        obscureText: false,
        maxLines: null,
        style: TextStyle(
          color: Colors.black,
        ),
//        onSaved:  (val) =>  postDetails["reason"] = val,
//        validator: (val) {
//          if (val.isEmpty) {
//            return "Required Field";
//          }
//        },
          onChanged: (String resons){
            setState((){
              reasonForLeave = resons;
              postDetails["reason"] = reasonForLeave;
            });

          },

        decoration: new InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: new EdgeInsets.fromLTRB(10.0, 80.0, 100.0, 10.0),
          border:
              new OutlineInputBorder(borderRadius: BorderRadius.horizontal()),
        ),
      ),
    );

    final dateFieldLebel =  Container(
        margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
        color: Colors.yellow,
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text("Start Date*",
                      ///textDirection: TextDirection.ltr,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontFamily: "Raleway",
                          fontWeight: FontWeight.w700)
                  ),

                ),
                Container(width: 10.0,),
                Expanded(
                  child: Text("End Date*",
                      //textDirection: TextDirection.ltr,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontFamily: "Raleway",
                          fontWeight: FontWeight.w700)
                  ),

                ),
              ],
            )
          ],
        ),
      );
    final dateField = Padding(
            padding:EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
              child:Column(
                 children: <Widget>[
                    Row(
                      children: <Widget>[
                      Expanded(
                      child: DateTimePickerFormField(
                      format: dateFormat,
                      dateOnly:true,
                      decoration: InputDecoration(
                          hintText: "DD-MM-YYYY",
                          hintStyle:TextStyle(
                              color: Colors.black
                          ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(0.0),
                          child: Icon(Icons.calendar_today,
                              color: Colors.black),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      obscureText: false,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                  onChanged: (dt){ date = dt;

                  String  startDate = formatter.format(dt);
                  postDetails["startDate"] = startDate;
                  print("PostDetails");
                  print(postDetails);
                  setState(() {
                    date = dt;
                  }
                );
              },
              validator: (dt) {
                if (dt == null) {
                  return "Required Field";
                }
              },
            ),
          ),
        Container(width: 10.0,),
                      Expanded(
                        child: DateTimePickerFormField(
                            dateOnly: true,
                            format: dateFormat,
                            decoration: InputDecoration(
                              hintText: "DD-MM-YYYY",
                              hintStyle:TextStyle(
                                 color: Colors.black
                               ),
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(0.0),
                                child: Icon(Icons.calendar_today,
                                    color: Colors.black
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            obscureText: false,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            onChanged: (dt) {
                              date = dt;
                              String  endDate = formatter.format(dt);
                              postDetails["endDate"] = endDate;
                              print("PostDetails");
                              print(postDetails);
                              setState(() {
                                date = dt;
                              }
                              );
                            },
          validator: (dt) {
            if (dt == null) {
              return "Required Field";
            }
          }

      ),
      ),
                      ],

                    ),

                 ],
              ),
        );

 var mendotryFields = Container(
   margin: EdgeInsets.fromLTRB(10.0, 50.0, 50.0, 10.0),

     color:Colors.yellow,
    child:Text("* All Fields are mendetory",style: TextStyle(
        color: Colors.black,
        fontSize: 20.0,
        fontFamily: "Raleway",
        fontWeight: FontWeight.w700))
   );
    var _submit = Padding(
      padding: new EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: Container(
        margin: EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 0.0),
        width: 250.0,
        height: 50.0,
        child: RaisedButton(
            color: Colors.blue,
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
           onPressed: () {
              _submitLeave();
         },
        ),
      ),
    );

    return new Scaffold(
      key: scaffoldKey,
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
            dateFieldLebel,
            dateField,
            mendotryFields,
            _isLoading
                ? Center(child: new CircularProgressIndicator())
                : _submit,

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
  void setLeaveDetails(leaveObj) async {
    setState(() => _isLoading = false);
    var id = int.parse(leaveObj.id);
    assert(id is int);
    print(id);
    if(id > 0){
      Navigator.of(context).pushNamed("/welcome");
    }else{
      this.onBatchError("All Ready Applied For Leave!");
    }
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
}
