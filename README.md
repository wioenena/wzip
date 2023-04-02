# Zip utilities for V
![Last commit](https://img.shields.io/github/last-commit/wioenena-q/wzip?label=Last%20Commit&style=flat-square)
![Size](https://img.shields.io/github/languages/code-size/wioenena-q/wzip?label=Size&style=flat-square)
![Language](https://img.shields.io/github/languages/top/wioenena-q/wzip?label=V&style=flat-square)

## wzip is a more readable version of the szip in V.

### Installation
```bash
v install --git https://github.com/wioenena-q/wzip
```

### Usage looks like this
```v
import szip
import wzip

fn main() {
    mut zip := szip.open("output.zip", .best_compression, .write)!
    defer { zip.close() }

    mut wzip_directory := &wzip.WZipDir {
        path: "my_directory",
        files: [
            &wzip.WZipFile {
                path: "hello.txt",
                bytes: "Hello".bytes()
            }
        ]
    }

    wzip_directory.add_file(&wzip.WZipFile {
        path: "world.txt",
        bytes: "World!".bytes()
    })

    wzip_directory.create(mut zip)!
}
```

## Author
- [wioenena.q](https://github.com/wioenena-q)
