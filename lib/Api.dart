import "package:app_youtube/model/Video.dart";
import "package:http/http.dart" as http;
import "dart:convert";

const CHAVE_YOUTUBE_API = "AIzaSyBykM-2EnA9Hv4Op2GOCAfx2ORRXa2G3QM";
const ID_CANAL = "UCVHFbqXqoYvEWM1Ddxl0QDg";
const URL_BASE = "https://www.googleapis.com/youtube/v3/";

class Api{
  Future<List<Video>> pesquisar(String pesquisa) async {

    http.Response response = await http.get(
        Uri.parse(URL_BASE + "search"
            "?part=snippet"
            "&maxResults=20"
            "&key=$CHAVE_YOUTUBE_API"
            "&q=$pesquisa")
    );

      print(response.statusCode);
      if(response.statusCode == 200){

        Map<String, dynamic> dadosJson = json.decode( response.body );

        List<Video> videos = dadosJson["items"].map<Video>(
            (map){
              return Video.fromJson(map);
            }
        ).toList();


        return videos;
        /*
        for(var video in dadosJson["items"]){
           print("Resultado: "+ video.toString() );
        }
        */


        //print ("resultado: "+ dadosJson['items'][0]["snippet"]["title"].toString());

      }else{
        // Em caso de erro, retorne uma lista vazia
        return [];
      }

  }
}