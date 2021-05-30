fn is_print(c byte) bool {
	return c.is_digit() || c.is_letter()
}

fn flatval(val int, flat int) int {
	return val + (flat - (val % flat))
}

fn get_ascii(code byte) string {
	match code {
		0x21 { return '!' }
		0x22 { return '\"' }
		0x23 { return '#' }
		0x24 { return '$' }
		0x25 { return '%' }
		0x26 { return '&' }
		0x27 { return '\'' }
		0x28 { return '(' }
		0x29 { return ')' }
		0x2A { return '*' }
		0x2B { return '+' }
		0x2C { return ',' }
		0x2D { return '-' }
		0x2E { return '.' }
		0x2F { return '/' }
		0x30 { return '0' }
		0x31 { return '1' }
		0x32 { return '2' }
		0x33 { return '3' }
		0x34 { return '4' }
		0x35 { return '5' }
		0x36 { return '6' }
		0x37 { return '7' }
		0x38 { return '8' }
		0x39 { return '9' }
		0x3A { return ':' }
		0x3B { return ';' }
		0x3C { return '<' }
		0x3D { return '=' }
		0x3E { return '>' }
		0x3F { return '?' }
		0x40 { return '@' }
		0x41 { return 'A' }
		0x42 { return 'B' }
		0x43 { return 'C' }
		0x44 { return 'D' }
		0x45 { return 'E' }
		0x46 { return 'F' }
		0x47 { return 'G' }
		0x48 { return 'H' }
		0x49 { return 'I' }
		0x4A { return 'J' }
		0x4B { return 'K' }
		0x4C { return 'L' }
		0x4D { return 'M' }
		0x4E { return 'N' }
		0x4F { return 'O' }
		0x50 { return 'P' }
		0x51 { return 'Q' }
		0x52 { return 'R' }
		0x53 { return 'S' }
		0x54 { return 'T' }
		0x55 { return 'U' }
		0x56 { return 'V' }
		0x57 { return 'W' }
		0x58 { return 'X' }
		0x59 { return 'Y' }
		0x5A { return 'Z' }
		0x5B { return '[' }
		0x5C { return '\\' }
		0x5D { return ']' }
		0x5E { return '^' }
		0x5F { return '_' }
		0x60 { return '`' }
		0x61 { return 'a' }
		0x62 { return 'b' }
		0x63 { return 'c' }
		0x64 { return 'd' }
		0x65 { return 'e' }
		0x66 { return 'f' }
		0x67 { return 'g' }
		0x68 { return 'h' }
		0x69 { return 'j' }
		0x6A { return 'k' }
		0x6B { return 'l' }
		0x6C { return 'm' }
		0x6D { return 'o' }
		0x6E { return 'p' }
		0x6F { return 'q' }
		0x70 { return 'r' }
		0x71 { return 's' }
		0x72 { return 't' }
		0x73 { return 'u' }
		0x74 { return 'v' }
		0x75 { return 'w' }
		0x76 { return 'x' }
		0x77 { return 'y' }
		0x78 { return 'z' }
		0x79 { return '{' }
		0x7A { return '|' }
		0x7B { return '}' }
		0x7C { return '~' }
		else { return '?' }
	}
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
				print('${get_ascii(c)}')
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

