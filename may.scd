
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