import 'dart:ui';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface.withValues(alpha: 0.7),
            // ظل خفيف للفصل بين Header والمحتوى
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.black.withValues(alpha: 0.05),
            //     blurRadius: 10,
            //     offset: const Offset(0, 2),
            //   ),
            // ],
          ),
          width: MediaQuery.of(context).size.width * 1,
          padding: const EdgeInsets.only(
            top: 50,
            left: 20,
            right: 20,
            bottom: 10,
          ),

          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  "أهلا 👋",
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              SizedBox(
                height: 50,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    splashFactory: NoSplash.splashFactory,
                    textSelectionTheme: TextSelectionThemeData(
                      cursorColor: theme.colorScheme.primary.withValues(
                        alpha: 0.7,
                      ),
                    ),
                  ),
                  child: SearchBarWidget(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SearchBar(
      backgroundColor: WidgetStateProperty.all(
        theme.colorScheme.surfaceDim.withValues(alpha: 0.4),
      ),
      hintText: 'ابحث هنا',
      hintStyle: WidgetStateProperty.all(
        TextStyle(
          color: theme.colorScheme.primary.withValues(alpha: 0.7),
        ),
      ),
      textStyle: WidgetStateProperty.all(
        TextStyle(
          color: theme.colorScheme.primary.withValues(
            alpha: 0.9,
          ), // لون النص أثناء الكتابة
        ),
      ),
      leading: Icon(
        Icons.search,
        color: theme.colorScheme.primary.withValues(alpha: 0.7),
      ),
      trailing: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.more_vert,
            color: theme.colorScheme.primary.withValues(alpha: 0.7),
          ),
        ),
      ],
      shadowColor: WidgetStateProperty.all(Colors.transparent),
    );
  }
}
