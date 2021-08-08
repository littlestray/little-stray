
(
"init.scd".loadRelative;
~setup.value("desktop-asio").postln;
)

//select for streaming
(
"init.scd".loadRelative;
~setup.value("desktop-stream").postln;
)

// Testing 1...2...3...
{SinOsc.ar(220,0,0.1)!2}.play


b = NetAddr.new("127.0.0.1", 6969);
b.sendMsg("/CubeX", 2.0);





