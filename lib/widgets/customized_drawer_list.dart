import 'package:flutter/material.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/responsive/responsive.dart';

class CustomDrawerList extends StatelessWidget {
  final String title;
 final GestureTapCallback? onTap;
const  CustomDrawerList({Key? key, required this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorManager.primary3,
      child: InkWell(
        splashColor: ColorManager.whiteColor,
        enableFeedback: true,
        excludeFromSemantics: true,
        onTap: onTap,
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                const SizedBox(width: 15),
                Text(
                  String.fromCharCode(Icons.arrow_forward_ios.codePoint),
                  style: TextStyle(
                    inherit: false,
                    color: ColorManager.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700,
                    fontFamily: Icons.arrow_forward_ios.fontFamily,
                    package: Icons.arrow_forward_ios.fontPackage,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 3),
                    child: Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: getBoldtStyle(
                          color: ColorManager.black,
                          fontSize: Responsive.isMobile(context) ? 16 : 13),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
