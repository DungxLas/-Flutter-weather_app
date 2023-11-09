import 'package:flutter/material.dart';

class Input extends StatefulWidget {
  const Input({
    super.key,
    required this.city,
    required this.fetchWeatherData,
  });
  final String city;
  final Function(String) fetchWeatherData;

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.city;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          textAlign: TextAlign.center,
          decoration: const InputDecoration(hintText: 'Enter city name'),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              widget.fetchWeatherData(_controller.text);
              _controller.clear();
            });
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
