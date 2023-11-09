import 'package:flutter/material.dart';

class Info extends StatefulWidget {
  const Info({
    super.key,
    required this.city,
    required this.temp,
    required this.condDetail,
    required this.condIcon,
  });
  final String city, temp, condDetail, condIcon;

  @override
  State<Info> createState() => _InputState();
}

class _InputState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;

    return Column(
      children: [
        Text(
          widget.city,
          style: const TextStyle(
            fontSize: 30,
          ),
        ),
        Text(
          '${widget.temp}°K',
          style: const TextStyle(
            fontSize: 48,
          ),
        ),
        ImageIcon(
          NetworkImage(
              'https://openweathermap.org/img/wn/${widget.condIcon}@2x.png'),
          size: 0.3 * width,
        ),
        Text(
          widget.condDetail,
          style: const TextStyle(
            fontSize: 30,
          ),
        ),
      ],
    );
  }
}
