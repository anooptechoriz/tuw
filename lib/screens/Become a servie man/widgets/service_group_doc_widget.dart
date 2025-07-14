import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/providers/data_provider.dart';

import '../../../components/color_manager.dart';
import '../../../model/get_child_service.dart';
import '../../../widgets/title_widget.dart';

class ServiceGroupDocSection extends StatefulWidget {
  const ServiceGroupDocSection({super.key});

  @override
  State<ServiceGroupDocSection> createState() => _ServiceGroupDocSectionState();
}

class _ServiceGroupDocSectionState extends State<ServiceGroupDocSection> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DataProvider>();

    ChildServiceModel? itemModel = provider.customerChildSer;
    List<Document> documents = itemModel?.documents ?? [];
    log('documents --> ${documents.length}');
    if (documents.isEmpty) {
      return const SizedBox.shrink();
    }
    return ListView.separated(
      shrinkWrap: true,
      itemCount: documents.length,
      itemBuilder: (context, index) {
        Document item = documents[index];
        return ServiceGroupDocTile(item: item);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 12),
    );
  }
}

class ServiceGroupDocTile extends StatelessWidget {
  final Document item;
  const ServiceGroupDocTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
              height: 65,
              decoration: BoxDecoration(
                  color: ColorManager.whiteColor,
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 13, 0, 13),
                    child: SizedBox(
                      width: 50,
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
                          child: Icon(Icons.file_present_rounded)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 13, 10, 13),
                    child: SizedBox(
                      width: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.fromLTRB(13, 0, 13, 0)),
                          onPressed: () async {
                       item.file =    await  provider.openCamera();
                            // provider.pickedFile = ?
                            provider.onChangeFileName(
                                item: item , fileName: item.file?.name ?? '');
                            // setState(() {

                            // });
                          },
                          child: Icon(Icons.camera_alt)),
                    ),
                  ),
                  Expanded(child: Text(item.fileName ?? ''))
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
