import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:memory_info/disk_space.dart';
import 'package:memory_info/memory.dart';
import 'package:memory_info/memory_info.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  Memory? _memory;
  DiskSpace? _diskSpace;
  final _memoryInfoPlugin = MemoryInfoPlugin();


  @override
  void initState() {
    super.initState();
    initPlatformState();
    getMemoryInfo();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _memoryInfoPlugin.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> getMemoryInfo() async {
    Memory? memory;
    DiskSpace? diskSpace;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      memory = await MemoryInfoPlugin().memoryInfo;
      diskSpace = await MemoryInfoPlugin().diskSpace;
    } on PlatformException catch (e) {
      print('error $e');
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    if (memory != null || diskSpace != null) {
      setState(() {
        _memory = memory;
        _diskSpace = diskSpace;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
    String memInfo = encoder.convert(_memory?.toMap());
    String diskInfo = encoder.convert(_diskSpace?.toMap());
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: getMemoryInfo,
          child: const Icon(Icons.update),
        ),
        appBar: AppBar(
          title: const Text('Memory Info Plugin example app'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Running on: $_platformVersion\n'),
              const Text(
                'MemInfo:\n',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
              Text(memInfo),
              const Text('\n--------------------------------------------\n'),
              const Text(
                'DiskInfo:\n',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
              Text(diskInfo)
            ],
          ),
        ),
      ),
    );
  }
}
