import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class TaskDetailsPage extends StatelessWidget {
  const TaskDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text(
          "Mid Term Task 1",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              TaskDetailsSection(teacher: "Ms Nazneen Ansari"),
              const SizedBox(height: 30),
              UploadTaskSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class TaskDetailsSection extends StatelessWidget {
  final String teacher;
  const TaskDetailsSection({super.key, required this.teacher});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Problem Statement:",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(
          "You are required to implement a sorting algorithm of your choice (e.g., bubble sort, merge sort, quicksort) to organize a given dataset of integers in ascending order.",
        ),
        const SizedBox(height: 10),
        Text(
          "Requirements",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(
          "Document the implementation process, including code comments for clarity. Submit the code along with a written report explaining your approach, challenges faced, and any optimizations implemented.",
        ),
        const SizedBox(height: 5),
        Text(
          "Note: Late submissions will incur a penalty as per the course policy.",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            CircleAvatar(
              radius: 25,
              child: Image.asset(
                "assets/images/teacher_profile.png",
                width: 50,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ms Nazneen Ansari",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  "Uploaded on 12 Oct 2025",
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class UploadTaskSection extends StatefulWidget {
  const UploadTaskSection({super.key});

  @override
  State<UploadTaskSection> createState() => _UploadTaskSectionState();
}

class _UploadTaskSectionState extends State<UploadTaskSection> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();
  String? _fileName;
  bool _hasUploaded = false;
  bool _showSuffixIcon = false;

  @override
  void initState() {
    super.initState();
    _linkController.addListener(_handleTextChange);
  }

  void _handleTextChange() {
    setState(() {
      _showSuffixIcon = _linkController.text.isNotEmpty;
    });
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg', 'mp4', 'doc', 'docx'],
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _fileName = result.files.single.name;
        _hasUploaded = true;
      });
    }
  }

  void _addLink() {
    if (_linkController.text.trim().isNotEmpty) {
      setState(() {
        _hasUploaded = true;
      });
      FocusScope.of(context).unfocus();
    }
  }

  void _removeAttachment() {
    setState(() {
      _fileName = null;
      _linkController.clear();
      _hasUploaded = false;
    });
  }

  void _handleSubmit() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Task submitted successfully!")),
    );
  }

  @override
  void dispose() {
    _linkController.removeListener(_handleTextChange);
    _linkController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Submit Your Task",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
        const Text("Description"),
        const SizedBox(height: 6),
        TextField(
          controller: _descriptionController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: "Add description",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        const SizedBox(height: 16),

        // Upload Box
        GestureDetector(
          onTap: _pickFile,
          child: DottedBorderContainer(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.cloud_upload_outlined, color: Colors.blue, size: 40),
                SizedBox(width: 15),
                Column(
                  children: [
                    Text(
                      "Click to upload your file",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "PDF, PNG, JPG, MP4 (max size: 30MB)",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        // OR separator
        Row(
          children: const [
            Expanded(child: Divider()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text("or"),
            ),
            Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: 12),

        // Link Input
        TextField(
          controller: _linkController,
          decoration: InputDecoration(
            hintText: "Paste link here",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            prefixIcon: const Icon(Icons.link, color: Colors.grey),
            suffixIcon: _showSuffixIcon
                ? IconButton(
                    onPressed: _addLink,
                    icon: const Icon(Icons.check, color: Colors.green),
                  )
                : null,
          ),
        ),
        const SizedBox(height: 16),

        // Attached Resources
        if (_hasUploaded) ...[
          const Text(
            "Attached resources",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          if (_fileName != null)
            AttachmentTile(label: _fileName!, onDelete: _removeAttachment),
          if (_linkController.text.isNotEmpty)
            AttachmentTile(
              label: _linkController.text,
              onDelete: _removeAttachment,
            ),
          const SizedBox(height: 16),
        ],

        // Submit Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _hasUploaded ? _handleSubmit : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: _hasUploaded
                  ? Colors.indigo.shade900
                  : Colors.grey.shade300,
              foregroundColor: _hasUploaded
                  ? Colors.white
                  : Colors.grey.shade600,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text("Submit"),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}

// Helper Widgets

class DottedBorderContainer extends StatelessWidget {
  final Widget child;
  const DottedBorderContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          style: BorderStyle.solid,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(child: child),
    );
  }
}

class AttachmentTile extends StatelessWidget {
  final String label;
  final VoidCallback onDelete;
  const AttachmentTile({
    super.key,
    required this.label,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: const BorderSide(color: Colors.grey, width: 0.5),
      ),
      child: ListTile(
        dense: true,
        title: Text(label, overflow: TextOverflow.ellipsis),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
