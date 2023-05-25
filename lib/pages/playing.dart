import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Cubit/Cubit.dart';
import '../Cubit/state.dart';

class Playing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Musiccubit , Musicstate>(
        listener: (context , state){},
        builder: (context , state){
          var cubit = Musiccubit.get(context);
          void Changetosecands(int s){
            Duration f = Duration(seconds: s);
            cubit.player1.seek(f);
          }
          if(cubit.position==cubit.duration){
            print("amrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
            cubit.playnext() ;
          }
          return Container(
            decoration: BoxDecoration(
                image: DecorationImage(image:NetworkImage("https://images.unsplash.com/photo-1518022525094-218670c9b745?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NjR8fHNlYXxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=600&q=60"),fit: BoxFit.fill)
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Spacer(),
                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      SizedBox(
                        width: 500,
                        child: Column(children: [
                          Text("${cubit.e.artist}",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white),),
                          Text(cubit.e.title,overflow: TextOverflow.ellipsis,maxLines: 2,style: TextStyle(fontSize: 15,color: Colors.white,overflow: TextOverflow.ellipsis)),
                        ],),
                      ),
                      Spacer(),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Column(children: [
                    Container(
                      child: Slider(
                        thumbColor: Colors.pinkAccent,
                        max:cubit.duration.inSeconds.toDouble(),
                        value:cubit.refreshpos(),
                        min:  const Duration(microseconds: 0).inSeconds.toDouble(),
                        onChanged: (value) {
                          Changetosecands(value.toInt());
                          cubit.changetoplay();
                        }, activeColor: Colors.black,
                      ),
                    ),
                    Row(children: [
                      Text(cubit.position.toString().split(".")[0],style: const TextStyle(color: Colors.white)),const Spacer(),
                      Text(cubit.duration.toString().split(".")[0],style: const TextStyle(color: Colors.white),)
                    ],)
                  ],),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Spacer(),
                      IconButton(onPressed: (){
                        cubit.playprev();
                      }, icon: const Icon(Icons.skip_previous_outlined,size: 30,color: Colors.white,)),
                      Spacer(),
                      IconButton(onPressed: (){
                        if(cubit.player1.playing){
                          cubit.Stoppossition = cubit.position ;
                          cubit.player1.stop();
                        }
                        else{
                          cubit.playsong();
                        }
                        cubit.changetoplay();
                      }, icon: Icon(cubit.player1.playing?Icons.pause:Icons.play_circle_filled_rounded,size: 30,color: Colors.white,)),
                      const Spacer(),
                      IconButton(onPressed: (){
                        cubit.playnext();
                      }, icon: const Icon(Icons.skip_next_outlined,size: 30,color: Colors.white,)),
                      const Spacer(),
                    ],
                  ),
                  const Spacer(),
                  // SizedBox(height: 20,),
                  // Expanded(child: ListView.builder(itemBuilder: (context,index)=>style())),
                ],),
            ),
          );
        });
  }
}
