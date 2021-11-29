{SinOsc.ar(220, 0, 0.1)}.play

(
SynthDef(\bee, {arg freq = 440, detune = 1, out = 0, amp = 0.1, pan = 0, cutoff = 2000;
	var sig;
	var env = Env.new(levels: [0, 1, 0.9, 0], times: [0.1, 0.1, 0.1], curve: [-5, 0, -5]);
	sig = Saw.ar(
				MulAdd(
					freq,
					detune,
					0),
				amp,
				0
			);
	sig = LPF.ar(sig, cutoff);
	sig = sig * SinOsc.kr(0.1);
	Out.ar(out,
		Pan2.ar(
			sig,
			pan,
			1));
}).add;

SynthDef(\reverb, {
	arg in, out = 0, delay = 1, delayAmt = 0.5;
	var sig;
	sig = In.ar(in,2);
	sig = DelayL.ar(sig, 4, delay, delayAmt, sig);
	sig = FreeVerb.ar(sig, 0.5, 0.8, 0.2);
	sig = HPF.ar(sig, 30,1);
	sig = HPF.ar(sig, 30,1);
	sig = Limiter.ar(sig, 0.99, 0.01);
	Out.ar(out, sig);
}).add;

)

//--------------------------------------------------------------GLOBAL VARIABLES


~detuneAmount = 0.002;
~detuneAmount = 0.02;
~detuneAmount = 0.2;
~detuneAmount = 02;


//-----------------------------------------------------------------DECLARE GROUP
(
~reverbBus = Bus.audio(s, 2);

~beeGrp = Group.new();

~detuneAmount = 0.002;
)
//--------------------------------------------------------------INSTANTIATE BEES
(
~beeList = Array.fill(8, {
	Synth.new("bee", [\freq, 220, \out, ~reverbBus], ~beeGrp);
});

~reverb = Synth.new(\reverb, [\in, ~reverbBus], ~beeGrp, \addAfter);

)

//-------------------------------------------------------------------SEQUENCING

(
Pdef(
	\fringe,
Pbind(
	\type, \set,
	\id, ~beeGrp.nodeID,
		// \midinote, Pxrand([41, 41, 41.02, 41.025, 45.1, 45.85, 56.77, 60.1, 64, 65, 69, 69.66, 70, 69.90, 76], inf).trace,
		\midinote, Pxrand([41, 41, 41.02, 41.025, 45.1, 45.85, 56.86, 60.1, 64, 65, 69, 69.90, 76],inf).trace,
		// \dur, 0.05,
		\dur, Prand([0.1],inf).trace,
		\stretch, 60/30 * 4,
	\cutoff, 400,
);
).play

)

(
Pdef(
	\reverb,
Pbind(
	\type, \set,
	\id, ~reverb,
	\delay, Prand([1,2,4], inf),
	\delayAmt, 0.75,


		//DON'T TOUCH
	\dur, 4,
	\stretch, 60/30 * 4,
);
).play

)