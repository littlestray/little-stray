// "C:/Users/Chris/Documents/github/little-stray/ir/ac30.wav"

(

SynthDef.new(\input, {
	arg in=0, out=0, amp=1;
	var sig;
	sig = SoundIn.ar(in!2) * amp;
	Out.ar(out, sig);
}).add;

SynthDef.new(\ampSim, {
	arg in=0, out=0, amp=1, irBuf;
	var sig, kernal;
	sig = In.ar(in, 2) * amp;
	kernal = PlayBuf.ar(2, buf,1,1,0,0,0)
	Out.ar(out, sig);
}).add;

)




(

~bAmpIr = Buffer.read(s, "C:/Users/Chris/Documents/github/little-stray/ir/ac30.wav");

~guitarIn = 0;
~ampBus = Bus.audio(s, 2);

~inputGrp  = Group.new;
~ampGrp = Group.after(~inputGrp);

~inputSynth = Synth(\input, [\in, ~guitarIn, \out, ~ampBus], ~inputGrp);
~ampSynth   = Synth(\ampSim, [\in, ~ampBus, \out, 0], ~ampGrp);

)

~ampGrp.set(\amp, 1);

s.freeAll;
