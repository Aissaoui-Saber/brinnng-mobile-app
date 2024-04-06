import 'dart:convert';
import 'dart:io';
//import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'product_info.dart';
import 'product.dart';
//import 'package:http/http.dart' as http;
//import 'package:path_provider/path_provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String Creator = "";
  List<Widget> _productsWidgets = [];
  //Dio dio = new Dio();

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }


  Widget getProductImagesRow(Product product) {
    List<Widget> images = [];

    for (int i=0;i<product.images.length;i++){
      images.add(
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(child: Image.network("http://153.92.222.43/products/"+product.ID+"/images/"+product.images[i],width: 250,height: 250,fit: BoxFit.cover),
            onTap: () async {
              //await downloadFile("http://153.92.222.43/products/"+product.ID+"/images/"+product.images[i].toString(), product.images[i].toString());
            },
          ),
        )
      );
    }
    return Row(
      children: images,
    );
  }

  Widget productListItem(Product p) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent)),
        child: Column(
          children: [
            Center(
              child: SingleChildScrollView(
                // This next line does the trick.
                scrollDirection: Axis.horizontal,
                child: getProductImagesRow(p),
              ),
            ),
            Row(
              children: [
                Text(
                  "ID: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(p.ID),
              ],
            ),
            Row(
              children: [
                Text(
                  "CODE BAR: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(p.barcode),
              ],
            ),
            Row(
              children: [
                Text(
                  "UNITE DE MESURE: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(p.measuringUnit),
              ],
            ),
            Row(
              children: [
                Text(
                  "QUANTITE: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(p.quantity.toString()),
              ],
            ),
            Row(
              children: [
                Text(
                  "NATURE: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(p.nature),
              ],
            ),
            Row(
              children: [
                Text(
                  "MARQUE: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(p.brand),
              ],
            ),
            Row(
              children: [
                Text(
                  "TYPE OU MODEL: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(p.type),
              ],
            ),
            Row(
              children: [
                Text(
                  "UNITE DE VENTE: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(p.vendingUnit),
              ],
            ),
            Row(
              children: [
                Text(
                  "GOUT: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(p.taste),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Crée le "+p.creationDate+" a "+p.creationTime+" par "+p.creator,style: TextStyle(fontSize: 12),),
                Text(p.treated == "false" ? "non traité":"traité",style: TextStyle(color: p.treated == "false" ? Colors.redAccent : Colors.blueAccent),)
              ],)
          ],
        ),
      ),
    );
  }

  /*Future<List<Product>> getProducts() async {
    String url = 'http://153.92.222.43/products';
    http.Response result = await http.get(Uri.parse(url));
    List data = jsonDecode(result.body);
    List<Product> p = [];
    //print(data[1]['creation_date'].runtimeType);
    for (int i = 0; i < data.length; i++) {
      p.add(Product(
          ID: data[i]['id'].toString(),
          language_data_id: data[i]['language_data_id'].toInt(),
          barcode: data[i]['barcode'].toString(),
          measuringUnit: data[i]['measuring_unit'].toString(),
          quantity: data[i]['quantity'].toDouble(),
          creationDate: data[i]['creation_date'].toString() == "null" ? data[i]['creation_date'].toString() : data[i]['creation_date'].toString().substring(0,10),
          creationTime: data[i]['creation_time'].toString(),
          treated: data[i]['treated'].toString(),
          creator: data[i]['creator'].toString(),
          packOf: data[i]['pack_of'].toString(),
          nature: data[i]['nature'].toString(),
          type: data[i]['type'].toString(),
          brand: data[i]['brand'].toString(),
          vendingUnit: data[i]['vending_unit'].toString(),
          taste: data[i]['taste'].toString(),
          language: data[i]['language'].toString(),
          images: data[i]['images']
      ));
    }
    return p;
  }*/

  /*Future<void> getProductsWidgets() async {
    List<Product> l = await getProducts();
    for (int i = 0; i < l.length; i++) {
      _productsWidgets.add(productListItem(l[i]));
    }
    setState(() {});

  }*/

  @override
  initState() {
    super.initState();
    getText();
    //getProductsWidgets();
  }

  Future<void> getText() async {
    SharedPreferences sharedPref;
    sharedPref = await SharedPreferences.getInstance();
    Creator = sharedPref.getString("creator").toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children:[
            Text("bonjour, " + Creator),
              SingleChildScrollView(
                  child: Column(
                    children: _productsWidgets,
                  ),
              ),
            ]
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          //Navigator.push(
              //context, MaterialPageRoute(builder: (context) => ProductInfo()))
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
