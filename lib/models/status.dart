part 'status.g.dart';

class Status {
  int id;
  String name;

  Status({required this.id, required this.name});

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);

  Map<String, dynamic> toJson() => _$StatusToJson(this);
}
// var status={
//   '1':Status(id:1,name:"Completed"),
//   '0':Status(id:0,name: "Off Plan"),
// };
// var statusList=[
//
//   Status(id:1,name:"Completed"),
//   Status(id:0,name: "Off Plan"),
// ];
