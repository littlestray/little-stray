
(
"init.scd".loadRelative;
~setup.value("desktop-asio").postln;
)

//select for streaming
(
"init.scd".loadRelative;
~setup.value("desktop-stream").postln;
)

{SinOsc.ar(220,0,0.1)!2}.play


b = NetAddr.new("127.0.0.1", 6969);





b.sendMsg("/CubeX", 2.0);

(
{
	"hello".post
}.play
)



a = r{ i = i+1; i.yield };

a.next.postln;

r = Routine({
    var delta;
    loop {
        delta = rrand(1, 3) * 0.5;
        Synth(\singrain, [freq: exprand(200, 800), amp: rrand(0.1, 0.5), sustain: delta * 0.8]);
        delta.yield;
    }
});
)

(
r = Routine({
    var delta;
    loop {
		delta = Pseq([1,2,3,4], inf).asStream.next.yield.postln;
		b.sendMsg("/CubeX", delta);
		delta.postln;
		delta.yield;

    }
});
)

r.play(TempoClock, 2);
r.stop

q = r.p.asStream

q.next

Pdef(\test,
	PBind(

b.sendMsg("/CubeX", r.play);

n = NetAddr("127.0.0.1", 6969);

(
// Play a sine wave lfo outputting it's value to the control bus above
Ndef(\sinelfo, { |lfoFreq=1, updateFreq=100|
    var sig = SinOsc.kr(lfoFreq);
    SendReply.kr(Impulse.kr(updateFreq), '/1lfo/val', sig);
});

// Register a callback function that is called whenever our lfo sends it's
// output to it and then pass on the single value of the lfo to our osc
// destination
OSCdef(\lfosend1, { |msg, time, addr, port|
    var val = msg[3];
    n.sendMsg("/yo", val);
}, '/1lfo/val');
)