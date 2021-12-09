import 'package:flutter/material.dart';
import 'package:ecommercee/helper/database.dart';
import 'package:ecommercee/model/productmodel.dart';
import 'package:ecommercee/screens/cart.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key key}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  DatabaseHelper helper =DatabaseHelper();

  List<Product> productsList =
  [
    Product("Shirts","550rs","1","https://media.istockphoto.com/photos/red-tshirt-clothes-picture-id685779142?k=20&m=685779142&s=612x612&w=0&h=bSAsSmDmvnjz1cBxOfTpVrJ2Nj0c5Yz3A8ovqhjdm_Y="),
    Product("Tshirts","1250rs","1","https://assets.ajio.com/medias/sys_master/root/20210403/OjjF/6068dc44aeb269a9e33a52ba/-288Wx360H-462103975-pink-MODEL.jpg"),
    Product("Shoes","1750rs","1","https://m.media-amazon.com/images/I/41Leu3gBUFL.jpg")
  ];

  @override
  Widget build(BuildContext context)
  {
    var width= MediaQuery.of(context).size.width;
    var height= MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Products",style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Cart()));
          }, icon: Icon(Icons.add_shopping_cart_outlined,color: Colors.white,))
        ],
      ),
      body: productsWidget(width,height)

    );
  }

  Widget productsWidget(double width , double height){
    return   Padding(
      padding: const EdgeInsets.all(18.0),
      child: ListView.builder(
          itemCount: productsList.length,
          itemBuilder: (BuildContext context,int index){
            return
              Card(
                elevation: 15,
                child:   Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: width*0.25,
                        child: AspectRatio(
                          aspectRatio: 0.88,
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Color(0xFFF5F6F9),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Image.network(productsList[index].image),
                          ),
                        ),
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productsList[index].title,
                            style: TextStyle(color: Colors.black,
                                fontSize: 18,fontWeight: FontWeight.w600),
                            maxLines: 2,
                          ),
                          SizedBox(height: height*0.02),
                          Text.rich(
                            TextSpan(
                              text: "${productsList[index].price}",
                              style: TextStyle(
                                fontWeight: FontWeight.w800,),
                            ),
                          )
                        ],
                      ),

                      RaisedButton(
                        onPressed: (){
                          helper.insertProduct(productsList[index]);

                        },child: Text("Add to cart",style: TextStyle(
                          color: Colors.white,fontWeight: FontWeight.bold
                      ),),color: Colors.black,)
                    ],
                  ),
                ),
              );
          }
      ),
    );
  }
}
