
import 'package:flutter/material.dart';

import '../../../../core/model/network_log_model.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/typography.dart';


class NetworkLogListItem extends StatelessWidget {

  const NetworkLogListItem({
    required this.networkLogModel
  });

  final NetworkLogModel networkLogModel;

  Icon? getIconByStatusCode(int statusCode) {

    if (statusCode >= 100 && statusCode < 200) {
      return Icon(
        Icons.info_outline,
        color: AppColors.orange,
        size: 35,
      );
    }

    if (statusCode >= 200 && statusCode < 300) {
      return const Icon(
        Icons.check,
        color: Colors.green,
        size: 35,

      );
    }

    if (statusCode >= 300 && statusCode < 400) {
      return const Icon(
        Icons.forward,
        color: AppColors.orange,
        size: 35,

      );
    }

    if (statusCode >= 400 && statusCode < 500) {
      return const Icon(
        Icons.cancel_outlined,
        color: AppColors.orange,
        size: 35,

      );
    }

    if (statusCode >= 500 && statusCode < 600) {
      return const Icon(
        Icons.error_outline,
        color: AppColors.orange,
        size: 35,

      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.gray.shade50,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 16.0,
        ),
        child: Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                if (networkLogModel.statusCode != null) getIconByStatusCode(networkLogModel.statusCode!) ?? const SizedBox.shrink(),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Text(
                    '${networkLogModel.statusCode}',
                    style: AppTypography.font24Regular.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 24.0
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${networkLogModel.httpMethod}',
                    style: AppTypography.font24Regular.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 100,
                    child: Text(
                      '${networkLogModel.requestUrl}',
                      style: AppTypography.font14Regular.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                      overflow: TextOverflow.fade,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}