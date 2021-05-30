fn is_print(c byte) bool {
	return c.is_digit() || c.is_letter()
}

fn flatval(val int, flat int) int {
	return val + (flat - (val % flat))
}

fn print_hexdump(buf []byte) {
	lines := buf.len / 16 + int(((buf.len % 16) != 0))
	for i in 0 .. lines {
		print('${i.hex():8}||')
		for v in 0 .. 16 {
			c := buf[i * 16 + v]
			print('${c.hex()}')
			if i * 16 + v == buf.len || v == 15 {
				break
			}
			print(' ')
		}
		print('||')
		for v in 0 .. 16 {
			c := buf[i * 16 + v]
			if is_print(c) {
				print('${c.ascii_str()}')
			} else {
				print('.')
			}
			if i * 16 + v == buf.len {
				break
			}
		}
		print("\n")
	}
}

