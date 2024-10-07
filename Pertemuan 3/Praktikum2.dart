//Langkah 1
void main() {
  var halogens = {'fluorine', 'chlorine', 'bromine', 'iodine', 'astatine'};
  print(halogens);

  var names1 = <String>{};
  Set<String> names2 = {}; // This works, too.
  var names3 = {}; // Creates a map, not a set.

  print(names1);
  print(names2);
  print(names3);

  // Adding elements to names1 and names2
  names1.add('Najwa Azzahra');
  names1.add('2241720139');
  
  names2.add('Najwa Azzahra');
  names2.addAll({'2241720139'});
}
