import 'package:charts_common/common.dart' as chartCommon;
import 'package:flutter/material.dart';
import 'package:flutter_graphs/ConsumoPorMes.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class GraficoConsumoMensal extends StatefulWidget {
  List<ConsumoPorMes> data = [];

  GraficoConsumoMensal({Key key, @required this.data}) : super(key: key);

  @override
  _GraficoConsumoMensalState createState() => _GraficoConsumoMensalState();
}

class _GraficoConsumoMensalState extends State<GraficoConsumoMensal> {

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  final formatter = new NumberFormat("###,##0.00", "pt-br");

  pintaOMaior() {
    ConsumoPorMes maiorConsumo;

    for (ConsumoPorMes atual in widget.data) {
      if (maiorConsumo == null) {
        maiorConsumo = atual;
      }

      if (atual.consumo > maiorConsumo.consumo ||
          atual.consumo == maiorConsumo.consumo) {
        maiorConsumo = atual;
      }
    }

    maiorConsumo.color = Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    pintaOMaior();

    var series = [
      new charts.Series(
        id: "barChart",
        domainFn: (ConsumoPorMes consumoPorMes, _) =>
            consumoPorMes.exercicio.substring(0, 3),
        measureFn: (ConsumoPorMes consumoPorMes, _) => consumoPorMes.consumo,
        colorFn: (ConsumoPorMes consumoPorMes, _) => charts.Color(
            r: consumoPorMes.color.red,
            g: consumoPorMes.color.green,
            b: consumoPorMes.color.blue,
            a: consumoPorMes.color.alpha),
        labelAccessorFn: (ConsumoPorMes consumoPorMes, _) =>
            consumoPorMes.consumo.toStringAsFixed(0),
        data: widget.data,
      ),
    ];

    var chart = new charts.BarChart(
      series,
      animate: true,
      vertical: false,
      barRendererDecorator: new charts.BarLabelDecorator(
          insideLabelStyleSpec: chartCommon.TextStyleSpec(
            color: chartCommon.Color.white,
          ),
          labelAnchor: chartCommon.BarLabelAnchor.end),
      primaryMeasureAxis:
          new charts.NumericAxisSpec(renderSpec: new charts.NoneRenderSpec()),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 10, left: 16),
              child: new Text("Últimos 12 meses",
                  style: const TextStyle(
                      color: const Color(0xff555555),
                      fontWeight: FontWeight.w700,
                      fontFamily: "Roboto",
                      fontStyle: FontStyle.normal,
                      fontSize: 18.0)),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 16),
          child: SizedBox(
            height: 200.0,
            child: chart,
          ),
        ),
        Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Text("Competência",
                            style: const TextStyle(
                                color: const Color(0xff999999),
                                fontWeight: FontWeight.w400,
                                fontFamily: "Roboto",
                                fontStyle: FontStyle.normal,
                                fontSize: 12.0))),
                    Expanded(
                        child: Text("Consumo",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: const Color(0xff999999),
                                fontWeight: FontWeight.w400,
                                fontFamily: "Roboto",
                                fontStyle: FontStyle.normal,
                                fontSize: 12.0))),
                    Expanded(
                        child: Text("Valor",
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                                color: const Color(0xff999999),
                                fontWeight: FontWeight.w400,
                                fontFamily: "Roboto",
                                fontStyle: FontStyle.normal,
                                fontSize: 12.0))),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Container(
                            height: 2.0,
                            color: const Color(0x80d8d8d8),
                            margin: const EdgeInsets.only(top: 1))),
                  ],
                )
              ],
            )),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(top: 10),
            itemCount: widget.data.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 10),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(widget.data[index].exercicio,
                            style: const TextStyle(
                                color: const Color(0xff555555),
                                fontWeight: FontWeight.w300,
                                fontFamily: "Roboto",
                                fontStyle: FontStyle.normal,
                                fontSize: 14.0)),
                      ),
                      Expanded(
                          child: Text(
                              widget.data[index].consumo.toStringAsFixed(0) +
                                  " m³",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: const Color(0xff555555),
                                  fontWeight: FontWeight.w300,
                                  fontFamily: "Roboto",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14.0))),
                      Expanded(
                        child: Text(
                            "R\$ " + formatter.format(widget.data[index].valor).toString(),
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                                color: const Color(0xff555555),
                                fontWeight: FontWeight.w400,
                                fontFamily: "Roboto",
                                fontStyle: FontStyle.normal,
                                fontSize: 14.0)),
                      ),
                    ],
                  ));
            },
          ),
        )
      ],
    );
  }
}
