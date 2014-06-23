global _lBounds = [0.390625, 0.453125, 0.515625, 0.578125, 0.640625, \
				   0.703125, 0.781250, 0.859375, 0.937500, 1.046875, \
				   1.171875, 1.328125, 1.531250, 1.859375, 2.906250];

global _rVals	= [0.4049  , 0.4558  , 0.5038  , 0.5490  , 0.5911  , \
				   0.6348  , 0.6791  , 0.7190  , 0.7609  , 0.8057  , \
				   0.8493  , 0.8916  , 0.9329  , 0.9740  , 1.0000  ];

global _iBits   = 2;
global _fBits   = 14;

function val = LUT_Tanh(x)
	global _lBounds;
	global _rVals;
	
	fLows = toFixed(_lBounds);
	fVals = toFixed(_rVals);

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
