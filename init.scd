"init.scd".postln;

s.options.memSize = 102400;

~echo = { |x|

	x.postln;

};

~setup = { |setup|
	var caseFound = false;

	if(setup == "desktop",
		{
			"desktop initialized".postln;
			caseFound = true;
			s.options.outDevice ="Voicemeeter AUX Virtual ASIO";
			s.options.numOutputBusChannels = 2;
			s.options.numInputBusChannels = 2;
			s.reboot;
		},
	);

	caseFound.value;
};


