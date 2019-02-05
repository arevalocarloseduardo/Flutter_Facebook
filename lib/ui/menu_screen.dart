import 'package:bitstudio/ui/listview_note.dart';
import 'package:bitstudio/ui/listview_tratamientos.dart';
import 'package:bitstudio/ui/noticias_screen.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int currentTab = 0;
  NoticiasScreen one;
  ListviewTratamientos two;
  ListviewTratamientos tree;
  ListViewNote four;

  List<Widget>pages;
  Widget currentPage;


  @override
  void initState() {
    one = NoticiasScreen();
    two = ListviewTratamientos();
    tree =ListviewTratamientos();
    four = ListViewNote();

    pages =[one,two,tree,four];

    currentPage=one;
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: currentPage,  
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentTab,
        onTap: (int index){
          setState(() {
           currentTab = index;
           currentPage = pages[index];
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Noticias")
            ),
              BottomNavigationBarItem(
              icon: Icon(Icons.receipt),
              title: Text("Reservar")
            ),
            BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            title: Text("Mis Turnos")
            ),
            BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            title: Text("Información")
            ),
        ],
      ),
      
    );
  }
}