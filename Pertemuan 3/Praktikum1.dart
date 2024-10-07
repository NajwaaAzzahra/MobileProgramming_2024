//Langkah 1
// void main() {
//   var list = [1, 2, 3];
//   assert(list.length == 3);
//   assert(list[1] == 2);
//   print(list.length);
//   print(list[1]);

//   list[1] = 1;
//   assert(list[1] == 1);
//   print(list[1]);
// }

//Ubah kode pada langkah 1 menjadi variabel final yang mempunyai index = 5 dengan default value = null. Isilah nama dan NIM Anda pada elemen index ke-1 dan ke-2. Lalu print dan capture hasilnya.

//Langkah 3

void main() {
  final List<String?> list = List.filled(5, null);

  list[1] = "Najwa Azzahra";
  list[2] = "2241720139";

  assert(list.length == 5);
  assert(list[1] == "Najwa Azzahra");
  assert(list[2] == "2241720139");

  print(list.length);
  print(list[1]);
  print(list[2]);
}


