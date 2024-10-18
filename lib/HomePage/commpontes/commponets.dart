import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mirror_wall/HomePage/HomePage.dart';
import 'package:mirror_wall/provider/mirror_provider.dart';
import 'package:provider/provider.dart';

class RadioButton extends StatelessWidget {
  String title, getSearch;

  RadioButton({super.key, required this.title, required this.getSearch});

  @override
  Widget build(BuildContext context) {
    var mirrorProviderTrue = Provider.of<MirrorProvider>(context, listen: true);
    var mirrorProviderFalse =
        Provider.of<MirrorProvider>(context, listen: true);
    return RadioListTile(
      value: title,
      title: Text(title),
      groupValue: mirrorProviderTrue.selectedSearchEngine,
      onChanged: (value) {
        mirrorProviderFalse.changeSearchEngin(value!);
        mirrorProviderFalse.getSearchEngin(getSearch);
        Navigator.pop(context);
      },
    );
  }
}

PopupMenuItem bottemPopupMenu1(String title, int value) {
  return PopupMenuItem(
      value: value,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.bookmark_add_outlined),
          SizedBox(
            width: 5,
          ),
          Text(title)
        ],
      ));
}

Future<void>? refreshWebAll(MirrorProvider mirrorProviderTrue) {
  return webViewController?.loadUrl(
      urlRequest: URLRequest(url: WebUri(mirrorProviderTrue.webUrl)));
}
