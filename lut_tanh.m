global _lBounds = [0.390625, 0.453125, 0.515625, 0.578125, 0.640625, \
				   0.703125, 0.781250, 0.859375, 0.937500, 1.046875, \
				   1.171875, 1.328125, 1.531250, 1.859375, 2.906250];

#NOTE: Hardware range converter requires atleast 3 integer bits 
global _iBits   = 3;
global _fBits   = 13;

function val = LUT_Tanh(x)
	global _lBounds;
	rVals = genValues(_lBounds);
	rVals(end + 1) = 1;

	fLows = toFixed(_lBounds);
	fVals = toFixed(rVals);

	s = sign(x);
	fMag = toFixed(abs(x));

	if (fMag <= fLows(1))
		val = fMag.x*s;
	else
		for i = [fLows; fVals]
			if (fMag > i(1))
				val = i(2).x*s;
			endif
		endfor
	endif
endfunction

function f = toFixed(x)
	global _iBits;
	global _fBits;
	f = fixed(_iBits, _fBits,x);
endfunction

function setPrecision(ib, fb)
	global _iBits;
	global _fBits;
	_iBits = ib;
	_fBits = fb;
endfunction

function rVals = genValues(bounds)
	#create pairs
	pairs = [];
	rVals = [];
	temp = bounds(1);
	for i = bounds(2:end)
		pairs(end + 1).a = temp;
		pairs(end).b = i;
		temp = i;
	endfor
	
	#get avg value
	for i = pairs
		rVals(end + 1) = 1/(i.b - i.a) * quad(@(x) tanh(x), i.a, i.b);
	endfor
endfunction
