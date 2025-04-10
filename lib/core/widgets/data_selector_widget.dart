import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:vas_ods/core/theme/app_colors.dart' show AppColors;
import 'package:vas_ods/core/theme/typography.dart' show AppTypography;
import 'package:vas_ods/feature/main_page/presentation/bloc/profile_bloc.dart';

class DataSelectorWidget extends StatefulWidget {
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
        BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            return ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 150,
                maxWidth: 230,
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
                    DateFormat('EEE, d MMMM', 'ru_RU').format(DateTime.now()),
                    style: AppTypography.font32Regular.copyWith(
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
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      selectedDate = picked;
    }
  }

}