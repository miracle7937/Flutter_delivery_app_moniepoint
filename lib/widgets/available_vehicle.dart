import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AvailableVehicle extends StatelessWidget {
  final String? image, title, subtitle;
  const AvailableVehicle({Key? key, this.image, this.title, this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.2,
              blurRadius: 1,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title ?? "",
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      subtitle ?? "",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.16,
                            child: ClipRect(
                              child: Transform.translate(
                                  offset: const Offset(0.0, -20.0),
                                  child: Image.asset(image ?? "")),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
