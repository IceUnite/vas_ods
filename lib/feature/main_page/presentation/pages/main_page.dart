import 'package:flutter/material.dart';
import 'package:vas_ods/core/theme/app_colors.dart';
import 'package:vas_ods/core/widgets/app_bar_widget.dart';
import 'package:vas_ods/feature/app/routing/route_path.dart' show AppRoute;
import 'package:vas_ods/feature/main_page/presentation/widgets/category_column.dart';
import 'package:vas_ods/feature/main_page/presentation/widgets/user_card.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  static String name = AppRoute.mainScreenPath;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final categories = [
      {
        'title': 'Справка о прохождении службы',
        'cards': List.generate(
            5,
            (_) => const UserCard(
                  userId: null,
                  userName: 'Артем',
                  orderDate: '14/12/2000',
                  phoneNumber: '8 964 505 01 91',
                  warningMessage: ' ЗАВТРА НАДА!',
                  documentId: 11,
                )),
      },
      {
        'title': 'Выписка из послужного списка',
        'cards': List.generate(
            5,
            (_) => const UserCard(
                  userId: null,
                  userName: 'Артем',
                  orderDate: '14/12/2000',
                  phoneNumber: '8 964 505 01 91',
                  warningMessage: ' ЗАВТРА НАДА!',
                  documentId: 11,
                )),
      },
      {
        'title': 'Справка об обучении в академии',
        'cards': List.generate(
            1,
            (_) => const UserCard(
                  userId: null,
                  userName: 'Артем',
                  orderDate: '14/12/2000',
                  phoneNumber: '8 964 505 01 91',
                  warningMessage: ' ЗАВТРА НАДА!',
                  documentId: 11,
                )),
      },
      {
        'title': 'Справка о принадлежности к семье военнослужащего',
        'cards': List.generate(
            1,
            (_) => const UserCard(
                  userId: null,
                  userName: 'Артем',
                  orderDate: '14/12/2000',
                  phoneNumber: '8 964 505 01 91',
                  warningMessage: ' ЗАВТРА НАДА!',
                  documentId: 11,
                )),
      },
      {
        'title': 'Справка о принадлежности к семье военнослужащего',
        'cards': List.generate(
            5,
            (_) => const UserCard(
                  userId: null,
                  userName: 'Артем',
                  orderDate: '14/12/2000',
                  phoneNumber: '8 964 505 01 91',
                  warningMessage: ' ЗАВТРА НАДА!',
                  documentId: 11,
                )),
      },
      {
        'title': 'Справка о принадлежности к семье военнослужащего',
        'cards': List.generate(
            2,
            (_) => const UserCard(
                  userId: null,
                  userName: 'Артем',
                  orderDate: '14/12/2000',
                  phoneNumber: '8 964 505 01 91',
                  warningMessage: ' ЗАВТРА НАДА!',
                  documentId: 11,
                )),
      },
      {
        'title': 'Справка о принадлежности к семье военнослужащего',
        'cards': List.generate(
            7,
            (_) => const UserCard(
                  userId: null,
                  userName: '',
                  orderDate: '',
                  phoneNumber: '',
                  warningMessage: '',
                  documentId: null,
                )),
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.black50,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Кастомный AppBar
          BreakfastAppBarWidget(
            selectTime: TimeOfDay.fromDateTime(DateTime.now()),
          ),

          // Горизонтальный скролл по категориям
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: categories.asMap().entries.map((entry) {
                  int index = entry.key;
                  var category = entry.value;
                  return index == categories.length - 1
                      ? CategoryColumn(
                          title: category['title'] as String,
                          cards: category['cards'] as List<Widget>,
                        )
                      : Row(
                          children: [
                            CategoryColumn(
                              title: category['title'] as String,
                              cards: category['cards'] as List<Widget>,
                            ),
                            const VerticalDivider(
                              color: AppColors.white500,
                              thickness: 1,
                              width: 20,
                            ),
                          ],
                        );
                }).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
