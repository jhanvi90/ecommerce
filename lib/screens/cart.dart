import 'package:flutter/material.dart';
import 'package:ecommercee/helper/database.dart';
import 'package:ecommercee/model/productmodel.dart';

class Cart extends StatefulWidget {
  const Cart({Key key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart>
{
  DatabaseHelper helper =DatabaseHelper();
  List<Product> cartList;

  fetchCartProducts(){
    Future<List<Product>> ProductListFuture = helper.getProductList();
    ProductListFuture.then((ProductList) {
      setState(() {
        this.cartList=ProductList;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCartProducts();
  }

  @override
  Widget build(BuildContext context)
  {

    var width= MediaQuery.of(context).size.width;
    var height= MediaQuery.of(context).size.height;

    return Scaffold(
     appBar: AppBar(
       leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
         onPressed: (){
         Navigator.pop(context);
       },),
          backgroundColor: Colors.black,
          title: Text("My Cart",style: TextStyle(color: Colors.white),),
        ),
      body: cartList.length==0?
            Center(child: Text("No product found !!")):
            cartWidget(width, height));
  }

  Widget cartWidget(double width , double height){
    return   Padding(
      padding: const EdgeInsets.all(18.0),
      child: ListView.builder(
          itemCount: cartList.length,
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
                            child: Image.network(cartList[index].image),
                          ),
                        ),
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cartList[index].title,
                            style: TextStyle(color: Colors.black,
                                fontSize: 18,fontWeight: FontWeight.w600),
                            maxLines: 2,
                          ),
                          SizedBox(height: height*0.02),
                          Text.rich(
                            TextSpan(
                              text: "${cartList[index].price}",
                              style: TextStyle(
                                fontWeight: FontWeight.w800,),
                            ),
                          )
                        ],
                      ),

                      RaisedButton(
                        onPressed: (){

                        },child: Text("Qty : ${cartList[index].qty}",style: TextStyle(
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
