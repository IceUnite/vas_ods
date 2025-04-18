
import 'package:flutter/material.dart';

import '../../../../core/model/log_model.dart';
import '../../mad_inspector.dart';
import '../widgets/log_details.dart';
import '../widgets/log_list_item.dart';



class Logs extends StatelessWidget {

  final List<LogModel> items = MadInspectorLogger.logs.reversed.toList();

   Logs({super.key});

  @override
  Widget build(BuildContext context) {
    // return SizedBox.shrink();
    return ListView.separated(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute<void>(
                    builder: (BuildContext context) => LogDetails(
                      logModel: items[index],
                    )
                )
            );
          },
          child: LogListItem(
            logModel: items[index],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Divider(),
        );
      },
    );
  }
}