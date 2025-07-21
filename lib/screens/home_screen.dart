import 'dart:ui';

//import 'package:clima_app/data/model/clima_response.dart';
import 'package:clima_app/bloc/clima_bloc.dart';
import 'package:clima_app/presentation/text_styles.dart';
import 'package:clima_app/presentation/traduccion_campo_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ClimaBloc climaBloc = ClimaBloc();

  Future<void> _refresh() {
    return climaBloc.cargarClima();
  }

  @override
  void initState() {
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
    return StreamBuilder(
      stream: climaBloc.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error");
        }
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: SpinKitThreeBounce(color: Colors.white, size: 30),
            ),
          );
        }
        final data = snapshot.data!;

        return Scaffold(
          backgroundColor: Colors.black,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.menu, color: Color(0xff333333)),
                  iconSize: 30,
                  color: Colors.white,
                ),
                Text("${data["ciudad"]}", style: EstiloTextos.titulo),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.search, color: Color(0xff333333)),
                  iconSize: 30,
                  color: Colors.white,
                ),
              ],
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarBrightness: Brightness.dark,
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFa6d8f7),
                  Colors.lightBlue.shade200, //Colors.lightBlue.withValues(alpha: 0.5) para opacidad
                  Color(0xFFf5faff)
              //    Colors.lightBlueAccent.shade100,
                ]
              )
              // image: DecorationImage(
              //   image: AssetImage("assets/fondo/few_clouds_dia.png"),
              //   fit: BoxFit.cover,
              ),
            
            child: Container(
              color: Color.fromRGBO(0, 0, 0, 0.2),
              child: RefreshIndicator(
                onRefresh: _refresh,
                child: ListView(
                  children: [
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0xff2C3A47),
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("${data["fecha"]}", style: EstiloTextos.fecha)
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 60),
                            // IconButton(
                            //   icon: Icon(Icons.refresh),
                            //   onPressed: () {
                            //     climaBloc.cargarClima();
                            //   },
                            // ),
                            //Image.asset("${data["icono"]}"),
                            Text(
                              "${data["temp"]}°",
                              style: EstiloTextos.textoGrande,
                            ),
                            Text("${data["des"]}.", style: EstiloTextos.textoPequeno1,),
                            Text("Sensación Térmica: ${data["termica"]}°", style: EstiloTextos.textoPequeno1),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Mínima"),
                            Text("Máxima")
                          ],
                        )
                      ],
                      
                    ),
                    SizedBox(height: 80),
                    Container(
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(44, 58, 71, 0.9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Icon(Icons.arrow_downward, size: 40, color: Colors.white70),
                                SizedBox(height: 10),
                                Column(
                                  children: [
                                    Text("${data["tempmin"]}°", style: EstiloTextos.textTarjetaGrande),
                                    SizedBox(height: 3),
                                    Text("Mín", style:EstiloTextos.textTarjetaPequeno)
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Icon(Icons.arrow_upward, size: 40, color: Colors.white70),
                                SizedBox(height: 10),
                                Column(
                                  children: [
                                    Text("${data["tempmax"]}°", style:EstiloTextos.textTarjetaGrande),
                                    SizedBox(height: 3),
                                    Text("Máx", style:EstiloTextos.textTarjetaPequeno),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Icon(Icons.water_drop, size: 40, color: Colors.white70),
                                SizedBox(height: 10),
                                Column(
                                  children: [
                                    Text("${data["humedad"]}%", style:EstiloTextos.textTarjetaGrande),
                                    SizedBox(height: 3),
                                    Text("Humedad", style:EstiloTextos.textTarjetaPequeno),
                                  ],
                                )
                              ],
                            ),         
                            Column(
                              children: [
                                Icon(Icons.air, size: 40, color: Colors.white70),
                                SizedBox(height: 10),
                                Column(
                                  children: [
                                    Text("${data["viento"]}km", style:EstiloTextos.textTarjetaGrande),
                                    SizedBox(height: 3),
                                    Text("Viento", style:EstiloTextos.textTarjetaPequeno),
                                  ],
                                )
                              ],
                            ),         
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
