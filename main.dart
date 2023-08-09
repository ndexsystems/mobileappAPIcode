import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Connection',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ApiConnectionDemo(),
    );
  }
}

class ApiConnectionDemo extends StatefulWidget {
  const ApiConnectionDemo({Key? key}) : super(key: key);

  @override
  ApiConnectionDemoState createState() => ApiConnectionDemoState();
}

class ApiConnectionDemoState extends State<ApiConnectionDemo> {
  Map<String, dynamic>? data;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  _fetchData() async {
    final params = {
      'grant_type': 'client_credentials',
      'firmName': 'firm name found in ndex URL',
      'client_id': 'userid',
      'client_secret': 'password',
      'product_type': 'fullservice',
      'portfolioId': 'portfolio id'
    };

    const authToken = 'auth token';
    final headers = {
      'Authorization': 'Bearer $authToken',
    };

    final url = Uri.https(
      'm.ndexsystems.com:8443',
      '/fengine_api/v1/assetAllocationBreakdown',
      params,
    );

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body);
      });
    } else {
      print("Error fetching data: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Connection'),
      ),
      body: Center(
        child: data == null
            ? const CircularProgressIndicator()
            : Text("Data retrieved: ${data.toString()}"),
      ),
    );
  }
}
