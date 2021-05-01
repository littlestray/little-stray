(
"init.scd".loadRelative;
~setup.value("desktop").postln;
)

{SinOsc.ar(220,0,0.1)!2}.play