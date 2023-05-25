import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../Cubit/Cubit.dart';
import '../Cubit/state.dart';
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Musiccubit , Musicstate>(
        listener: (context , state){},
        builder: (context , state){
          var cubit = Musiccubit.get(context);
          print(cubit.items.length);
          print(cubit.favboll);
          // cubit.changetoplay();
          print(cubit.items);
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(image:NetworkImage("https://images.unsplash.com/photo-1518022525094-218670c9b745?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MTB8fHxlbnwwfHx8fHw%3D&auto=format&fit=crop&w=600&q=60"),fit: BoxFit.fill)
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment:MainAxisAlignment.center ,children: [
                  CircleAvatar(radius: 140,backgroundImage: NetworkImage("https://www.shutterstock.com/image-photo/cheerful-enjoy-young-woman-wearing-600w-1935880312.jpg"),),
                ],),
                SizedBox(height: 20,),
                Row(children: [
                  Spacer(),
                  Text("Number of Songs : ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,),),
                  Text("${cubit.items.length}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),),
                  Text(" Song",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,),),
                  SizedBox(width: 10,)

                ],),
                Expanded(child: ListView.separated(
                  itemBuilder: (context,index)=>style(cubit.items,index,Musiccubit.get(context)),
                  separatorBuilder: (context,index)=>SizedBox(height: 5,),
                  itemCount:cubit.items.length.toInt(),)
                ),

              ],),
          );
        });
  }

  Widget style( List<SongModel> items,index, Musiccubit musiccubit)=>Padding(
    padding: EdgeInsets.all(10),
    child: Container(
      child: InkWell(
        onTap: (){
          musiccubit.player1.stop();
          musiccubit.current = 1 ;
          musiccubit.Possition = index ;
          musiccubit.playNormalOrfav = 0 ;
          musiccubit.e = items[index];
          musiccubit.player1.setAudioSource(AudioSource.uri(Uri.parse(musiccubit.items[index!].data)));
          musiccubit.eboll = musiccubit.favboll[index] ;
          musiccubit.bb();
          musiccubit.changetoplay() ;
        },
        child: Row(
          children: [
            CircleAvatar(backgroundImage: NetworkImage("https://www.shutterstock.com/image-photo/cheerful-enjoy-young-woman-wearing-600w-1935880312.jpg"),radius: 30,),
            SizedBox(width: 20,),
            Column(children: [
              Text("${items[index].artist}",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.black),),
              SizedBox(height: 15,),
              Container(
                  width: 500,
                  child: Text("${items[index].title}",overflow: TextOverflow.ellipsis,maxLines: 2,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white,overflow: TextOverflow.ellipsis,),)),
            ],),
            Spacer(),
            IconButton(
              onPressed: (){
                musiccubit.setandDelFav(index,items[index]);
              }, icon:Icon(musiccubit.favboll[index]?Icons.favorite :Icons.favorite_border, size: 30,color:musiccubit.favboll[index]?Colors.red :Colors.white,),),
            SizedBox(width: 10,),
            //IconButton(onPressed: (){}, icon:Icon(Icons.add,color: Colors.white, size: 30),),


          ],
        ),
      ),
    ),
  );
}

