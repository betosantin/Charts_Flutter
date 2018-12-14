import 'dart:ui';

import 'package:flutter/material.dart';

class ConsumoPorMes {

  final String exercicio;
  final double valor;
  final double consumo;
  Color color;

  ConsumoPorMes({@required this.exercicio, @required this.valor, @required this.consumo, Color color}){
    this.color = color ?? Colors.green;
  }

}