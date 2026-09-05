import 'dart:math';

class CyberNameGenerator {
  static const List<String> _prefixes = [
    'Neon', 'Cyber', 'Neural', 'Ghost', 'Void', 'Zero', 'Alpha', 'Nova',
    'Sonic', 'Flash', 'Titan', 'Apex', 'Phantom', 'Azure', 'Crimson',
    'Onyx', 'Vortex', 'Vector', 'Pixel', 'Logic', 'Meta', 'Zen', 'Pulse'
  ];

  static const List<String> _suffixes = [
    'Node', 'Link', 'Core', 'Shell', 'Wave', 'Drive', 'Grid', 'Pulse',
    'Stream', 'Byte', 'Sync', 'Ray', 'Matrix', 'Flow', 'Spark', 'Dash',
    'Prime', 'Signal', 'Vault', 'Shadow', 'Wire', 'Code', 'Gate'
  ];

  static String generate() {
    final random = Random();
    final prefix = _prefixes[random.nextInt(_prefixes.length)];
    final suffix = _suffixes[random.nextInt(_suffixes.length)];
    
    // Add a small numeric suffix for extra 'Cyber' feel
    final id = random.nextInt(99) + 1;
    
    return '$prefix$suffix-$id';
  }
}










































