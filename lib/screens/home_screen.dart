import 'dart:ui';

//import 'package:clima_app/data/model/clima_response.dart';
import 'package:clima_app/bloc/clima_bloc.dart';
import 'package:clima_app/presentation/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

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
                      SizedBox(height: 50,),
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
                  Container(
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 0, 100, 0.1),
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("Mínima"),
                            Text("${data["tempmin"]}"),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Máxima"),
                            Text("${data["tempmax"]}"),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Viento", style: TextStyle(),),
                            Text("12Km/hr"),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Humedad"),
                            Text("93%"),
                          ],
                        ),
                      ],
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
