# @(#) functions.bash ver.1.1.0
#
# This is general bash script functions.
#
# Version: 1.1.0
# Author : minanon
# License: {{{}}}
#
# Install:
# Please install from github.
#
#     git clone https://github.com/minanon/functions.bash
#
# Usage:
# . functions.bash #in your bash script

##
# get param for "echo" from param
#
# param mixed parameters ..
# return string option params
parse_echo_param()
{
    local param=""
    for p in "${@}"
    do
        case "${p}" in
            "-"*)
                param+=${p/-/}
                ;;
        esac
    done

    if [ "${param}" ]
    then
        echo "-${param} "
    fi

}

##
# get string for "echo" from param
#
# param mixed parameters ..
# return string string params
parse_echo_string()
{
    local str=""
    for p in "${@}"
    do
        case "${p}" in
            "-"*)
                ;;
            *)
                if [ "${str}" ]
                then
                    str+=" "
                fi
                str+="${p}"
                ;;
        esac
    done

    echo "${str}"
}

##
# output red color string to stderr
#
# param string message .. output this messages
error()
{
    params=$(parse_echo_param "${@}")
    str=$(parse_echo_string "${@}")
    echo ${params} $(decorate_string -c red "${str}") 1>&2
}
##
# output yellow color string to stderr
#
# param string message .. output this messages
warn()
{
    params=$(parse_echo_param "${@}")
    str=$(parse_echo_string "${@}")
    echo ${params} $(decorate_string -c yellow "${str}") 1>&2
}
##
# output blue color string to stderr
#
# param string message .. output this messages
inf()
{
    params=$(parse_echo_param "${@}")
    str=$(parse_echo_string "${@}")
    echo ${params} $(decorate_string -c blue "${str}") 1>&2
}

##
# output to stdout
#
# param string message .. output this messages
msg()
{
    echo "${@}"
}
##
# output green color to stdout
#
# param string message .. output this messages
comp()
{
    params=$(parse_echo_param "${@}")
    str=$(parse_echo_string "${@}")
    echo ${params} $(decorate_string -c green "${str}")
}

##
# decorate string
#
# param switch -b bold
# param switch -s line-through
# param switch -u underline
# param switch -l blink
# param switch -r reverse color
# param switch -n disable decoration
# param opt    -c {color_code} string color
# param opt    -g {color_code} background color
# param switch -o return decorated string(default)
# param switch -O return escaped string
# param string message .. output this messages
#
# ####color code:(number or name)
# |for font|for background|color name|
# |---     |---           |---       |
# |30      |40            |black     |
# |31      |41            |red       |
# |32      |42            |green     |
# |33      |43            |yellow    |
# |34      |44            |blue      |
# |35      |45            |magenta   |
# |36      |46            |cyan      |
# |37      |47            |white     |
decorate_string()
{
    local decs=()
    local decorated=0
    local opt=''

    local OPTIND=1
    while getopts bsulrnoOc:g: opt
    do
        case "${opt}" in
            b)
                decs+=('01')
                ;;
            s)
                decs+=('02')
                ;;
            u)
                decs+=('04')
                ;;
            l)
                decs+=('05')
                ;;
            r)
                decs+=('07')
                ;;
            n)
                decs+=('08')
                ;;
            c)
                case $OPTARG in
                    30|black)
                        decs+=('30')
                        ;;
                    31|red)
                        decs+=('31')
                        ;;
                    32|green)
                        decs+=('32')
                        ;;
                    33|yellow)
                        decs+=('33')
                        ;;
                    34|blue)
                        decs+=('34')
                        ;;
                    35|magenta)
                        decs+=('35')
                        ;;
                    36|cyan)
                        decs+=('36')
                        ;;
                    37|white)
                        decs+=('37')
                        ;;
                    *)
                        exit 'please set a color with -c.' 1>2
                        ;;
                esac
                ;;
            g)
                case $OPTARG in
                    40|black)
                        decs+=('40')
                        ;;
                    41|red)
                        decs+=('41')
                        ;;
                    42|green)
                        decs+=('42')
                        ;;
                    43|yellow)
                        decs+=('43')
                        ;;
                    44|blue)
                        decs+=('44')
                        ;;
                    45|magenta)
                        decs+=('45')
                        ;;
                    46|cyan)
                        decs+=('46')
                        ;;
                    47|white)
                        decs+=('47')
                        ;;
                    *)
                        exit 'please set a color with -g.' 1>2
                        ;;
                esac
                ;;
            o)
                decorated=0
                ;;
            O)
                decorated=-1
                ;;
        esac
    done

    shift $((OPTIND - 1))

    local deced=$(echo '\e[0m\e['$(IFS=\;;echo "${decs[*]}"m${*}'\e[0m'))
    if [ "${decorated}" -eq 0 ]
    then
        echo -e "${deced}"
    else
        echo "${deced}"
    fi
}

##
# truncate the character protruding from the window
#
# param string truncate string
truncate_string()
{
    local cols=$(tput cols)
    local str=${1}
    if [ "${#str}" -gt "${cols}" ]
    then
        echo $(echo ${str} | cut -c 1-${cols})
        return 0
    fi

    echo ${str}
}

