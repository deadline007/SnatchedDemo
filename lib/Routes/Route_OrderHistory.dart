import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteOrderHistory extends StatefulWidget {
  @override
  _RouteOrderHistoryState createState() => _RouteOrderHistoryState();
}

class _RouteOrderHistoryState extends State<RouteOrderHistory> {
  int counter = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFFAFAFA),
          elevation: 0,
          title: Center(
            child: Text(
              "Item Carts",
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          brightness: Brightness.light,
          actions: <Widget>[
            Icon(
              Icons.business_center,
              color: Color(0xFF3a3737),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    "Your Food Cart",
                    style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF3a3a3b),
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
//                CartItem(
//                    productName: "Cola",
//                    productPrice: "Rs. 6.00",
//                    productCartQuantity: "2"),
//                SizedBox(
//                  height: 10,
//                ),
//                CartItem(
//                    productName: "Burger",
//                    productPrice: "Rs. 5.08",
//                    productCartQuantity: "5"),
//                SizedBox(
//                  height: 10,
//                ),
//               // PromoCodeWidget(),
                SizedBox(
                  height: 10,
                ),
                TotalCalculationWidget(),
                Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                      height: 30.0,
                      width: 125.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Color.fromRGBO(255, 2, 102, 100),
                        color: Color.fromRGBO(255, 2, 102, 100),
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: () {
                            _paymentOptionSheet(context);
                          },
                          child: Center(
                            child: Text(
                              'CONFIRM',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                        ),
                      )),
                )
              ],
            ),
          ),
        ));
  }
}

void _paymentOptionSheet(context) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: new Wrap(
            children: <Widget>[
              new ListTile(
                  title: new Text(
                    'Payment Option',
                    style: TextStyle(color: Color.fromRGBO(255, 2, 102, 100)),
                  ),
                  onTap: () => {}),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15, 0, 8, 0),
                child: new ListTile(
                    title: new Text(
                      'Paytm',
                      style: TextStyle(color: Color.fromRGBO(255, 2, 102, 100)),
                    ),
                    onTap: () => {}),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15, 0, 8, 0),
                child: new ListTile(
                  title: new Text(
                    'Google Pay',
                    style: TextStyle(color: Color.fromRGBO(255, 2, 102, 100)),
                  ),
                  onTap: () => {},
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15, 0, 8, 0),
                child: new ListTile(
                    title: new Text(
                      'PhonePe',
                      style: TextStyle(color: Color.fromRGBO(255, 2, 102, 100)),
                    ),
                    onTap: () => {}),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15, 0, 8, 0),
                child: new ListTile(
                    title: new Text(
                      'UPI',
                      style: TextStyle(color: Color.fromRGBO(255, 2, 102, 100)),
                    ),
                    onTap: () => {}),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15, 0, 8, 0),
                child: new ListTile(
                    title: new Text(
                      'Card',
                      style: TextStyle(color: Color.fromRGBO(255, 2, 102, 100)),
                    ),
                    onTap: () => {}),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15, 0, 8, 0),
                child: new ListTile(
                    title: new Text(
                      'Cash',
                      style: TextStyle(color: Color.fromRGBO(255, 2, 102, 100)),
                    ),
                    onTap: () => {}),
              ),
              SizedBox(
                height: 80,
              ),
              RawMaterialButton(
                onPressed: () {},
                elevation: 2.0,
                fillColor: Color.fromRGBO(255, 2, 102, 100),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 35.0,
                ),
                //padding: EdgeInsets.all(10.0),
                shape: CircleBorder(),
              ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        );
      });
}

class TotalCalculationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color(0xFFfae3e2).withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 1,
          offset: Offset(0, 1),
        ),
      ]),
      child: Card(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 25, right: 30, top: 10, bottom: 10),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Grilled Salmon",
                    style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF3a3a3b),
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "\$192",
                    style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF3a3a3b),
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.left,
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Meat vegetable",
                    style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF3a3a3b),
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "\$102",
                    style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF3a3a3b),
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.left,
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Total",
                    style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF3a3a3b),
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "\$292",
                    style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF3a3a3b),
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.left,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//
//class PromoCodeWidget extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return SafeArea(
//      child: Container(
//        padding: EdgeInsets.only(left: 3, right: 3),
//        decoration: BoxDecoration(boxShadow: [
//          BoxShadow(
//            color: Color(0xFFfae3e2).withOpacity(0.1),
//            spreadRadius: 1,
//            blurRadius: 1,
//            offset: Offset(0, 1),
//          ),
//        ]),
//        child: TextFormField(
//          decoration: InputDecoration(
//              focusedBorder: OutlineInputBorder(
//                borderSide: BorderSide(color: Color(0xFFe6e1e1), width: 1.0),
//              ),
//              enabledBorder: OutlineInputBorder(
//                  borderSide: BorderSide(color: Color(0xFFe6e1e1), width: 1.0),
//                  borderRadius: BorderRadius.circular(7)),
//              fillColor: Colors.white,
//              hintText: 'Add Your Promo Code',
//              filled: true,
//              suffixIcon: IconButton(
//                  icon: Icon(
//                    Icons.local_offer,
//                    color: Color(0xFFfd2c2c),
//                  ),
//                  onPressed: () {
//                    debugPrint('222');
//                  })),
//        ),
//      ),
//    );
//  }
//}

class CartItem extends StatelessWidget {
  String productName;
  String productPrice;
  String productImage;
  String productCartQuantity;

  CartItem({
    Key key,
    @required this.productName,
    @required this.productPrice,
    @required this.productImage,
    @required this.productCartQuantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 130,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color(0xFFfae3e2).withOpacity(0.3),
          spreadRadius: 1,
          blurRadius: 1,
          offset: Offset(0, 1),
        ),
      ]),
      child: Card(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Center(
                        child: Image.asset(
                      "assets/images/popular_foods/$productImage.png",
                      width: 110,
                      height: 100,
                    )),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "$productName",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xFF3a3a3b),
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              child: Text(
                                "$productPrice",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xFF3a3a3b),
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: Image.asset(
                            "assets/images/menus/ic_delete.png",
                            width: 25,
                            height: 25,
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      alignment: Alignment.centerRight,
                      //child: AddToCartMenu(2),
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}

class AddToCartMenu extends StatelessWidget {
  int productCounter;

  AddToCartMenu(this.productCounter);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.remove),
            color: Colors.black,
            iconSize: 18,
          ),
          InkWell(
            onTap: () => print('hello'),
            child: Container(
              width: 100.0,
              height: 35.0,
              decoration: BoxDecoration(
                color: Color(0xFFfd2c2c),
                border: Border.all(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Center(
                child: Text(
                  'Add To $productCounter',
                  style: new TextStyle(
                      fontSize: 12.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
            color: Color(0xFFfd2c2c),
            iconSize: 18,
          ),
        ],
      ),
    );
  }
}
