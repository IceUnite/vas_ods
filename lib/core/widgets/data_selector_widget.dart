import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:vas_ods/core/theme/app_colors.dart' show AppColors;
import 'package:vas_ods/core/theme/typography.dart' show AppTypography;
import 'package:vas_ods/feature/main_page/presentation/bloc/order_bloc.dart';

class DataSelectorWidget extends StatefulWidget {
  final Function(DateTime)? onDateSelected;

  const DataSelectorWidget({Key? key, this.onDateSelected}) : super(key: key);

  @override
  _MyDateWidgetState createState() => _MyDateWidgetState();
}

class _MyDateWidgetState extends State<DataSelectorWidget> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            // Получаем selectedDate из состояния блока, если оно существует
            DateTime currentSelectedDate = state.selectedDate ?? DateTime.now();

            return ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 150,
                maxWidth: 280,
              ),
              child: IntrinsicWidth(
                child: ElevatedButton(
                  onPressed: () => _selectDate(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                  ),
                  child: Text(
                    DateFormat('EEE, d MMMM', 'ru_RU').format(currentSelectedDate),
                    style: AppTypography.font30Regular.copyWith(
                      color: AppColors.orange100,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
      locale: const Locale('ru', 'RU'),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.orange100, // заголовок и кнопки
              onPrimary: Colors.white, // текст заголовка
              onSurface: Colors.black, // текст внутри календаря
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });

      // 🔥 Добавляем вызов события блока
      context.read<OrderBloc>().add(ChangeDateEvent(date: selectedDate));
      context.read<OrderBloc>().add(GetApplicationsByDateEvent(date: DateFormat('yyyy-MM-dd').format(selectedDate)));

      // вызываем колбэк, если передан
      if (widget.onDateSelected != null) {
        widget.onDateSelected!(picked);
      }
    }
  }
}
