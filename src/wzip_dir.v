module wzip

import szip
import os

pub struct WZipDirEntry {
mut:
	files []WZipFile
pub:
	path string
}

pub fn (mut self WZipDirEntry) add_file(file &WZipFile) {
	self.files << file
}

pub fn (mut self WZipDirEntry) create(mut zip szip.Zip) ! {
	dir_path := os.join_path(self.path, '')
	zip.open_entry(dir_path)!
	zip.close_entry()

	for mut file in self.files {
		if mut file is WZipDirEntry {
			file.create(mut zip)!
		} else if mut file is WZipFileEntry {
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
