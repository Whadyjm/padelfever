import 'package:blur/blur.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:padelpoint/providers/btn_provider.dart';
import 'package:padelpoint/widgets/authWidgets/authTextField.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../alertDialogs/authAlertDialogs/emptyFieldsDialog.dart';
import '../../services/firebase_services.dart';
import '../../theme/colors.dart';
import '../../theme/text.dart';
import 'loginAlertDialog.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({super.key});

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  bool _isLoading = false;
  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final btnProvider = Provider.of<BtnProvider>(context, listen: true);

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
                    Icon(
                      Icons.sports_tennis_rounded,
                      color: AppColors.secondaryColorLight,
                      size: 50,
                    ),
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
                onPressed: () {
                  LoginAlertDialog.showLoginAlertDialog(context, btnProvider);
                },
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
                  await guestProcess(btnProvider);
                },
                child:
                    _isLoading
                        ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 4,
                          ),
                        )
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


  Future<void> guestProcess(BtnProvider btnProvider) async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Future.delayed(Duration(seconds: 2));
    } finally {
      setState(() {
        _isLoading = false;
        btnProvider.hideBlur();
        btnProvider.setGuest();
      });
    }
  }
}
