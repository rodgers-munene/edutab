import 'package:edutab/models/task_model.dart';
import 'package:edutab/providers/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  // no manual TabController — use DefaultTabController in build

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TaskProvider>().listenToTasks();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('My Tasks'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Consumer<TaskProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading tasks',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    provider.errorMessage ?? "",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => provider.fetchTasks(),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          // Use DefaultTabController and AnimatedBuilder so the tab UI
          // (including the counts/badges) rebuilds on index changes.
          return DefaultTabController(
            length: 2,
            child: Builder(
              builder: (context) {
                final controller = DefaultTabController.of(context)!;
                return AnimatedBuilder(
                  animation: controller,
                  builder: (context, _) => Column(
                    children: [
                      // Custom Tab Bar
                      Container(
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.all(4),
                        
                        child: TabBar(
                          controller: controller,
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                              colors: [
                                Theme.of(context).primaryColor,
                                Theme.of(context).primaryColor.withOpacity(0.8),
                              ],
                            ),
                          ),
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.grey[600],
                          labelStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          unselectedLabelStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                          tabs: [
                            _buildTab(
                              label: 'Pending',
                              count: provider.pendingTasks.length,
                              isSelected: controller.index == 0,
                              selectedColor: Colors.white,
                              unselectedColor: Colors.black,
                            ),
                            _buildTab(
                              label: 'Completed',
                              count: provider.completedTasks.length,
                              isSelected: controller.index == 1,
                              selectedColor: Colors.white,
                              unselectedColor: Colors.black,
                            ),
                          ],
                        ),
                      ),
                      // Tab Views
                      Expanded(
                        child: TabBarView(
                          controller: controller,
                          children: [
                            _TasksList(
                              tasks: provider.pendingTasks,
                              isPending: true,
                            ),
                            _TasksList(
                              tasks: provider.completedTasks,
                              isPending: false,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildTab({
    required String label,
    required int count,
    required bool isSelected,
    required Color selectedColor,
    required Color unselectedColor,
  }) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: isSelected
                  ? selectedColor.withOpacity(0.3)
                  : unselectedColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '$count',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: isSelected ? selectedColor : unselectedColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TasksList extends StatelessWidget {
  final List<TaskModel> tasks;
  final bool isPending;

  const _TasksList({required this.tasks, required this.isPending});

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: isPending
                    ? Colors.orange.withOpacity(0.1)
                    : Colors.green.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isPending ? Icons.task_alt : Icons.check_circle,
                size: 64,
                color: isPending ? Colors.orange[300] : Colors.green[300],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              isPending ? 'No pending tasks' : 'No completed tasks',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isPending
                  ? 'All caught up!'
                  : 'Complete some tasks to see them here',
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return _TaskCard(task: task, isPending: isPending);
      },
    );
  }
}

class _TaskCard extends StatelessWidget {
  final TaskModel task;
  final bool isPending;

  const _TaskCard({required this.task, required this.isPending});

  Color _getPriorityColor() {
    switch (task.priority) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  IconData _getPriorityIcon() {
    switch (task.priority) {
      case 'high':
        return Icons.flag;
      case 'medium':
        return Icons.flag_outlined;
      case 'low':
        return Icons.outlined_flag;
      default:
        return Icons.flag_outlined;
    }
  }

  bool _isOverdue() {
    return !task.isCompleted && task.dueDate.isBefore(DateTime.now());
  }

  String _getDueDateText() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dueDate = DateTime(
      task.dueDate.year,
      task.dueDate.month,
      task.dueDate.day,
    );

    final difference = dueDate.difference(today).inDays;

    if (difference < 0) {
      return 'Overdue';
    } else if (difference == 0) {
      return 'Due Today';
    } else if (difference == 1) {
      return 'Due Tomorrow';
    } else if (difference <= 7) {
      return 'Due in $difference days';
    } else {
      return DateFormat('MMM dd, yyyy').format(task.dueDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final priorityColor = _getPriorityColor();
    final isOverdue = _isOverdue();

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: task.isCompleted ? 1 : 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: isOverdue && !task.isCompleted
            ? BorderSide(color: Colors.red.withOpacity(0.5), width: 2)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: () {
          // Navigate to task details
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Custom Checkbox
                  GestureDetector(
                    onTap: () {
                      context.read<TaskProvider>().toggleTaskCompletion(
                        task.id,
                        !task.isCompleted,
                      );
                    },
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: task.isCompleted
                            ? Colors.green
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: task.isCompleted
                              ? Colors.green
                              : Colors.grey[400]!,
                          width: 2,
                        ),
                      ),
                      child: task.isCompleted
                          ? const Icon(
                              Icons.check,
                              size: 18,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          task.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            decoration: task.isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                            color: task.isCompleted
                                ? Colors.grey[500]
                                : Colors.black87,
                          ),
                        ),
                        // Description
                        if (task.description.isNotEmpty) ...[
                          const SizedBox(height: 6),
                          Text(
                            task.description,
                            style: TextStyle(
                              fontSize: 14,
                              color: task.isCompleted
                                  ? Colors.grey[400]
                                  : Colors.grey[600],
                              decoration: task.isCompleted
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                        const SizedBox(height: 12),
                        // Tags Row
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            // Subject Tag
                            if (task.subject.isNotEmpty)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.blue.withOpacity(0.3),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.book,
                                      size: 14,
                                      color: Colors.blue[700],
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      task.subject,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.blue[700],
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            // Priority Tag
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: priorityColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: priorityColor.withOpacity(0.3),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    _getPriorityIcon(),
                                    size: 14,
                                    color: priorityColor,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    task.priority.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: priorityColor,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Due Date Tag
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: isOverdue
                                    ? Colors.red.withOpacity(0.1)
                                    : Colors.grey.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: isOverdue
                                      ? Colors.red.withOpacity(0.3)
                                      : Colors.grey.withOpacity(0.3),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    isOverdue
                                        ? Icons.warning_amber_rounded
                                        : Icons.calendar_today,
                                    size: 14,
                                    color: isOverdue
                                        ? Colors.red[700]
                                        : Colors.grey[700],
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    _getDueDateText(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isOverdue
                                          ? Colors.red[700]
                                          : Colors.grey[700],
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
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
              // Overdue Banner
              if (isOverdue && !task.isCompleted) ...[
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.red.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: Colors.red[700]),
                      const SizedBox(width: 6),
                      Text(
                        'This task is overdue! Complete it soon.',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.red[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
