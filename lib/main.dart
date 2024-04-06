import 'package:flutter/material.dart';
import 'home.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  runApp(const MyApp());
}

Future<void> addCreator(String c) async {
  SharedPreferences sharedPref;
  sharedPref = await SharedPreferences.getInstance();
  sharedPref.setString("creator", c);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: startPage(),
    );
  }
}

class startPage extends StatefulWidget {
  const startPage({Key? key}) : super(key: key);

  @override
  State<startPage> createState() => _startPageState();
}

class _startPageState extends State<startPage> {
  final textEditControler = TextEditingController();

  @override
  void initState() {
    loadNewLaunch();
    super.initState();
  }

  void loadNewLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("creator")) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), labelText: 'Votre prénom'),
                controller: textEditControler,
              ),
              ElevatedButton(onPressed: () async=> {
                addCreator(textEditControler.text),
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Home()))
              }, child: Text("Suivant"))
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
