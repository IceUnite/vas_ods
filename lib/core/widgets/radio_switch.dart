import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../main.dart';
import '../theme/app_colors.dart';
import '../theme/typography.dart';

class RadioItem {
  RadioItem({
    required this.title,
    this.description,
  });

  final String title;
  final String? description;
}

class RadioSwitch extends StatelessWidget {
  const RadioSwitch({
    Key? key,
    required this.items,
    required this.onSelected,
    required this.currentIndex,
  }) : super(key: key);

  final List<RadioItem> items;
  final int currentIndex;
  final void Function(int) onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List<Widget>.generate(
        items.length,
            (int i) => RadioItemWidget(
          title: items[i].title,
          description: items[i].description!,
          isSelected: currentIndex == i,
          onTap: () async{
            await prefs.setInt('selectServer', i);
            onSelected.call(i);
          },
        ),
      ),
    );
  }
}

class RadioItemWidget extends StatelessWidget {
  const RadioItemWidget({
    Key? key,
    required this.title,
    this.description,
    required this.isSelected,
    this.isActive = true,
    this.onTap,
  }) : super(key: key);

  final String title;
  final String? description;
  final bool isSelected;
  final bool isActive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.symmetric(vertical: description != null ? 24 : 18),
        decoration: BoxDecoration(
          color: AppColors.black100,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: AppTypography.font14Regular.copyWith(fontSize: 18, color: isActive ? AppColors.white : AppColors.gray.shade30),
                    ),
                    if (description != null &&  description?.isNotEmpty == true)
                      Text(
                        description!,
                        style:AppTypography.font14Regular.copyWith(fontSize: 14, color: isActive ? AppColors.white : AppColors.gray.shade30),
                      ),
                  ],
                ),
              ),
            ),
            if (isSelected)
              Padding(
                padding: const EdgeInsets.only(right: 22),
                child: CustomPaint(
                  painter: _CirclePainter(
                    AppColors.orange,
                  ),
                  child:  Padding(
                    padding: EdgeInsets.all(2),
                    child: SvgPicture.asset(
                     'assets/images/ic_check.svg',
                      semanticsLabel: 'check-svg',
                      width: 10,
                      height: 10,
                      color: AppColors.orange,
                    )
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _CirclePainter extends CustomPainter {
  _CirclePainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset position = size.center(Offset.zero);

    final Paint borderPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawCircle(position, size.height, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
