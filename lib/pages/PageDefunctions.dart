import 'package:etno_app/models/Defunction.dart';
import 'package:etno_app/store/section.dart';
import 'package:etno_app/utils/WarningWidgetValueNotifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../widgets/appbar_navigation.dart';

class PageDefunctions extends StatefulWidget {
  const PageDefunctions({super.key});
  @override
  State<StatefulWidget> createState() {
    return PageState();
  }
}

class PageState extends State<PageDefunctions> {
  final Section section = Section();

  @override
  void initState() {
    section.getAllDefunctionsByLocality('Bolea');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: false, cardTheme: const CardTheme(color: Colors.white), bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.white)),
      title: 'Page defunctions',
      home: Scaffold(
          appBar: appBarCustom(
            context,
            true,
              'Defunciones',
              Icons.language,
                  () => null,
              null
          ),
          body: SafeArea(
              child: Container(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                      children: [
                        const WarningWidgetValueNotifier(),
                        Observer(
                            builder: (context){
                              if(section.getDefunctions.isNotEmpty){
                                return Expanded(child: ListView(
                                    shrinkWrap: true,
                                    children: section.getDefunctions.map((e) => cardDefunction(context, e)).toList()
                                ));
                              }else {
                                return Container(
                                  height: 550.0,
                                  alignment: Alignment.center,
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text('No hay defunciones para mostrar', style: TextStyle(fontWeight: FontWeight.bold)),
                                        Image.asset('assets/death.png', width: 50.0)
                                      ]
                                  ),
                                );
                              }
                            }
                        )
                      ]
                  )
              )
          )
      ),
    );
  }
}

Widget cardDefunction(BuildContext context, Defunction defunction){
  return SizedBox(
    height: 100,
    child: InkWell(
      onTap: () => showDialogDefunction(context, defunction),
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/pass.png', height: 35.0, width: 35.0),
                const SizedBox(
                    width: 16.0
                ),
                Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(defunction.name!, style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 2.0),
                      Text('Fallecido el ${defunction.deathDate}', style: const TextStyle(color: Colors.grey)),
                      ]
                ),
                const Icon(Icons.chevron_right, size: 40.0)
              ]
          ),
        )
      )
    )
  );
}

showDialogDefunction(BuildContext context, Defunction defunction) => showBottomSheet(enableDrag: true ,context: context, builder: (context){
  return Wrap(
    children: [
      Column(
        children: [
          Container(
              padding: const EdgeInsets.only(top: 15.0),
              child: defunction.imageUrl == null ? Image.asset('assets/pass.png', height: 100.0, width: 100.0) : Image.network(defunction.imageUrl!)
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(15.0),
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 15.0),
                        alignment: Alignment.topLeft,
                        child: Text(defunction.name!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0)),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 15.0),
                        alignment: Alignment.topLeft,
                        child: Text('${defunction.username}', style: const TextStyle(color: Colors.grey, fontSize: 10.0)),
                      ),
                     const SizedBox(height: 4.0),
                      Container(
                        padding: const EdgeInsets.only(left: 15.0),
                        alignment: Alignment.topLeft,
                        child: Text(defunction.deathDate!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0)),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 15.0),
                        alignment: Alignment.topLeft,
                        child: const Text('Día de fallecimiento', style: TextStyle(color: Colors.grey, fontSize: 10.0)),
                      ),
                      const Divider(),
                      Container(
                          padding: const EdgeInsets.only(left: 15.0),
                          alignment: Alignment.topLeft,
                          child: Text(
                              defunction.description!,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0)
                          )
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      )
    ],
  );
});