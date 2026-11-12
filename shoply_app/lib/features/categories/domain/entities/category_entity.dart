import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final int id;
  final String name;
  final String? icon;

  const CategoryEntity({
    required this.id,
    required this.name,
    this.icon,
  });

  @override
  List<Object?> get props => [id, name, icon];
}