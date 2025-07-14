import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';

showAnimatedSnackBar(BuildContext context, String text, {AnimatedSnackBarType? type , int ?timeDurationInSec}) {
  AnimatedSnackBar.material(text,
          type:type?? AnimatedSnackBarType.error,
          borderRadius: BorderRadius.circular(6),
          duration:   Duration(seconds:timeDurationInSec?? 1))
      .show(
    context,
  );
}
