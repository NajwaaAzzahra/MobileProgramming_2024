# LAPORAN JOBSHEET 13 RESTFUL API

- **Nama**: Najwa Azzahra
- **Kelas**: TI-3C
- **NIM**: 2241720139

## Praktikum 1: Designing an HTTP client and getting data

1.  Mendaftarlah ke layanan Lab Mock di https://app.wiremock.cloud/. Bisa anda gunakan akun google untuk mendaftar. Jika berhasil bendaftar dan login, akan muncul seperti gambar berikut.

<img src="img/1.1.png"/>

2. Di halaman dahsboard, klik menu Stubs, kemudian klik entri pertama yaitu “GET a JSON 
resource”. Anda akan melihat layar yang mirip dengan berikut

<img src="img/1.2.png"/>

3. Klik “Create new stub”. Di kolom sebelah kanan, lengkapi data berikut. Namanya adalah “Pizza List”, kemudian pilih GET dan isi dengan “/pizzalist”. Kemudian, pada bagian Response, untuk status 200, kemudian pada Body pilih JSON sebagai formatnya dan isi konten JSON dari https://bit.ly/pizzalist. Perhatikan gambar berikut.

<img src="img/1.3.png"/>

4. Tekan tombol SAVE di bagian bawah halaman untuk menyimpan Mock ini. Jika berhasil 
tersimpan, maka Mock API sudah siap digunakan.

<img src="img/1.4.png"/>

5. Buatlah project flutter baru dengan nama pizza_api_nama_anda, tambahkan depedensi 
“http” melalui terminal.

<img src="img/1.5.1.png"/>
<img src="img/1.5.2.png"/>

6. DI folder “lib” project anda, tambahkan file dengan nama “httphelper.dart”.

<img src="img/1.6.png"/>

7. Isi httphelper.dart dengan kode berikut. Ubah “02z2g.mocklab.io” dengan URL Mock API anda.

```dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'pizza.dart';

class HttpHelper {
  final String authority = '42rmy.wiremockapi.cloud';
  final String path = '/pizzalist';

  Future<List<Pizza>> getPizzaList() async {
    // Construct the full URL
    final Uri url = Uri.https(authority, path);
    // Make the GET request
    final http.Response result = await http.get(url);

    // Check the status code
    if (result.statusCode == 200) {
      // Parse the response body
      final jsonResponse = jsonDecode(result.body);
      List<Pizza> pizzas = (jsonResponse as List<dynamic>)
          .map<Pizza>((item) => Pizza.fromJson(item))
          .toList();
      return pizzas;
    } else {
      // Return an empty list if the request fails
      return [];
    }
  }
}

```

8. Di file “main.dart”, di class _ MyHomePageState, tambahkan metode bernama “callPizzas”. Metode ini mengembalikan sebuah Future dari daftar objek Pizza dengan memanggil metode getPizzaList dari kelas HttpHelper, dengan kode sebagai berikut:


```dart
  Future<List<Pizza>> callPizzas() async {
    HttpHelper helper = HttpHelper();
    List<Pizza> pizzas = await helper.getPizzaList();
    return pizzas;
  }
```
9.  Pada metode build di class _MyHomePageState, di dalam body Scaffold, tambahkan FutureBuilder yang membuat ListView dari widget ListTile yang berisi objek Pizza:

```dart
  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: const Color.fromARGB(255, 231, 185, 212),
      title: const Text('Najwa JSON'),
    ),
    body: FutureBuilder<List<Pizza>>(
      future: callPizzas(),
      builder: (BuildContext context, AsyncSnapshot<List<Pizza>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No data available'));
        }
        
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (BuildContext context, int position) {
            return ListTile(
              title: Text(snapshot.data![position].pizzaName),
              subtitle: Text(
                '${snapshot.data![position].description} - € ${snapshot.data![position].price}'
              ),
            );
          },
        );
      },
    ),
  );
}
```

10.  Jalankan aplikasi. Anda akan melihat layar yang mirip dengan berikut ini:

<img src="img/1.10.png"/>


## Praktikum 2: POST-ing data

1.  Masuk ke layanan Lab Mock di https://app.wiremock.cloud/ dan klik bagian Stubs, 
kemudian, buatlah stub baru


2.  Lengkapi isian seperti gambar berikut:

<img src="img/2.2.png"/> 

3. Simpan.

4. Di proyek Flutter, di file httpHelper.dart, di kelas HttpHelper, buat metode baru bernama postPizza, lengkapi kode sebagai berikut

```dart
Future<String> postPizza(Pizza pizza) async {
    const postPath = '/pizza';
    String post = json.encode(pizza.toJson());
    Uri url = Uri.https(authority, postPath);
    http.Response r = await http.post(
      url,
      body: post,
    );
    return r.body;
  }
```

5. Di dalam proyek, buat sebuah file baru bernama pizza_detail.dart.

6. Di bagian atas file baru, tambahkan impor yang diperlukan.

```dart
import 'package:flutter/material.dart';
import 'httphelper.dart';
import 'pizza.dart';
```

