import 'dart:ui';

//import 'package:clima_app/data/model/clima_response.dart';
import 'package:clima_app/bloc/clima_bloc.dart';
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
  final ClimaBloc climaBloc = ClimaBloc();
 
  @override
  void initState(){
    super.initState();
    climaBloc.cargarClima();
  }

  @override
  void dispose() {
    climaBloc.dispose();
    super.dispose();
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 1.2 * kToolbarHeight, 30, 20),
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
                child: StreamBuilder(
                  stream: climaBloc.stream,
                  builder: (context, snapshot) {
                    if(snapshot.hasError){
                      return Text("Error al cargar");
                    }
                    if(!snapshot.hasData){
                      return Text("Cargando temperatura...");
                    }
                    final data = snapshot.data!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "Temperatura: ${data!["temp"].toStringAsFixed(1)} Celsius",
                            style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "PUNTA ARENAS",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.refresh),     
                              onPressed: (){
                                climaBloc.cargarClima();
                              },
                            )
                          ],
                        ),
                        SizedBox(height: 5),
                        Image.asset("${data["icono"]}"),
                        SizedBox(height: 5),
                        Center(
                          child: Text(
                                "${data["temp"].toStringAsFixed(0)}°C",
                                style: TextStyle(fontSize: 70, color: Colors.white),
                          ),
                        ),
                        Center(
                          child: Text(
                                data["des"].toUpperCase(),
                                style: TextStyle(fontSize: 22, color: Colors.white), 
                          ),
                        )
                      ],
                    );
                  }
                ),
              )
            ],
          ),
        ),  
      ),
        
    );
  }
}