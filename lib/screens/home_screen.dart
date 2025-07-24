import 'dart:ui';

//import 'package:clima_app/data/model/clima_response.dart';
import 'package:clima_app/bloc/clima_bloc.dart';
import 'package:clima_app/presentation/text_styles.dart';
import 'package:clima_app/presentation/traduccion_campo_main.dart';
import 'package:clima_app/screens/buscador.dart';
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
                Text("${data["ciudad"]}"),
                IconButton(
                  onPressed: () async {
                    final resultado = await showSearch(
                      context: context,
                      delegate: DataSearch(),
                    );
                    print("aca va la ciudad");
                    if (resultado != null && resultado.isNotEmpty){
                      climaBloc.ciudadSink.add(resultado);
                    }
                  },
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
                  Colors
                      .lightBlue
                      .shade200, //Colors.lightBlue.withValues(alpha: 0.5) para opacidad
                  Color(0xFFf5faff),
                  //    Colors.lightBlueAccent.shade100,
                ],
              ),
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
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("${data["fecha"]}", style: EstiloTextos.fecha),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Row(
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
                                style: EstiloTextos.textoGrande(context),
                              ),
                              //Text("${data["des"]}", style: EstiloTextos.textoPequeno1,),
                              //Text("Sensación Térmica: ${data["termica"]}°", style: EstiloTextos.textoPequeno1),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Mín ${data["tempmin"]}°",
                                style: EstiloTextos.textoMinMax,
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Máx ${data["tempmax"]}°",
                                style: EstiloTextos.textoMinMax,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Sensación Térmica: ${data["termica"]}°",
                                    style: EstiloTextos.textoPequeno1,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${data["des"]}",
                                    style: EstiloTextos.textoPequeno1,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
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
                                Icon(
                                  Icons.wb_sunny,
                                  size: 40,
                                  color: Colors.white70,
                                ),
                                SizedBox(height: 10),
                                Column(
                                  children: [
                                    Text(
                                      "${data["uv"]}",
                                      style: EstiloTextos.textTarjetaGrande,
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      "UV",
                                      style: EstiloTextos.textTarjetaPequeno1,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Icon(
                                  Icons.water_drop,
                                  size: 40,
                                  color: Colors.white70,
                                ),
                                SizedBox(height: 10),
                                Column(
                                  children: [
                                    Text(
                                      "${data["humedad"]}%",
                                      style: EstiloTextos.textTarjetaGrande,
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      "Humedad",
                                      style: EstiloTextos.textTarjetaPequeno1,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Icon(
                                  Icons.air,
                                  size: 40,
                                  color: Colors.white70,
                                ),
                                SizedBox(height: 10),
                                Column(
                                  children: [
                                    Text(
                                      "${data["viento"]}km",
                                      style: EstiloTextos.textTarjetaGrande,
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      "Viento",
                                      style: EstiloTextos.textTarjetaPequeno1,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 1,
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      color: Colors.grey[300],
                    ),
                    Container(
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        //color: Color.fromRGBO(255, 255, 255, 0.898),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${data["nombreDia1"]}",
                                  style: EstiloTextos.textTarjetaPequeno2,
                                ),
                                SizedBox(height: 15),
                                Text(
                                  "${data["nombreDia2"]}",
                                  style: EstiloTextos.textTarjetaPequeno2,
                                ),
                                SizedBox(height: 15),
                                Text(
                                  "${data["nombreDia3"]}",
                                  style: EstiloTextos.textTarjetaPequeno2,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${data["tempminDia1"]}°/${data["tempmaxDia1"]}  ",
                                      style: EstiloTextos.textTarjetaPequeno2,
                                    ),
                                    Icon(Icons.thermostat),
                                  ],
                                ),
                                SizedBox(height: 15),
                                Row(
                                  children: [
                                    Text(
                                      "${data["tempminDia2"]}°/${data["tempmaxDia2"]}  ",
                                      style: EstiloTextos.textTarjetaPequeno2,
                                    ),
                                    Icon(Icons.thermostat),
                                  ],
                                ),
                                SizedBox(height: 15),
                                Row(
                                  children: [
                                    Text(
                                      "${data["tempminDia3"]}°/${data["tempmaxDia3"]}  ",
                                      style: EstiloTextos.textTarjetaPequeno2,
                                    ),
                                    Icon(Icons.thermostat),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "${data["maxWindDia1"]}km",
                                  style: EstiloTextos.textTarjetaPequeno2,
                                ),
                                SizedBox(height: 15),
                                Text(
                                  "${data["maxWindDia2"]}km",
                                  style: EstiloTextos.textTarjetaPequeno2,
                                ),
                                SizedBox(height: 15),
                                Text(
                                  "${data["maxWindDia3"]}km",
                                  style: EstiloTextos.textTarjetaPequeno2,
                                ),
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
