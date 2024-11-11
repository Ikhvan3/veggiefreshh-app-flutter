class AppConfig {
  // Gunakan getter untuk memastikan nilai selalu konsisten
  static String get baseUrl => 'http://192.168.1.20:8000';
  static String get apiUrl => '$baseUrl/api';

  static String getFullImageUrl(String path) {
    try {
      // Debug prints
      print('Original path: $path');
      print('Base URL: $baseUrl');

      // Jika path sudah berupa URL lengkap, extract path-nya saja
      if (path.startsWith('http')) {
        Uri uri = Uri.parse(path);
        path = uri.path;
        print('Extracted path from full URL: $path');
      }

      // Bersihkan path
      String cleanPath = path
          .replaceAll('/storage/storage/', '/storage/')
          .replaceAll('storage/storage/', '/storage/');

      if (!cleanPath.startsWith('/storage/')) {
        cleanPath = '/storage/' + cleanPath;
      }

      String fullUrl = '$baseUrl$cleanPath';
      print('Final constructed URL: $fullUrl');

      return fullUrl;
    } catch (e) {
      print('Error in getFullImageUrl: $e');
      return path; // Return original path if processing fails
    }
  }
}
