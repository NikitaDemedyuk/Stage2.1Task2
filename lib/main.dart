import 'dart:io';
import 'package:path/path.dart' as path;

File normalizePath(String rootPath, String fileName) {
    String filePath = path.join(rootPath, 'images', fileName);   // join "directory" and "file.txt" using the current platform's directory separator
    filePath = path.normalize(filePath);                         // Normalizes path, simplifying it by handling .., and ., and removing redundant path separators whenever possible.
    File filePathToRead = new File(filePath);                     // Create an object type File
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

Future <void> downloadImages(final List images, final List filePathToRead) async {
    final request = [];
    for (int i = 0; i < images.length; ++i) {
        request.add(await HttpClient().getUrl(Uri.parse(images[i])));     // An HTTP client for communicating with an HTTP server.
        final response = await request[i].close();                        // Opens a HTTP connection using the GET method.
        response.pipe(filePathToRead[i].openWrite());                     // An IOSink combines a StreamSink of bytes with a StringSink, and allows easy output of both bytes and text.
                                                                          // .openWrite() - creates a new independent IOSink for the file.
                                                                          // .pipe() - binds this stream as the input of the provided StreamConsumer.
    }
}

Future <void> main () async {
    await downloadImages(returnListOfImages(), returnListOfPath());
}

