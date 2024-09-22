part of 'menu_bloc.dart';

abstract class MenuState extends Equatable {
  const MenuState();

  @override
  List<Object> get props => [];
}

class MenuInitial extends MenuState {}

class MenuLoaded extends MenuState {
  final List<Menu> menus;
  final List<Menu> filteredMenus;
  final List<Category> categories;
  final int selectedCategoryId;

  const MenuLoaded({required this.menus, required this.filteredMenus, required this.categories, required this.selectedCategoryId});

  @override
  List<Object> get props => [menus, filteredMenus, categories, selectedCategoryId];
}