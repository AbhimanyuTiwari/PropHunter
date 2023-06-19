import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:prophunter/models/bedrooms.dart';
import 'package:prophunter/models/property_type.dart';
import 'package:prophunter/provider/propertyProvider.dart';
import 'package:provider/provider.dart';

import '../models/communities.dart';
import '../models/properties.dart';
import '../models/status.dart';
import '../models/units.dart';

class CustomQuery {
  CollectionReference propertyRef = FirebaseFirestore.instance.collection('property');
  CollectionReference unitRef = FirebaseFirestore.instance.collection('unit');

  Future<List<Units>> getUnitsByPropertyId(int id) async {
    QuerySnapshot data = await unitRef.where('propertyId', isEqualTo: id).get();
    List unitList = data.docs.map((e) => e.data()).toList();
    List<Units> units = unitList
        .map((e) => Units(
              status: e['status'],
              position: e['position'],
              size: e['size'],
              price: e['price'],
              bedrooms: e['bedroom'],
              propertyId: e['propertyId'],
              statusId: e['statusId'],
              name: e['name'],
              id: e['id'] ?? 0,
            ))
        .toList();
    return units;
  }

  Future<List<Units>> getUnitByCommunityId(int communityId, context) async {
    List<Properties> propertyList =
        Provider.of<PropertyProvider>(context, listen: false).propertyList;

    List<int> resultList = [];
    for (int i = 0; i < propertyList.length; i++) {
      if (communityId == propertyList[i].communityId) resultList.add(propertyList[i].id);
    }

    QuerySnapshot data = await unitRef.where('propertyId', whereIn: resultList).get();
    List unitList = data.docs.map((e) => e.data()).toList();
    print(unitList);
    List<Units> units = unitList
        .map((e) => Units(
              status: e['status'],
              position: e['position'],
              size: e['size'],
              price: e['price'],
              bedrooms: e['bedroom'],
              propertyId: e['propertyId'],
              statusId: e['statusId'],
              name: e['name'],
              id: e['id'] ?? 0,
            ))
        .toList();
    return units;
  }

  Future<List<Units>> getUnitByPropertyList(
      List<Properties> propertyList, BuildContext context) async {
    List<int> id = propertyList.map((e) => e.id).toList();
    QuerySnapshot data = await unitRef.where('propertyId', whereIn: id).get();
    List unitList = data.docs.map((e) => e.data()).toList();
    List<Units> units = unitList
        .map((e) => Units(
              status: e['status'],
              position: e['position'],
              size: e['size'],
              price: e['price'],
              bedrooms: e['bedroom'],
              propertyId: e['propertyId'],
              statusId: e['statusId'],
              name: e['name'],
              id: e['id'] ?? 0,
            ))
        .toList();
    return units;
  }

  Future<List<Units>> getPriceBetween(int high, int low) async {
    QuerySnapshot data = await unitRef
        .where('price', isGreaterThanOrEqualTo: low)
        .where('price', isLessThanOrEqualTo: high)
        .get();
    List unitList = data.docs.map((e) => e.data()).toList();
    List<Units> units = unitList
        .map((e) => Units(
              status: e['status'],
              position: e['position'],
              size: e['size'],
              price: e['price'],
              bedrooms: e['bedroom'],
              propertyId: e['propertyId'],
              statusId: e['statusId'],
              name: e['name'],
              id: e['id'] ?? 0,
            ))
        .toList();
    return units;
  }

  Future<List<Units>> getPropertySizeBetween(int high, int low) async {
    QuerySnapshot data = await unitRef
        .where('size', isGreaterThanOrEqualTo: low)
        .where('size', isLessThanOrEqualTo: high)
        .get();
    List unitList = data.docs.map((e) => e.data()).toList();
    List<Units> units = unitList
        .map((e) => Units(
              status: e['status'],
              position: e['position'],
              size: e['size'],
              price: e['price'],
              bedrooms: e['bedroom'],
              propertyId: e['propertyId'],
              statusId: e['statusId'],
              name: e['name'],
              id: e['id'] ?? 0,
            ))
        .toList();
    return units;
  }

