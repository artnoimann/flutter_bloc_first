import 'package:flutter/material.dart';
import 'package:flutter_bloc_first/color_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Bloc F',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ColorBloc _bloc = ColorBloc();

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Bloc F'),
        centerTitle: true,
      ),
      body: Center(
        child: StreamBuilder(
          stream: _bloc.outputStateStream,
          initialData: Colors.amber,
          builder: (context, AsyncSnapshot snapshot) {
            return AnimatedContainer(
              height: 100,
              width: 100,
              color: snapshot.data,
              duration: Duration(microseconds: 50000),
            );
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: () {
              _bloc.inputEventSink.add(ColorEvent.event_amber);
            },
            backgroundColor: Colors.amber,
            label: Text('Default', style: TextStyle(color: Colors.black),),
            icon: Icon(Icons.disabled_by_default, color: Colors.black,),
          ),
          SizedBox(
            width: 110,
          ),
          FloatingActionButton(
            onPressed: () {
              _bloc.inputEventSink.add(ColorEvent.event_red);
            },
            backgroundColor: Colors.red,
            child: Icon(Icons.brush),
          ),
          SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            onPressed: () {
              _bloc.inputEventSink.add(ColorEvent.event_green);
            },
            backgroundColor: Colors.green,
            child: Icon(Icons.brush),
          ),
        ],
      ),
    );
  }
}
