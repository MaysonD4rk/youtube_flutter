import 'package:app_youtube/Api.dart';
import 'package:app_youtube/model/Video.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Inicio extends StatefulWidget {
  //const Inicio({super.key});

  String pesquisa;

  Inicio(this.pesquisa);

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {

  _listarVideos(String pesquisa){


    Api api = Api();
    return api.pesquisar(pesquisa);

  }

  @override
  Widget build(BuildContext context) {

    YoutubePlayerController _videoController = YoutubePlayerController(
      initialVideoId: '', // Vídeo vazio inicialmente
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );


    return FutureBuilder<List<Video>>(
      future: _listarVideos(widget.pesquisa),
      builder: (context, snapshot){
        switch( snapshot.connectionState){
          case ConnectionState.none :
          case ConnectionState.waiting :
            return Center(
              child: CircularProgressIndicator(),
            );
            break;
          case ConnectionState.active :
          case ConnectionState.done :
            if(snapshot.hasData){
                return ListView.separated(
                    itemBuilder: (context, index){

                      List<Video>? videos = snapshot.data;
                      Video video = videos![index];

                      return GestureDetector(
                        onTap: (){
                          _videoController = YoutubePlayerController(
                            initialVideoId: video.id.toString(),
                            flags: YoutubePlayerFlags(
                              autoPlay: true,
                              mute: false,
                            ),
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Scaffold(
                                appBar: AppBar(
                                  title: Text(video.titulo.toString()),
                                ),
                                body: Center(
                                  child: YoutubePlayer(
                                    controller: _videoController,
                                    showVideoProgressIndicator: true,
                                    progressIndicatorColor: Colors.blueAccent,
                                  ),
                                ),
                              ),
                            ),
                          );


                        },
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 200,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage( video.imagem ?? '' ),
                                  )
                              ),
                            ),
                            ListTile(
                              title: Text(video.titulo ?? ''),
                              subtitle: Text(video.canal ?? ''),
                            )
                          ],
                        ),
                      );

                    },
                    separatorBuilder: (context, index)=> Divider(
                      height: 3,
                      color: Colors.red,
                    ),
                    itemCount:  snapshot.data?.length ?? 0,
                );
            }else{
              return Center(
                child: Text("Nenhum dado a ser exibido!"),
              );
            }
            break;
        }
      },
    );
  }
}
