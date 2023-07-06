import 'package:hive/hive.dart';
part 'local_data_model.g.dart';

@HiveType(typeId: 1)
class GetLocalDataModel {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String description;
  @HiveField(3)
  dynamic language;
  @HiveField(4)
  int openIssuesCount;
  @HiveField(5)
  int watchersCount;

  GetLocalDataModel({
    required this.id,
    required this.name,
    required this.description,
    required this.watchersCount,
    required this.language,
    required this.openIssuesCount,
  });

  factory GetLocalDataModel.fromJson(Map<String, dynamic> json) =>
      GetLocalDataModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        watchersCount: json["watchers_count"],
        language: json["language"],
        openIssuesCount: json["open_issues_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "watchers_count": watchersCount,
        "language": language,
        "open_issues_count": openIssuesCount,
      };
}
