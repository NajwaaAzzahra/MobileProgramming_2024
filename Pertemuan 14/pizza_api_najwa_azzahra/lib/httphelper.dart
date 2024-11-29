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
  
  Future<String> deletePizza(int id) async {
    const deletePath = '/pizza';
    Uri url = Uri.https(authority, deletePath);
    http.Response r = await http.delete(
      url,
    );
    return r.body;
  }
}
