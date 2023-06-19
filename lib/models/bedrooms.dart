class BedRoom {
  int id;
  String name;

  BedRoom({required this.id, required this.name});
}

List<BedRoom> bedRoom = [
  BedRoom(id: 0, name: 'Studio'),
  BedRoom(id: 1, name: '1BR'),
  BedRoom(id: 2, name: '2BR'),
  BedRoom(id: 3, name: '3BR'),
  BedRoom(id: 4, name: '4BR'),
  BedRoom(id: 5, name: '5BR'),
  BedRoom(id: 6, name: '5BR+'),
];
Map<int, BedRoom> bedRoomMap = {
  0: BedRoom(id: 0, name: 'Studio'),
  1: BedRoom(id: 1, name: '1BR'),
  2: BedRoom(id: 2, name: '2BR'),
  3: BedRoom(id: 3, name: '3BR'),
  4: BedRoom(id: 4, name: '4BR'),
  5: BedRoom(id: 5, name: '5BR'),
  6: BedRoom(id: 6, name: '5BR+'),
};
