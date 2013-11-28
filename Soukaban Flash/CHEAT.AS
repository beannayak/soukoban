keycodes = [65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96]
keyvalues = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
for (x=0 ; x<=26 ; x++){
	if (Key.getCode() == keycodes[x]){
		_level0.cheat = _level0.cheat + keyvalues[x];
	}
}
mystring = new String(_level0.cheat);
if (_level0.cheat == "binayak"){
	a = _root.level;
	b = Number(a) + 1;
	atext = eval("_level0.level" + b + "text");
	_root.create(atext);
	_root.level = b;
	_level0.cheat = "";
}else if (mystring.length >= 7 && _level0.cheat != "priya"){
	_level0.cheat = "";
}