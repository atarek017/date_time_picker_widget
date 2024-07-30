import 'package:date_time_picker_widget/date_time_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const MyHomePage(title: 'Date Time Picker Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String _d1 = '';


  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _newDatetimePicker(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _newDatetimePicker() {
    final dt = DateTime.now();
    final dtMin = DateTime.now().add(const Duration(hours: 1, minutes: 0));
    final dtMax = dtMin.add(const Duration(
      days: 4,
    ));
    debugPrint('dt: ${dt.toString()}');
    debugPrint('dtMin: ${dtMin.toString()}');
    debugPrint('dtMax: ${dtMax.toString()}');

    return Container(
        child: DateTimePicker(
      initialSelectedDate: DateTime.now(),
      startDate: dtMin.subtract(const Duration(days: 1)),
      endDate: dtMax,
      startTime: dt,
      endTime: dtMax,
      timeInterval: const Duration(minutes: 15),
      datePickerTitle: 'Pick your preferred date',
      timePickerTitle: 'Pick your preferred time',
      timeOutOfRangeError: 'Sorry shop is closed now',
      is24h: false,
      numberOfWeeksToDisplay: 1,
      locale: 'en',
      type: DateTimePickerType.Date,
      onDateChanged: (date) {
        setState(() {
          _d1 = DateFormat('dd MMM, yyyy').format(date);
        });
      },
    ));
  }
}
