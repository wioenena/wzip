module wzip

import os

pub struct WZipFileEntry {
mut:
	bytes []u8

	path string
}

pub fn (mut self WZipFileEntry) get_bytes() ![]u8 {
	if self.bytes.len != 0 {
		return self.bytes
	}

	self.bytes = os.read_bytes(self.path)!

	return self.bytes
}
