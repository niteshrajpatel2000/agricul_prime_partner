import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Future<bool> showDeleteConfirmationDialog({
  required BuildContext context,
  required String itemName, // Name of the item to delete
}) async {
  final _theme = Theme.of(context);
  return await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Do you really want to delete this  $itemName?',
                    style: _theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 26),
                  Center(child: SvgPicture.asset('assets/hrm/delete.svg')),
                  SizedBox(height: 26),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('No'),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Yes'),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
