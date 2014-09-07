buzzer <- hardware.pin1;

// Music note frequencies
local notes = {
    c2 = 65.41,
    d2 = 73.42,
    e2 = 82.41,
    f2 = 87.31,
    g2 = 98.00,
    a3 = 110.00,
    b3 = 123.47,
    c3 = 130.81,
    d3 = 146.83,
    e3 = 164.81,
    f3 = 174.61,
    g3 = 196.00,
    a4 = 220.00,
    b4 = 246.94,
    c4 = 261.63
}

/*
    play("c2", true);
    play("c3", false);
    play("e3", false);
    play("b4", false);
*/

function play(note, lead) {
    
    // more sloppy hackathon code
    if (lead) {
		// lead notes are special. Always C3 to 'calibrate' the human ear
        if (note == "phone") {
			// Three quick tones
            buzzer.configure(PWM_OUT, (1.0 / notes["c3"]) / 4, 0.5);
            imp.sleep(1.0/16);
            buzzer.write(0);
            imp.sleep(1.0/32);
            buzzer.configure(PWM_OUT, (1.0 / notes["c3"]) / 4, 0.5);
            imp.sleep(1.0/16);
            buzzer.write(0);
            imp.sleep(1.0/32);
            buzzer.configure(PWM_OUT, (1.0 / notes["c3"]) / 4, 0.5);
            imp.sleep(1.0/16);
            buzzer.write(0);
        } else if (note == "text") {
			// Two tones
            buzzer.configure(PWM_OUT, (1.0 / notes["c3"]) / 4, 0.5);
            imp.sleep(1.0/12);
            buzzer.write(0);
            imp.sleep(1.0/24);
            buzzer.configure(PWM_OUT, (1.0 / notes["c3"]) / 4, 0.5);
            imp.sleep(1.0/12);
            buzzer.write(0);
        } else if (note == "email") {
			// One long tone
            buzzer.configure(PWM_OUT, (1.0 / notes["c3"]) / 4, 0.5);
            imp.sleep(1.0/8);
            buzzer.write(0);
        }
        
        imp.sleep(1.0/6);
    } else {
		// non-lead tones are always the same length
        buzzer.configure(PWM_OUT, (1.0 / notes[note]) / 4, 0.5);
        imp.sleep(1.0/8);
        buzzer.write(0);
        imp.sleep(1.0/8);
    }

}

// This event is triggered from the hosted web project
function notifier(arguments) {
    play(arguments[0], true);
    
    for (local i = 1; i < arguments.len(); i++) {
        play(arguments[i], false);
    }
}
agent.on("notify", notifier)
