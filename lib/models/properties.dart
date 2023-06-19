class Properties {
  String name;
  String communityName;
  int communityId;
  int id;
  List installment;
  double lat;
  double lan;
  List<String> images;
  List<String> media;
  String propertyType;
  int propertyTypeId;

  Properties({
    required this.lat,
    required this.name,
    required this.media,
    required this.communityId,
    required this.images,
    required this.installment,
    required this.propertyType,
    required this.communityName,
    required this.id,
    required this.lan,
    required this.propertyTypeId,
  });

// static List<Properties> dynamicToList(List items) {
//   return items.map((item) =>
//       Properties(id: item.id,
//           typeId: item.typeId,
//           name: item.name,
//           communityId: item.communityId,
//           installments: item.installments,
//           location: item.location,
//           images: item.images)).toList();
// }
}
