import 'package:flutter/material.dart';
import 'package:fuzzy_time/fuzzy_time.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TimeOfDay? _date;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Autocomplete<TimeOfDay>(
              displayStringForOption: (value) {
                final hour = value.hour.toString().padLeft(2, '0');
                final minute = value.minute.toString().padLeft(2, '0');
                return '$hour:$minute';
              },
              optionsBuilder: (value) {
                final time = fuzzyTimeParse(value.text);
                return time == null ? [] : [time];
              },
              onSelected: (value) => setState(
                () {
                  _date = value;
                },
              ),
            ),
            Text(
              'current time: $_date',
            ),
          ],
        ),
      ),
    );
  }
}