##
# centering string
#
# param string centering align string
centering()
{
    local cols=$(tput cols)
    local str=${1}
    if [ "${#str}" -le "${cols}" ]
    then
        local len=$(( (${cols} - ${#str}) / 2 ))
        for ((i = 0; i < ${len}; i++))
        do
            str=" ${str}"
        done
        echo "${str}"
        return 0
    fi

    echo ${str}
}

##
# right align string
#
# param string right align string
right_align()
{
    local cols=$(tput cols)
    printf "%${cols}s\n" "${1}"
}

##
# Horizontal Rule
#
# param switch -c centering
# param switch -r right align
# param switch -t truncate the character protruding from the window(default)
# param switch -T NOT truncate the character protruding from the window
# param opt    -n {repeat_count} repeat count(default: 20)
# param opt    -s {line_string} line string(default: '-')
hr()
{
    local repeat=20
    local string='-'
    local center=-1
    local right=-1
    local truncate=0
    local opt=''

    local OPTIND=1
    while getopts crtTn:s: opt
    do
        case "${opt}" in
            c)
                center=0
                ;;
            r)
                right=0
                ;;
            t)
                truncate=0
                ;;
            T)
                truncate=-1
                ;;
            n)
                repeat=$OPTARG
                ;;
            s)
                string=$OPTARG
                ;;
        esac
    done

    local line=''

    for ((i = 0; i < ${repeat}; i++))
    do
        line+=${string}
    done

    # truncate
    if [ "${truncate}" -eq 0 ]
    then
        line=$(truncate_string ${line})
    fi

    # centering or right align
    if [ "${center}" -eq 0 ]
    then
        line=$(centering ${line})
    elif [ "${right}" -eq 0 ]
    then
        line=$(right_align ${line})
    fi

    echo "${line}"
}

