import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;

File normalizePath(String rootPath, String fileName) {
    String filePath = path.join(rootPath, 'images', fileName);
    filePath = path.normalize(filePath);
    File filePathToRead = new File(filePath);
    stdout.write('$filePathToRead\n');
    return filePathToRead;
}

List returnListOfImages() {
    var images = ['https://dev.bgsoft.biz/task/CennImb4CZA.jpg',
                  'https://dev.bgsoft.biz/task/8S6BkMGaLyQ.jpg',
                  'https://dev.bgsoft.biz/task/nU5JmY-umLU.jpg',
                  'https://dev.bgsoft.biz/task/Mq2TTSeeSoM.jpg',
                  'https://dev.bgsoft.biz/task/UrNZXCdFOlg.jpg'
                ];
    return images;
}

List returnListOfPath() {

    var filePathToRead = [normalizePath('${Directory.current.parent.path}', 'CennImb4CZA.jpg'),
                          normalizePath('${Directory.current.parent.path}', '8S6BkMGaLyQ.jpg'),
                          normalizePath('${Directory.current.parent.path}', 'nU5JmY-umLU.jpg'),
                          normalizePath('${Directory.current.parent.path}', 'Mq2TTSeeSoM.jpg'),
                          normalizePath('${Directory.current.parent.path}', 'UrNZXCdFOlg.jpg'),
                         ];
    return filePathToRead;
}

Future <void> downloadImage(final image, final filePathToRead, final i) async {
  final client = HttpClient();
  try {
      stdout.write('\nStart downloading ${i + 1} image\n');
      final request = await client.getUrl(Uri.parse(image));
      final response = await request.close();
      response.pipe(filePathToRead.openWrite());
    } finally {
      client.close();
      stdout.write('\nEnd downloading ${i + 1} image\n');
    }
}

Future <void> main () async {
    List images  = returnListOfImages();
    List filePathToRead = returnListOfPath();
    for (int i = 0; i < images.length; ++i) {
        downloadImage(images[i], filePathToRead[i], i);
    }
}

