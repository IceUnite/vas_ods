import 'package:flutter/material.dart';
import 'package:vas_ods/core/theme/typography.dart';

import '../../../../core/theme/app_colors.dart';

class CategoryColumn extends StatelessWidget {
  final String title;
  final List<Widget> cards;

  const CategoryColumn({
    required this.title,
    required this.cards,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: AppColors.black50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Заголовок категории
          Container(
            margin: EdgeInsets.only(left: 20),
            height: 70,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                textAlign: TextAlign.start,
                maxLines: 6,
                style: AppTypography.font20Raleway.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.white300,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
            height: 2,
            width: double.infinity,
            color: AppColors.white300,
          ),

          // Вот здесь делаем скролл максимально возможным
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: cards.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: cards[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
