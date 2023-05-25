import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../Cubit/Cubit.dart';
import '../Cubit/state.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var Serchcon = TextEditingController();
    var cubit = Musiccubit.get(context);
    return BlocConsumer<Musiccubit , Musicstate>(
        listener: (context , state){},
        builder: (context , state){
          return Container(
            decoration: BoxDecoration(
                image: DecorationImage(image:NetworkImage("https://images.unsplash.com/photo-1518022525094-218670c9b745?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MTB8fHxlbnwwfHx8fHw%3D&auto=format&fit=crop&w=600&q=60"),fit: BoxFit.fill)
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment:MainAxisAlignment.center ,children: [
                  CircleAvatar(radius: 140,backgroundImage: NetworkImage("https://www.shutterstock.com/image-photo/picture-happy-emotional-woman-housewife-600w-1917981491.jpg"),),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                  Spacer(),
                  Text("Result of Search : ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,),),
                  Text("${cubit.search.length}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),),
                  Text(" Song",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,),),
                  SizedBox(width: 10,)

                ],),
                Container(
                  color: Colors.white,
                  child: TextFormField(
                    decoration: InputDecoration(
                      label: Text("Search"),
                      prefixIcon: Icon(Icons.search),
                      hintText: "Seach to get your favourite music",
                    ),
                    controller: Serchcon ,
                    //validator: ,

                  ),
                ),
                Container(
                  width: double.infinity,
                  color: Colors.green,
                  child: MaterialButton(onPressed: (){
                    cubit.gersearch(Serchcon.text.toString());
                  }),
                ),
                SizedBox(height: 10,),
                Expanded(child: ListView.builder(
                  itemBuilder: (context,index)=>style(cubit.search,index,Musiccubit.get(context)),
                  itemCount: cubit.search.length,
                )),
              ],),
          );
        });
  }

  Widget style(List<SongModel> search, int index, Musiccubit musiccubit)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: InkWell(
      onTap: (){
        musiccubit.player1.stop();
        musiccubit.current = 1 ;
        musiccubit.Possition = musiccubit.searchpos[index] ;
        musiccubit.playNormalOrfav = 0 ;
        musiccubit.player1.setAudioSource(AudioSource.uri(Uri.parse(musiccubit.items[musiccubit.searchpos[index]].data)));
        musiccubit.e = musiccubit.items[musiccubit.searchpos[index]] ;
        musiccubit.eboll = musiccubit.favboll[musiccubit.searchpos[index]];
        musiccubit.bb();
        musiccubit.changetoplay() ;
      },
      child: Row(
        children: [
          CircleAvatar(backgroundImage: NetworkImage("https://www.shutterstock.com/image-photo/picture-happy-emotional-woman-housewife-600w-1917981491.jpg"),radius: 30,),
          SizedBox(width: 20,),
          Column(children: [
            Text("${musiccubit.search[index].artist}",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white54),),
            SizedBox(height: 15,),
            Container(
                width: 500,
                child: Text("${musiccubit.search[index].title}",overflow: TextOverflow.ellipsis,maxLines :2,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white,overflow: TextOverflow.ellipsis,),)),
          ],),
          Spacer(),
          SizedBox(width: 10,),
          IconButton(onPressed: (){
            musiccubit.searchfav(index);
          },
              icon: Icon(musiccubit.favboll[musiccubit.searchpos[index]]?Icons.favorite :Icons.favorite_border, size: 30,color:musiccubit.favboll[musiccubit.searchpos[index]]?Colors.red :Colors.white,)),
          Icon(Icons.add,color: Colors.white,)
        ],
      ),
    ),
  );
}
