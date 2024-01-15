import 'package:dotted_border/dotted_border.dart';
import 'package:drop_image_app/model/dropped_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';

class DropzoneWidget extends StatefulWidget {
  final ValueChanged<DroppedFile> onDroppedFile;

  const DropzoneWidget({super.key, required this.onDroppedFile});

  @override
  State<DropzoneWidget> createState() => _DropzoneWidgetState();
}

class _DropzoneWidgetState extends State<DropzoneWidget> {
  late DropzoneViewController controller;
  bool _isHighlighted = false;

  @override
  Widget build(BuildContext context) {
    final colorButton =
        _isHighlighted ? Colors.blue.shade300 : Colors.green.shade300;

    return buildDecoration(
      child: Stack(children: [
        DropzoneView(
          onCreated: (controller) => this.controller = controller,
          onDrop: _acceptFile,
          onHover: () => setState(() => _isHighlighted = true),
          onLeave: () => setState(() => _isHighlighted = false),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.cloud_upload, size: 80, color: Colors.white),
              const Text(
                'Drop file here',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  primary: colorButton,
                  shape: const RoundedRectangleBorder(),
                ),
                onPressed: () async {
                  final event = await controller.pickFiles();
                  if (event.isEmpty) return;
                  _acceptFile(event.first);
                },
                icon: const Icon(
                  Icons.search,
                  size: 32,
                ),
                label: const Text(
                  'Choose Files',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Future<void> _acceptFile(dynamic event) async {
    final name = event.name;
    final mime = await controller.getFileMIME(event);
    final bytes = await controller.getFileSize(event);
    final url = await controller.createFileUrl(event);

    print('Name: $name');
    print('Mime: $mime');
    print('Bytes: $bytes');
    print('Url: $url');

    final droppedFile = DroppedFile(
      url: url,
      name: name,
      mime: mime,
      bytes: bytes,
    );

    widget.onDroppedFile(droppedFile);
    setState(() {
      _isHighlighted = false;
    });
  }

  Widget buildDecoration({required Widget child}) {
    final colorBackground = _isHighlighted ? Colors.blue : Colors.green;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        color: colorBackground,
        padding: const EdgeInsets.all(12),
        child: DottedBorder(
          borderType: BorderType.RRect,
          color: Colors.white,
          strokeWidth: 3,
          padding: EdgeInsets.zero,
          dashPattern: const [8, 4],
          radius: const Radius.circular(10),
          child: child,
        ),
      ),
    );
  }
}
