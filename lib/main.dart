import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:br/pessoa.dart';
import 'package:br/pessoa_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application name
      title: 'Flutter Stateful Clicker Counter',
      theme: ThemeData(
        // Application theme data, you can set the colors for the application as
        // you want
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Clicker Counter Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PessoaCtrl pController = PessoaCtrl();
  List<Pessoa> people = [];
  TextEditingController txtNome = TextEditingController();

  List<Map<String, dynamic>> pessoas = [];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
        // Column is also a layout widget. It takes a list of children and
        // arranges them vertically. By default, it sizes itself to fit its
        // children horizontally, and tries to be as tall as its parent.
        //
        // Column has various properties to control how it sizes itself and
        // how it positions its children. Here we use mainAxisAlignment to
        // center the children vertically; the main axis here is the vertical
        // axis because Columns are vertical (the cross axis would be
        // horizontal).
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                          color: Colors.amber, style: BorderStyle.solid)),
                  hintText: 'Nome'),
              controller: txtNome,
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          ElevatedButton(
            onPressed: () => {
              pessoas.add(Pessoa.toMap(Pessoa(
                nome: txtNome.text,
              ))),
              pController.add(
                  'user', json.encode(pessoas)), //adicionando no SharedPref
              people.add(Pessoa(
                nome: txtNome.text,
              ))
            },
            child: Icon(Icons.send),
            // onPressed: () async {
            //   Fluttertoast.showToast(
            //       msg: (await pController.read('user'))[0]['nome'],
            //       toastLength: Toast.LENGTH_LONG,
            //       gravity: ToastGravity.BOTTOM,
            //       timeInSecForIosWeb: 1,
            //       backgroundColor: Colors.green,
            //       textColor: Colors.white,
            //       fontSize: 16.0);
            // },
            // child: Text('Read data')
          ),
          ListView.separated(
              padding: const EdgeInsets.all(8),
              itemBuilder: (BuildContext context, int index) {
                return Card(
                    child: ListTile(
                  title: const Text('Pessoa'),
                  subtitle: Text('Nome: ' + people[index].nome),
                ));
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemCount: people.length)
        ], // This trailing comma makes auto-formatting nicer for build methods.
      )),
    );
  }
}
