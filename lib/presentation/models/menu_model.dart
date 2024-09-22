import 'package:equatable/equatable.dart';

class Menu extends Equatable {
  final int id;
  final String name;
  final String image;
  final String description;
  final num price;
  final int category;

  const Menu({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.category,
  });

  @override
  List<Object> get props => [id, name, image, description, price, category];
}