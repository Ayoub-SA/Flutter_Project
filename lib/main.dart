
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.grey[200],
        ),
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.grey[800],
        ),
      ),
      themeMode: _themeMode,
      home: HomeScreen(toggleTheme: _toggleTheme, themeMode: _themeMode),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  final ThemeMode themeMode;

  HomeScreen({required this.toggleTheme, required this.themeMode});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSwitchOn = false;  
  String _userInput = '';  
  List<String> _inputList = []; 

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ayoub_Salama'),
        actions: [
          IconButton(
            icon: Icon(widget.themeMode == ThemeMode.light ? Icons.dark_mode : Icons.light_mode),
            onPressed: widget.toggleTheme,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, 
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Enter something',
              ),
              obscureText: _isSwitchOn, 
              onChanged: (value) {
                setState(() {
                  _userInput = value;    
                });
              },
              controller: TextEditingController(text: _userInput),
            ),
            SizedBox(height: 20),
            SwitchListTile(
              title: Row(
                children: [
                  Icon(
                    _isSwitchOn ? Icons.check_circle : Icons.cancel,
                    color: _isSwitchOn ? Colors.green : Colors.red,
                  ),
                  SizedBox(width: 10),
                  Text(_isSwitchOn ? 'Switch is ON' : 'Switch is OFF'),
                ],
              ),
              value: _isSwitchOn,
              onChanged: (value) {
                setState(() {
                  _isSwitchOn = value;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(_isSwitchOn ? 'Switch turned ON!' : 'Switch turned OFF!'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                });
              },
              activeColor: Colors.green,
              inactiveThumbColor: Colors.red,
              inactiveTrackColor: Colors.grey,
            ),
            SizedBox(height: 20),
    
            Text('User Input: $_userInput'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (_userInput.isNotEmpty) {
                    _inputList.add(_userInput);
                    _userInput = '';
                  }
                });
              },
              child: Text('Add to List'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondScreen(inputList: _inputList)),
                );
              },
              child: Text('Go to Next Screen'),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  final List<String> inputList;

  SecondScreen({required this.inputList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
      body: ListView.builder(
        itemCount: inputList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(inputList[index]),
          );
        },
      ),
    );
  }
}
