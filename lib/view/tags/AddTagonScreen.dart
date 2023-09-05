import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import '../../components/colors.dart';
import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/rendering.dart';

import '../../controller/tagcontroller.dart';
import 'AddTagScreen.dart';

class AddTagonScreen extends StatefulWidget {
  final File image;
  AddTagonScreen({Key? key, required this.image}) : super(key: key);

  @override
  _AddTagonScreenState createState() => _AddTagonScreenState();
}

class _AddTagonScreenState extends State<AddTagonScreen> {
  TagController controller = Get.find();

  final List<Tag> _tags = [];
  Offset? _currentTagPosition;
  Color currentTagColor = DynamicColor.primaryColor;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _currentTagPosition = details.localPosition;
    });
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    setState(() {
      _currentTagPosition = _currentTagPosition! + details.delta;
    });
  }

  void _handlePanEnd(DragEndDetails details) {
    setState(() {
      _tags.add(Tag(
        position: _currentTagPosition!,
        color: currentTagColor,
        text: "Tag ${_tags.length + 1}",
      ));
      _currentTagPosition = null;
    });
  }

  @override
  GlobalKey _globalKey = GlobalKey();

  Future<Uint8List> captureScreenshot() async {
    RenderRepaintBoundary boundary =
        _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      appBar: AppBar(
        backgroundColor: DynamicColor.primary,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Add Tag on Image'),
        actions: [
          IconButton(
            onPressed: () async {
              Uint8List? screenshotBytes = await captureScreenshot();
              if (screenshotBytes != null) {
                final directory = await getApplicationDocumentsDirectory();
                final path = '${directory.path}/screenshot.png';
                final screenshotFile = File(path);
                File imageFile = File(path);
                await imageFile.writeAsBytes(screenshotBytes);
                controller.issuetagform.file = imageFile;
                Get.back();
              }
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Center(
        child: RepaintBoundary(
          key: _globalKey,
          child: GestureDetector(
            onTapDown: _handleTapDown,
            onPanUpdate: _handlePanUpdate,
            onPanEnd: _handlePanEnd,
            child: Stack(
              children: [
                Image.file(
                  widget.image,
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
                CustomPaint(
                  painter: TagPainter(tags: _tags),
                ),
                if (_currentTagPosition != null)
                  TagWidget(
                    position: _currentTagPosition!,
                    color: currentTagColor,
                    text: "Tag ${_tags.length + 1}",
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TagPainter extends CustomPainter {
  final List<Tag> tags;
  TagPainter({required this.tags});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    for (final tag in tags) {
      IconData icon = Icons.location_on;
      paint.color = DynamicColor.primary;
      TextPainter textPainter = TextPainter(textDirection: TextDirection.rtl);
      textPainter.text = TextSpan(
          text: String.fromCharCode(icon.codePoint),
          style: TextStyle(
              fontSize: 40.0,
              fontFamily: icon.fontFamily,
              color: DynamicColor.primary));
      textPainter.layout();
      textPainter.paint(canvas, tag.position + const Offset(10, -10));
    }
  }

  @override
  bool shouldRepaint(TagPainter oldDelegate) => true;
}

class TagWidget extends StatelessWidget {
  final Offset position;
  final Color color;
  final String text;

  const TagWidget({
    Key? key,
    required this.position,
    required this.color,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Icon(
            Icons.arrow_drop_down,
            color: color,
            size: 30,
          ),
        ],
      ),
    );
  }
}

class Tag {
  final Offset position;
  final Color color;
  final String text;

  Tag({
    required this.position,
    required this.color,
    required this.text,
  });
}
