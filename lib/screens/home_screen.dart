import 'dart:ui';

//import 'package:clima_app/data/model/clima_response.dart';
import 'package:clima_app/bloc/clima_bloc.dart';
import 'package:clima_app/presentation/text_styles.dart';
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${data["ciudad"]}",
                  style: EstiloTextos.titulo
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
              image: DecorationImage(
                image: AssetImage("assets/fondo/few_clouds_dia.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              color: Color.fromRGBO(0, 0, 0, 0.2),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                        "${data["temp"].toStringAsFixed(0)}°C",
                        style: EstiloTextos.estilo1,
                      ),
                      Text(
                        data["des"],
                        style: EstiloTextos.estilo2
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Container(
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 0, 100, 0.1),
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.arrow_upward),
                              Text("Mínima", style: EstiloTextos.estilo3),
                              Text("${data["tempmin"]}°", style: EstiloTextos.estilo3),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.arrow_downward),
                              Text("Máxima", style: EstiloTextos.estilo3),
                              Text("${data["tempmax"]}°", style: EstiloTextos.estilo3),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.water_drop),
                              Text("Humedad", style: EstiloTextos.estilo3),
                              Text("${data["humedad"]}%", style: EstiloTextos.estilo3),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.air),
                              Text("Viento", style: EstiloTextos.estilo3),
                              Text("${data["viento"]}km", style: EstiloTextos.estilo3),
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
        );
      },
    );
  }
}
