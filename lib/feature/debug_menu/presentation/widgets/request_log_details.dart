import 'dart:convert';


import 'package:flutter/material.dart';
import '../../../../core/model/network_log_model.dart';
import 'log_item_card.dart';

class RequestLogDetails extends StatelessWidget {

  const RequestLogDetails({super.key, 
    required this.networkLogModel
  });

  final NetworkLogModel networkLogModel;

  String prettyPrintJson(dynamic jsonString) {
    try {
      return _printJson(
          jsonDecode(
              _convertToJsonStringQuotes(raw: jsonString as String)
          )
      );
    } catch(_) {
      return jsonString as String;
    }
  }

  String _convertToJsonStringQuotes({required String raw}) {
    String jsonString = raw;

    /// add quotes to json string
    jsonString = jsonString.replaceAll('{', '{"');
    jsonString = jsonString.replaceAll(': ', '": "');
    jsonString = jsonString.replaceAll(', ', '", "');
    jsonString = jsonString.replaceAll('}', '"}');

    /// remove quotes on object json string
    jsonString = jsonString.replaceAll('"{"', '{"');
    jsonString = jsonString.replaceAll('"}"', '"}');

    /// remove quotes on array json string
    jsonString = jsonString.replaceAll('"[{', '[{');
    jsonString = jsonString.replaceAll('}]"', '}]');

    return jsonString;
  }


  String _printJson(dynamic jsonObject, {int indent = 0}) {
    String prettyString = '';
    if (jsonObject is Map) {
      prettyString += '{\n';
      int index = 0;
      jsonObject.forEach((dynamic key, dynamic value) {
        if (value is String) {
          prettyString += '${" " * (indent + 2)}"$key": "$value"';
        } else {
          prettyString +=
          '${" " * (indent + 2)}"$key": ${_printJson(value, indent: indent + 2)}';
        }
        if (index < jsonObject.length - 1) {
          prettyString += ",\n";
        } else {
          prettyString += "\n";
        }
        index++;
      });
      prettyString += "${" " * indent}}";
    } else if (jsonObject is List) {
      prettyString += "[\n";
      for (var i = 0; i < jsonObject.length; i++) {
        prettyString +=
        "${" " * (indent + 2)}${_printJson(jsonObject[i], indent: indent + 2)}";
        if (i < jsonObject.length - 1) {
          prettyString += ",\n";
        } else {
          prettyString += "\n";
        }
      }
      prettyString += "${" " * indent}]";
    } else {
      prettyString += jsonObject.toString();
    }
    return prettyString;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          LogItemCard(
            title: 'Url',
            details: '${networkLogModel.requestUrl}',
          ),
          LogItemCard(
            title: 'Timestamp',
            details: '${networkLogModel.timestamp}',
          ),
          LogItemCard(
            title: 'Headers',
            details: '${networkLogModel.requestHeaders}',
          ),
          LogItemCard(
            title: 'Body',
            details: prettyPrintJson(networkLogModel.requestBody),
          )
        ],
      ),
    );
  }
}