import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    required this.name,
    this.onTap,
    super.key,
  });

  final String name;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 60,
            width: 60,
            child: ClipOval(
              child: ColoredBox(
                color: Colors.grey,
                child: Center(
                  child: Text(
                    name[0],
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          if (onTap != null)
            Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
        ],
      ),
    );
  }
}
