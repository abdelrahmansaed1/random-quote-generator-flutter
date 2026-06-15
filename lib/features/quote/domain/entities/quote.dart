import 'package:equatable/equatable.dart';

class Quote extends Equatable {
  final String content;
  final String author;

  const Quote({required this.content, required this.author});

  @override
  List<Object?> get props => [content, author];
}
