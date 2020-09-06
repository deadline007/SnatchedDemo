// Shows a slide of quick stuff in the app

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snatched/Routes/Route_AuthSignIn.dart';

import 'package:snatched/Utilities/Class_AssetHolder.dart';
import 'package:snatched/Utilities/Class_ScreenConf.dart';
import 'package:snatched/Utilities/Class_PermissionManager.dart';

class RouteAppInfo extends StatefulWidget {
  @override
  _RouteAppInfoState createState() => _RouteAppInfoState();
}

class _RouteAppInfoState extends State<RouteAppInfo> {

  List<SliderModel> mySLides = new List<SliderModel>();
  int slideIndex = 0;
  PageController controller;

  Widget _buildPageIndicator(bool isCurrentPage){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? Colors.grey : Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mySLides = getSlides();
    controller = new PageController();
  }

  @override
  Widget build(BuildContext context) {
    void _SignIn() {
      Navigator.popAndPushNamed(context, "/authSignIn");
    }
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [const Color(0xff3C8CE7), const Color(0xff00EAFF)])),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height - 100,
          child: PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() {
                slideIndex = index;
              });
            },
            children: <Widget>[
              SlideTile(
                imagePath: mySLides[0].getImageAssetPath(),
                title: mySLides[0].getTitle(),
                desc: mySLides[0].getDesc(),
              ),
              SlideTile(
                imagePath: mySLides[1].getImageAssetPath(),
                title: mySLides[1].getTitle(),
                desc: mySLides[1].getDesc(),
              ),
              SlideTile(
                imagePath: mySLides[2].getImageAssetPath(),
                title: mySLides[2].getTitle(),
                desc: mySLides[2].getDesc(),
              )
            ],
          ),
        ),
        bottomSheet: slideIndex != 2 ? Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                onPressed: (){
                  controller.animateToPage(2, duration: Duration(milliseconds: 400), curve: Curves.linear);
                },
                splashColor: Colors.blue[50],
                child: Text(
                  "SKIP",
                  style: TextStyle(color: Color(0xFF0074E4), fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                child: Row(
                  children: [
                    for (int i = 0; i < 3 ; i++) i == slideIndex ? _buildPageIndicator(true): _buildPageIndicator(false),
                  ],),
              ),
              FlatButton(
                onPressed: (){
                  print("this is slideIndex: $slideIndex");
                  controller.animateToPage(slideIndex + 1, duration: Duration(milliseconds: 500), curve: Curves.linear);
                },
                splashColor: Colors.blue[50],
                child: Text(
                  "NEXT",
                  style: TextStyle(color: Color(0xFF0074E4), fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ):InkWell(
        onTap: _SignIn,
//          child: new Icon(Icons.navigate_next),

        child: Container(
           height: 60,
            color: Colors.blue,
            alignment: Alignment.center,
            child: Text(
              "GET STARTED NOW",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),

        ),
      ),
      );

  }
}

class SlideTile extends StatelessWidget {
  String imagePath, title, desc;

  SlideTile({this.imagePath, this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(imagePath),
          SizedBox(
            height: 40,
          ),
          Text(title, textAlign: TextAlign.center,style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20
          ),),
          SizedBox(
            height: 20,
          ),
          Text(desc, textAlign: TextAlign.center,style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14))
        ],
      ),
    );
  }
}

class SliderModel{

  String imageAssetPath;
  String title;
  String desc;

  SliderModel({this.imageAssetPath,this.title,this.desc});

  void setImageAssetPath(String getImageAssetPath){
    imageAssetPath = getImageAssetPath;
  }

  void setTitle(String getTitle){
    title = getTitle;
  }

  void setDesc(String getDesc){
    desc = getDesc;
  }

  String getImageAssetPath(){
    return imageAssetPath;
  }

  String getTitle(){
    return title;
  }

  String getDesc(){
    return desc;
  }

}


