import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miros_share_and_web_dock/features/web_dock/data/database/database_service.dart';

final databaseProvider = Provider((ref) => DatabaseService());
