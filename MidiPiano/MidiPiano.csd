<Cabbage>
bounds(0, 0, 0, 0)
form caption("MidiPiano") size(1200, 105), colour(255,255,255), pluginid("def1")
keyboard bounds(6, 10, 1188, 85), keysdowncolour(0,0,255) scrollbars(0)

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
    
    ;Sine wave
    gisine ftgen 0, 0, 2^16+1, 10, 1
    gisinefree vco2init -1, gisine+1, 1.05, 128, 2^16, gisine
        
    aVco vco2 p5*0, iFreq, 14, 0
 
    outs aVco, aVco

endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
</CsScore>
</CsoundSynthesizer>
