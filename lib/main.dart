import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.red.shade300,
          titleSpacing: 2,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      home: const MyHomePage(title: 'Quy đổi USD -> VND'),
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
  // rate between VND and USD
  final int _rate = 23000;
  final _USDController = TextEditingController();
  final _VNDController = TextEditingController();
  final _VNDFormatter = NumberFormat.currency(locale: 'vi_vn');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Tỉ giá USD / VND: $_rate',
              ),
              _myTextField(
                controller: _USDController,
                label: 'USD',
                onChanged: (text) {
                  int val = int.tryParse(text) ?? 0;
                  _VNDController.text = _VNDFormatter.format(val * _rate);
                  setState(() {});
                },
              ),
              _myTextField(controller: _VNDController, enabled: false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _myTextField({
    String? label,
    required TextEditingController controller,
    void Function(String)? onChanged,
    bool enabled = true,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
          hintText: '0',
        ),
        controller: controller,
        onChanged: onChanged,
        enabled: enabled,
      ),
    );
  }
}
