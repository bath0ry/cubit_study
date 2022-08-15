import 'package:cubit_study/color_cubit.dart';
import 'package:cubit_study/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(providers: [
        BlocProvider<CounterCubit>(
          create: (BuildContext context) => CounterCubit(),
        ),
        BlocProvider<ColorCubit>(
          create: (BuildContext context) => ColorCubit(),
        ),
      ], child: const MyHomePage()),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter"),
      ),
      body: Column(
        children: [
          Center(
            child: BlocConsumer<ColorCubit, Color>(listener: (context, state) {
              if (state == Colors.purple) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  duration: Duration(milliseconds: 500),
                  content: Text('Cor é roxa'),
                ));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  duration: Duration(milliseconds: 500),
                  content: Text('Cor é preta'),
                ));
              }
            }, builder: (context, state) {
              return GestureDetector(
                onTap: () => context.read<ColorCubit>().switchColor(),
                child: Container(
                  color: state,
                  width: 200,
                  height: 200,
                ),
              );
            }),
          ),
        ],
      ),
      // BlocBuilder<CounterCubit, int>(
      //   builder: (context, state) {
      //     return Text('$state');
      //   },
      // ),
      floatingActionButton: Row(
        children: [
          FloatingActionButton(
            heroTag: 'kadabra',
            onPressed: () => context.read<CounterCubit>().decrement(),
            child: Icon(Icons.remove),
          ),
          FloatingActionButton(
            onPressed: () => context.read<CounterCubit>().increment(),
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
