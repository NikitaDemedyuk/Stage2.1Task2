import 'dart:io';
import 'package:path/path.dart' as path;

File normalizePath(String rootPath, String fileName) {
    String filePath = path.join(rootPath, fileName);
    //stdout.write('${path.join(rootPath, fileName)}\n');
    filePath = path.normalize(filePath);
    //stdout.write('${path.normalize(filePath)}\n');
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

    var filePathToRead = [normalizePath('${Directory.current.path}', 'CennImb4CZA.jpg'),
                          normalizePath('${Directory.current.path}', '8S6BkMGaLyQ.jpg'),
                          normalizePath('${Directory.current.path}', 'nU5JmY-umLU.jpg'),
                          normalizePath('${Directory.current.path}', 'Mq2TTSeeSoM.jpg'),
                          normalizePath('${Directory.current.path}', 'UrNZXCdFOlg.jpg'),
                         ];
    return filePathToRead;
}

Future <void> downloadImages(final List images, final List filePathToRead) async {
    final request = [];
    for (int i = 0; i < images.length; ++i) {
      request.add(await HttpClient().getUrl(Uri.parse(images[i])));
       final response = await request[i].close();
       response.pipe(filePathToRead[i].openWrite());
    }
}

Future <void> main () async {
    await downloadImages(returnListOfImages(), returnListOfPath());
}

