// lib/features/home/widgets/search_bar/search_bar.dart
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:my_app/features/home/widgets/search_bar.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface.withValues(alpha: 0.7),
          ),
          width: MediaQuery.of(context).size.width * 1,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SafeArea(
            child: SizedBox(
              child: Theme(
                data: Theme.of(context).copyWith(
                  splashFactory: NoSplash.splashFactory,
                  textSelectionTheme: TextSelectionThemeData(
                    cursorColor: theme.colorScheme.primary.withValues(
                      alpha: 0.7,
                    ),
                  ),
                ),
                // child: SearchBarWidget(),
                child: SearchBarWidget(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// class SearchBarWidget extends StatelessWidget {
//   const SearchBarWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return SearchBar(
//       backgroundColor: WidgetStateProperty.all(
//         theme.colorScheme.surfaceDim.withValues(alpha: 0.4),
//       ),
//       hintText: 'ابحث هنا',
//       hintStyle: WidgetStateProperty.all(
//         TextStyle(color: theme.colorScheme.primary.withValues(alpha: 0.7)),
//       ),
//       textStyle: WidgetStateProperty.all(
//         TextStyle(
//           color: theme.colorScheme.primary.withValues(
//             alpha: 0.9,
//           ), // لون النص أثناء الكتابة
//         ),
//       ),
//       leading: Icon(
//         Icons.search,
//         color: theme.colorScheme.primary.withValues(alpha: 0.7),
//       ),
//       trailing: [
//         IconButton(
//           onPressed: () {},
//           icon: Icon(
//             Icons.more_vert,
//             color: theme.colorScheme.primary.withValues(alpha: 0.7),
//           ),
//         ),
//       ],
//       shadowColor: WidgetStateProperty.all(Colors.transparent),
//     );
//   }
// }
