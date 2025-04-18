import 'package:equatable/equatable.dart';

class LogModel extends Equatable {

  const LogModel({
    required this.name,
    required this.details,
    this.stackTrace,
    required this.type,
    required this.timestamp,
  });

  final String name;
  final Object? details;
  final StackTrace? stackTrace;
  final String type;
  final String timestamp;

  @override
  List<Object?> get props => <Object?>[
    name,
    details,
    stackTrace,
    type,
    timestamp,
  ];
}