import 'dart:io';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:http/http.dart' as http;


class ControllerPage extends StatefulWidget {
  const ControllerPage({Key? key, required this.socketUri})
      : super(key: key);

  final String? socketUri;

  @override
  State<ControllerPage> createState() => _ControllerPageState();
}


class _ControllerPageState extends State<ControllerPage> {
  WebSocketChannel? channel;

  Future<Uri?> connectRemoteServer(String? serverUri) async {
    if (serverUri != null) {
      final client = http.Client();
      final request = http.Request(
          'GET', Uri.parse(serverUri)
      )..followRedirects = false;
      http.StreamedResponse response = await client.send(request);
      print(response.statusCode);
      if (response.statusCode == 308) {
        return Uri.parse(serverUri).replace(
          scheme: 'ws',
          path: response.headers['location'],
        );
      }
      throw Exception('Failed to connect!');
    }
    return null;
  }

  Future<WebSocketChannel> connectWebSocket(Uri? serverUri) async {
    if (serverUri != null) {
      WebSocketChannel connectionChannel = WebSocketChannel.connect(
        serverUri,
      );
      connectionChannel.sink.add('data');
      if (connectionChannel.closeCode != null) {
        throw Error();
      }
      if (connectionChannel.closeReason != null) {
        throw Error();
      }
      return connectionChannel;
    }
    throw Error();
  }

  @override
  void initState() {
    super.initState();
    connectRemoteServer(widget.socketUri)
        .then((webSocketUri) =>
        connectWebSocket(webSocketUri)
            .then((connectionChannel) =>
            setState(() {
              channel = connectionChannel;
            }),
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: false,
      appBar: AppBar(
        title: const Text('Connection'),
      ),
      body: Center(
        child: Column(
            children: [
              Text('Nothing to do here...'),
            ],
        ),
      ),
    );
  }
}