7. Buat StatefulWidget bernama PizzaDetailScreen

```dart
class PizzaDetailScreen extends StatefulWidget {
  const PizzaDetailScreen({super.key});

  @override
  State<PizzaDetailScreen> createState() => _PizzaDetailScreenState();
}

class _PizzaDetailScreenState extends State<PizzaDetailScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}
```

8. Di bagian atas kelas _PizzaDetailScreenState, tambahkan lima widget TextEditingController. Widget ini akan berisi data untuk objek Pizza yang akan diposting nanti. Juga, tambahkan sebuah String yang akan berisi hasil dari permintaan POST.

``` dart
  final TextEditingController txtId = TextEditingController();
  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtDescription = TextEditingController();
  final TextEditingController txtPrice = TextEditingController();
  final TextEditingController txtImageUrl = TextEditingController();
  String operationResult = '';
```

9. Override metode dispose() untuk membuang controllers

```dart
@override
  void dispose() {
    txtId.dispose();
    txtName.dispose();
    txtDescription.dispose();
    txtPrice.dispose();
    txtImageUrl.dispose();
    super.dispose();
  }
```

10. Dalam metode build() pada kelas, kita return sebuah Scaffold, yang AppBar-nya berisi Teks yang menyatakan “Detail Pizza” dan Body-nya berisi Padding dan SingleChildScrollView yang berisi Column.

11.  Untuk properti anak dari Column, tambahkan beberapa Text yang akan berisi hasil posting, lima TextFields, masing-masing terikat pada TextEditingController, dan sebuah ElevatedButton untuk menyelesaikan aksi POST (metode postPizza akan dibuat berikutnya). Juga, tambahkan SizedBox untuk memberi jarak pada widget di layar

```dart
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Najwa Pizza Detail'),
        backgroundColor: const Color.fromARGB(255, 231, 185, 212),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                operationResult,
                style: TextStyle(
                  backgroundColor: Colors.green.shade200,
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: txtId,
                decoration: const InputDecoration(hintText: 'Insert ID'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 24),
              TextField(
                controller: txtName,
                decoration:
                    const InputDecoration(hintText: 'Insert Pizza Name'),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: txtDescription,
                decoration:
                    const InputDecoration(hintText: 'Insert Description'),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: txtPrice,
                decoration: const InputDecoration(hintText: 'Insert Price'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 24),
              TextField(
                controller: txtImageUrl,
                decoration: const InputDecoration(hintText: 'Insert Image Url'),
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                child: const Text('Send Post'),
                onPressed: postPizza,
              ),
            ],
          ),
        ),
      ),
    );
  }
```

12. Di bagian bawah kelas _PizzaDetailState, tambahkan metode postPizza.
```dart
Future postPizza() async {
    HttpHelper helper = HttpHelper();
    Pizza pizza = Pizza(
      id: int.tryParse(txtId.text) ?? 0,
      pizzaName: txtName.text,
      description: txtDescription.text,
      price: double.tryParse(txtPrice.text) ?? 0.0,
      imageUrl: txtImageUrl.text,
    );

    String result = await helper.postPizza(pizza);
    setState(() {
      operationResult = result;
    });
  }
```

13. Di file main.dart, impor file pizza_detail.dart.
14. Di perancah metode build() dari kelas _MyHomePageState, tambahkan FloatingActionButton yang akan menavigasi ke rute PizzaDetail.
```dart
floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PizzaDetailScreen()),
          );
        },
      ),
```
15. Jalankan aplikasi. Pada layar utama, tekan FloatingActionButton untuk menavigasi ke rute PizzaDetail
16. Tambahkan detail pizza di kolom teks dan tekan tombol Kirim Postingan. Anda akan 
melihat hasil yang berhasil, seperti yang ditunjukkan pada gambar berikut.
<img src="img/2.16.gif"/> 

## Praktikum 3: PUT-ting data

1.  Masuk ke layanan Lab Mock di https://app.wiremock.cloud/ dan klik bagian Stubs, 
kemudian, buatlah stub baru.

2. Lengkapi isian seperti gambar berikut

<img src="img/3.2.png"/>

3. Simpan

4. Di proyek Flutter, tambahkan metode putPizza ke kelas HttpHelper di file http_helper.dart

```` dart
Future<String> putPizza(Pizza pizza) async {
    const putPath = '/pizza';
    String put = json.encode(pizza.toJson());
    Uri url = Uri.https(authority, putPath);
    http.Response r = await http.put(
      url,
      body: put,
    );
    return r.body;
  }
````

5. Di kelas PizzaDetailScreen di file pizza_detail.dart, tambahkan dua properti, Pizza dan boolean, dan di konstruktor, atur dua properti tersebut


```` dart
const PizzaDetailScreen({
    super.key, 
    required this.pizza,
    required this.isNew});
  final Pizza pizza;
  final bool isNew;
````

6. Di kelas PizzaDetailScreenState, override metode initState. Bila properti isNew dari kelas PizzaDetail tidak baru, properti ini akan menetapkan konten TextFields dengan nilai objek Pizza yang dilewatkan

