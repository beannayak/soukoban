function canceldown(blockno) {
	blockno += 1;
	values = [8, 17, 26, 35, 44, 53, 62, 71, 80, 89];
	var valuefound = 0;
	for (x = 0; x <= 9; x++) {
		if (blockno == values[x]) {
			valuefound = 1;
		}
	}
	if (valuefound == 0) {
		canmove = true;
	} else {
		canmove = false;
	}
	return canmove;
}
function cancelup(blockno) {
	blockno = blockno - 1;
	values = [0, 9, 18, 27, 36, 45, 54, 63, 72, 81];
	var valuefound = 0;
	for (x = 0; x <= 9; x++) {
		if (blockno == values[x]) {
			valuefound = 1;
		}
	}
	if (valuefound == 0) {
		canmove = true;
	} else {
		canmove = false;
	}
	return canmove;
}