List<SliderModel> getSlides(){

  List<SliderModel> slides = new List<SliderModel>();
  SliderModel sliderModel = new SliderModel();

  //1
  sliderModel.setDesc("Discover a Food Courner offering the best fast food near you");
  sliderModel.setTitle("Search......");
  sliderModel.setImageAssetPath("assets/images/foodie_image1.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //2
  sliderModel.setDesc("Our food plan is filled with delicious seasonal vegetables, whole grains, fast food , burgger , pizza etc.");
  sliderModel.setTitle("Order..... ");
  sliderModel.setImageAssetPath("assets/images/foodie_image2.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //3
  sliderModel.setDesc("Food delivery or pickup from local restaurants, Explore restaurants that deliver near you.");
  sliderModel.setTitle("Deliver........");
  sliderModel.setImageAssetPath("assets/images/foodie_image2.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  return slides;
}





//class RouteAppInfo extends StatelessWidget {
//  final double widthMin = ClassScreenConf.blockH;
//  final double widthMax = ClassScreenConf.hArea;
//  final double heightMin = ClassScreenConf.blockV;
//  final double heightMax = ClassScreenConf.vArea;
//  final List<Image> imageList = [
//    Image.asset(
//      ClassAssetHolder.intro1,
//    ),
//    Image.asset(
//      ClassAssetHolder.intro2,
//    ),
//    Image.asset(
//      ClassAssetHolder.intro3,
//    )
//  ];
//
//  @override
//  Widget build(BuildContext context) {
//    return ChangeNotifierProvider<ValueNotifier<int>>(
//      create: (context) => ValueNotifier<int>(0),
//      builder: (context, _) => widgetData(context),
//    );
//  }
//
//  Widget widgetData(BuildContext context) {
//    final counter = Provider.of<ValueNotifier<int>>(context, listen: false);
//    void changeCounter(String option) {
//      if (option == "add") {
//        counter.value += 1;
//      } else {
//        counter.value -= 1;
//      }
//    }
//
//    return Scaffold(
//      body: Container(
//        height: heightMax,
//        width: widthMax,
//        child: Stack(
//          children: <Widget>[
//            GestureDetector(
//              onPanUpdate: (details) {
//                if (details.delta.dx < -1.5 &&
//                    counter.value < imageList.length - 1) {
//                  changeCounter("add");
//                } else if (details.delta.dx > 1.5 && counter.value > 0) {
//                  changeCounter("minus");
//                }
//              },
//              child: Center(
//                child: Consumer<ValueNotifier<int>>(
//                  builder: (_, counter, __) => Container(
//                      width: widthMax,
//                      height: heightMax,
//                      color: Colors.brown[200],
//                      child: imageList[counter.value]),
//                ),
//              ),
//            ),
//            Positioned(
//              bottom: widthMin * 8,
//              right: widthMin * 8,
//              child: ClipRRect(
//                borderRadius: BorderRadius.circular(15),
//                child: Container(
//                  color: ClassAssetHolder.mainColor,
//                  child: IconButton(
//                    iconSize: widthMin * 10,
//                    enableFeedback: true,
//                    icon: Icon(
//                      ClassAssetHolder.rightIcon,
//                      color: Colors.white,
//                      size: widthMin * 10,
//                    ),
//                    onPressed: () async {
//                      if (counter.value < imageList.length - 1) {
//                        changeCounter("add");
//                      } else {
//                        await Future.value(
//                                ClassPermissionManager().askForPerms())
//                            .then(
//                          (_) => Navigator.pushNamedAndRemoveUntil(
//                            context,
//                            '/authSignIn',
//                            (_) => false,
//                          ),
//                        );
//                      }
//                    },
//                  ),
//                ),
//              ),
//            ),

//          ],
//        ),
//      ),
//    );
//  }
//}

/* Positioned(
              bottom: heightMin * 6,
              child: Container(
                height: heightMin * 10,
                width: widthMin * 20,
                child: Consumer<ValueNotifier<int>>(
                  builder: (_, counter, __) {
                    return Slider(

                      max: (imageList.length - 1) * 1.0,
                      value: (counter.value) * 1.0,
                      onChanged: (_) {},
                    );
                  },
                ),
              ),
            ) */


