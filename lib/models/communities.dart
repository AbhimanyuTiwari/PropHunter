part 'communities.g.dart';

class Community {
  String name;
  int id;

  Community({required this.name, required this.id});

  static List<Community> dynamicToList(List items) {
    return items.map((item) => Community(name: item.name, id: item.id)).toList();
  }
}
