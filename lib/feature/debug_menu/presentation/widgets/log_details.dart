
import 'package:flutter/material.dart';

import '../../../../core/model/log_model.dart';
import 'log_item_card.dart';



class LogDetails extends StatelessWidget {

  const LogDetails({super.key, 
    required this.logModel
  });

  final LogModel logModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: <Widget>[
            LogItemCard(
              title: 'Name',
              details: logModel.name,
            ),
            LogItemCard(
              title: 'Type',
              details: logModel.type,
            ),
            LogItemCard(
              title: 'Timestamp',
              details: logModel.timestamp,
            ),
            LogItemCard(
              title: 'Message',
              details: logModel.details.toString(),
            ),
            LogItemCard(
              title: 'Stack Trace',
              details: '${logModel.stackTrace?.toString()}',
            ),
          ],
        )
    );
  }
}