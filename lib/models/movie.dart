import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable(
  nullable: false,
  fieldRename: FieldRename.snake,
)
class Movie {
  final int id;
  final String photoUrl;
  final String name;

  Movie({
    this.id,
    this.name,
    this.photoUrl,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  Map<String, dynamic> toJson() => _$MovieToJson(this);
}
