import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Cubit/Cubit.dart';
import 'Cubit/state.dart';
import 'package:on_audio_query/on_audio_query.dart';
class App extends StatelessWidget {
  final OnAudioQuery audioQuery = OnAudioQuery();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(

        create: (BuildContext context) => Musiccubit(),
        child: BlocConsumer<Musiccubit, Musicstate>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = Musiccubit.get(context);
              if(cubit.items.isEmpty){
                return FutureBuilder<List<SongModel>>(
                  builder:(context,item){
                    if(item.data == null){return Center(child: CircularProgressIndicator(),);}
                    if(item.data!.isEmpty){return Center(child: Text("No Songs Found"),);}
                    cubit.items.addAll(item.data!);
                    cubit.favfalse();
                    print("iteams");
                    print(cubit.items);
                    print(cubit.favboll);
                    print("iteam");
                    print(item.data);
                    return Scaffold(
                      body: cubit.page[cubit.current!.toInt()],
                      bottomNavigationBar: BottomNavigationBar(
                        selectedItemColor: Colors.white,
                        unselectedItemColor: Colors.black54,
                        onTap: (i){
                          cubit.changecurrent(i);
                        },
                        currentIndex: cubit.current!.toInt(),
                        items: const [
                          BottomNavigationBarItem(icon: Icon(Icons.music_note_outlined),label: "Home",backgroundColor: Colors.deepOrangeAccent),
                          BottomNavigationBarItem(icon: Icon(Icons.pause),label: "Playing",backgroundColor: Colors.deepOrangeAccent),
                          BottomNavigationBarItem(icon: Icon(Icons.favorite),label: "Favourite",backgroundColor: Colors.deepOrangeAccent),
                          BottomNavigationBarItem(icon: Icon(Icons.search),label: "Search",backgroundColor: Colors.deepOrangeAccent),
                        ],
                      ),
                    );
                  },
                  future: audioQuery.querySongs(
                    sortType: null,
                    orderType: OrderType.ASC_OR_SMALLER,
                    uriType: UriType.EXTERNAL,
                    ignoreCase: true,
                  ),
                );
              }
              else {
                return Scaffold(
                  body: cubit.page[cubit.current!.toInt()],
                  bottomNavigationBar: BottomNavigationBar(
                    selectedItemColor: Colors.white,
                    unselectedItemColor: Colors.black54,
                    //backgroundColor: Colors.black,
                    onTap: (i){
                      cubit.changecurrent(i);
                    },
                    currentIndex: cubit.current!,
                    items: const [
                      BottomNavigationBarItem(icon: Icon(Icons.music_note_outlined),label: "Home",backgroundColor: Colors.deepOrangeAccent),
                      BottomNavigationBarItem(icon: Icon(Icons.pause),label: "Playing",backgroundColor: Colors.deepOrangeAccent),
                      BottomNavigationBarItem(icon: Icon(Icons.favorite),label: "Favourite",backgroundColor: Colors.deepOrangeAccent),
                      BottomNavigationBarItem(icon: Icon(Icons.search),label: "Search",backgroundColor: Colors.deepOrangeAccent),
                    ],
                  ),
                );
              }
            }
        ));
  }
}
