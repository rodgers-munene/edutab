import 'package:flutter/material.dart';

class PendingTasks extends StatelessWidget {
  const PendingTasks({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> pendingTasks = [
      {
        "task": "Database Design Assignment",
        "teacher": "Mr. Kamau",
        "imgPath": "assets/images/task1.png",
      },
      {
        "task": "Submit Flutter UI Prototype",
        "teacher": "Ms. Achieng",
        "imgPath": "assets/images/task2.png",
      },
      {
        "task": "Review AI Research Paper",
        "teacher": "Dr. Otieno",
        "imgPath": "assets/images/task2.png",
      },
    ];

    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: pendingTasks.length,
        itemBuilder: (context, index) {
          final task = pendingTasks[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: PendingTaskCard(
              assigner: task['teacher']!,
              imgPath: task['imgPath']!,
              taskTitle: task['task']!,
            ),
          );
        },
      ),
    );
  }
}

class PendingTaskCard extends StatelessWidget {
  final String imgPath;
  final String taskTitle;
  final String assigner;

  const PendingTaskCard({
    super.key,
    required this.assigner,
    required this.imgPath,
    required this.taskTitle,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width * .6,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            spreadRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              imgPath,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  taskTitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(assigner, style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.w600),),
                    TextButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text("View"),
                          const SizedBox(width: 5,),
                          const Icon(Icons.arrow_forward, size: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
