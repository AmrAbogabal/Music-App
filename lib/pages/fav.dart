import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../Cubit/Cubit.dart';
import '../Cubit/state.dart';

class Fav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Musiccubit , Musicstate>(
        listener: (context , state){},
        builder: (context , state){
          var cubit = Musiccubit.get(context);
          return Container(
            decoration: BoxDecoration(
                image: DecorationImage(image:NetworkImage("https://images.unsplash.com/photo-1518022525094-218670c9b745?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MTB8fHxlbnwwfHx8fHw%3D&auto=format&fit=crop&w=600&q=60"),fit: BoxFit.fill)
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment:MainAxisAlignment.center ,children: [
                  CircleAvatar(radius: 140,backgroundImage: NetworkImage("https://www.shutterstock.com/image-photo/handsome-curly-guy-touches-his-600w-1324502225.jpg"),),
                ],),
                SizedBox(height: 20,),
                Row(children: [
                  Spacer(),
                  Text("Number of Your Favourite Songs : ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,),),
                  Text("${cubit.fav.length}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),),
                  Text(" Song",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,),),
                  SizedBox(width: 10,)

                ],),
                Expanded(child: ListView.builder(itemBuilder: (context,index)=>style(cubit.fav,index,Musiccubit.get(context)),itemCount: cubit.fav.length,)),

              ],),
          );
        });
  }

  Widget style(List<SongModel> fav, int index, Musiccubit musiccubit)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: InkWell(
      onTap: (){
        musiccubit.player1.stop();
        musiccubit.current = 1 ;
        musiccubit.possitionofFav = index;
        musiccubit.playNormalOrfav = 1 ;
        musiccubit.e = fav[index];
        musiccubit.player1.setAudioSource(AudioSource.uri(Uri.parse(musiccubit.fav[index!].data)));
        musiccubit.bb();
        musiccubit.eboll = musiccubit.favboll[musiccubit.favpos[index]];
        musiccubit.changetoplay() ;
      },
      child: Row(
        children: [
          CircleAvatar(backgroundImage: NetworkImage("https://www.shutterstock.com/image-photo/handsome-curly-guy-touches-his-600w-1324502225.jpg"),radius: 30,),
          SizedBox(width: 20,),
          Column(children: [
            Text("${fav[index].artist}",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white54),),
            SizedBox(height: 15,),
            Container(
                width: 500,
                child:  Text("${fav[index].title}",overflow: TextOverflow.ellipsis,maxLines: 2,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white,overflow: TextOverflow.ellipsis,),)),
          ],),
          Spacer(),
          IconButton(onPressed: (){
            musiccubit.removeFave(fav[index], index);
            //musiccubit.favboll[musiccubit.favpos[index]] = false;
          }, icon: Icon(Icons.delete , size: 30,color: Colors.white,)),
          SizedBox(width: 10,),
          //Icon(Icons.add,color: Colors.white,)
        ],
      ),
    ),
  );
}
