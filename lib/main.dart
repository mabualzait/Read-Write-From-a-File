import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(new MaterialApp(
    title: 'IO File System',
    home: new Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _enterDataField = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("IO - Read Write"),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: new Container(
        padding: const EdgeInsets.all(13.5),
        alignment: Alignment.topCenter,
        child: new ListTile(
          title: new TextField(
            controller: _enterDataField,
            decoration: new InputDecoration(labelText: "Write Something"),
          ),
          subtitle: new FlatButton(
            onPressed:(){
              //if statement
              writeData(_enterDataField.text);
            },
            child: new Column(
              children: <Widget>[
                new Text('Save Data'),
                new Padding(padding: new EdgeInsets.all(15.0),),
               new FutureBuilder(
                 future: readData(),
                 builder: (BuildContext context, AsyncSnapshot<String> data){
                   if(data.hasData != null){
                     return new Text(data.data.toString(),
                     style: new TextStyle(
                       color: Colors.red
                     ),);
                   }else{
                     return new Text("There is not saved data");
                   }
                 },
               )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path; //home/directory/document
}

Future<File> get _localFile async {
  final path = await _localPath;
  return new File('$path/data.txt');
}

Future<File> writeData(String message) async {
  final file = await _localFile;
  return file.writeAsString(message);
}

Future<String> readData() async {
  try {
    final file = await _localFile;
    //read from the file
    String data = await file.readAsString();
    return data;
  } catch (e) {
    return "Nothing saved in the file!";
  }
}
