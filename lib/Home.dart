import 'package:app_youtube/CustomSearchDelegate.dart';
import 'package:app_youtube/telas/Biblioteca.dart';
import 'package:app_youtube/telas/EmAlta.dart';
import 'package:app_youtube/telas/Inicio.dart';
import 'package:app_youtube/telas/Inscricao.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _resultado = "";
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    List<Widget> telas = [
      Inicio(_resultado),
      EmAlta(),
      Inscricao(),
      Biblioteca(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.grey,
          opacity: 1,
        ),
        title: Image.asset("images/youtube.png", width: 98, height: 22),
        actions: <Widget>[
          IconButton(
              onPressed: () async {
                String? res = await showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(),
                );
                setState((){
                  _resultado = res?? "";
                });
                },
              icon: Icon(Icons.search))


          //IconButton(onPressed: (){print('acao videocam');}, icon: Icon(Icons.videocam)),
          //IconButton(onPressed: (){print('acao account');}, icon: Icon(Icons.account_circle)),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: telas[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
        items: [
          BottomNavigationBarItem(label: "Início",icon: Icon(Icons.home), backgroundColor: Colors.orange ),
          BottomNavigationBarItem(label: "Em alta",icon: Icon(Icons.whatshot), backgroundColor: Colors.red ),
          BottomNavigationBarItem(label: "Inscrições",icon: Icon(Icons.subscriptions), backgroundColor: Colors.blue ),
          BottomNavigationBarItem(label: "Biblioteca",icon: Icon(Icons.folder), backgroundColor: Colors.green ),

        ],
      ),
    );
  }
}
