
class Product {

  int _id;
  String _title;
  String _price;
  String _qty;
  String _image;

  Product(this._title, this._price, this._qty, this._image);


  int get id => _id;

  String get title => _title;

  String get price => _price;

  String get qty => _qty;

  String get image => _image;

  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this._title = newTitle;
    }
  }

  set price(String newDescription) {

      this.price = newDescription;

  }

  set qty(String Qty) {
    this._qty = Qty;
  }


  set image(String newDate) {
    this._image = newDate;
  }

  //  Product object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['price'] = _price;
    map['qty'] = _qty;
    map['image'] = _image;

    return map;
  }

  //  Product object from a Map object
  Product.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._price = map['price'];
    this._qty = map['qty'];
    this._image = map['image'];
  }
}









