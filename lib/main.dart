import 'dart:io';

import 'package:animation/projects_database.dart';
import 'package:animation/screens/projects_screen.dart';
import 'package:animation/sketch_data_base.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_archive/flutter_archive.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
late Box box;
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final document = await getApplicationDocumentsDirectory();
  var path = document.path;
  Hive
    ..init(path);
  Hive.registerAdapter(SketchDatabaseAdapter());
  Hive.registerAdapter(ProjectsDatabaseAdapter());
  box= await Hive.openBox("SketchDatabase");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:
      //ProjectsScreen()
      const MyHomePage(title: 'Flutter Demo Home Page'),
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
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    _downloadFile("https://github.com/AhmadRaza7861/animation/raw/main/gif_cat.rar","animation");
  }

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
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  Future<File> _downloadFile(String url, String filename) async {
    var status = await Permission.storage.request();
    var client = http.Client();
    var request = await client.get(Uri.parse(url));
   // var response = await request;
    //var bytes = await consolidateHttpClientResponseBytes(response);
    var bytes = await request.bodyBytes;
    print("Bites ${bytes}");
    String dir = (await getApplicationDocumentsDirectory()).path;
    Directory dirr=Directory("$dir/Sketch/SketchGifs");
    dirr.create(recursive: true);
    File file = File('$dir/Sketch/SketchGifs/$filename.zip');
    print("file ${file.path}");
    // Directory newDirectory = Directory('${file.path}');
    // newDirectory.createSync(recursive: true);
    await file.writeAsBytes(bytes);
    try {
      await ZipFile.extractToDirectory(zipFile: file, destinationDir: Directory('$dir/Sketch/SketchGifs'));
      file.delete(recursive: true);
    } catch (e) {
      print(e);
    }
    return file;
  }
  // Future<File?> _downloadFile(String url, String filename) async {
  //   try {
  //     // Request storage permission
  //     var status = await Permission.storage.request();
  //
  //     if (status.isGranted) {
  //       var client = http.Client();
  //       var request = await client.get(Uri.parse(url));
  //       var bytes = request.bodyBytes;
  //
  //       // Get the application documents directory
  //       Directory appDocDir = await getApplicationDocumentsDirectory();
  //       String appDocPath = appDocDir.path;
  //
  //       // Create directories if they don't exist
  //       Directory saveDir = Directory('$appDocPath/Sketch/SketchGifs');
  //       if (!saveDir.existsSync()) {
  //         saveDir.createSync(recursive: true);
  //       }
  //       print("jkjhjhj");
  //       // Create the file path
  //       String filePath = '$appDocPath/Sketch/SketchGifs/$filename';
  //
  //       // Write the file
  //       File file = File(filePath);
  //       await file.writeAsBytes(bytes);
  //
  //       print("File downloaded: ${file.path}");
  //       return file;
  //     } else {
  //       // Handle denied or restricted permissions
  //       print("Permission denied for storage");
  //       return null;
  //     }
  //   } catch (e) {
  //     // Handle other errors that might occur during the download process
  //     print("Error downloading file: $e");
  //     return null;
  //   }
  // }
}
