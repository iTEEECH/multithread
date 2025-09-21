import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isolates/src/features/home/home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Timer.
  late final Stopwatch _stopwatch;
  late final Timer _timer;
  String? _elapsedTime;

  // Future.
  late final Future<List<Beer>> _future;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _future = _fetchData('assets/data.json');
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  void _startTimer() {
    _stopwatch = Stopwatch()..start();
    _timer = Timer.periodic(const Duration(milliseconds: 10), (_) {
      if (mounted && _stopwatch.isRunning) {
        setState(() {
          _elapsedTime = (_stopwatch.elapsedMilliseconds / 1000).toStringAsFixed(3);
        });
      }
    });
  }

  void _stopTimer() {
    if (_timer.isActive) _timer.cancel();
    if (_stopwatch.isRunning) _stopwatch.stop();
  }

  Future<List<Beer>> _fetchData(String path) async {
    try {
      final String response = await rootBundle.loadString(path);
      return await _parser(response);
    } catch (error) {
      throw Exception(error);
    } finally {
      _stopTimer();
    }
  }

  Future<List<Beer>> _parser(String response) async {
    final ReceivePort receivePort = ReceivePort();
    try {
      await Isolate.spawn(_isolate, [receivePort.sendPort, response]);
      return await receivePort.first;
    } catch (error) {
      throw Exception(error);
    } finally {
      receivePort.close();
    }
  }

  static Future<void> _isolate(List args) async {
    final [SendPort sendPort, String response] = args;
    final List json = jsonDecode(response) as List;
    Isolate.exit(sendPort, List<Beer>.from(json.map((data) => Beer.fromJson(data))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Isolates loading time : $_elapsedTime')),
      body: FutureBuilder<List<Beer>>(
        future: _future,
        builder: (_, AsyncSnapshot<List<Beer>> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error was occurred.'));
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (_, int index) {
                final Beer? beer = snapshot.data?[index];
                return ListTile(
                  title: Text('Name ${beer?.name}'),
                  subtitle: Text('Type ${beer?.type}'),
                  trailing: Text('Origin ${beer?.country}'),
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator.adaptive());
        },
      ),
    );
  }
}
