module main

import szip
import wzip

fn main() {
	mut zip := szip.open('output.zip', .best_compression, .write)!
	defer {
		zip.close()
	}

	mut dir_entry := &wzip.WZipDirEntry{
		path: 'my_directory'
		files: []
	}

	mut second_dir_entry := &wzip.WZipDirEntry {
		path: "my_second_directory",
		files: [
			&wzip.WZipFileEntry {
				path: "world.txt",
				bytes: "World!".bytes()
			}
		]
	}

	file_entry := &wzip.WZipFileEntry{
		path: 'hello.txt'
		bytes: 'Hello'.bytes()
	}

	dir_entry.add_file(file_entry)
	dir_entry.add_file(second_dir_entry)
	dir_entry.create(mut zip)!
}
