

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/enum/server_type.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/radio_switch.dart';
import '../../../../main.dart';
import '../../../app/routing/route_path.dart';



List<String> servers = ['https://gw.dev.apeironspace.ru/','https://gw.test.apeironspace.ru/','https://gw.stage.apeironspace.ru/','https://gw.apeironspace.online/'];

class SelectServerMenu extends StatefulWidget {
  const SelectServerMenu({required this.onSelect, Key? key}) : super(key: key);
  final void Function(ServerType type) onSelect;

  @override
  _DebugMenuState createState() => _DebugMenuState();
}

class _DebugMenuState extends State<SelectServerMenu> {
  int startIndex = 1;
  int currentIndex = 1;

  @override
  void initState()  {
    currentIndex =  prefs.getInt('selectServer') ?? 1;
    startIndex =  prefs.getInt('selectServer') ?? 1;
    // currentIndex = context.read<PersistCubit>().state.serverType!.index;
    super.initState();
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Text(
                  "Выберите сервер",
                  style: AppTypography.font28Regular.copyWith(color: AppColors.white, fontWeight: FontWeight.w700),
                ),
              ),
              RadioSwitch(
                currentIndex: currentIndex,
                items: ServerType.values
                    .map((ServerType v) => RadioItem(
                          title: v.toString(),
                          description: "v.toDiningString",
                        ))
                    .toList(),
                onSelected: (int i) {
                  setState(() {
                    currentIndex = i;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: ElevatedButton(
                  onPressed: () {
                    if (currentIndex != startIndex) {
                      widget.onSelect(ServerType.values[currentIndex]);
                      prefs.setString('selectServerString', servers[currentIndex]);
                      context.goNamed(AppRoute.authScreenPath);
                    } else {
                      context.goNamed(prefs.getString('previousRouteName')!);
                    }
                  },
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(const Size(335, 53)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    )),
                    backgroundColor: MaterialStateProperty.all(AppColors.black100),
                  ),
                  child: const Text(
                    'Выбрать',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: ElevatedButton(
                  onPressed: () {
                    prefs.setInt('selectServer', startIndex);
                    context.goNamed(prefs.getString('previousRouteName')!);
                    // context.goNamed(AppRoute.breakfastScreenPath);
                  },
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(const Size(335, 53)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    )),
                    backgroundColor: MaterialStateProperty.all(AppColors.black100),
                  ),
                  child: const Text(
                    'Закрыть',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
