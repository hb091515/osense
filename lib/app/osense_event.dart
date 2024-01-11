abstract class OsenseEvent {}

class OsenseSubmit extends OsenseEvent {
  OsenseSubmit({
    required this.name,
    required this.selectFruit,
  });
  final String name;
  final String selectFruit;
}
