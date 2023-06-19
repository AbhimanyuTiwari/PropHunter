import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prophunter/constant.dart';
import 'package:prophunter/size_config.dart';
import 'package:prophunter/widgets/buttons.dart';
import 'package:prophunter/widgets/text.dart';

Future bottomSheet(context, List items, String text, Function(List) onExit) {
  List selectedItems = [];
  return showModalBottomSheet(
      context: context,
      elevation: 10,
      isDismissible: false,
      isScrollControlled: true,
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      backgroundColor: const Color(0xff1B1B1B),
      // <-- SEE HERE
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: SizeConfig.screenHeight * .90,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Stack(
                          alignment: Alignment.topRight,
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Center(
                              child: Container(
                                alignment: Alignment.center,
                                width: SizeConfig.screenWidth * .4,
                                height: 6,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: fadeWhite,
                                ),
                              ),
                            ),
                            IconButton(
                                padding: const EdgeInsets.all(0),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  CupertinoIcons.clear,
                                  color: fadeWhite,
                                )),
                          ],
                        ),
                        Text(
                          text,
                          style: headingWhite20,
                        ),
                        defaultSpace2x,
                        // SearchBar(),
                        defaultSpace3x,
                        ...List.generate(
                            items.length,
                            (index) => CheckboxListTile(
                                  shape: Border(top: BorderSide(color: fadeWhite, width: 0.5)),
                                  title: Text(
                                    items[index].name,
                                    style: titleWhite18,
                                  ),
                                  //    <-- label
                                  value: selectedItems.contains(items[index]),
                                  checkboxShape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                  activeColor: Colors.blue,
                                  onChanged: (newValue) {
                                    if (newValue!) {
                                      selectedItems.add(items[index]);
                                    } else {
                                      selectedItems.remove(items[index]);
                                    }
                                    setState(() {});
                                  },
                                ))
                      ],
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      child: DefaultButton(
                        text: "DONE",
                        press: () {
                          onExit(selectedItems);
                          Navigator.pop(context);
                        },
                      )),
                ],
              ),
            ),
          );
        });
      });
}
