module wzip

import szip
import os

pub struct WZipDir {
mut:
	files []IWZipFile
pub:
	path string
}

pub fn (mut self WZipDir) add_file(file &IWZipFile) {
	self.files << file
}

pub fn (mut self WZipDir) create(mut zip szip.Zip) ! {
	dir_path := os.join_path(self.path, '')
	zip.open_entry(dir_path)!
	zip.close_entry()

	for mut file in self.files {
		if mut file is WZipDir {
			file.create(mut zip)!
		} else if mut file is WZipFile {
			relative_path := os.join_path(dir_path, file.path)
			zip.open_entry(relative_path)!

			file_bytes := file.get_bytes()!
			if file_bytes.len != 0 {
				zip.write_entry(file_bytes)!
			}
			zip.close_entry()
		}
	}
}