##
# generate shell for README.md
#
# param switch -j japanese
# param string shell script filepath
shhelp-gen()
{
    local lang='en'
    local output=''

    local OPTIND=1
    while getopts jo: opt
    do
        case "${opt}" in
            j)
                lang='ja'
                ;;
        esac
    done

    shift $((OPTIND - 1))
    local filepath="${@}"
    local filename=$(basename ${filepath})

    # check read source file name
    if [ ! -f "${filepath}" ]
    then
        echo "Please set filename: ${0} filename"
        exit
    fi

    local desc=$(awk -v lang="$lang" 'BEGIN{
        head         = ""
        head_opt     = ""
        intro        = ""
        install      = ""
        usage        = ""
        functions    = ""

        func_list    = ""
        desc         = ""
        params       = ""
        pparams      = ""
        ret          = ""

        switch (lang) {
            case "en":
                func_usage  = "Usage"
                func_param  = "####Parameter"
                func_return = "####return"
                break
            case "ja":
                func_usage  = "使用方法"
                func_param  = "####引数"
                func_return = "####戻り値"
                break
        }

        type = ""
    }

    # head_opt
    # intro
    # install
    # usage
    /^# (Version|Author|License)/{type = "head_opt"; before = ""}
    /^# Install:/{type = "install"; before = ""; next}
    /^# Usage:/{type = "usage"; before = ""; next}
    (type == "head_opt" || type == "intro" || type == "install" || type == "usage"){
        str = $0
        if (str == "") {
            type  = ""
        }
        else {
            sub(/^# ?/, "", str)
            nl     = (str && before ? "  " : "")
            before = str
            switch (type) {
                case "head_opt":
                    head_opt = head_opt nl "\n" str
                    break
                case "intro":
                    intro = intro nl "\n" str
                    break
                case "install":
                    install = install (install ? nl "\n" : "") str
                    break
                case "usage":
                    usage = usage (usage ? nl "\n" : "") str
                    break
            }
        }
    }

    # head
    /@\(#\)/{
        type = "intro"
        head = $0
        sub(/# *@\(#\) */, "#", head)
    }

    # functions
    (type == "functions" && /^[^#][^(]+\(/){
        type = ""
        if (func_list) {
            func_list = func_list "\n"
        }
        func_list = func_list "  - " $0
        if (functions) {
            functions = functions "\n\n"
        }
        functions = functions "###" $0 desc
        if (ret) {
            functions = functions "\n\n" ret
        }
        functions = functions "\n\n" "####" func_usage "\t" $0 "\n```shell-session\n"
        func_name = $0
        sub(/\(\)/, "", func_name)
        functions = functions func_name
        if (params) {
            functions = functions " [-" params"]"
        }
        functions = functions pparams (string_param ? " " : "") string_param
        functions = functions "\n" "```"

    }
    (type == "functions"){
        if (match($0, /^# *param/)) {
            before     = ""
            param_type = $0
            sub(/^# *param */, "", $0)
            match($0, /^[^ ]+/)
            param_type = substr($0, RSTART, RLENGTH)
            sub(/^[^ ]+ */, "", $0)
            switch (param_type) {
                case "switch":
                    params = params substr($0, 2, 1)
                    break
                case "opt":
                    match($0, /^[^}]+/)
                    pparams = pparams " [-" substr($0, RSTART + 1, RLENGTH) "]"
                    break
                case "string":
                case "mixed":
                    string_param = string_param "<" param_type ">"
                    break
            }

            if (p1 == "") {
                p1 = "1"
                desc = "\n" desc "\n" func_param
            }
            desc = desc "\n- " $0
        }
        else if (match($0, /^# *return/)) {
            ret = $0
            sub(/^# *return *[^ ]+ */, "", ret)
            ret = func_return "\n" ret
        }
        else {
            tmp = $0
            sub(/^# ?/, "", tmp)
            nl     = (tmp && before ? "  \n" : "\n")
            before = tmp
            if (desc) {
                desc = desc nl
            }
            desc = desc tmp
        }
    }
    /^##/{type = "functions"; desc = ""; params = ""; pparams = ""; p1 = ""; string_param = ""; before = ""; ret = ""}

    END{
        gsub(/^\n+|\n+$/, "", intro)
        print head
        print intro
        print head_opt
        print ""
        switch (lang) {
            case "en":
                print "###Contents"
                print "- Introduction"
                print "- Install"
                print "- Usage"
                print "- Functions"
                print func_list
                print "- ChangeLog"
                print ""
                print "##Introduction"
                print intro
                print ""
                print "##Install"
                print install
                print ""
                print "##Usage"
                print "```shell-session"
                print usage
                print "```"
                print ""
                print "##Functions"
                print functions
                print ""
                print "##ChangeLog"
                break
            case "ja":
                print "###目次"
                print "- 概要"
                print "- インストール"
                print "- 使用方法"
                print "- 関数"
                print func_list
                print "- 更新履歴"
                print ""
                print "##概要"
                print intro
                print ""
                print "##インストール"
                print install
                print ""
                print "##使用方法"
                print "```shell-session"
                print usage
                print "```"
                print ""
                print "##関数"
                print functions
                print ""
                print "##更新履歴"
                break
        }
    }
    ' ${filepath})

    # output README
    (IFS=''; echo ${desc})

}

##
# wait user input
#
# param string insert this var from inputted value
# param string display input message
# param string default selected value
# param string(s) selectable values...
# param switch -a allow empty
# param switch -r receive all input(free input text)
# param switch -i ignore case
# param switch -l return lower case
question(){
    local var_name=""
    local msg=""
    local default=""
    local reg=""
    local allow_empty=false
    local allow_all=false
    local ignore_case=false
    local lower_case=false
    local cnt=0
    for arg in "${@}"
    do
        case "${arg}" in
            "-e")
                allow_empty=true
                continue
                ;;
            "-r")
                allow_all=true
                continue
                ;;
            "-i")
                ignore_case=true
                continue
                ;;
            "-l")
                lower_case=true
                continue
                ;;
        esac

        case ${cnt} in
            0)
                var_name="${arg}"
                ;;
            1)
                msg="${arg}"
                ;;
            2)
                default="${arg}"
                ;;
            *)
                reg+="${reg:+|}${arg}"
                ;;
        esac
        cnt=$(( $cnt + 1 ))
    done

    set_to_var(){
        ${lower_case} \
            && eval "${var_name}='$( to_lower "${1}")'"\
            || eval "${var_name}='${1}'"
    }

    $ignore_case && reg=$(to_lower "${reg}")

    while true
    do
        msg -n "${msg}"$([ "${reg}" ] && echo " [${reg}]")$([ "${default}" ] && echo " (default: ${default})")": "; read -r answer

        $ignore_case && answer=$(to_lower "${answer}")

        if [ ! "${answer}" ]
        then
            [  "${default}" ] && { set_to_var "${default}"; break; }
            ${allow_empty} && { set_to_var ''; break; }
        fi
        ${allow_all} && { set_to_var "${answer}"; break; }
        [ "${reg}" ] && bash -c "[[ '${answer}' =~ ${reg} ]]" \
            && { set_to_var "${answer}"; break; }
    done
}

##
# text to lower case
#
# param string text
# return lower strings
to_lower(){
    echo "${1}" | tr "[:upper:]" "[:lower:]"
}

##
# text to upper case
#
# param string text
# return upper strings
to_upper(){
    echo "${1}" | tr "[:lower:]" "[:upper:]"
}

##
# subcommand by file base
#   subcommand name is file name
#
# param string directory within subcommand files
# param string subcommand
# param mixed.. parameters for subcommand 
subcommand()
{
    local script_dir="${1}"
    local subcmd="${2}"

    ## exec subcommand
    local cmd="${script_dir}/${subcmd}"
    [ -f "${cmd}" ] && [ -x "${cmd}" ] \
        && { "${cmd}" "${@:3}"; return $?; }

    ## display usage
cat <<_USAGE
Usage:
    Please set subcommand.

    subcommands:
$(
        for file in $(find ${script_dir} -maxdepth 1 -type f -executable -not -name '.*')
        do
            local name=$(basename "${file}")
cat <<EOS
        ${name} ... $(sed -ne '/^# *@(#)/{ s/^# *@(#) *//; p }' ${file})
EOS
        done
)
_USAGE
}
