import 'package:flutter/material.dart';

class IndroductionCard extends StatefulWidget {
  final String imageUrl;
  final double imageHeight;
  final double imageWidth;
  const IndroductionCard({super.key, 
    required this.imageUrl,
    required this.imageHeight,
    required this.imageWidth,
  });

  @override
  State<StatefulWidget> createState() {
    return IndroductionCardState();
  }
}

class IndroductionCardState extends State<IndroductionCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image(
          image: AssetImage(widget.imageUrl),
          height: widget.imageHeight,
          width: widget.imageWidth,
          fit: BoxFit.contain,
        ),
      ],
    );
  }
}
