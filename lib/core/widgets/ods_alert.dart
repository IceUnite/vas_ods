import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:vas_ods/core/theme/app_colors.dart' show AppColors;
import 'package:vas_ods/core/theme/typography.dart' show AppTypography;


class ApeironSpaceDialog extends StatelessWidget {
  const ApeironSpaceDialog({super.key,
    this.title,
    this.message,
    this.confirmText,
    this.onConfirmTap,
    this.closeText,
    this.content,
    this.onCloseTap,
    this.showTextField = false,
    this.textFieldController,
  });

  final String? title;
  final String? message;
  final String? confirmText;
  final VoidCallback? onConfirmTap;
  final String? closeText;
  final VoidCallback? onCloseTap;
  final Widget? content;

  final bool showTextField;
  final TextEditingController? textFieldController;
  static final Queue<DialogQueueData> _queue = Queue<DialogQueueData>();
  static void showUnknownErrorDialog(BuildContext context) {
    showApiErrorDialog(
      outerContext: context,
      title: "errorSomethingWrong",
      message: "errorComeBackLater",
      showHelp: true,
    );
  }

  static void showPaymentErrorDialog(
      {required BuildContext context, String? title, String? message, String? confirmText}) {
    _handleDialogQueue(
        context: context,
        builder: (BuildContext context) {
          return ApeironSpaceDialog(
            title: title ?? "paymentError",
            message: message ?? "pleaseTryAgain",
            confirmText: confirmText ?? "toRetry",
            onConfirmTap: () => Navigator.of(context).pop(),
          );
        },
        idToCompare: 'showPaymentErrorDialog$title$message$confirmText');
  }

  static void showCardErrorDialog(BuildContext context, String title) {
    _handleDialogQueue(
        context: context,
        builder: (BuildContext context) {
          return ApeironSpaceDialog(
            title: title,
            message: "pleaseTryAgain",
            confirmText: "toRetry",
            onConfirmTap: () => Navigator.of(context).pop(),
          );
        },
        idToCompare: 'showCardErrorDialog$title');
  }

  // static void showConfirmDialog(BuildContext context, AlertDialogConfirmType typeDialog) {
  //   _handleDialogQueue(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return ApeironSpaceDialog(
  //           title: typeDialog.title,
  //           message: typeDialog.message,
  //           confirmText: typeDialog.textButton,
  //           onConfirmTap: () => Navigator.of(context).pop(),
  //         );
  //       }
  //   );
  // }

  static void showApiErrorDialog({
    required BuildContext outerContext,
    required String title,
    required String message,
    bool showHelp = false,
  }) {
    _handleDialogQueue(
        context: outerContext,
        builder: (BuildContext context) => ApeironSpaceDialog(
              title: title,
              message: message,
              confirmText: showHelp ? "contactTheHotel" : "ok",
              onConfirmTap: showHelp ? () => Navigator.of(context).pop() : () => Navigator.of(context).pop(),
              closeText: showHelp ? "ok" : null,
            ),
        idToCompare: 'showApiErrorDialog$title$message');
  }

  static void showApiErrorSmartDialog({
    required BuildContext outerContext,
    required String title,
    required String message,
    bool showHelp = false,
  }) {
    _handleDialogQueue(
        context: outerContext,
        builder: (BuildContext context) => ApeironSpaceDialog(
              title: title,
              message: message,
              confirmText: showHelp ? "contactTheHotel" : "ok",
              onConfirmTap: showHelp
                  ? () {}
                  : () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
              closeText: showHelp ? "ok" : null,
            ),
        idToCompare: 'showApiErrorSmartDialog$title$message');
  }

  static void showNoConnectionErrorDialog(BuildContext context) {
    showApiErrorDialog(
      outerContext: context,
      title: "noInternet",
      message: "errorLostConnectionToServer",
      showHelp: true,
    );
  }

  static void showSuccessDialog(BuildContext context, String title, String message, {String? confirmText}) {
    _handleDialogQueue(
        context: context,
        builder: (BuildContext context) {
          return ApeironSpaceDialog(
            title: title,
            message: message,
            confirmText: confirmText ?? "ok",
            onConfirmTap: () => Navigator.of(context).pop(),
            onCloseTap: () => Navigator.of(context).pop(),
          );
        });
  }

  static void showActionDialog(
      BuildContext context, {
        required String title,
        required VoidCallback onPressedConfirm,
        required VoidCallback onPressedClosed,
        String? message,
        String? confirmText,
        String? closeText,
        bool dismissible = true,
        double? verticalMargin,
        bool showTextField = false,
        TextEditingController? textFieldController,
      }) {
    _handleDialogQueue(
      context: context,
      dismissible: dismissible,
      builder: (BuildContext context) {
        return ApeironSpaceDialog(
          title: title,
          message: message,
          confirmText: confirmText ?? "go",
          closeText: closeText,
          onConfirmTap: () {
            Navigator.of(context).pop();
            onPressedConfirm.call();
          },
          onCloseTap: () {
            Navigator.of(context).pop();
            onPressedClosed.call();
          },
          showTextField: showTextField,
          textFieldController: textFieldController,
        );
      },
    );
  }

