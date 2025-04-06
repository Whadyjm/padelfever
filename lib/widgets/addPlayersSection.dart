import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/btn_provider.dart';
import '../theme/colors.dart';
import 'PlayersTextField.dart';

class AddPlayersSection extends StatelessWidget {
  AddPlayersSection({
    super.key,
    required this.controller1,
    required this.controller2,
    this.toggleTextfield,
    this.showTextField = false,
  });

  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  void Function()? toggleTextfield;
  bool showTextField = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Visibility(
            visible: showTextField ? false : true,
            child: SizedBox(
              height: 30,
              width: 50,
              child: FloatingActionButton.extended(
                elevation: 0,
                onPressed: toggleTextfield,
                label: Icon(Icons.add_rounded, color: Colors.white, size: 25),
                backgroundColor: AppColors.primaryColorLight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
