import 'dart:async';
import 'dart:convert';

import 'package:compute/src/features/home/home.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
          _elapsedTime = (_stopwatch.elapsedMilliseconds / 1000)
              .toStringAsFixed(3);
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
      return await compute(
        (String response) => _parser(response),
        response,
      );
    } catch (error) {
      throw Exception(error);
    } finally {
      _stopTimer();
    }
  }

  static List<Beer> _parser(String response) {
    final List json = jsonDecode(response) as List;
    return List<Beer>.from(
      json.map((data) => Beer.fromJson(data)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Compute loading time : $_elapsedTime')),
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
