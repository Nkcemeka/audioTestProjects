<Cabbage> bounds(0, 0, 0, 0)
form caption("STSynth") size(450, 400), colour(255,255,255), pluginid("def1")
keyboard bounds(6, 300, 438, 85)



groupbox bounds(20, 18, 193, 117) text("OSC") colour(64, 47, 103, 255) fontcolour("255,255,255")

combobox bounds(40, 72, 80, 20) text("Saw", "Tri", "Sine") channel("Waveform")

rslider bounds(130, 60, 63, 58) range(0, 360, 0, 1, 1) text("Phase") trackercolour(255, 160, 0, 240) textcolour(255, 255, 255, 255) popuppostfix("°") channel("Phase")

groupbox bounds(248, 18, 180, 117) text("LPF") colour(64, 47, 103, 255) fontcolour("255,255,255")
rslider bounds(264, 60, 63, 58) range(0, 20000, 1520, 0.25, 0.01) text("Cutoff") trackercolour(255, 160, 0, 240) textcolour(255, 255, 255, 255) channel("Cutoff") popuppostfix(" Hz")

rslider bounds(350, 60, 63, 58) range(0, 1, 0, 1, 0.1) text("Resonance") trackercolour("255,160,0,240") textcolour("255,255,255") channel("Resonance") popuppostfix(" ")
groupbox bounds(20, 154, 410, 133) text("VCA") colour(64, 47, 103, 255)  fontcolour("255,255,255")
rslider bounds(140, 184, 48, 53) range(0, 1, 0, 1, 0.1) text("S") trackercolour("255,160,0,240") textcolour("255,255,255") channel("Sustain") popuppostfix(" ")
rslider bounds(40, 184, 48, 53) range(0, 1, 0, 1, 0.1) text("A") trackercolour("255,160,0,240") textcolour("255,255,255") channel("Attack") popuppostfix(" s")
rslider bounds(90, 184, 48, 53) range(0, 1, 0, 1, 0.1) text("D") trackercolour("255,160,0,240") textcolour("255,255,255") channel("Decay") popuppostfix(" s")
rslider bounds(190, 184, 48, 53) range(0, 1, 0, 1, 0.1) text("R") trackercolour("255,160,0,240") textcolour("255,255,255") channel("Release") popuppostfix(" s")
rslider bounds(290, 184, 48, 53) range(0, 100, 0, 1, 1) trackercolour("255,160,0,240") text("Amt") textcolour("255,255,255") channel("Amount") popuppostfix(" %")

hslider bounds(40, 234, 150, 50) range(0, 100, 0, 1, 1) trackercolour("255,160,0,240") text("Volume") textcolour("255,255,255") channel("Volume") popuppostfix(" %")
</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d --midi-key-cps=4 --midi-velocity-amp=5
</CsOptions>
<CsInstruments>
; Initialize the global variables. 
ksmps = 32
nchnls = 2
0dbfs = 1 

;instrument will be triggered by keyboard widget
instr 1

    iFreq = p4
    iPh chnget "Phase"
    iPhnorm = iPh/360
    kPhase = k(iPhnorm)
    iAmt = 1-(chnget:i("Amount")/100)
    iVol = chnget:i("Volume")/100
    
    ;Sine wave
    gisine ftgen 0, 0, 2^16+1, 10, 1
    gisinefree vco2init -1, gisine+1, 1.05, 128, 2^16, gisine

  
    kEnv madsr chnget:i("Attack")+0.1, chnget:i("Decay"), chnget:i("Sustain"), chnget:i("Release")
    
    if chnget:k("Waveform") == 1 then
        aVco vco2 p5*kEnv, iFreq, 0, 0, kPhase
        aLp moogladder aVco, chnget:k("Cutoff"),chnget:k("Resonance")
        
    elseif chnget:k("Waveform") == 2 then
        aVco vco2 p5, iFreq, 12, 0, kPhase
        aLp moogladder aVco, chnget:k("Cutoff"), chnget:k("Resonance")
        
    elseif chnget:k("Waveform") == 3 then
        aVco vco2 p5, iFreq, 14, 0, kPhase
        aLp moogladder aVco, chnget:k("Cutoff"), chnget:k("Resonance")
    endif
    
    
    aOutput = aLp*iVol
 
    outs aOutput, aOutput

endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
</CsScore>
</CsoundSynthesizer>
