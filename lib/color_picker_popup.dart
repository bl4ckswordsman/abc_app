import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerPopup extends StatefulWidget {
  final Color initialColor;
  final ValueChanged<Color> onColorSelected;

  ColorPickerPopup({required this.initialColor, required this.onColorSelected});

  @override
  _ColorPickerPopupState createState() => _ColorPickerPopupState();
}

class _ColorPickerPopupState extends State<ColorPickerPopup> {
  Color _selectedColor;

  _ColorPickerPopupState() : _selectedColor = Colors.blue;

  @override
  void initState() {
    super.initState();
    _selectedColor = widget.initialColor;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Pick a color'),
      content: SingleChildScrollView(
        child: BlockPicker(
          pickerColor: _selectedColor,
          onColorChanged: (color) {
            setState(() {
              _selectedColor = color;
            });
          },
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Reset to default'),
          onPressed: () {
            setState(() {
              _selectedColor = Colors.blue;
            });
          },
        ),
        TextButton(
          child: Text('Apply'),
          onPressed: () {
            widget.onColorSelected(_selectedColor);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
