import 'package:messenger/main.dart';

class GradientButton extends UI {
  final GradientColor gradientColor;
  final void Function()? onPressed;
  final Widget child;

  const GradientButton({
    super.key,
    this.gradientColor = GradientColor.greeny,
    this.onPressed,
    required this.child,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: gradientColor.colors),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          minimumSize: Size.fromHeight(60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: child,
      ),
    ).pad();
  }
}

enum GradientColor {
  bluish([Colors.blue, Colors.blueGrey]),
  greeny([Colors.green, Colors.lightGreen]),
  reddish([Colors.red, Colors.pink]);

  const GradientColor([
    this.colors = const [Colors.blue, Colors.blueGrey],
  ]);
  final List<MaterialColor> colors;
}
