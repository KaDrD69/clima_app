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

  Future<void> _refresh(){
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
                  onPressed: (){},
                  icon: Icon(Icons.menu),
                  iconSize: 30,
                  color: Colors.white,
                ),
                Text(
                  "${data["ciudad"]}",
                  style: EstiloTextos.titulo
                ),
                IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.search),
                  iconSize: 30,
                  color: Colors.white,
                )
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
              child:RefreshIndicator(
                onRefresh: _refresh,
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
                          style: EstiloTextos.textoGrande,
                        ),
                        Text(
                          data["des"],
                          style: EstiloTextos.textoPequeno1
                        ),
                      ],
                    ),
                    SizedBox(height: 80),
                    Container(
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(0, 0, 0, 0.094),
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.arrow_downward),
                                SizedBox(width: 5),
                                Text("Mínima", style: EstiloTextos.textoPequeno2),
                                Spacer(),
                                Text("${data["tempmin"]}°", style: EstiloTextos.textoPequeno2),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.arrow_upward),
                                SizedBox(width: 5),
                                Text("Máxima", style: EstiloTextos.textoPequeno2),
                                Spacer(),
                                Text("${data["tempmax"]}°", style: EstiloTextos.textoPequeno2),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.water_drop),
                                SizedBox(width: 5),
                                Text("Humedad", style: EstiloTextos.textoPequeno2),
                                Spacer(),
                                Text("${data["humedad"]}%", style: EstiloTextos.textoPequeno2),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.air),
                                SizedBox(width: 5),
                                Text("Viento", style: EstiloTextos.textoPequeno2),
                                Spacer(),
                                Text("${data["viento"]}km", style: EstiloTextos.textoPequeno2),
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