  static void showCustomDialog(
    BuildContext context,
    WidgetBuilder builder, {
    bool dismissible = true,
  }) {
    _handleDialogQueue(
      context: context,
      dismissible: dismissible,
      builder: (BuildContext sheetContext) {
        return Center(
          child: SingleChildScrollView(
            // physics: SuperBouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 16,
                right: 16,
              ),


            ),
          ),
        );
      },
    );
  }

  static void showBreakfastDialog({
    required BuildContext context,
    required String? title,
    required String? message,
    required String? confirmText,
    required String? closeText,
  }) {
    _handleDialogQueue(
      context: context,
      builder: (BuildContext context) {
        return ApeironSpaceDialog(
          title: title,
          message: message,
          confirmText: confirmText ?? "ok",
          onConfirmTap: () {
            Navigator.of(context).pop();
          },
          closeText: closeText ?? "close",
        );
      },
    );
  }

  static void showChatDialog({
    required BuildContext context,
    required String? title,
    required String? message,
    required String? confirmText,
    required String? closeText,
    required Function() onConfirmTap,
    required Function() onCloseTap,
  }) {
    _handleDialogQueue(
      context: context,
      builder: (BuildContext context) {
        return ApeironSpaceDialog(
          title: title,
          message: message,
          confirmText: confirmText ?? "ok",
          onConfirmTap: onConfirmTap,
          closeText: closeText ?? "close",
          onCloseTap: onCloseTap,
        );
      },
    );
  }

  static void showFindBookingFailureDialog({
    required BuildContext context,
    required String? title,
    required String? message,
    required String? confirmText,
    required String? closeText,
    required Function() onConfirmTap,
    required Function() onCloseTap,
  }) {
    _handleDialogQueue(
        context: context,
        builder: (BuildContext context) {
          return ApeironSpaceDialog(
            title: title,
            message: message,
            confirmText: confirmText ?? "ok",
            onConfirmTap: onConfirmTap,
            closeText: closeText ?? "close",
            onCloseTap: onCloseTap,
          );
        },
        idToCompare: '$title$message$confirmText$closeText');
  }

  static void showSmartFailureDialog({
    required BuildContext context,
    required String? message,
    required String? confirmText,
    required String? closeText,
    required Function() onConfirmTap,
    required Function() onCloseTap,
  }) {
    _handleDialogQueue(
        context: context,
        builder: (BuildContext context) {
          return ApeironSpaceDialog(
            message: message,
            confirmText: confirmText ?? "context.loc.goToChat",
            onConfirmTap: onConfirmTap,
            closeText: closeText ?? "context.loc.good",
            onCloseTap: onCloseTap,
          );
        },
        idToCompare: '$message$confirmText$closeText');
  }

  static void showLuggageStorageDialog({
    required BuildContext context,
    required String? title,
    required String? message,
    required String? confirmText,
    required String? closeText,
    required Function()? onConfirmTap,
    required Function()? onCloseTap,
  }) {
    _handleDialogQueue(
      context: context,
      builder: (BuildContext context) {
        return ApeironSpaceDialog(
          title: title,
          message: message,
          confirmText: confirmText,
          onConfirmTap: onConfirmTap,
          closeText: closeText,
          onCloseTap: onCloseTap,
        );
      },
    );
  }

  static Future<void> _handleDialogQueue(
      {required BuildContext context,
      required WidgetBuilder builder,
      bool dismissible = true,
      String? idToCompare}) async {
    Future<void> callback() async {
      await showDialog<void>(
        context: context,
        barrierColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black.withOpacity(.8)
            : AppColors.orange200.withOpacity(.3),
        barrierDismissible: dismissible,
        builder: builder,
      );
      if (_queue.isNotEmpty) {
        _queue.removeFirst();
      }

      if (_queue.isNotEmpty) {
        // Waiting for animation
        const Duration duration = Duration(milliseconds: 200);
        await Future<dynamic>.delayed(duration);

        _queue.removeFirst().callback();
      }
    }

    if (_queue.isEmpty) {
      _queue.add(DialogQueueData(callback: callback, idToCompare: idToCompare));
      await callback();
    } else {
      if (idToCompare != null && _queue.last.idToCompare != idToCompare) {
        _queue.add(DialogQueueData(callback: callback, idToCompare: idToCompare));
      }
    }
  }

  static void clearAll(BuildContext context) {
    final bool hasClean = _queue.isNotEmpty;
    _queue.clear();

    if (hasClean) {
      Future<void>.delayed(const Duration(milliseconds: 200)).then((_) {
        Navigator.of(context).pop();
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).brightness;
    final screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          left: 16,
          right: 16,
        ),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: screenWidth < 350 ? 20 : (screenWidth - 350) / 2),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: theme == Brightness.dark ? AppColors.gray.shade90 : AppColors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (title != null)
                Text(
                  title!,
                  textAlign: TextAlign.center,
                  style: AppTypography.font20Regular.copyWith(fontWeight: FontWeight.w700),
                ),
              const SizedBox(height: 12),
              if (message != null)
                Text(
                  message!,
                  style: AppTypography.font20Regular.copyWith(color: AppColors.black),
                  textAlign: TextAlign.center,
                ),
              if (showTextField) ...[
                const SizedBox(height: 20),
                Material(
                  color: AppColors.gray.shade90,
                  child: TextField(
                    controller: textFieldController,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Введите сообщение для пользователя',
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      filled: true,
                      fillColor: Colors.grey.shade700 ,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColors.white,
                  backgroundColor: theme == Brightness.dark
                      ? AppColors.green300.withOpacity(0.8)
                      : AppColors.green200.withOpacity(0.8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                ),
                onPressed: onConfirmTap,
                child: Text(
                  confirmText ?? 'Подтвердить',
                  style: AppTypography.font16Regular.copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              if (closeText != null)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.white,
                    backgroundColor: AppColors.redLight.withOpacity(0.8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                  ),
                  onPressed: onCloseTap,
                  child: Text(
                    closeText!,
                    style: AppTypography.font16Regular.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.w700,
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



class DialogQueueData {
  const DialogQueueData({
    required this.callback,
    required this.idToCompare,
  });

  final Future<void> Function() callback;
  final String? idToCompare;
}
