import 'package:emp_crud/db/dbhelper.dart';
import 'package:emp_crud/model/person.dart';
import 'package:emp_crud/view/form.dart';
import 'package:emp_crud/view/list.dart';
import 'package:flutter/material.dart';

class DBTestPage extends StatefulWidget {
  final String title;

  DBTestPage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DBTestPageState();
  }
}

class _DBTestPageState extends State<DBTestPage> {
  var dbHelper = DBHelper();
  Future<List<Person>> employees;
  refreshList() {
    setState(() {
      employees = dbHelper.getEmployees();
    });
  }

  void saveToDB(name, age, mobileNo, height) {
    var employee = Person(name, age, mobileNo, height);
    dbHelper.saveEmployee(employee);
    refreshList();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
        appBar: new AppBar(
          title: new Text('CRUD'),
        ),
        body: new Container(
            child:ListView(
              children: <Widget>[ new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                verticalDirection: VerticalDirection.down,
                children: <Widget>[
              MyForm(saveToDB),
              SizedBox(
                height: 5,
              ),
              MyList(employees),
            ],
          ),
         ],
        ),
      ),
    );
  }
}