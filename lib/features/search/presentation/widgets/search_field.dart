import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchField extends StatefulWidget {
  final Function(String) onSearch;
  const SearchField(
      {super.key,
      required this.onSearch,
      required TextEditingController controller});

  @override
  SearchFieldState createState() => SearchFieldState();
}

class SearchFieldState extends State<SearchField> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: TextField(
        controller: _controller,
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white),
        onChanged: (query) {
          if (_debounce?.isActive ?? false) _debounce?.cancel();
          _debounce = Timer(const Duration(milliseconds: 500), () {
            widget.onSearch(query); // Trigger search after a short delay
          });
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 16.h),
          filled: true,
          fillColor: Colors.white.withOpacity(0.05),
          hintText: "Search",
          hintStyle: const TextStyle(color: Colors.white54),
          prefixIcon: Icon(
            Icons.search,
            size: 34.h.w,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(27.r),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
