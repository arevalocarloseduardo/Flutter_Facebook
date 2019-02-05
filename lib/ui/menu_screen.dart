import 'package:bitstudio/ui/informacion_screen.dart';
import 'package:bitstudio/ui/listview_tratamientos.dart';
import 'package:bitstudio/ui/misturnos_screen.dart';
import 'package:bitstudio/ui/noticias_screen.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  int i;
  MenuScreen(this.i);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {

  int currentTab = 0;
  NoticiasScreen one;
  ListviewTratamientos two;
  MisTurnosScreen tree;
  InformacionScreen four;

  List<Widget>pages;
  Widget currentPage;


  @override
  void initState() {
    one = NoticiasScreen();
    two = ListviewTratamientos();
    tree =MisTurnosScreen();
    four = InformacionScreen();

    pages =[one,two,tree,four];
    currentTab = widget.i;
    currentPage=pages[widget.i];
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