#functions.bash ver.1.0.0
This is general bash script functions.

Version: 1.0.0
Author : minanon
License: {{{}}}


###Contents
- Introduction
- Install
- Usage
- Functions
  - parse_echo_param()
  - parse_echo_string()
  - error()
  - warn()
  - inf()
  - msg()
  - comp()
  - decorate_string()
  - truncate_string()
  - centering()
  - right_align()
  - hr()
  - shhelp-gen()
- ChangeLog

##Introduction
This is general bash script functions.

##Install
Please install from github.

    git clone https://github.com/minanon/functions.bash


##Usage
```shell-session
. functions.bash #in your bash script
```

##Functions
###parse_echo_param()
get param for "echo" from param

####Parameter
- parameters ..

####return
option params

####Usage	parse_echo_param()
```shell-session
parse_echo_param <mixed>
```

###parse_echo_string()
get string for "echo" from param

####Parameter
- parameters ..

####return
string params

####Usage	parse_echo_string()
```shell-session
parse_echo_string <mixed>
```

###error()
output red color string to stderr

####Parameter
- message .. output this messages

####Usage	error()
```shell-session
error <string>
```

###warn()
output yellow color string to stderr

####Parameter
- message .. output this messages

####Usage	warn()
```shell-session
warn <string>
```

###inf()
output blue color string to stderr

####Parameter
- message .. output this messages

####Usage	inf()
```shell-session
inf <string>
```

###msg()
output to stdout

####Parameter
- message .. output this messages

####Usage	msg()
```shell-session
msg <string>
```

###comp()
output green color to stdout

####Parameter
- message .. output this messages

####Usage	comp()
```shell-session
comp <string>
```

###decorate_string()
decorate string

####Parameter
- -b bold
- -s line-through
- -u underline
- -l blink
- -r reverse color
- -n disable decoration
- -c {color_code} string color
- -g {color_code} background color
- -o return decorated string(default)
- -O return escaped string
- message .. output this messages

####color code:(number or name)  
|for font|for background|color name|  
|---     |---           |---       |  
|30      |40            |black     |  
|31      |41            |red       |  
|32      |42            |green     |  
|33      |43            |yellow    |  
|34      |44            |blue      |  
|35      |45            |magenta   |  
|36      |46            |cyan      |  
|37      |47            |white     |

####Usage	decorate_string()
```shell-session
decorate_string [-bsulrnoO] [-c {color_code}] [-g {color_code}] <string>
```

###truncate_string()
truncate the character protruding from the window

####Parameter
- truncate string

####Usage	truncate_string()
```shell-session
truncate_string <string>
```

###centering()
centering string

####Parameter
- centering align string

####Usage	centering()
```shell-session
centering <string>
```

###right_align()
right align string

####Parameter
- right align string

####Usage	right_align()
```shell-session
right_align <string>
```

###hr()
Horizontal Rule

####Parameter
- -c centering
- -r right align
- -t truncate the character protruding from the window(default)
- -T NOT truncate the character protruding from the window
- -n {repeat_count} repeat count(default: 20)
- -s {line_string} line string(default: '-')

####Usage	hr()
```shell-session
hr [-crtT] [-n {repeat_count}] [-s {line_string}]
```

###shhelp-gen()
generate shell for README.md

####Parameter
- -j japanese
- shell script filepath

####Usage	shhelp-gen()
```shell-session
shhelp-gen [-j] <string>
```

##ChangeLog
- 2014-10-26
  - Ver.1.0 public this script.
