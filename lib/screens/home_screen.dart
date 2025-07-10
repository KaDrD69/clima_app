import 'dart:ui';

//import 'package:clima_app/data/model/clima_response.dart';
import 'package:clima_app/bloc/clima_bloc.dart';
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
            body: Center(child: SpinKitThreeBounce(
              color: Colors.white,
              size: 30
            ))
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
                Text("${data["ciudad"]}", style: TextStyle(color: Colors.white)),
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
                image: AssetImage("assets/fondo/dia.png"),
                fit: BoxFit.cover
              )
            ),
            child: Container(
              color: Color.fromRGBO(0, 0, 0, 0.2),
              child: ListView(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // IconButton(
                        //   icon: Icon(Icons.refresh),
                        //   onPressed: () {
                        //     climaBloc.cargarClima();
                        //   },
                        // ),
                        SizedBox(height: 5),
                        //Image.asset("${data["icono"]}"),
                        SizedBox(height: 5),
                        Center(
                          child: Text(
                            "${data["temp"].toStringAsFixed(0)}°C",
                            style: TextStyle(fontSize: 70, color: Colors.white),
                          ),
                        ),
                        Center(
                          child: Text(
                            data["des"],
                            style: TextStyle(fontSize: 22, color: Colors.white, fontStyle: FontStyle.italic),
                          ),
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
