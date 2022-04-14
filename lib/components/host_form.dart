import 'package:flutter/material.dart';
import 'package:remote_mouse/views/controller_view.dart';



class HostForm extends StatefulWidget {
  const HostForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HostFormState();
}

class _HostFormState extends State<HostForm> {
  String? socketUri;
  final _formKey = GlobalKey<FormState>();

  String? validateUri(String? value) {
    if (value == null) return 'Введите адрес в поле ввода';
    if (value.isEmpty) return 'Адрес сервера не введен!';
    if (!Uri.parse(value).isAbsolute) {
      return 'Введите корректный адрес сервера!';
    }
    socketUri = value;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 8,
            ),
            child: TextFormField(
              validator: (value) => validateUri(value),
              textAlign: TextAlign.center,
              textDirection: TextDirection.ltr,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Введите адрес сервера',
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 8
              ),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Подключение...'),
                      ),
                    );
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ControllerPage(
                            socketUri: socketUri,
                          ),
                        ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Некорректный адрес сервера!'),
                      ),
                    );
                  }
                },
                child: const Text('Подключиться'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}