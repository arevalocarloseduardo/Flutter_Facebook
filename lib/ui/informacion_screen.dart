import 'package:flutter/material.dart';
import 'package:bitstudio/utils/common_divider.dart';
import 'package:bitstudio/utils/common_scaffold.dart';
import 'package:bitstudio/utils/profile_tile.dart';

class InformacionScreen extends StatelessWidget {
  var deviceSize;
  //Column1
  Widget profileColumn() => Container(
        height: deviceSize.height * 0.24,
        child: FittedBox(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ProfileTile(
                  title: "Estetica",
                  subtitle: "La Plata",
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.chat),
                        color: Colors.black,
                        onPressed: () {},
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(40.0)),
                          border: new Border.all(
                            color: Colors.purple,
                            width: 2.0,
                          ),
                        ),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://pngimage.net/wp-content/uploads/2018/06/logo-estetica-png-1.png"),
                          foregroundColor: Colors.black,
                          radius: 30.0,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.call),
                        color: Colors.black,
                        onPressed: () {},
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );

  //column2

  //column3
  Widget descColumn() => Container(
        height: deviceSize.height * 0.13,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Text(
              "Estetica La Plata, Reservar, Turnos y mucho mas desde nuestra Aplicación totalmente gratis",
              style: TextStyle(fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
              maxLines: 3,
              softWrap: true,
            ),
          ),
        ),
      );
  //column4
  Widget accountColumn() => FittedBox(
        fit: BoxFit.fill,
        child: Container(
          height: deviceSize.height * 0.3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FittedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ProfileTile(
                      title: "Web",
                      subtitle: "www.estetica.com",
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ProfileTile(
                      title: "Teléfono",
                      subtitle: "+54 221 619-5020",
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ProfileTile(
                      title: "YouTube",
                      subtitle: "youtube.com/EsteticaBella",
                    ),
                  ],
                ),
              ),
              FittedBox(
                fit: BoxFit.cover,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ProfileTile(
                      title: "Dirección",
                      subtitle: "122 y 66",
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ProfileTile(
                      title: "Email",
                      subtitle: "estetica@gmail.com",
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ProfileTile(
                      title: "Facebook",
                      subtitle: "fb.com/estetica",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget bodyData() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          profileColumn(),
          CommonDivider(),
          followColumn(deviceSize),
          CommonDivider(),
          descColumn(),
          CommonDivider(),
          accountColumn()
        ],
      ),
    );
  }

  Widget _scaffold() => CommonScaffold(
        appTitle: "View Profile",
        bodyData: bodyData(),
        showFAB: true,
        showDrawer: true,
        floatingIcon: Icons.person_add,
      );

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return _scaffold();
  }
}

Widget followColumn(Size deviceSize) => Container(
      height: deviceSize.height * 0.13,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ProfileTile(
            title: "1.5K",
            subtitle: "Especialistas",
          ),
          ProfileTile(
            title: "2.5K",
            subtitle: "Clientes",
          ),
          ProfileTile(
            title: "10K",
            subtitle: "Tratamientos",
          ),
          
        ],
      ),
    );