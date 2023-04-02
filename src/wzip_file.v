module wzip

import os

pub struct WZipFile {
mut:
	bytes []u8

	path string
}

pub fn (mut self WZipFile) get_bytes() ![]u8 {
	if self.bytes.len != 0 {
		return self.bytes
	}

	self.bytes = os.read_bytes(self.path)!

	return self.bytes
}
