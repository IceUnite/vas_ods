import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vas_ods/core/theme/app_colors.dart';
import 'package:vas_ods/core/widgets/app_bar_widget.dart';
import 'package:vas_ods/feature/app/routing/route_path.dart' show AppRoute;
import 'package:vas_ods/feature/main_page/presentation/cubit/order_cubit.dart';
import 'package:vas_ods/feature/main_page/presentation/widgets/category_column.dart';
import 'package:vas_ods/feature/main_page/presentation/widgets/user_card.dart';

import '../bloc/order_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  static String name = AppRoute.mainScreenPath;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black50,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BreakfastAppBarWidget(
            selectTime: TimeOfDay.fromDateTime(DateTime.now()),
          ),
          Expanded(
            child: BlocBuilder<OrderCubit, OrderCubitState>(
              builder: (context, state) {
                final groupedList = state.groupedApplicationList;

                if (groupedList.isEmpty) {
                  return const Center(child: Text('Заявки не найдены'));
                }

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: groupedList.asMap().entries.map((entry) {
                      final index = entry.key;
                      final group = entry.value ?? [];

                      return Row(
                        children: [
                          CategoryColumn(
                            title: group.first.document.name ?? '',
                            cards: group.map((item) {
                              return UserCard(
                                userId: item.idUser,
                                userName: '${item.user.name ?? ''} ${item.user.middleName ?? ''}',
                                orderDate: item.createdAt ?? '',
                                phoneNumber: item.user.phone,
                                warningMessage: null,
                                documentId: item.idDoc,
                                status: item.status,
                                id: item.id,
                              );
                            }).toList(),
                          ),
                          if (index != groupedList.length - 1)
                            const VerticalDivider(
                              color: AppColors.white500,
                              thickness: 1,
                              width: 20,
                            ),
                        ],
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
