import os

fn target_device(dev_num int) ?int {
	unsafe {
		static ret := int(0)
		if dev_num >= 0 {
			ret = dev_num
			device_name := '\\\\.\\PhysicalDrive' + dev_num.str()
			device := os.open(device_name) or { return error('Device is not exist') }
			device.close()
		}
		return ret
	}
}

fn show_sector(index u64, count u64) ? {
	dev_num := target_device(-1) or { return error('Device is not set') }
	println('device #${dev_num}')
	device_name := '\\\\.\\PhysicalDrive' + dev_num.str()
	mut device := os.open(device_name) or { return error('Device is not exist') }
	for i in 0 .. count {
		buf := device.read_bytes_at(512, (i + index) * 512)
		if buf.len == 0 {
			return error('wrong sector')
		}
		print_hexdump(buf)
	}
	device.close()
}

fn command(cmd string) ? {
	token := cmd.replace('\r\n', '').split(' ')
	if token.len > 0
	{
		task_name := token[0]
		match task_name {
			'h', 'help' { println('help message') }
			'd', 'device' {
				if token.len > 1 {
					dev_num := token[1].int()
					if dev_num >= 0 {
						target_device(token[1].int())
						or {
							println('Specified device does not exist')
						}
					} else {
						println('Specified device does not exist')
					}
				}
			}
			's', 'sector' {
				if token.len > 1 {
					if token.len > 2 {
						show_sector(u64(token[1].int()), u64(token[2].int())) or { println('Sector is not reachable') }
					} else {
						show_sector(u64(token[1].int()), 1) or { println('Sector is not reachable') }
					}
				}
			}
			'q', 'quit' { exit(0) }
			else { println(task_name) }
		}
	}
	
}