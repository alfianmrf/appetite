part of 'menu_bloc.dart';

abstract class MenuEvent extends Equatable {
  const MenuEvent();

  @override
  List<Object> get props => [];
}

class LoadMenu extends MenuEvent {}

class SearchMenu extends MenuEvent {
  final String keyword;

  const SearchMenu(this.keyword);

  @override
  List<Object> get props => [keyword];
}

class SelectCategory extends MenuEvent {
  final int categoryId;

  const SelectCategory(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}
