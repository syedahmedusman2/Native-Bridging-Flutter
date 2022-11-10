import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // variable for showing battery level in UI
  int? _batteryLevel;
  Future<void> _getBatteryLevel() async {
    //Method channel that will be use for communicating with native code
    //Method channel identifier should be like an url
    //Method channel identifior should be unique in app and should not mathch to other Method Channel identifier in the app
    const platform = MethodChannel('com.flutter.dev/battery');
    try {
      //Invoke method are use to send message to the method channel which already established a communication with native side
      final batteryLevel = await platform.invokeMethod('batteryLevel');
      setState(() {
        _batteryLevel = batteryLevel;
      });
    } on PlatformException catch (e) {
      setState(() {
        _batteryLevel = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(_batteryLevel != null
            ? "Battery Level: " + _batteryLevel.toString()
            : "Battery Level: ...."),
      ),
    );
  }
}
