import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:abc_app/language_provider.dart';
import 'glowing_gradient_border.dart';

class ColorPickerButton extends StatelessWidget {
  final Color initialColor;
  final ValueChanged<Color> onColorSelected;

  const ColorPickerButton({
    required this.initialColor,
    required this.onColorSelected,
    super.key,
  });

  void _showColorPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Provider.of<LanguageProvider>(context, listen: false)
              .translate('pickColor')),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: initialColor,
              onColorChanged: (color) {
                onColorSelected(color);
                Navigator.of(context)
                    .pop(); // Automatically closes on color selection
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.refresh),
                  const SizedBox(width: 8),
                  Text(Provider.of<LanguageProvider>(context, listen: false)
                      .translate('resetToDefault')),
                ],
              ),
              onPressed: () {
                onColorSelected(Colors.blue); // Reset color
                Navigator.of(context).pop(); // Close the popup
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GlowingGradientBorder(
        borderSize: 3.5,
        glowSize: 3.5,
        borderRadius: BorderRadius.circular(24),
        gradientColors: [
          Colors.red,
          Colors.orange,
          Colors.yellow,
          Colors.green,
          Colors.blue,
          Colors.indigo,
          Colors.purple,
          Colors.red,
        ].map((color) => color.withOpacity(0.8)).toList(),
        child: Material(
          elevation: 0,
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
          child: IconButton(
            icon: const Icon(Icons.color_lens),
            onPressed: () => _showColorPicker(context),
          ),
        ),
      ),
    );
  }
}
