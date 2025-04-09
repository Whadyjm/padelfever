import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:padelpoint/providers/btn_provider.dart';
import 'package:provider/provider.dart';

import '../theme/colors.dart';
import '../theme/text.dart';

class BlurBox extends StatefulWidget {
  const BlurBox({super.key});

  @override
  State<BlurBox> createState() => _BlurBoxState();
}

class _BlurBoxState extends State<BlurBox> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final btnProvider = Provider.of<BtnProvider>(context, listen: false);
    final blur = btnProvider.blur;
    return Visibility(
      visible: blur ? true : false,
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                height: 50,
                minWidth: 200,
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'PadelFever',
                      style: TextStyle(
                        fontFamily: 'sf-pro-display',
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Icon(Icons.sports_tennis_rounded, color: AppColors.secondaryColorLight, size: 50,)
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                height: 50,
                minWidth: 200,
                color: AppColors.primaryColorLight,
                onPressed: () {},
                child: Text(
                  'Iniciar sesión',
                  style: AppText.smallTextStyle(Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                height: 50,
                minWidth: 200,
                color: AppColors.primaryColorLight,
                onPressed: () async {
                  setState(() {
                    _isLoading = true; // Show loading indicator
                  });
                  try {
                    await Future.delayed(Duration(seconds: 2));
                  } finally {
                    setState(() {
                      _isLoading = false;
                      btnProvider.hideBlur();
                    });
                  }
                },
                child:
                    _isLoading
                        ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 4,))
                        : Text(
                          'Invitado',
                          style: AppText.smallTextStyle(Colors.white),
                        ),
              ),
            ),
          ],
        ),
      ).frosted(blur: 5, frostColor: Colors.black),
    );
  }
}
