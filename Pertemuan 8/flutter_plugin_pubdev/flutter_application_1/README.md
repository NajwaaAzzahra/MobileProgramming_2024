# Laporan Jobsheet 7 Manajemen Plugin

### Najwa Azzahra
### TI-3C/19
### 2241720139

#### Praktikum Menerapkan Plugin di Project Flutter

red_text_widget.dart

```dart
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class RedTextWidget extends StatelessWidget {
  final String text;
const RedTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: const TextStyle(color: Colors.red, fontSize: 14),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
);
  }
}
```

main.dart

```dart
import 'package:flutter/material.dart';
import 'package:flutter_application_1/red_text_widget.dart';

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
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              color: Colors.yellowAccent,
              width: 50,
              child: const RedTextWidget(
                text: 'You have pushed the button this many times:',
              ),
            ),
            Container(
              color: Colors.greenAccent,
              width: 100,
              child: const Text(
                'You have pushed the button this many times:',
              ),
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
}
```

2. Jelaskan maksud dari langkah 2 pada praktikum tersebut!

Langkah ini bertujuan untuk menambahkan plugin auto_size_text ke dalam proyek Flutter. Plugin ini digunakan untuk menyesuaikan ukuran teks secara otomatis agar sesuai dengan ruang yang tersedia pada layar, tanpa perlu memotong teks atau mengatur ukuran teks secara manual. Dengan menjalankan perintah flutter pub add auto_size_text di terminal, Flutter akan menambahkan plugin tersebut ke dalam daftar dependencies di file pubspec.yaml

3. Jelaskan maksud dari langkah 5 pada praktikum tersebut!

Langkah ini bertujuan untuk membuat variabel text dan mendefinisikan parameter pada constructor di dalam sebuah widget khusus, yaitu RedTextWidget. Variabel text bertipe String akan menyimpan data teks yang akan ditampilkan oleh widget.

Pada constructor RedTextWidget, ditambahkan parameter required this.text, yang menandakan bahwa saat widget ini digunakan, nilai text harus diberikan. Hal ini memastikan bahwa teks yang akan ditampilkan oleh widget RedTextWidget selalu ada saat widget tersebut dibuat. Selain itu, penggunaan super(key: key) memungkinkan pengelolaan kunci (key) untuk identifikasi widget dalam hirarki widget pada Flutter, yang penting untuk optimasi dan efisiensi dalam proses rebuild.

4. Pada langkah 6 terdapat dua widget yang ditambahkan, jelaskan fungsi dan perbedaannya!

- Fungsi
Container Pertama (RedTextWidget): Menampilkan teks dari custom widget RedTextWidget dengan latar belakang kuning dan lebar 50 piksel.
Container Kedua (Text): Menampilkan teks menggunakan widget Text bawaan Flutter dengan latar belakang hijau dan lebar 100 piksel.

**Perbedaan**

- Jenis Widget:

Pertama: custom widget (RedTextWidget) yang dapat dikustomisasi.
Kedua: widget bawaan (Text) yang lebih sederhana.

- Kustomisasi:

Pertama: Menyediakan pengaturan tambahan untuk gaya dan tampilan.
Kedua: Langsung menampilkan teks tanpa opsi tambahan.

- Lebar:

Pertama: Lebar 50 piksel.
Kedua: Lebar 100 piksel.

5. Jelaskan maksud dari tiap parameter yang ada di dalam plugin auto_size_text berdasarkan tautan pada dokumentasi ini !

Berikut adalah penjelasan mengenai parameter yang ada dalam plugin auto_size_text:

1. key: Kunci untuk menggantikan widget lain dalam pohon widget.
2. textKey: Kunci untuk widget Text yang dihasilkan.
3. style: Gaya teks yang digunakan.
4. minFontSize: Ukuran font minimum saat penyesuaian ukuran teks, diabaikan jika presetFontSizes diatur.
5. maxFontSize: Ukuran font maksimum untuk penyesuaian ukuran teks, diabaikan jika presetFontSizes diatur.
6. stepGranularity: Langkah pengurangan ukuran font saat menyesuaikan ukuran.
7. presetFontSizes: Daftar ukuran font yang diperbolehkan, harus dalam urutan menurun.
8. group: Mengelompokkan beberapa AutoSizeText agar memiliki ukuran yang sama.
9. textAlign: Pengaturan perataan teks secara horizontal.
10. textDirection: Arah teks yang menentukan interpretasi nilai perataan.
11. locale: Memilih font yang tepat berdasarkan karakter Unicode.
12. softWrap: Menentukan apakah teks dapat dipotong pada pemisah baris.
13. wrapWords: Menentukan apakah kata yang tidak muat akan dibungkus.
14. overflow: Menentukan bagaimana menangani overflow visual.
15. overflowReplacement: Widget yang ditampilkan jika teks tidak muat.
16. textScaleFactor: Faktor skala font untuk mempengaruhi ukuran font.
17. maxLines: Jumlah maksimum baris untuk teks.
18. semanticsLabel: Label alternatif untuk aksesibilitas.
