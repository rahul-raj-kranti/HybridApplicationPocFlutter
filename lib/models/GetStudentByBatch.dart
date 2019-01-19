
class GetStudentByBatch {
  List<String> parsJsonToStudentsList = new List<String>();
  Map studentUserIdAgainstStudentName = new Map();

  List<String> _studentsList;

  GetStudentByBatch(this._studentsList, this._studentUserId);

  Map _studentUserId;

  List<String> get studentsList => _studentsList;


  GetStudentByBatch.map(dynamic obj)  {

    for (var x = 0; x < obj.length; x++) {
      if(parsJsonToStudentsList.length < 6 && studentUserIdAgainstStudentName.length < 6){
      var studentName = obj[x]["firstName"] + " " + obj[x]["lastName"];
      parsJsonToStudentsList.add(studentName);
      var _userId = obj[x]["userId"];
      studentUserIdAgainstStudentName[studentName] = _userId;
     }
    }
    print(parsJsonToStudentsList);
    print(studentUserIdAgainstStudentName);
    this._studentsList = parsJsonToStudentsList;
    this._studentUserId = studentUserIdAgainstStudentName;

    //this._studentsList = ["hello"];
    //this._studentUserId = {"hello": "111"};
  }

  Map get studentUserId => _studentUserId;


  Map<String, dynamic> studentsMap() {
    var map = new Map<String, dynamic>();
    map["studentsList"] = parsJsonToStudentsList.toString();
    map["UserId"] = studentUserIdAgainstStudentName.toString();
    return map;
  }
}
