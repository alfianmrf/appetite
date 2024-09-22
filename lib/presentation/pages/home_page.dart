import 'package:appetite/core/constants/constants.dart';
import 'package:appetite/core/extensions/extensions.dart';
import 'package:appetite/core/functions/transition.dart';
import 'package:appetite/presentation/pages/pages.dart';
import 'package:appetite/presentation/widgets/widgets.dart';
import 'package:appetite/presentation/blocs/blocs.dart';
import 'package:appetite/presentation/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _groupMenuNotifier = ValueNotifier<String>('all');
  final _searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _groupMenuNotifier.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void selectedGroupMenu(String value) {
    _groupMenuNotifier.value = value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        foregroundColor: Colors.white,
        title: const Text(
          AppStrings.title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            decoration: const BoxDecoration(
              color: AppColor.primary,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
            ),
            child: SearchBoxWidget(
              controller: _searchController,
              onChanged: (val) {
                context.read<MenuBloc>().add(SearchMenu(val));
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<MenuBloc, MenuState>(
                builder: (context, state) {
                  if (state is MenuInitial) {
                    return const Center(child: CircularProgressIndicator(color: AppColor.primary));
                  }
                  if (state is MenuLoaded) {
                    return Column(
                      children: <Widget>[
                        SizedBox(
                          width: double.infinity,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: ValueListenableBuilder<String>(
                              valueListenable: _groupMenuNotifier,
                              builder: (BuildContext context, String value, Widget? child) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(width: 10),
                                    GestureDetector(
                                      onTap: (){},
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                        child: InkWell(
                                          onTap: (){
                                            _searchController.clear();
                                            FocusScope.of(context).unfocus();
                                            context.read<MenuBloc>().add(const SelectCategory(-1));
                                          },
                                          borderRadius: BorderRadius.circular(16),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: state.selectedCategoryId < 0 ? AppColor.primary : AppColor.primary.withOpacity(0.5),
                                              borderRadius: BorderRadius.circular(16),
                                            ),
                                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                            child: const Text(
                                              'All',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    for (Category category in state.categories)
                                      GestureDetector(
                                        onTap: (){},
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                          child: InkWell(
                                            onTap: (){
                                              _searchController.clear();
                                              FocusScope.of(context).unfocus();
                                              context.read<MenuBloc>().add(SelectCategory(category.id));
                                            },
                                            borderRadius: BorderRadius.circular(16),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: state.selectedCategoryId == category.id ? AppColor.primary : AppColor.primary.withOpacity(0.5),
                                                borderRadius: BorderRadius.circular(16),
                                              ),
                                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                              child: Text(
                                                category.name.capitalize(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                textAlign: TextAlign.center,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    const SizedBox(width: 10),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            child: GridView.builder(
                              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                crossAxisSpacing: 15,
                                mainAxisExtent: 200,
                              ),
                              itemCount: state.filteredMenus.length,
                              itemBuilder: (BuildContext ctx, index) {
                                return MenuWidget(
                                  image: state.filteredMenus[index].image,
                                  name: state.filteredMenus[index].name,
                                  price: state.filteredMenus[index].price.formatRupiah(),
                                  onPressed: () {
                                    goTo(context, DetailPage(menu: state.filteredMenus[index]));
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Center(child: Text('Something went wrong!'));
                  }
                }
            ),
          ),
        ],
      ),
    );
  }
}
