class Product {
  String ID;
  int language_data_id;
  String barcode;
  String measuringUnit;
  double quantity;
  String creationDate;
  String creationTime;
  String treated;
  String creator;
  String packOf;
  String nature;
  String type;
  String brand;
  String vendingUnit;
  String taste;
  String language;
  List<dynamic> images;

  Product({required this.ID, required this.language_data_id, required this.barcode, required this.measuringUnit,
    required this.quantity, required this.creationDate, required this.creationTime, required this.treated,
    required this.creator,required this.packOf,required this.nature,required this.type,required this.brand,required this.vendingUnit,
    required this.taste,required this.language,required this.images});

  //get getClasse => this.classe;

  //get fullName => this.firstName + " " + this.lastName;
}