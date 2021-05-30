import os

fn main () {
	for {
		print('(> ')
		mut cmd := os.get_raw_line()
		command(cmd)?
	}
}