import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:tpm/Routes/app_pages.dart';
import 'package:tpm/components/colors.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: screenWidth * 0.6,
              width: screenWidth * 0.6,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: NetworkImage(
                    "https://i.dawn.com/primary/2020/11/5fb66f3731147.jpg",
                  ),
                  fit: BoxFit.cover
                ),
                borderRadius: BorderRadius.circular(screenWidth * 0.3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenWidth * 0.1),
            Text(
              "Welcome to TPM",
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      fontSize: screenWidth * 0.06,
                      color: DynamicColor.primary)),
            ),
            SizedBox(height: screenWidth * 0.1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ScaleButton(
                  onTap: () => Get.toNamed(Routes.tags),
                  text: "View Data",
                  icon: Icons.view_list,
                  color: DynamicColor.primaryColor,
                  size: screenWidth * 0.28,
                ),
                ScaleButton(
                  onTap: () => Get.toNamed(Routes.tagraised),
                  text: "Capture",
                  icon: Icons.camera_alt,
                  color: DynamicColor.primaryColor,
                  size: screenWidth * 0.28,
                ),
                ScaleButton(
                  onTap: () => Get.toNamed(Routes.visualize),
                  text: "Visualize",
                  icon: Icons.assessment,
                  color: DynamicColor.primaryColor,
                  size: screenWidth * 0.28,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ScaleButton extends StatefulWidget {
  final Function() onTap;
  final String text;
  final IconData icon;
  final Color color;
  final double size;

  const ScaleButton(
      {Key? key,
      required this.onTap,
      required this.text,
      required this.icon,
      required this.color,
      required this.size})
      : super(key: key);

  @override
  _ScaleButtonState createState() => _ScaleButtonState();
}

class _ScaleButtonState extends State<ScaleButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _animation =
        Tween<double>(begin: 1, end: 0.8).animate(_animationController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _animationController.forward(),
      onTapUp: (_) => _animationController.reverse(),
      onTapCancel: () => _animationController.reverse(),
      onTap: widget.onTap,
      child: ScaleTransition(
        scale: _animation,
        child: Container(
          height: widget.size,
          width: widget.size,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                color: Colors.white,
                size: 30,
              ),
              const SizedBox(height: 10),
              Text(
                widget.text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
