with_fx :reverb, damp: 0.2, amp: 0.7 do |r|
  pitch_melt = 0;
  
  live_loop :foo do |x|
    x -= 0.005
    pitch_melt = x
    play 70 + x
    play 74 + x
    sleep 1
    play 70 + x
    if one_in(2)
      control r, room: 0.3
      play 75 + x
      play 65 + x
    else
      control r, room: 1
      play 75.25 + x
      play 63.25 + x
    end
    sleep 1
    x
  end
  with_synth :tb303 do
    live_loop :foo2 do
      play 70 - 24 + pitch_melt, cutoff: rrand(40, 70), release: rand(0.9)
      sleep (2.0/3.0)
    end
    
    b = 70.0
    
    live_loop :foo3 do |a|
      a += 1.0
      play_pattern_timed chord(82, :M7) + pitch_melt, (a / 7.0), cutoff: 70
      a
    end
    
  end
end


