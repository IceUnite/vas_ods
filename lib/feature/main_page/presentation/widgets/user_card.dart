import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vas_ods/core/resources/assets/resources.dart';
import 'package:vas_ods/core/theme/button_style.dart';
import 'package:vas_ods/core/theme/typography.dart';
import 'package:vas_ods/feature/main_page/presentation/cubit/order_cubit.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/ods_alert.dart';

class UserCard extends StatelessWidget {
  final int? userId;
  final String? userName;
  final String? orderDate;
  final String? phoneNumber;
  final int? documentId;
  final String? warningMessage;
  final String? status;

  const UserCard({
    super.key,
    required this.userId,
    required this.userName,
    required this.orderDate,
    required this.phoneNumber,
    required this.documentId,
    required this.warningMessage,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final config = OrderCubit.getStatusUIConfig(status);

    return Container(
      width: 320,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: config.appBarColor,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: [
                SvgPicture.asset(VectorAssets.user, width: 30, height: 30),
                const SizedBox(width: 8),
                Text('User id: $userId', style: const TextStyle(color: Colors.white)),
                const Spacer(),
                Text(userName ?? '', style: const TextStyle(color: Colors.white)),
              ],
            ),
          ),

          // Warning box
          Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFE7DFFF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                SvgPicture.asset(VectorAssets.message, width: 40, height: 40),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    warningMessage ?? '',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),

          Container(height: 1, color: const Color(0xFFE0E0E0)),

          // Date
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: infoTile(VectorAssets.calendar, 'Дата заказа: ${OrderCubit.formatDate(orderDate ?? '')}'),
          ),

          // Phone
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: infoTile(VectorAssets.phone, '  $phoneNumber'),
          ),

          // Document ID
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: infoTile(VectorAssets.documentId, 'ID документа: $documentId'),
          ),

          const SizedBox(height: 12),

          // Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              children: [
                if (status == 'in work') ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
                    child: ElevatedButton(
                      onPressed: () {
                        ApeironSpaceDialog.showActionDialog(
                          context,
                          title: "Отметить документ выполненным?",
                          onPressedConfirm: () {},
                          confirmText: "Да",
                          closeText: 'Нет',
                          onPressedClosed: () {

                          },
                        );
                      },
                      style: AppButtonStyle.primaryStyleOrange.copyWith(
                        minimumSize: WidgetStateProperty.all(const Size.fromHeight(40)),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        ),
                      ),
                      child: Text(
                        'Выполнить',
                        style: AppTypography.font16Raleway.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
                    child: ElevatedButton(
                      onPressed: () {
                        final TextEditingController errorController = TextEditingController();

                        ApeironSpaceDialog.showActionDialog(
                          context,
                          title: "Отметить ошибку в документе?",
                          confirmText: "Нет",
                          closeText: 'Да',
                          onPressedConfirm: () {
                            // Можно обработать ввод текста здесь
                            final userInput = errorController.text;
                            debugPrint("User input: $userInput");

                            // Закрытие диалога — уже происходит в onConfirmTap внутри диалога
                          },
                          onPressedClosed: () {
                            // При закрытии можно также использовать errorController.text
                            final userInput = errorController.text;
                            debugPrint("Closed with input: $userInput");
                          },
                          showTextField: true,
                          textFieldController: errorController,
                        );
                      },
                      style: AppButtonStyle.primaryStyleOrange.copyWith(
                        minimumSize: WidgetStateProperty.all(const Size.fromHeight(40)),
                        backgroundColor: const WidgetStatePropertyAll(AppColors.redLight),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        ),
                      ),
                      child: Text(
                        'Отметить ошибку',
                        style: AppTypography.font16Raleway.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                  ),
                ] else ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
                    child: ElevatedButton(
                      onPressed: null,
                      style: AppButtonStyle.primaryStyleOrange.copyWith(
                        minimumSize: WidgetStateProperty.all(const Size.fromHeight(30)),
                        backgroundColor: WidgetStateProperty.all(config.buttonColor.withOpacity(0.7)),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        ),
                        foregroundColor: WidgetStateProperty.all(AppColors.white),
                      ),
                      child: Text(
                        config.buttonText,
                        style: AppTypography.font16Raleway.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (warningMessage != null && warningMessage!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text(
                        warningMessage!,
                        style: AppTypography.font16Raleway.copyWith(
                          color: AppColors.redLight,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ]
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget infoTile(String icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0))),
      ),
      child: Row(
        children: [
          SvgPicture.asset(icon),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: AppTypography.font16Regular.copyWith(color: AppColors.black),
            ),
          ),
        ],
      ),
    );
  }
}
