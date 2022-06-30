import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:appetite/presentation/models/models.dart';
import 'package:appetite/presentation/data/data.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc() : super(MenuInitial()) {
    on<LoadMenu>((event, emit) async {
      await Future<void>.delayed(const Duration(seconds: 1));

      emit(
        MenuLoaded(
          menus: menus,
          filteredMenus: menus,
          categories: categories,
          selectedCategoryId: -1,
        ),
      );
    });
    on<SearchMenu>((event, emit) async {
      if (state is MenuLoaded) {
        final state = this.state as MenuLoaded;

        List<Menu> filteredMenus = state.menus.where((element) =>
            element.name.toLowerCase().contains(event.keyword.toLowerCase())).toList();

        if (state.selectedCategoryId >= 0) {
          filteredMenus = state.menus.where((element) =>
            element.name.toLowerCase().contains(event.keyword.toLowerCase()) &&
            element.category == state.selectedCategoryId).toList();
        }

        emit(
          MenuLoaded(
            menus: state.menus,
            filteredMenus: filteredMenus,
            categories: state.categories,
            selectedCategoryId: state.selectedCategoryId,
          ),
        );
      }
    });
    on<SelectCategory>((event, emit) async {
      if (state is MenuLoaded) {
        final state = this.state as MenuLoaded;

        List<Menu> filteredMenus = state.menus;

        if (event.categoryId >= 0) {
          filteredMenus = state.menus.where((element) => element.category == event.categoryId).toList();
        }

        emit(
          MenuLoaded(
            menus: state.menus,
            filteredMenus: filteredMenus,
            categories: state.categories,
            selectedCategoryId: event.categoryId,
          ),
        );
      }
    });
  }
}
