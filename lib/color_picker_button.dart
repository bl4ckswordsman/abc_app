import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerButton extends StatelessWidget {
  final Color initialColor;
  final ValueChanged<Color> onColorSelected;

  ColorPickerButton({required this.initialColor, required this.onColorSelected});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.color_lens),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ColorPickerDialog(
              initialColor: initialColor,
              onColorSelected: onColorSelected,
            );
          },
        );
      },
    );
  }
}

class ColorPickerDialog extends StatefulWidget {
  final Color initialColor;
  final ValueChanged<Color> onColorSelected;

  ColorPickerDialog({required this.initialColor, required this.onColorSelected});

  @override
  _ColorPickerDialogState createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  Color _selectedColor;

  _ColorPickerDialogState() : _selectedColor = Colors.blue;

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
