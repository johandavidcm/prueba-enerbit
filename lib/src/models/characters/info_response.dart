import 'package:equatable/equatable.dart';

class Info extends Equatable {
  const Info({
    required this.count,
    required this.pages,
    this.next,
    this.prev,
  });

  final int count;
  final int pages;
  final String? next;
  final String? prev;

  @override
  List<Object?> get props => [
        count,
        pages,
        next,
        prev,
      ];

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        count: json["count"],
        pages: json["pages"],
        next: json["next"],
        prev: json["prev"],
      );
}
