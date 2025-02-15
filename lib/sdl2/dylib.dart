import 'dart:ffi';
import 'dart:io';

/// @nodoc
DynamicLibrary dylibOpen(String mark) {
  var header = '';
  var extension = '';
  switch (Platform.operatingSystem) {
    case 'android':
    case 'linux':
    case 'fuchsia':
      header = 'lib';
      extension = '.so';
      break;
    case 'ios':
    case 'macos':
      header = 'lib';
      extension = '.dylib';

      if (!File(header + mark + extension).existsSync()) {
        header = '';
        extension = '.framework/$mark';
      }
      break;
    case 'windows':
      header = '';
      extension = '.dll';
      break;
  }
  return DynamicLibrary.open(header + mark + extension);
}
