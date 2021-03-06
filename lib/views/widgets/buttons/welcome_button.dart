import 'package:flutter/material.dart';
import 'package:flutter_template/style.dart';

import 'wide_button.dart';

class WelcomeButton extends StatefulWidget {
  final Widget child;
  final Color background;
  final IconData icon;
  final String label;
  final double fontSize;
  @required
  final VoidCallback onPressed;

  const WelcomeButton(
      {Key key,
      this.background,
      this.icon,
      this.label,
      this.fontSize = 16,
      this.onPressed,
      this.child})
      : super(key: key);

  @override
  _WelcomeButtonState createState() => _WelcomeButtonState();
}

class _WelcomeButtonState extends State<WelcomeButton>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Color> _colorTween;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 3100),
    );
    _colorTween = ColorTween(begin: widget.background, end: widget.background)
        .animate(_animationController);
    super.initState();
  }

  @override
  void didUpdateWidget(WelcomeButton oldWidget) {
    setState(() {
      _colorTween = ColorTween(begin: _colorTween.value, end: widget.background)
          .animate(_animationController);
      _animationController.reset();
      _animationController.forward();
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) => WideButton(
        onPressed: widget.onPressed,
        background: _colorTween.value,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              widget.icon == null
                  ? Container()
                  : Padding(
                      padding: EdgeInsets.only(right: 13),
                      child: Icon(
                        widget.icon,
                        size: widget.fontSize,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
              Text(widget.label.toUpperCase(),
                  style: buttonTextStyle.apply(
                      color: Colors.white,
                      fontSizeDelta:
                          widget.fontSize - buttonTextStyle.fontSize)),
            ],
          ),
        ),
      ),
    );
  }
}
