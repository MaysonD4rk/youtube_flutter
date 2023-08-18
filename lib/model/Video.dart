class Video{
  String? id;
  String? titulo;
  String? imagem;
  String? canal;
  String? descricao;

  Video({ this.id, this.titulo, this.descricao, this.imagem, this.canal});

  /*
  static converterJson(Map<String, dynamic> json){
    return Video(
      id: json["id"]["videoId"],
      titulo: json["snippet"]["title"],
      imagem: json["snippet"]["thumbnails"]["high"]["url"],
      canal: json["snippet"]["channelId"]
    );
  }


   */

  factory Video.fromJson(Map<String, dynamic> json){
    return Video(
        id: json["id"]["videoId"],
        titulo: json["snippet"]["title"],
        imagem: json["snippet"]["thumbnails"]["high"]["url"],
        canal: json["snippet"]["channelTitle"],
        descricao: json["snippet"]["description"],
    );
  }
}