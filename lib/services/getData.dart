import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prophunter/models/user.dart';
import 'package:prophunter/provider/userProvider.dart';
import 'package:provider/provider.dart';

import '../models/banner.dart';
import '../models/communities.dart';
import '../models/featuredCommunity.dart';
import '../models/properties.dart';
import '../models/property_type.dart';
import '../models/status.dart';
import '../models/units.dart';
import '../provider/basicDataProvider.dart';
import '../provider/propertyProvider.dart';
import '../provider/unitProvider.dart';

class SendData {
  CollectionReference appData = FirebaseFirestore.instance.collection('appData');
  CollectionReference propertyRef = FirebaseFirestore.instance.collection('property');
  CollectionReference unitRef = FirebaseFirestore.instance.collection('unit');
  CollectionReference userRef = FirebaseFirestore.instance.collection('user');

  Future getMinMax(context) async {
    BasicDataProvider basicProvider = Provider.of<BasicDataProvider>(context, listen: false);
    var minMaxData = await appData.doc('minmax').get();
    var data = minMaxData;
    basicProvider.priceMax = data['priceMax'];
    basicProvider.priceMin = data['priceMin'];
    basicProvider.sizeMax = data['sizeMax'];
    basicProvider.sizeMin = data['sizeMin'];
    basicProvider.changeMinMaxLoading();
  }

  Future getUser(context) async {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    var data = await userRef.doc(FirebaseAuth.instance.currentUser!.uid).get();
    userProvider
        .setUser(UserData(phoneNo: data['phoneNo'], name: data['name'], email: data['email']));
  }

  Future getStatus(context) async {
    BasicDataProvider basicProvider = Provider.of<BasicDataProvider>(context, listen: false);
    var data = await appData.doc('status').get();
    var statusListMap = data;
    print(statusListMap['statusList']);
    List<Status> statusModelList = statusListMap['statusList']
        .map<Status>((e) => Status.fromJson(e as Map<String, dynamic>))
        .toList();

    basicProvider.createStatusList(statusModelList);

    basicProvider.changeStatusLoading();
  }

  Future getTopPicks(context) async {
    BasicDataProvider basicProvider = Provider.of<BasicDataProvider>(context, listen: false);
    var data = await appData.doc('topPicks').get();
    var statusListMap = data;
    List<int> statusModelList = statusListMap['topPicksList'].map<int>((e) => e as int).toList();
    basicProvider.createTopPicks(statusModelList);
    basicProvider.changeTopPickLoading();
  }

  Future getCommunity(context) async {
    BasicDataProvider basicProvider = Provider.of<BasicDataProvider>(context, listen: false);
    var data = await appData.doc('community').get();
    var communityListMap = data;
    List<Community> communityList = communityListMap['communityList']
        .map<Community>((e) => Community(name: e['name'], id: e['id']))
        .toList();
    basicProvider.createCommunityList(communityList);
    basicProvider.changeCommunityLoading();
  }

  Future getPropertyType(context) async {
    BasicDataProvider basicProvider = Provider.of<BasicDataProvider>(context, listen: false);
    var data = await appData.doc('propertyType').get();
    var propertyTypeMap = data;
    List<PropertyType> propertyTypeList = propertyTypeMap['propertyTypeList']
        .map<PropertyType>((e) => PropertyType(name: e['name'], id: e['id']))
        .toList();
    basicProvider.createPropertyList(propertyTypeList);
    basicProvider.changePropertyTypeLoading();
  }

  Future getProperty(context) async {
    BasicDataProvider basicProvider = Provider.of<BasicDataProvider>(context, listen: false);
    PropertyProvider propertyProvider = Provider.of<PropertyProvider>(context, listen: false);
    QuerySnapshot data = await propertyRef.get();
    List propertyList = data.docs.map((e) => e.data()).toList();
    List<Properties> property = propertyList
        .map((e) => Properties(
            lat: e['lat'],
            media: (e['media'] ?? []).map<String>((element) => element.toString()).toList(),
            name: e['name'],
            communityId: e['communityId'],
            images: e['imageUrl'].map<String>((element) => element.toString()).toList(),
            installment: e['installment'],
            propertyType: e['propertyType'],
            communityName: e['communityName'],
            id: e['id'] ?? 0,
            lan: e['lng'],
            propertyTypeId: e['propertyTypeId']))
        .toList();
    propertyProvider.createPropertyList(property);
    basicProvider.changePropertyLoading();
  }

  Future getUnit(context) async {
    BasicDataProvider basicProvider = Provider.of<BasicDataProvider>(context, listen: false);
    UnitProvider unitProvider = Provider.of<UnitProvider>(context, listen: false);
    QuerySnapshot data = await unitRef.get();
    List unitList = data.docs.map((e) => e.data()).toList();
    List<Units> units = unitList
        .map((e) => Units(
              status: e['status'],
              position: e['position'],
              size: e['size'],
              price: int.parse(e['price']),
              bedrooms: e['bedroom'],
              propertyId: e['propertyId'],
              statusId: e['statusId'],
              name: e['name'],
              id: e['id'] ?? 0,
            ))
        .toList();
    unitProvider.createPropertyList(units);
    unitProvider.changeLoading();
  }

  Future getBanner(context) async {
    BasicDataProvider basicProvider = Provider.of<BasicDataProvider>(context, listen: false);
    var data = await appData.doc('banner').get();
    var propertyTypeMap = data;
    List<Banners> propertyTypeList = propertyTypeMap['bannerList']
        .map<Banners>((e) => Banners(
            imageUrl: e['imageUrl'],
            heading: e['heading'],
            propertyId: e['propertyId'],
            subheading: e['subheading']))
        .toList();
    basicProvider.createBanner(propertyTypeList);
    basicProvider.changeBanner();
  }

  Future getFeaturedCommunity(context) async {
    BasicDataProvider basicProvider = Provider.of<BasicDataProvider>(context, listen: false);
    var data = await appData.doc('featuredCommunity').get();
    var featureCommunityMap = data;
    List<FeaturedCommunity> featuredCommunityList = featureCommunityMap['featuredCommunityList']
        .map<FeaturedCommunity>((e) => FeaturedCommunity(
            image: e['image'],
            heading: e['heading'],
            amenities: e['amenities'].map<String>((e) => e.toString()).toList(),
            communityId: e['communityId'],
            subheading: e['subheading']))
        .toList();
    basicProvider.createFeaturedCommunity(featuredCommunityList);
    basicProvider.changeFeaturedCommunity();
  }
}
