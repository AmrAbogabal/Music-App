import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/Cubit/state.dart';
import 'package:musicapp/pages/Home.dart';
import '../pages/Playing.dart';
import '../pages/fav.dart';
import '../pages/search.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:just_audio/just_audio.dart';

class Musiccubit extends Cubit<Musicstate> {
  Musiccubit():super(Initialstate(
  ));
  static Musiccubit get(context)=>BlocProvider.of(context) ;
  int? current = 0 ;
  late int error = 0 ;
  int? Possition = 0 ;
  int? possitionofFav = 0 ;
  int? Start = 0 ;
  int? playNormalOrfav = 0 ;
  late bool? eboll = false ;
  late List<SongModel> items =[];
  late List<SongModel> search= [] ;
  late List<SongModel> fav= [] ;
  late List<bool> favboll = [] ;
  late List<bool> favbollsearch = [] ;
  late List<int> favpos = [] ;
  late List<int> searchpos = [] ;
  final player1 = AudioPlayer() ;
  late SongModel e = items[0] ;
  Duration duration = const Duration();
  Duration position = const Duration();
  Duration Stoppossition= Duration();
  // final OnAudioQuery audioQuery = OnAudioQuery();
  List<Widget> page = [Home(),Playing(),Fav(),Search()];
  void changecurrent(inde) {
    current = inde ;
  emit(changecurrentstate());
    if(current==1 && player1.playing){
      Future.delayed(const Duration(seconds: 1,days: 2), () {
        print("ccccccccccccccccccccccccccccc");
        changetoplay() ;
      });
    }
  }
  dynamic storesongs(List<SongModel> d){
    for(int i = 0;i<d.length;i++){
      items!.add(d[i]!);
    }
    emit(Collettsuccess());
  }
  void favfalse(){
    for(int i=0 ; i<items.length;i++){
      favboll.add(false);
    }
  }
  void setandDelFav(int index,SongModel s){
    if(favboll[index]==true){
      favboll[index] =false ;
      fav.remove(s);
      favpos.remove(index);
      print("Abo gabal false");
    }
    else{
      favboll[index] =true ;
      fav.add(s);
      favpos.add(index);
      print("Abo gabal true");
    }

    emit(ChangeFav());
  }
  dynamic refreshpos(){
    emit(refreshpo());
    return position.inSeconds.toDouble() ;
  }
  void removeFave(SongModel s,int index){
    fav.remove(s);
    favboll[favpos[index]]= false ;
    favpos.removeAt(index);
    emit(removeFavourite());
  }
  void gersearch(String t){
    search = [];
    searchpos = [];
    for(int i = 0;i<items.length ; i++){
      if(t.toString() != "" ){
        if(items[i].title.contains("${t}" )){
          favbollsearch.add(favboll[i]);
          search.add(items[i]);
          print(i);
          searchpos.add(i);
          print("Search is good ");
        }
        else  null;
      }
      else break ;

    }
    emit(Searcht());
  }
  void searchfav(index){
    if(favboll[searchpos[index]]){
      fav.remove(items[searchpos[index]]);
      favpos.remove(searchpos[index]);

      favboll[searchpos[index]]=false ;
    }
    else {
      fav.add(items[searchpos[index]]);
      favpos.add(searchpos[index]);
      favboll[searchpos[index]]=true ;
    }
    emit(Searchf());

  }
  void changetoplay(){
    emit(ChangeToPlay());
  }
  void playsong(){
    if(playNormalOrfav==0){
      player1.setAudioSource(AudioSource.uri(Uri.parse(items[Possition!.toInt()].data)));
      bb() ;
      player1.play();
      player1.seek(Stoppossition);
      print("good");
    }
    else{
      player1.setAudioSource(AudioSource.uri(Uri.parse(items[favpos[possitionofFav!]].data)));
      bb() ;
      player1.play();player1.seek(Stoppossition);
      print("good");
    }
    emit(playing());
  }
  void playnext(){
    if(playNormalOrfav==0){
      Possition = (Possition!+1) ;
      if(Possition == items.length){
        Possition= 0;
      }
      player1.setAudioSource(AudioSource.uri(Uri.parse(items[Possition!].data)));
      e = items[Possition!];
      eboll = favboll[Possition!];
      player1.play;
      print("good");
    }
    if(playNormalOrfav==1){
      possitionofFav = (possitionofFav!+1) ;
      if(possitionofFav == favpos.length){
        possitionofFav= 0;
      }
      player1.setAudioSource(AudioSource.uri(Uri.parse(fav[possitionofFav!].data)));
      e = fav[possitionofFav!];
      eboll = favboll[possitionofFav!];
      player1.play();
      print("good");
    }
    bb();
    emit(next());
  }
  void playprev(){
    if(playNormalOrfav==0){
      Possition = (Possition!-1) ;
      if(Possition ==-1){
        Possition= items.length;
      }
      player1.setAudioSource(AudioSource.uri(Uri.parse(items[Possition!].data)));
      e = items[Possition!];
      player1.play();
      print("good");
    }
    if(playNormalOrfav==1){
      possitionofFav = (possitionofFav!-1) ;
      if(possitionofFav == -1){
        possitionofFav= favpos.length;
      }
      player1.setAudioSource(AudioSource.uri(Uri.parse(fav[possitionofFav!].data)));
      e = fav[possitionofFav!];
      player1.play();
      print("good");
    }
    bb();
    emit(prev());
  }
  void bb(){
    player1.durationStream.listen((event) {
      duration = event! ;
    });
    print("good");
    player1.positionStream.listen((event) {
      position = event!;
      //print(position);
    });
    print("good");
  }
  void Changetosecands(int s){
    Duration f = Duration(seconds: s);
    player1.seek(f);
    emit(Changetosecand());
  }
}
