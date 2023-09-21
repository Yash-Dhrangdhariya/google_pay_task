import 'package:flutter/material.dart';
import 'package:google_pay_task/resources/app_text_styles.dart';

class CustomKeyboard extends StatelessWidget {
  const CustomKeyboard({
    required this.onTap,
    required this.onSubmit,
    required this.limit,
    required this.text,
    super.key,
  });

  final void Function(String) onTap;
  final void Function() onSubmit;
  final List<String> text;
  final int limit;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade300,
          ),
          bottom: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 0.5,
        ),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: KeyboardButton(
                      onTap: () {
                        if (text.length < limit) {
                          text.add('1');
                          onTap(text.join());
                        }
                      },
                      text: '1',
                    ),
                  ),
                  Expanded(
                    child: KeyboardButton(
                      onTap: () {
                        if (text.length < limit) {
                          text.add('2');
                          onTap(text.join());
                        }
                      },
                      text: '2',
                    ),
                  ),
                  Expanded(
                    child: KeyboardButton(
                      onTap: () {
                        if (text.length < limit) {
                          text.add('3');
                          onTap(text.join());
                        }
                      },
                      text: '3',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: KeyboardButton(
                      onTap: () {
                        if (text.length < limit) {
                          text.add('4');
                          onTap(text.join());
                        }
                      },
                      text: '4',
                    ),
                  ),
                  Expanded(
                    child: KeyboardButton(
                      onTap: () {
                        if (text.length < limit) {
                          text.add('5');
                          onTap(text.join());
                        }
                      },
                      text: '5',
                    ),
                  ),
                  Expanded(
                    child: KeyboardButton(
                      onTap: () {
                        if (text.length < limit) {
                          text.add('6');
                          onTap(text.join());
                        }
                      },
                      text: '6',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: KeyboardButton(
                      onTap: () {
                        if (text.length < limit) {
                          text.add('7');
                          onTap(text.join());
                        }
                      },
                      text: '7',
                    ),
                  ),
                  Expanded(
                    child: KeyboardButton(
                      onTap: () {
                        if (text.length < limit) {
                          text.add('8');
                          onTap(text.join());
                        }
                      },
                      text: '8',
                    ),
                  ),
                  Expanded(
                    child: KeyboardButton(
                      onTap: () {
                        if (text.length < limit) {
                          text.add('9');
                          onTap(text.join());
                        }
                      },
                      text: '9',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: KeyboardButton(
                      text: 'Remove',
                      onTap: () {
                        if (text.isNotEmpty) {
                          text.removeLast();
                        }
                        onTap(text.join());
                      },
                      icon: Icons.backspace_rounded,
                    ),
                  ),
                  Expanded(
                    child: KeyboardButton(
                      onTap: () {
                        if (text.length < limit) {
                          text.add('0');
                          onTap(text.join());
                        }
                      },
                      text: '0',
                    ),
                  ),
                  Expanded(
                    child: KeyboardButton(
                      onTap: onSubmit,
                      text: 'Submit',
                      icon: Icons.check_circle_rounded,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class KeyboardButton extends StatelessWidget {
  const KeyboardButton({
    required this.text,
    super.key,
    this.onTap,
    this.icon,
  });

  final String text;
  final void Function()? onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Ink(
          color: Colors.white,
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(
                width: 0.5,
                color: Colors.grey.shade300,
              ),
            ),
            child: Center(
              child: (icon != null)
                  ? Icon(icon)
                  : Text(
                      text.toUpperCase(),
                      style: AppTextStyles.fontMediumLarge,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
