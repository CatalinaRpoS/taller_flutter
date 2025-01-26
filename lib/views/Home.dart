import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './ImageSelection.dart';
import './Info.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? _backgroundImage;

  @override
  void initState() {
    super.initState();
    _loadBackgroundImage();
  }

  Future<void> _loadBackgroundImage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _backgroundImage = prefs.getString('background_image') ??
          'assets/orchid.jpg'; // Default image
    });
  }

  Future<void> _saveBackgroundImage(String imagePath) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('background_image', imagePath);
    setState(() {
      _backgroundImage = imagePath;
    });
  }

  void _navigateToImageSelection() async {
    final selectedImage = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ImageSelection()),
    );

    if (selectedImage != null && selectedImage is String) {
      await _saveBackgroundImage(selectedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (_backgroundImage != null)
            Positioned.fill(
              child: Image.asset(
                _backgroundImage!,
                fit: BoxFit.cover,
              ),
            ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _navigateToImageSelection,
                  child: Text(
                    'Seleccionar Imagen',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.pink[300],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Info.route);
                  },
                  child: Text(
                    'Ver Información',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.pink[300],
                    ),
                  ),
                ),
              ],
            )
          ),
        ],
      ),
    );
  }
}