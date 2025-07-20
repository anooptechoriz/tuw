import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:provider/provider.dart';
import 'package:tuw_services/components/color_manager.dart';
import 'package:tuw_services/model/get_child_service.dart';
import '../../components/styles_manager.dart';
import '../../providers/data_provider.dart';
import '../../widgets/title_widget.dart';
import '../../l10n/app_localizations.dart';

class ServiceDocPickerWidget extends StatelessWidget {
  final Document item;

  const ServiceDocPickerWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final str = AppLocalizations.of(context)!;
    final provider = context.read<DataProvider>();
    String docName = item.document ?? '';
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Row(
            children: [
              TitleWidget(name: docName),
              const Icon(
                Icons.star_outlined,
                size: 10,
                color: ColorManager.errorRed,
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 10.0,
                  color: Colors.grey.shade300,
                  // offset: const Offset(5, 8.5),
                ),
              ],
            ),
            child: Container(
              width: size.width,
              height: 60,
              decoration: BoxDecoration(
                  color: ColorManager.whiteColor,
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 13, 10, 13),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.fromLTRB(13, 0, 13, 0)),
                        onPressed: () async {
                          // if (provider.isLoading) return;
                            FilePickerResult? result =
                                await provider.pickFiles();
                            if (result != null) {
                              PlatformFile file = result.files.first;
                              provider.onChangeFileName(item: item,fileName: file.name);
                              final path = file.path;
                              final filePath = XFile(path!);
                              item.file = filePath;
                              // provider.pickedFile = filePath
                            } else {}
                        },
                        child: Text(str.c_browse,
                            style: getLightStyle(
                                color: ColorManager.whiteText, fontSize: 18))),
                  ),
                  Expanded(child: Text(item.fileName??''))
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
