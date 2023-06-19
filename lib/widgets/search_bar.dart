import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:prophunter/constant.dart';
import 'package:prophunter/models/properties.dart';
import 'package:prophunter/models/units.dart';
import 'package:prophunter/provider/propertyProvider.dart';
import 'package:prophunter/screens/property_list/property_list.dart';
import 'package:prophunter/services/queries.dart';
import 'package:prophunter/widgets/loading_dialog.dart';
import 'package:prophunter/widgets/text.dart';
import 'package:provider/provider.dart';

import '../utils/keyboard.dart';

class SearchBar extends StatelessWidget {
  SearchBar({Key? key}) : super(key: key);
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      margin: const EdgeInsets.all(10),
      height: 55,
      decoration: BoxDecoration(
        color: kFadeBlack,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 9,
            child: TypeAheadField(
              hideSuggestionsOnKeyboardHide: true,
              noItemsFoundBuilder: (context) => ListTile(
                  title: Text('No item found', style: titleWhite20.copyWith(color: fadeWhite))),
              textFieldConfiguration: TextFieldConfiguration(
                autofocus: false,
                controller: search,
                style: titleWhite18,
                onSubmitted: (val) async {
                  KeyboardUtil.hideKeyboard(context);
                  await searchNavigation(context, val);
                },
                decoration: const InputDecoration(border: InputBorder.none, hintText: 'Search'),
              ),
              suggestionsCallback: (pattern) async {
                return Provider.of<PropertyProvider>(context, listen: false)
                    .getSuggestions(pattern);
              },
              itemBuilder: (context, Properties suggestion) {
                return ListTile(
                  title: Text(
                    suggestion.name,
                    style: titleWhite18,
                  ),
                  subtitle: Text(
                    '${suggestion.communityName}',
                    style: titleWhite15.copyWith(color: fadeWhite),
                  ),
                );
              },
              onSuggestionSelected: (Properties suggestion) async {
                showLoaderDialog(context);
                List<Units> unitList = await CustomQuery().getUnitsByPropertyId(suggestion.id);
                Navigator.pop(context);
                pushNewScreen(context, screen: PropertyList(unitList: unitList));
              },
            ),
          ),
          Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () async {
                  await searchNavigation(context, search.text);
                },
                child: SvgPicture.asset(
                  'assets/icons/search_bar.svg',
                  color: Colors.white,
                ),
              ))
        ],
      ),
    );
  }

  Future searchNavigation(context, String query) async {
    KeyboardUtil.hideKeyboard(context);
    showLoaderDialog(context);
    List<Properties> propertyList = [];
    List<Properties> prop = Provider.of<PropertyProvider>(context, listen: false).propertyList;
    propertyList.addAll(prop);
    propertyList
        .retainWhere((property) => property.name.toLowerCase().contains(query.toLowerCase()));
    List<Units> unitList = [];
    if (propertyList.isNotEmpty)
      unitList = await CustomQuery().getUnitByPropertyList(propertyList, context);
    Navigator.pop(context);
    pushNewScreen(context, screen: PropertyList(unitList: unitList));
  }
}
