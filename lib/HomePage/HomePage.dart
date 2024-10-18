import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mirror_wall/MirrorPage/MirrorPage.dart';
import 'package:mirror_wall/provider/mirror_provider.dart';
import 'package:provider/provider.dart';

import 'commpontes/commponets.dart';

InAppWebViewController? webViewController;
TextEditingController searchController = TextEditingController();

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var mirrorProviderTrue = Provider.of<MirrorProvider>(context, listen: true);
    var mirrorProviderFalse =
        Provider.of<MirrorProvider>(context, listen: true);

    return Scaffold(
        appBar: AppBar(
          title:
          TextField(
            controller: searchController,
            onSubmitted: (value) {
              print(
                  '-------------------------------------------------------------------->');
              print(value);

              webViewController?.loadUrl(
                urlRequest: URLRequest(
                    url: WebUri("https://www.google.com/search?q=$value")),
              );
            //  refreshWebAll(mirrorProviderTrue);
            },
          ),


          
          actions: [
            IconButton(onPressed: () {
              refreshWebAll(mirrorProviderTrue);
            }, icon: Icon(Icons.refresh)),
            PopupMenuButton(
              itemBuilder: (context) => [
                bottemPopupMenu1("History", 0),
                bottemPopupMenu1("Search Engine", 1),
              ],
              onSelected: (item) {
                if (item == 1) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      String data=searchController.text;
                      return AlertDialog(
                        title: Text("Search Engine"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,

                          children: [
                            RadioButton(title: "Google",getSearch:data,),
                            RadioButton(title: "Yahoo",getSearch:data),
                            RadioButton(title: "bing",getSearch: data,),
                            RadioButton(title: "Duck Duck Do",getSearch: data,),

                          ],
                        ),
                      );
                    },
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog.fullscreen(
                        child: Column(
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("X Dismiss")),
                           Consumer<MirrorProvider>(builder: (context, value, child) =>  Expanded(
                             child: ListView.builder(
                               itemCount:
                               mirrorProviderTrue.userHistory.length,

                               itemBuilder: (context, index) {
                                 final data =
                                 mirrorProviderTrue.userHistory[index];
                                 final url =
                                 data.split('---').sublist(0, 1).join(' ');
                                 final search =
                                 data.split('---').sublist(1, 2).join(' ');
                                 print("-----");
                                 print("-----$url");

                                 ListTile(
                                   onTap: () {
                                     searchController.text=search;
                                     webViewController!.loadUrl(urlRequest: URLRequest(url: WebUri(url)));

                                     Navigator.pop(context);
                                   },
                                   title: Text(search),
                                   subtitle: Text(url),
                                   trailing: IconButton(
                                       onPressed: () {
                                         mirrorProviderFalse.deleteHistory(index);
                                       },
                                       icon: Icon(Icons.delete)),
                                 );
                               },
                             ),
                           ),
                           )
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            )
          ],
        ),
        body: Column(
          children: [
            (mirrorProviderTrue.isLoading)
                ? LinearProgressIndicator(
              color: Colors.blue.shade600,
            ):

            Expanded(

              child: InAppWebView(
                initialUrlRequest: URLRequest(
                  url: WebUri(mirrorProviderTrue.webUrl),
                ),
                onWebViewCreated: (controller) {
                  webViewController = controller;
                },
                onLoadStart: (controller, url) {
                  mirrorProviderFalse.updateLoadingStatus(true);
                },
                onLoadStop: (controller, url) {
                  mirrorProviderFalse.updateLoadingStatus(false);
                  String getSearch = searchController.text != ""
                      ? searchController.text
                      : mirrorProviderTrue.selectedSearchEngine;
                  mirrorProviderTrue.addHistory(url.toString(), getSearch);
                },
              ),
            )
          ],
        ),
        bottomSheet:


        InAppWebView(
          initialUrlRequest: URLRequest(
            url: WebUri("https://www.google.com/search?q="),
          ),
          onWebViewCreated: (controller) {
            webViewController = controller;
          },
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      mirrorProviderTrue.getSearchEngin("");
                      searchController.clear();
                    },
                    icon: const Icon(Icons.home)),
                SizedBox(
                  width: 25,
                ),
                Icon(Icons.bookmark_add_outlined),
                SizedBox(
                  width: 25,
                ),
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    webViewController?.goBack();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {
                    webViewController?.reload();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    webViewController?.goForward();
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
// PopupMenuItem(
// child: Row(
// mainAxisSize: MainAxisSize.min,
// children: [
// Icon(Icons.bookmark_add_outlined),
// SizedBox(
// width: 5,
// ),
// Text(
// "All BookMarks",
// )
// ],
// )),

