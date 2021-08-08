"init.scd".postln;

s.options.memSize = 102400;

~echo = { |x|

	x.postln;

};

~setup = { |setup|
	var caseFound = false;

	if(setup == "desktop-asio",
		{
			"desktop-asio initialized".postln;
			caseFound = true;
			s.options.outDevice ="Voicemeeter AUX Virtual ASIO";
			s.options.numOutputBusChannels = 2;
			s.options.numInputBusChannels = 2;
			s.reboot;
		},
	);

	if(setup == "desktop-stream",
		{
			"desktop-stream initialized".postln;
			caseFound = true;
			s.options.inDevice ="MME : VoiceMeeter Aux Output";
			s.options.outDevice ="MME : VoiceMeeter Aux Input";
			s.options.numOutputBusChannels = 2;
			s.options.numInputBusChannels = 2;
			s.reboot;
		},
	);

	caseFound.value;
};


