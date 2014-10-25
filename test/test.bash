#!/bin/bash


. $(dirname ${0})/../functions.bash #in your bash script

echo '### decorate test'
echo $(decorate_string not decorate)

echo $(decorate_string -b bold)
echo $(decorate_string -s line-through)
echo $(decorate_string -u underline)
echo $(decorate_string -l blink)
echo $(decorate_string -r reverse)
echo $(decorate_string -n no display)

echo
echo $(decorate_string -c black   black   color string)
echo $(decorate_string -c red     red     color string)
echo $(decorate_string -c green   green   color string)
echo $(decorate_string -c yellow  yellow  color string)
echo $(decorate_string -c blue    blue    color string)
echo $(decorate_string -c magenta magenta color string)
echo $(decorate_string -c cyan    cyan    color string)
echo $(decorate_string -c white   white   color string)

echo
echo $(decorate_string -c 30 black   color string - number)
echo $(decorate_string -c 31 red     color string - number)
echo $(decorate_string -c 32 green   color string - number)
echo $(decorate_string -c 33 yellow  color string - number)
echo $(decorate_string -c 34 blue    color string - number)
echo $(decorate_string -c 35 magenta color string - number)
echo $(decorate_string -c 36 cyan    color string - number)
echo $(decorate_string -c 37 white   color string - number)

echo
echo $(decorate_string -g black   black   color background)
echo $(decorate_string -g red     red     color background)
echo $(decorate_string -g green   green   color background)
echo $(decorate_string -g yellow  yellow  color background)
echo $(decorate_string -g blue    blue    color background)
echo $(decorate_string -g magenta magenta color background)
echo $(decorate_string -g cyan    cyan    color background)
echo $(decorate_string -g white   white   color background)

echo
echo $(decorate_string -g 40 black   color background - number)
echo $(decorate_string -g 41 red     color background - number)
echo $(decorate_string -g 42 green   color background - number)
echo $(decorate_string -g 43 yellow  color background - number)
echo $(decorate_string -g 44 blue    color background - number)
echo $(decorate_string -g 45 magenta color background - number)
echo $(decorate_string -g 46 cyan    color background - number)
echo $(decorate_string -g 47 white   color background - number)

echo
echo $(decorate_string -c blue -g red -b -u blue string, red background, bold and underline)
echo $(decorate_string -c blue -g red -r blue string, red background but reverse)

echo
echo "$(decorate_string -c green -g magenta -u -o green string, magenta background and underline)"
echo "$(decorate_string -c green -g magenta -u -O green string code, magenta background code and underline code)"
echo '### decorate test end'

echo
echo '### general output'
error error string
inf '===' error message redirect stderr to null. next row should be warn test.
error error string 2>/dev/null
warn warn string
inf '===' warn message redirect stderr to null. next row should be info test.
warn warn string 2>/dev/null
inf info string
inf '===' info message redirect stderr to null. next row should be msg test.
inf info string 2>/dev/null
msg message string
comp "complete" string
echo '### general output end'

decorate_string -c blue   black   color string
decorate_string -c red     red     color string
echo
echo '### hr'
hr
hr -n 50
hr -s '='
hr -s '$' -t -n 1000
hr -s '>' -T -n 500
hr -c
hr -r
echo '### hr end'

echo '### shhelp-gen'
shhelp-gen $(dirname ${0})/../functions.bash
shhelp-gen -j $(dirname ${0})/../functions.bash
echo '### shhelp-gen end'
