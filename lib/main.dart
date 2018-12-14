import 'package:flutter/material.dart';
import 'package:flutter_graphs/ConsumoPorMes.dart';
import 'package:flutter_graphs/GraficoConsumoMensal.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        inputDecorationTheme: InputDecorationTheme(),
        primarySwatch: Colors.red,
      ),
      home: new MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var data = [
    new ConsumoPorMes(exercicio: 'Janeiro/2018', valor: 8110.65, consumo: 12.5),
    new ConsumoPorMes(exercicio: 'Fevereiro/2018', valor: 110.0, consumo: 11),
    new ConsumoPorMes(exercicio: 'Março/2018', valor: 50.0, consumo: 18),
    new ConsumoPorMes(exercicio: 'Abril/2018', valor: 80.0, consumo: 11),
    new ConsumoPorMes(exercicio: 'Maio/2018', valor: 60.0, consumo: 13),
    new ConsumoPorMes(exercicio: 'Junho/2018', valor: 88.0, consumo: 17),
    new ConsumoPorMes(exercicio: 'Julho/2018', valor: 64.0, consumo: 16),
    new ConsumoPorMes(exercicio: 'Agosto/2018', valor: 111.0, consumo: 14),
    new ConsumoPorMes(exercicio: 'Setembro/2018', valor: 100.0, consumo: 9),
    new ConsumoPorMes(exercicio: 'Outubro/2018', valor: 68.0, consumo: 11),
    new ConsumoPorMes(exercicio: 'Novembro/2018', valor: 71.0, consumo: 14),
    new ConsumoPorMes(exercicio: 'Dezembro/2018', valor: 95.0, consumo: 16),
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Histórico de Consumo"),
        centerTitle: true,
      ),
      body: new Center(
        child: GraficoConsumoMensal(
          data: data,
        ),
      ),
    );
  }
}
