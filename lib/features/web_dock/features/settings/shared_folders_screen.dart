import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import '../../data/models/shared_folder.dart';
import 'package:miros_share_and_web_dock/core/app_providers.dart';
import 'package:path/path.dart' as p;

final sharedFoldersProvider = FutureProvider((ref) async {
  final db = ref.watch(databaseProvider);
  return db.getAllSharedFolders();
});

class SharedFoldersScreen extends ConsumerWidget {
  const SharedFoldersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foldersAsync = ref.watch(sharedFoldersProvider);
    final db = ref.watch(databaseProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Shared Folders')),
      body: foldersAsync.when(
        data: (folders) {
          if (folders.isEmpty) {
            return const Center(child: Text('No folders shared yet.'));
          }
          return ListView.builder(
            itemCount: folders.length,
            itemBuilder: (context, index) {
              final folder = folders[index];
              return ListTile(
                title: Text(folder.name),
                subtitle: Text(
                  '${folder.virtualPath} -> ${folder.physicalPath}',
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    await db.removeSharedFolder(folder.id);
                    ref.invalidate(sharedFoldersProvider);
                  },
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String? selectedDirectory = await FilePicker.getDirectoryPath();
          if (selectedDirectory != null) {
            final folders = await db.getAllSharedFolders();
            String name = p.basename(selectedDirectory);
            String virtualPath = name.toLowerCase().replaceAll(' ', '_');

            // Handle name/path conflicts
            int counter = 1;
            while (folders.any((f) => f.virtualPath == virtualPath)) {
              virtualPath =
                  '${name.toLowerCase().replaceAll(' ', '_')}_$counter';
              counter++;
            }

            final folder = SharedFolder()
              ..physicalPath = selectedDirectory
              ..name = name
              ..virtualPath = virtualPath;

            await db.addSharedFolder(folder);
            ref.invalidate(sharedFoldersProvider);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}



