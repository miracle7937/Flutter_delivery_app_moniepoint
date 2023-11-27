import 'package:flutter/material.dart';

class SelectableList extends StatefulWidget {
  final Animation<Offset> slideAnimation;
  final Animation<double> fadeAnimation;

  const SelectableList({
    super.key,
    required this.slideAnimation,
    required this.fadeAnimation,
  });

  @override
  _SelectableListState createState() => _SelectableListState();
}

class _SelectableListState extends State<SelectableList> {
  int selectedIndex = -1;
  String selectedValue = "";
  List<SelectItem> items = [
    SelectItem("Documents", Icons.star),
    SelectItem("Glass", Icons.favorite),
    SelectItem("Liquid", Icons.thumb_up),
    SelectItem("Food", Icons.thumb_down),
    SelectItem("Electronics", Icons.thumb_down),
    SelectItem("Products", Icons.thumb_down),
    SelectItem("Others", Icons.thumb_down),
  ];

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: widget.fadeAnimation,
      child: SlideTransition(
        position: widget.slideAnimation,
        child: Wrap(
          children: List.generate(
              items.length,
              (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedValue = items[index].text;
                      });
                    },
                    child: SelectableListItem(
                      item: items[index],
                      isSelected: selectedValue == items[index].text,
                    ),
                  )).toList(),
        ),
      ),
    );
  }
}

class SelectableListItem extends StatelessWidget {
  final SelectItem item;
  final bool isSelected;

  const SelectableListItem(
      {super.key, required this.item, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
          color: isSelected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        // width: isSelected ? 120 : 100,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: 8.0, horizontal: isSelected ? 15 : 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isSelected
                  ? Icon(
                      Icons.check,
                      color: isSelected ? Colors.white : Colors.black,
                    )
                  : Container(),
              const SizedBox(width: 5),
              Text(
                item.text,
                style: TextStyle(
                  fontSize: isSelected ? 18 : 16,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectItem {
  final String text;
  final IconData icon;

  SelectItem(this.text, this.icon);
}
