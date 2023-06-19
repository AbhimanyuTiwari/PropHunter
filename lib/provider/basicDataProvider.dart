import 'package:flutter/cupertino.dart';
import 'package:prophunter/models/featuredCommunity.dart';

import '../constant.dart';
import '../models/banner.dart';
import '../models/communities.dart';
import '../models/installments.dart';
import '../models/property_type.dart';
import '../models/status.dart';

class BasicDataProvider extends ChangeNotifier {
  List<Community> _community = [];
  List<PropertyType> _propertyType = [];
  List<Installment> _installment = [];
  List<Banners> _banners = [];
  List<FeaturedCommunity> _featuredCommunity = [];
  Map<int, Status> _statusMap = {};
  List<int> _topPicks = [];
  num priceMin = 0;
  num priceMax = 0;
  num sizeMin = 0;
  num sizeMax = 0;
  bool _maxminLoading = true;
  bool _topPicksLoading = true;
  bool _isAgentLoading = true;
  bool _isUnitLoading = true;
  bool _bannerLoading = true;
  bool _isAllPropertyLoading = true;
  bool _isCommunityLoading = true;
  bool _isPropertyLoading = true;

  bool _isFeaturedCommunityLoading = true;
  bool _isInstallmentLoading = true;

  bool get isTopPicksLoading => _topPicksLoading;

  bool get isPropertyTypeLoading => _isPropertyLoading;

  bool get isPropertyLoading => _isAllPropertyLoading;

  bool get minmaxLoading => _maxminLoading;

  bool get isInstallmentLoading => _isInstallmentLoading;

  List<PropertyType> get getPropertyTypeList => _propertyType;

  List<Installment> get getInstallmentList => _installment;
  List<Status> _statusType = [];
  bool _isStatusLoading = true;

  void changeMinMaxLoading() {
    _maxminLoading = false;
    notifyListeners();
  }

  void addCommunityElement(Community type) {
    _community.add(type);
    communityMap[type.id] = type;
    notifyListeners();
  }

  void addPropertyTypeElement(PropertyType type) {
    _propertyType.add(type);
    propertyTypeMap[type.id] = type;
    notifyListeners();
  }

  void addTopPicks(int propertyId) {
    _topPicks.add(propertyId);
    notifyListeners();
  }

  void addStatusElement(Status type) {
    _statusMap[type.id] = type;
    _statusType.add(type);
    statusMap[type.id] = type;

    notifyListeners();
  }

  void addBanner(Banners banner) {
    _banners.add(banner);
    notifyListeners();
  }

  void addInstallment(Installment type) {
    _installment.add(type);
    notifyListeners();
  }

  void removeCommunityElement(int index) {
    communityMap.remove(_community[index].id);
    _community.removeAt(index);

    notifyListeners();
  }

  void removePropertyTypeElement(int index) {
    propertyTypeMap.remove(_propertyType[index].id);
    _propertyType.removeAt(index);
    notifyListeners();
  }

  void removeTopPicks(int index) {
    _topPicks.removeAt(index);
    notifyListeners();
  }

  void removeStatusElement(int type) {
    statusMap.remove(_statusType[type].id);
    _statusMap.remove([_statusType[type].id]);
    _statusType.removeAt(type);
    notifyListeners();
  }

  void removeInstallment(int type) {
    _installment.removeAt(type);
    notifyListeners();
  }

  void removeBanner(int type) {
    _banners.removeAt(type);
    notifyListeners();
  }

  void createCommunityList(List<Community> prop) {
    for (int i = 0; i < prop.length; i++) communityMap[prop[i].id] = prop[i];
    _community = prop;
    notifyListeners();
  }

  void createTopPicks(List<int> topPick) {
    _topPicks = topPick;
    notifyListeners();
  }

  void createPropertyList(List<PropertyType> prop) {
    for (int i = 0; i < prop.length; i++) propertyTypeMap[prop[i].id] = prop[i];
    _propertyType = prop;
    notifyListeners();
  }

  void createStatusList(List<Status> prop) {
    for (int i = 0; i < prop.length; i++) {
      statusMap[prop[i].id] = prop[i];
    }
    _statusType = prop;
    notifyListeners();
  }

  void createInstallment(List<Installment> prop) {
    _installment = prop;
    notifyListeners();
  }

  void createBanner(List<Banners> prop) {
    _banners = prop;
    notifyListeners();
  }

  void createFeaturedCommunity(List<FeaturedCommunity> prop) {
    _featuredCommunity = prop;
    notifyListeners();
  }

  void changeCommunityElement(String name, int index) {
    _community[index].name = name;
    communityMap[_community[index].id] = _community[index];
    notifyListeners();
  }

  void changePropertyElement(String name, int index) {
    _propertyType[index].name = name;

    propertyTypeMap[_propertyType[index].id] = _propertyType[index];
    notifyListeners();
  }

  void changeStatusElement(String name, int index) {
    _statusType[index].name = name;
    statusMap[_statusType[index].id] = _statusType[index];
    notifyListeners();
  }

  void changeInstallment(int index, {String? name, double? percent, int? days}) {
    _installment[index].name = name ?? _installment[index].name;
    _installment[index].percent = percent ?? _installment[index].percent;
    _installment[index].daysAfter = days ?? _installment[index].daysAfter;
    notifyListeners();
  }

  void changeStatusLoading() {
    _isStatusLoading = false;
    notifyListeners();
  }

  void changeCommunityLoading() {
    _isCommunityLoading = false;
    notifyListeners();
  }

  void changePropertyTypeLoading() {
    _isPropertyLoading = false;
    notifyListeners();
  }

  void changeInstallmentLoading() {
    _isInstallmentLoading = false;
    notifyListeners();
  }

  void changePropertyLoading() {
    _isAllPropertyLoading = false;
    notifyListeners();
  }

  void changeBanner() {
    _bannerLoading = false;
    notifyListeners();
  }

  void changeFeaturedCommunity() {
    _isFeaturedCommunityLoading = false;
    notifyListeners();
  }

  void changeTopPickLoading() {
    _topPicksLoading = false;
    notifyListeners();
  }

  void changeUnitLoading() {
    _isUnitLoading = false;
    notifyListeners();
  }

  void changeAgentLoading() {
    _isAgentLoading = false;
    notifyListeners();
  }

  bool get isStatusLoading => _isStatusLoading;

  List<Status> get getStatusTypeList => _statusType;

  bool get isCommunityLoading => _isCommunityLoading;

  get topPicks => _topPicks;

  bool get isBannerLoading => _bannerLoading;

  bool get isFeaturedCommunityLoading => _isFeaturedCommunityLoading;

  bool get isUnitLoading => _isUnitLoading;

  bool get isAgentLoading => _isAgentLoading;

  List<Banners> get bannerList => _banners;

  List<FeaturedCommunity> get featuredCommunityList => _featuredCommunity;

  List<Community> get getCommunityList => _community;

  List<int> get getTopPick => _topPicks;

  Map<int, Status> get getStatusMap => _statusMap;
}
