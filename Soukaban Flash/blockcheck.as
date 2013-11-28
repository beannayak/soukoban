a = _level0.lastkeypressed;
d = Number(b[90]);
if (a == "left"){ d = d + 9;}
if (a == "right"){ d = d -9;}
if (a == "up"){ d = d +1;}
if (a == "down"){ d = d -1;}
toplace_mc = eval("_root.block"+ d);
_root.soukaban._x = toplace_mc._x;
_root.soukaban._y = toplace_mc._y;