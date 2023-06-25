import 'package:flutter/material.dart';

class ColorAccessibilityScreen extends StatefulWidget {
  @override
  _ColorAccessibilityScreenState createState() => _ColorAccessibilityScreenState();
}

class _ColorAccessibilityScreenState extends State<ColorAccessibilityScreen> {
  Color _selectedColor = Colors.blue; // Cor inicial selecionada

  void _selectColor(Color color) {
    setState(() {
      _selectedColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acessibilidade de Cores'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Selecione uma cor de destaque:',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Wrap(
                spacing: 20,
                runSpacing: 20,
                children: [
                  ColorOption(
                    color: Colors.red,
                    isSelected: _selectedColor == Colors.red,
                    onTap: () => _selectColor(Colors.red),
                  ),
                  ColorOption(
                    color: Colors.green,
                    isSelected: _selectedColor == Colors.green,
                    onTap: () => _selectColor(Colors.green),
                  ),
                  ColorOption(
                    color: Colors.yellow,
                    isSelected: _selectedColor == Colors.yellow,
                    onTap: () => _selectColor(Colors.yellow),
                  ),
                  ColorOption(
                    color: Colors.purple,
                    isSelected: _selectedColor == Colors.purple,
                    onTap: () => _selectColor(Colors.purple),
                  ),
                  ColorOption(
                    color: Colors.orange,
                    isSelected: _selectedColor == Colors.orange,
                    onTap: () => _selectColor(Colors.orange),
                  ),
                  ColorOption(
                    color: Colors.teal,
                    isSelected: _selectedColor == Colors.teal,
                    onTap: () => _selectColor(Colors.teal),
                  ),
                ],
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  // Salve a cor selecionada e retorne à tela de login
                  Navigator.pop(context, _selectedColor);
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                child: Text(
                  'Aplicar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ColorOption extends StatelessWidget {
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const ColorOption({
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: isSelected ? Colors.black : Colors.transparent, width: 2),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ]
              : null,
        ),
      ),
    );
  }
}
