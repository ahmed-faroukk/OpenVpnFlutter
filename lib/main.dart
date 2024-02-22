import 'package:flutter/material.dart';
import 'package:openvpn_flutter/openvpn_flutter.dart';

import 'openVpn/OpenVpn.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final OpenVpnService vpnService = OpenVpnService();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
         
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(vpnService.vpnStage?.toString() ?? VPNStage.disconnected.toString()),
            Text(vpnService.vpnStatus?.toJson().toString() ?? ""),
            TextButton(
              child: const Text("Start"),
              onPressed: () {
                vpnService.connectToVpn("","","");
              },
            ),
            TextButton(
              child: const Text("STOP"),
              onPressed: () {
                vpnService.disconnectFromVpn();
              },
            ),

          ],
        ),
      ),
     // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
