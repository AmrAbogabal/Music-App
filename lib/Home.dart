import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musicapp/shared.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'App.dart';
class BordingModel{
  String ima;
  String title;
  String body;
  BordingModel({required this.ima ,required this.title ,required this.body });
}

class Pording extends StatefulWidget {
  const Pording({Key? key}) : super(key: key);

  @override
  State<Pording> createState() => _PordingState();
}


class _PordingState extends State<Pording> {
  var bordcontlolar = PageController() ;
  late bool islast;
  late List<SongModel> Items=[] ;

  //late bool last ;
  //islast = true ;
  List<BordingModel> Bord = [
    BordingModel(
      body: " ",
      ima: "https://www.shutterstock.com/shutterstock/photos/649067062/display_1500/stock-photo-happy-young-man-with-headphones-listening-music-649067062.jpg",
      title:"Start enjoying" ,
    ),BordingModel(
      body: " ",
      ima: "https://www.shutterstock.com/image-photo/cheerful-young-caucasian-lady-wireless-600w-2018765360.jpg",
      title:"Be happy" ,
    ),BordingModel(
      body: "",
      ima: "https://www.shutterstock.com/image-photo/happy-woman-shirt-listening-music-600w-570090316.jpg",
      title:"Happiness depends upon ourselves." ,
    ),
  ];

  @override
  initState() {         // this is called when the class is initialized or called for the first time
    super.initState();//  this is the material super constructor for init state to link your instance initState to the global initState context
    requestPermission();
    if(CacheHelper.getData(key: "info")==null){
      setState((){
        islast = false ;
        print("Error");
        print(CacheHelper.getData(key: "info"));
        print("Error");
      });
    }
    else{
      setState((){
        print(CacheHelper.getData(key: "info"));
        islast = CacheHelper.getData(key: "info") ;
      });
    }
  }
  void requestPermission()async{
    if (await Permission.contacts.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
    }
// You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.storage,
    ].request();
    print(statuses[Permission.location]);
  }
  Widget build(BuildContext context) {
    if(islast == true){
      print("El Zamalek");
      WidgetsBinding.instance.addPostFrameCallback((_){
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => App(),
          ),
        );

        // Add Your Code here.
      });
      print("El Zamalekkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
    }
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white24,
        title: Text("Music App"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: PageView.builder(itemBuilder: (context , index)=>BuiltBordingItem(Bord[index]),
                onPageChanged: (index){
                  if (index ==Bord.length-1){
                    setState(() {
                      print("kjujkikbhihjklhnlef");
                      print(index);
                      islast = true ;
                    });
                  }
                  else {
                    setState(() {
                      print("kjujkikbhihjklhnlef");
                      print(index);
                      islast = false ;
                    });
                  }
                },
                controller: bordcontlolar,
                itemCount: Bord.length,
              ),
            ),
            SizedBox(height: 25,),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: bordcontlolar,
                  count: Bord.length,
                  effect: ExpandingDotsEffect(
                      dotColor: Colors.orange,
                      spacing: 20,
                      dotWidth: 10,
                      dotHeight: 10,
                      expansionFactor: 5,
                      activeDotColor: Colors.red

                  ),
                ),
                Spacer(),
                FloatingActionButton(onPressed: (){
                  if(islast){
                    CacheHelper.putData(key: "info", Li: true);
                    islast = CacheHelper.getData(key: "info") ;
                    print(CacheHelper.getData(key: "info"));

                  }
                  if (islast){
                    Navigator.pushReplacement(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) => new App()));
                  }
                  bordcontlolar.nextPage(duration: Duration(microseconds: 40000), curve: Curves.fastOutSlowIn);
                },
                  child: Icon(Icons.arrow_forward_ios),)
              ],
            )

          ],
        ),
      ),
    );

  }
  Widget BuiltBordingItem(BordingModel bord)=>Column(
    //crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: Image(image: NetworkImage("${bord.ima}"),)),
      SizedBox(height: 20,),
      Text("${bord.title}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
      SizedBox(height: 20,),
      Text(" ${bord.body}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),


    ],
  );
}
