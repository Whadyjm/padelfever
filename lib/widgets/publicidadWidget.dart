import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../theme/text.dart';

class PublicidadWidget extends StatelessWidget {
  const PublicidadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: Radius.circular(12),
      dashPattern: [6, 3],
      color: Colors.grey.shade400,
      strokeWidth: 4,
      child: Container(
        height: 100,
        width: MediaQuery.sizeOf(context).width,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Espacio publicitario', style: AppText.subtitleStyle(Colors.grey.shade400),),
          ],
        ),
      ),
    );
  }
}
