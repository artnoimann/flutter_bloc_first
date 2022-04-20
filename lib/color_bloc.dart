import 'dart:async';

import 'package:flutter/material.dart';

enum ColorEvent { event_red, event_green, event_amber }

class ColorBloc {
  //прослушиваем выходной поток для нового состояния в конструкторе
  ColorBloc() {
    //подписываемся на поток и обрабатываем события со стороны UI
    // и трансформируем их в новый state
    _inputEventController.stream.listen((_mapEventToState));
  }

  //цвет по умолчанию
  Color _color = Colors.red;

  //входные данные для потока с типом ColorEvent, тк принимаем события
  final _inputEventController = StreamController<ColorEvent>();

  StreamSink<ColorEvent> get inputEventSink => _inputEventController.sink;

  //выходные данные для state с типом Color, тк отдаем конкретный цвет
  final _outputStateController = StreamController<Color>();

  Stream<Color> get outputStateStream => _outputStateController.stream;

  //метод который преобразовывает события в новое состояние
  void _mapEventToState(ColorEvent event) {
    if (event == ColorEvent.event_red)
      _color = Colors.red;
    else if (event == ColorEvent.event_green)
      _color = Colors.green;
    else if (event == ColorEvent.event_amber)
      _color = Colors.amber;
    else
      throw Exception('Wrong event type');

    //после того как получили новое состояние, добавляем во входной поток
    _outputStateController.sink.add(_color);
  }

  //по окончанию работы потоков их нужно закрыть
  void dispose() {
    _inputEventController.close();
    _outputStateController.close();
  }
}
