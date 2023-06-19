class FeaturedCommunity {
  String heading;
  String subheading;
  String image;
  List<String> amenities;
  int communityId;

  FeaturedCommunity(
      {required this.image,
      required this.subheading,
      required this.heading,
      required this.communityId,
      required this.amenities});
}

Map<String, String> amenitiesList = {
  'fitness_center': 'Fitness Center',
  'swimming_pool': 'Swimming Pool',
  'parking': 'Parking',
  "security": 'Gated Security',
  'laundry': 'Laundry',
  'playground': "Playground",
  'school': 'School',
  'shopping_center': "Shopping Center"
};
