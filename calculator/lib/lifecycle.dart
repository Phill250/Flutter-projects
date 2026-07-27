import 'package:flutter/material.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

@override
State<CounterScreen> createState(){
  print("createState");
  return _CounterScreenState();
}
}
class _CounterScreenState extends State<CounterScreen>{
  late int _counter;

  void _increment(){
    setState(() {
      _counter += 1;
    });
  }
  @override
  void initState() {
    print("initState");
    _counter = 0;
    super.initState();
  }

  @override
  void didChangeDependencies(){
    print("didChangeDependencies");
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant CounterScreen oldWidget){
    print("didUpdateWidget");
    super.didUpdateWidget(oldWidget);

  }

  @override
  void dispose(){
    print("dispose");
    super.dispose();
  }

  @override
  void deactivate() {
    print("deactivate");
    super.deactivate();
  }

  @override
  Widget build(BuildContext context){
    print("build");
    return Scaffold(
      appBar: AppBar(title: Text("Lifecycle demo"),),
      body: Container(
        child: Column(
        children: [
        Text(_counter.toString()),
        ElevatedButton(onPressed:_increment, child: Text('Increment'))
      ],),
      )
    );

  }


}