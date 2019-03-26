//example for algorithmic music, Pattern, Pbind etc.
(
OSCdef.new(
	\time,
	{
		arg msg;
		msg.postln;

	},
	'/root/x'
)
);


(
OSCdef.new(
	\blood,
	{
		arg msg;
		msg.postln;
		~blood = msg[1]/100;
		~blood.postln;
	},
	'/root/fx'
)
);

(
OSCdef.new(
	\slope,
	{
		arg msg;
		msg.postln;

	},
	'/root/dx'
)
);

(
OSCdef.new(
	\sum,
	{
		arg msg;
		msg.postln;

	},
	'/root/sx'
)
);


(
SynthDef.new(\first, {
	arg freq=440, atk=0.005, rel=0.3, amp=1, pan=0;
	var sig, env;
	sig = SinOsc.ar(freq);
	env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel], [1, -1]), doneAction:2);
	sig = Pan2.ar(sig, pan, amp);
	sig = sig * env;
	Out.ar(0, sig);
}).add;
)

(
Pbind(
		\instrument, \first,
	    \dur, Pfunc({~blood}),
		\freq, 400,
		\harmonic, 8,
		\atk, 0.1,
		\rel, 0.05,
	    \amp, 0.5,
	    \pan, 0,
).play;
)

