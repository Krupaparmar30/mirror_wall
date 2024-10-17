


import 'package:flutter/material.dart';
import 'package:mirror_wall/provider/mirror_provider.dart';
import 'package:provider/provider.dart';

class RadioButton extends StatelessWidget {
  String title,getSearch;
  RadioButton({super.key,required this.title,required this.getSearch});


  @override
  Widget build(BuildContext context) {
    var mirrorProviderTrue = Provider.of<MirrorProvider>(context, listen: true);
    var mirrorProviderFalse =
    Provider.of<MirrorProvider>(context, listen: true);
    return RadioListTile(
      value: title,
      title: Text(title),
      groupValue:
      mirrorProviderTrue.selectedSearchEngine,
      onChanged: (value) {
        mirrorProviderFalse.changeSearchEngin(value!);
        mirrorProviderFalse.getSearchEngin(getSearch);
        Navigator.pop(context);

      },
    );
  }
}
