import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuWidget extends StatefulWidget {
  const MenuWidget({Key? key}) : super(key: key);

  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (FocusScope.of(context).hasFocus) {
          FocusScope.of(context).unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xFFEAEDED),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
          child: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        'Menú',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Readex Pro',
                          color: Color(0xFF154360),
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.signOutAlt,
                      color: Color(0xFF154360),
                      size: 24,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/Login');
                    },
                  ),
                ),
              ],
            ),
            actions: [],
            centerTitle: false,
            toolbarHeight: MediaQuery.of(context).size.height * 0.06,
            elevation: 2,
          ),
        ),
        body: SafeArea(
          top: true,
          child: Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 20),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  buildMenuButton(
                    context,
                    'Tarifarias Multas',
                    FontAwesomeIcons.donate,
                    'TraficoDeMulta',
                  ),
                  buildMenuButton(
                    context,
                    'Aplicar Multar',
                    FontAwesomeIcons.fileSignature,
                    'AplicarMulta',
                  ),
                  buildMenuButton(
                    context,
                    'Multas Registradas',
                    FontAwesomeIcons.clipboardCheck,
                    'MultaRegistrada',
                  ),
                  buildMenuButton(
                    context,
                    'Mapa de multas',
                    FontAwesomeIcons.mapMarkedAlt,
                    'MapaMulta',
                  ),
                  buildMenuButton(
                    context,
                    'Consultar Vehiculo',
                    FontAwesomeIcons.car,
                    'ConsultaVehiculo',
                  ),
                  buildMenuButton(
                    context,
                    'Consultar Conductor',
                    FontAwesomeIcons.idCard,
                    'ConsultaConductor',
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      buildMenuButton(
                        context,
                        '',
                        FontAwesomeIcons.solidNewspaper,
                        'Noticias',
                        buttonWidth: MediaQuery.of(context).size.width * 0.23,
                      ),
                      buildMenuButton(
                        context,
                        '',
                        FontAwesomeIcons.cloudSun,
                        'Clima',
                        buttonWidth: MediaQuery.of(context).size.width * 0.23,
                      ),
                      buildMenuButton(
                        context,
                        '',
                        FontAwesomeIcons.centos,
                        'Horoscopo',
                        buttonWidth: MediaQuery.of(context).size.width * 0.23,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMenuButton(BuildContext context, String text, IconData icon, String routeName,
      {double buttonWidth = double.infinity}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: SizedBox(
        width: buttonWidth,
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed("/$routeName");
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                icon,
                size: 40,
                color: Color(0xFF154360),
              ),
              SizedBox(width: 10),
              Text(
                text,
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: Color(0xFF154360),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