```` dart
@override
  void initState() {
    if (!widget.isNew) {
      txtId.text = widget.pizza.id.toString();
      txtName.text = widget.pizza.pizzaName;
      txtDescription.text = widget.pizza.description;
      txtPrice.text = widget.pizza.price.toString();
      txtImageUrl.text = widget.pizza.imageUrl;
    }
    super.initState();
  }
````

7. Edit metode savePizza sehingga memanggil metode helper.postPizza ketika properti isNew bernilai benar, dan helper.putPizza ketika bernilai salah

```` dart
  Future savePizza() async {
    HttpHelper helper = HttpHelper();
    Pizza pizza = Pizza(
      id: int.tryParse(txtId.text) ?? 0,
      pizzaName: txtName.text,
      description: txtDescription.text,
      price: double.tryParse(txtPrice.text) ?? 0.0,
      imageUrl: txtImageUrl.text,
    );

    //memanggil postPizza atau putPizza berdasarkan 'isNew'
    final result = await (widget.isNew
        ? helper.postPizza(pizza)
        : helper.putPizza(pizza));

    setState(() {
      operationResult = result;
    });
    
  }
````

8. Di file main.dart, di metode build _MyHomePageState, tambahkan properti onTap ke ListTile sehingga saat pengguna mengetuknya, aplikasi akan mengubah rute dan menampilkan layar PizzaDetail, dengan menampilkan data pizza yang ada saat ini dan menjadikan false untuk parameter isNew

```` dart
 return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int position) {
              final Pizza currentPizza = snapshot.data![position];
              return ListTile(
                title: Text(currentPizza.pizzaName),
                subtitle: Text(
                  '${currentPizza.description} - € ${currentPizza.price.toStringAsFixed(2)}',
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PizzaDetailScreen(
                        pizza: currentPizza,
                        isNew: false, // Editing existing pizza
                      ),
                    ),
                  );
                },
              );
            },
          );
````

9. Di floatingActionButton, passing data Pizza baru dan menjadikan true untuk parameter isNew ke rute PizzaDetail

```` dart
floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PizzaDetailScreen(
                pizza: Pizza(
                  id: 0, // Default values for a new pizza
                  pizzaName: '',
                  description: '',
                  price: 0.0,
                  imageUrl: '',
                ),
                isNew: true,
              ),
            ),
          );
        },
      ),
````

10. Jalankan aplikasi. Pada layar utama, ketuk Pizza mana pun untuk menavigasi ke rute PizzaDetail

11. Edit detail pizza di kolom teks dan tekan tombol Simpan. Anda akan melihat pesan yang menunjukkan bahwa detail pizza telah diperbarui

<img src="img/3.1.gif"/>

## Praktikum 4: DELETE-ing data

1. Masuk ke layanan Wiremock di https://app.wiremock.cloud dan klik pada bagian Stubs pada contoh API. Kemudian, buatlah sebuah stub baru

2. Lengkapi isian, dengan data berikut:
- Name: Delete Pizza
- Verb: DELETE
- Address: /pizza
- Status: 200
- Body Type: json
- Body: {"message": "Pizza was deleted"}

<img src="img/4.2.png"/>

3. Save the new stub

4. Di proyek Flutter, tambahkan metode deletePizza ke kelas HttpHelper di file http_helper.dart

```` dart
Future<String> deletePizza(int id) async {
    const deletePath = '/pizza';
    Uri url = Uri.https(authority, deletePath);
    http.Response r = await http.delete(
      url,
    );
    return r.body;
  }
````

5.  Pada file main.dart, di metode build kelas _MyHomePageState, refaktor itemBuilder dari ListView.builder agar ListTile terdapat dalam widget Dismissible, seperti berikut

```` dart
          return ListView.builder(
            itemCount: (snapshot.data == null) ? 0 : snapshot.data!.length,
            itemBuilder: (BuildContext context, int position) {
              return Dismissible(
                key: Key(snapshot.data![position].id.toString()),
                onDismissed: (direction) {
                  setState(() {
                    HttpHelper helper = HttpHelper();
                    // Save the deleted pizza details before removing it
                    Pizza deletedPizza = snapshot.data![position];

                    // Call delete API
                    helper.deletePizza(deletedPizza.id);

                    // Remove the pizza from the list
                    snapshot.data!.removeAt(position);

                    // Log the deletion in the console
                    print(
                        "Deleted Pizza: ${deletedPizza.pizzaName} (ID: ${deletedPizza.id})");
                  });
                },
                child: ListTile(
                  title: Text(snapshot.data![position].pizzaName),
                  subtitle: Text(
                    '${snapshot.data![position].description} - € ${snapshot.data![position].price.toStringAsFixed(2)}',
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PizzaDetailScreen(
                          pizza: snapshot.data![position],
                          isNew: false,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
````

6. Jalankan aplikasi. Saat Anda menggeser elemen apa pun dari daftar pizza, ListTile akan menghilang

<img src="img/4.png"/>

<img src="img/4.gif"/>