import 'package:drop_image_app/model/dropped_file.dart';
import 'package:drop_image_app/widget/dropped_file_widget.dart';
import 'package:drop_image_app/widget/dropzone_widget.dart';
import 'package:flutter/material.dart';

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
  DroppedFile? file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DroppedFileWidget(file: file),
            const SizedBox(height: 16),
            Container(
              height: 300,
              child: DropzoneWidget(
                onDroppedFile: (file) => setState(() => this.file = file),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
