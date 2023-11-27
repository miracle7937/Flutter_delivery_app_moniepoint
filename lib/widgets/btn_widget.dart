import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrangeCircularButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const OrangeCircularButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  _OrangeCircularButtonState createState() => _OrangeCircularButtonState();
}

class _OrangeCircularButtonState extends State<OrangeCircularButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 50,
      child: Material(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.orange,
        child: InkWell(
          borderRadius: BorderRadius.circular(20.0),
          onTap: widget.onPressed,
          child: Center(
            child: Text(
              widget.text,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
