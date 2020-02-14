import 'package:emp_crud/model/person.dart';
import 'package:emp_crud/view/row.dart';
import 'package:flutter/material.dart';

class MyList extends StatefulWidget {
  final Future<List<Person>> employees;

  MyList(this.employees);

  @override
  State<StatefulWidget> createState() {
    return _MyListState();
  }
}

class _MyListState extends State<MyList> {
  TextStyle getTextStyle() {
    return new TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0);
  }

  Text getRowText(value) {
    return new Text(value, style: getTextStyle());
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      
        padding: new EdgeInsets.all(16.0),
        child: new FutureBuilder(
            future: widget.employees,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return new ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data == null ? 0 : snapshot.data.length,   
                                 
                  itemBuilder: (context, index) {
                    if(index ==0){
                      return  Text("    Name     Age       Height        Mobile");
                    }
                    index -=1;
                    //var row = data[index];
                    return new Padding(
                        padding: new EdgeInsets.all(8.0),
                        child: ListRow(
                            snapshot.data[index].name,
                            snapshot.data[index].age,
                            snapshot.data[index].mobileNo,
                            snapshot.data[index].height,
                            ),
                          );
                  },
                  shrinkWrap: true,
                );
              } else if (null == snapshot.data || snapshot.data.length == 0) {
                return new Text("No Records Found");
              }
              return new Container(
                alignment: AlignmentDirectional.center,
                child: new CircularProgressIndicator(),
              );
            }
          ),
        );
  }
}