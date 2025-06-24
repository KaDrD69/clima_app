import 'dart:ui';

//import 'package:clima_app/data/model/clima_response.dart';
import 'package:clima_app/data/icons_weather.dart';
import 'package:clima_app/data/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double? temp;
  String? des;
  int? id;
  String? icono;
  int? dt;
  bool? esDia;

  @override
  void initState(){
    super.initState();
    cargarClima();
  }

  Future<void> cargarClima() async {
    final repo = Repository();
    final clima = await repo.fetchClima();
    if (clima != null){
      setState(() {
        temp = clima.temp;
        des = clima.description;
        id = clima.id;
        dt = clima.dt;
        if (dt! >= clima.amanacer && dt! < clima.atardecer){
          esDia = true;
        } else {
          esDia = false;
        }
        icono = obtenerIcono(esDia, id);
      });
    }
  }



  @override
  Widget build(BuildContext context) {
       
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark
        ),
      ),
      body: RefreshIndicator(
        onRefresh: cargarClima,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional(8, -0.1),
                  child: Container(
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blueAccent
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-8, -0.1),
                  child: Container(
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blueAccent
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0, -1.22),
                  child: Container(
                    height: 300,
                    width: 600,
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent
                    ),
                  ),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 200.0, sigmaY: 200.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.transparent
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        temp == null
                        ? "cargando temperatura"
                        : "Temperatura: ${temp!.toStringAsFixed(1)} Celsius",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        "PUNTA ARENAS",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Image.asset("$icono"),
                      SizedBox(height: 5),
                      Center(
                        child: Text(
                          (temp == null || des == null)
                            ? ""
                            : "${temp!.toStringAsFixed(0)}°C",
                          style: TextStyle(fontSize: 70, color: Colors.white),
                        ),
                      ),
                      Center(
                        child: Text(
                          (temp == null || des == null)
                            ? ""
                            : des!.toUpperCase(),
                          style: TextStyle(fontSize: 22, color: Colors.white), 
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),  
        ),
      ),
        
    );
  }
}