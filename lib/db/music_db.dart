import 'package:hive_flutter/hive_flutter.dart';
part 'music_db.g.dart';

@HiveType(typeId: 1)
class Playlistmodel extends HiveObject {
  @HiveField(0)
  List<int> songid;
  @HiveField(1)
  final String name;

  Playlistmodel({
    required this.songid,
    required this.name,
  });
  add(int id) async {
    songid.add(id);
    save();
  }

  deleteData(int id) {
    songid.remove(id);
    save();
  }

  bool isValueIn(int id) {
    return songid.contains(id);
  }
}