  Future<List<Units>> getPropertyStatus(List<Status> status) async {
    QuerySnapshot data = await unitRef
        .where('statusId', whereIn: List.generate(status.length, (index) => status[index].id))
        .get();
    List unitList = data.docs.map((e) => e.data()).toList();
    List<Units> units = unitList
        .map((e) => Units(
              status: e['status'],
              position: e['position'],
              size: e['size'],
              price: e['price'],
              bedrooms: e['bedroom'],
              propertyId: e['propertyId'],
              statusId: e['statusId'],
              name: e['name'],
              id: e['id'] ?? 0,
            ))
        .toList();
    return units;
  }

  Future<List<Units>> getByPropertyType(List<PropertyType> propertyType, context) async {
    List<int> propertyTypeId = propertyType.map((e) => e.id).toList();
    List<Properties> property = Provider.of<PropertyProvider>(context, listen: false).propertyList;
    List<int> propertyId = [];
    for (var e in property) {
      if (propertyTypeId.contains(e.propertyTypeId)) {
        propertyId.add(e.id);
      }
    }
    if (propertyId.isEmpty) return [];
    QuerySnapshot data = await unitRef.where('propertyId', whereIn: propertyId).get();
    List unitList = data.docs.map((e) => e.data()).toList();
    List<Units> units = unitList
        .map((e) => Units(
              status: e['status'],
              position: e['position'],
              size: e['size'],
              price: e['price'],
              bedrooms: e['bedroom'],
              propertyId: e['propertyId'],
              statusId: e['statusId'],
              name: e['name'],
              id: e['id'] ?? 0,
            ))
        .toList();
    return units;
  }

  Future<List<Units>> getComplexQuery(
      List<Properties> properties,
      List<Community> community,
      List<Status> status,
      List<PropertyType> propertyType,
      int priceHigh,
      int priceLow,
      List<BedRoom> bedRooms,
      context) async {
    List<int> bedRoomList = bedRooms.map((e) => e.id).toList();
    CollectionReference unitRef = FirebaseFirestore.instance.collection('unit');
    List<int> propertyTypeId = propertyType.map((e) => e.id).toList();
    List<int> propertyInt = properties.map((e) => e.id).toList();
    List<int> communityId = community.map((e) => e.id).toList();
    List<int> statusId = status.map((e) => e.id).toList();
    print(bedRoomList);
    List<Properties> propertyList =
        Provider.of<PropertyProvider>(context, listen: false).propertyList;
    List<int> resultList = [];
    for (int i = 0; i < propertyList.length; i++) {
      if (propertyTypeId.isNotEmpty && !propertyTypeId.contains(propertyList[i].propertyTypeId))
        continue;
      if (communityId.isNotEmpty && !communityId.contains(propertyList[i].communityId)) continue;
      if (propertyInt.isNotEmpty && !propertyInt.contains(propertyList[i].id)) continue;
      resultList.add(propertyList[i].id);
    }
    print(priceHigh);
    Query query = unitRef
        .where('price', isGreaterThanOrEqualTo: priceLow)
        .where('price', isLessThanOrEqualTo: priceHigh);
    if (resultList.isNotEmpty) {
      print(resultList);
      query = query.where('propertyId', whereIn: resultList);
      QuerySnapshot data = await query.get();

      List unitList = data.docs.map((e) => e.data()).toList();
      List<Units> units = unitList
          .map((e) => Units(
                status: e['status'],
                position: e['position'],
                size: e['size'],
                price: e['price'],
                bedrooms: e['bedroom'],
                propertyId: e['propertyId'],
                statusId: e['statusId'],
                name: e['name'],
                id: e['id'] ?? 0,
              ))
          .toList();
      print(units.length);
      if (statusId.isNotEmpty) {
        units = units.where((element) => statusId.contains(element.statusId)).toList();
      }

      if (bedRoomList.isNotEmpty) {
        units = units.where((element) => bedRoomList.contains(element.bedrooms)).toList();
      }
      return units;
    } else if (status.isNotEmpty) query = query.where('status', whereIn: statusId);

    QuerySnapshot data = await query.get();
    List unitList = data.docs.map((e) => e.data()).toList();
    List<Units> units = unitList
        .map((e) => Units(
              status: e['status'],
              position: e['position'],
              size: e['size'],
              price: e['price'],
              bedrooms: e['bedroom'],
              propertyId: e['propertyId'],
              statusId: e['statusId'],
              name: e['name'],
              id: e['id'] ?? 0,
            ))
        .toList();
    List<Units> unitsList = units;
    if (bedRoomList.isNotEmpty) {
      unitsList = units.where((element) => bedRoomList.contains(element.bedrooms)).toList();
    }
    return unitsList;
  }
}
