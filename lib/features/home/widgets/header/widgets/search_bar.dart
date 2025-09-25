import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_app/features/home/widgets/header/widgets/search_controller.dart';
import 'package:my_app/features/home/widgets/stores/store_model.dart';
import 'package:my_app/features/home/widgets/stores/widgets/store_card.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBarWidget> {
  late final SearchBarController _controller;
  late final TextEditingController _textController;
  late final FocusNode _focusNode;

  bool _isFocused = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _controller = SearchBarController();
    _textController = TextEditingController();
    _focusNode = FocusNode();

    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });

    _textController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _textController.dispose();
    _focusNode.dispose();
    _controller.dispose(); 
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      _controller.fetchStoresByName(_textController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ChangeNotifierProvider.value(
      value: _controller,
      child: Column(
        children: [
          _buildSearchBar(theme),
          if (_isFocused) const SizedBox(height: 20),
          if (_isFocused) _SuggestionsCard(),
        ],
      ),
    );
  }

  // ============================
  // SearchBar Widget
  // ============================
  Widget _buildSearchBar(ThemeData theme) {
    return SearchBar(
      controller: _textController,
      focusNode: _focusNode,
      backgroundColor: WidgetStateProperty.all(
        theme.colorScheme.surfaceDim.withValues(alpha: 0.4),
      ),
      hintText: 'ابحث هنا',
      hintStyle: WidgetStateProperty.all(
        TextStyle(color: theme.colorScheme.primary.withValues(alpha: 0.7)),
      ),
      textStyle: WidgetStateProperty.all(
        TextStyle(color: theme.colorScheme.primary.withValues(alpha: 0.9)),
      ),
      leading: Icon(
        Icons.search,
        color: theme.colorScheme.primary.withValues(alpha: 0.7),
      ),
      trailing: _isFocused
          ? [
              IconButton(
                onPressed: () {
                  _textController.clear();
                  _focusNode.unfocus();
                },
                icon: Icon(
                  Icons.close,
                  color: theme.colorScheme.primary.withValues(alpha: 0.7),
                ),
              ),
            ]
          : [],
      shadowColor: WidgetStateProperty.all(Colors.transparent),
    );
  }
}

// ============================
// Suggestions Card Widget
// ============================
class _SuggestionsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<SearchBarController>(
      builder: (context, controller, _) {
        return Container(
          width: double.infinity,
          height: 300,
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceDim.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(12),
          ),
          child: _buildContent(context, controller),
        );
      },
    );
  }

  // ============================
  // محتوى الكونتينر حسب الحالة
  // ============================
  Widget _buildContent(BuildContext context, SearchBarController controller) {
    final theme = Theme.of(context);

    if (controller.isLoading) {
      // حالة Loading مع Skeleton
      return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Skeletonizer(
            child: StoreCard(
              store: StoreModel(
                id: "id",
                name: "name",
                icon: "icon",
                description: "description",
              ),
            ),
          );
        },
      );
    } else if (controller.list.isEmpty) {
      // حالة فارغة
      return Center(
        child: Text(
          "لا توجد نتائج",
          style: TextStyle(color: theme.colorScheme.primary, fontSize: 16),
        ),
      );
    } else {
      // حالة نجاح
      return ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: controller.list.length,
        itemBuilder: (context, index) {
          final store = controller.list[index];
          return StoreCard(store: store);
        },
      );
    }
  }
}
