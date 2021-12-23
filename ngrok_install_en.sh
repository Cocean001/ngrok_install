#!/bin/bash
trap 'rm -f "$TMPFILE"' EXIT

blue() {
    echo -e "\033[34m\033[01m$1\033[0m"
}
green() {
    echo -e "\033[32m\033[01m$1\033[0m"
}
yellow() {
    echo -e "\033[33m\033[01m$1\033[0m"
}
red() {
    echo -e "\033[31m\033[01m$1\033[0m"
}

CHECK_STATUS_FILE=$(mktemp) || exit 1
START_FROM_FILE=$(mktemp) || exit 1
echo "0" 1>$CHECK_STATUS_FILE
echo "0" 1>$START_FROM_FILE

function delay() { sleep 0.1; }

function bar_continue() {
    echo "1" 1>$CHECK_STATUS_FILE
    wait
    echo -ne '                                                                             \r'
}

function bar_start_from() {
    echo "$1" 1>$START_FROM_FILE
    echo "0" 1>$CHECK_STATUS_FILE
}

function bar_hold_at() {
    custom_progress=$1;
    custom_phase=$2;
    num=0
    postfix=('|' '/' '-' '\')
    read check_start_from <$START_FROM_FILE
    read check_status <$CHECK_STATUS_FILE

    while [ $check_start_from -le 0 -a $custom_progress -ge 0 ]
    do
        let index=num%4
        printf "%-31s %-50s \r" "[ ${postfix[$index]} ] [..........................] (0%)" "$custom_phase"
        let num++
        sleep 0.1
        if [ $custom_progress -gt 0 ]; then
            let check_start_from=5
            break
        elif [ "$check_status" = "1" ]; then
            echo "5" 1>$START_FROM_FILE
            exit 0
        else
            continue
        fi
    done

    while [ $check_start_from -le 5 -a $custom_progress -ge 5 ]
    do
        let index=num%4
        printf "%-31s %-50s \r" "[ ${postfix[$index]} ] [#.........................] (5%)" "$custom_phase"
        let num++
        sleep 0.1
        if [ $custom_progress -gt 5 ]; then
            let check_start_from=10
            break
        elif [ "$check_status" = "1" ]; then
            echo "10" 1>$START_FROM_FILE
            exit 0
        else
            continue
        fi
    done

    while [ $check_start_from -le 10 -a $custom_progress -ge 10 ]
    do
        let index=num%4
        printf "%-31s %-50s \r" "[ ${postfix[$index]} ] [##........................] (10%)" "$custom_phase"
        let num++
        sleep 0.1
        if [ $custom_progress -gt 10 ]; then
            let check_start_from=15
            break
        elif [ "$check_status" = "1" ]; then
            echo "15" 1>$START_FROM_FILE
            exit 0
        else
            continue
        fi
    done

    while [ $check_start_from -le 15 -a $custom_progress -ge 15 ]
    do
        let index=num%4
        printf "%-31s %-50s \r" "[ ${postfix[$index]} ] [###.......................] (15%)" "$custom_phase"
        let num++
        sleep 0.1
        if [ $custom_progress -gt 15 ]; then
            let check_start_from=20
            break
        elif [ "$check_status" = "1" ]; then
            echo "20" 1>$START_FROM_FILE
            exit 0
        else
            continue
        fi
    done

    while [ $check_start_from -le 20 -a $custom_progress -ge 20 ]
    do
        let index=num%4
        printf "%-31s %-50s \r" "[ ${postfix[$index]} ] [####......................] (20%)" "$custom_phase"
        let num++
        sleep 0.1
        read check_status <$CHECK_STATUS_FILE
        if [ $custom_progress -gt 20 ]; then
            let check_start_from=25
            break
        elif [ "$check_status" = "1" ]; then
            echo "25" 1>$START_FROM_FILE
            exit 0
        else
            continue
        fi
    done

    while [ $check_start_from -le 25 -a $custom_progress -ge 25 ]
    do
        let index=num%4
        printf "%-31s %-50s \r" "[ ${postfix[$index]} ] [#####.....................] (25%)" "$custom_phase"
        let num++
        sleep 0.1
        read check_status <$CHECK_STATUS_FILE
        if [ $custom_progress -gt 25 ]; then
            let check_start_from=30
            break
        elif [ "$check_status" = "1" ]; then
            echo "30" 1>$START_FROM_FILE
            exit 0
        else
            continue
        fi
    done

    while [ $check_start_from -le 30 -a $custom_progress -ge 30 ]
    do
        let index=num%4
        printf "%-31s %-50s \r" "[ ${postfix[$index]} ] [######....................] (30%)" "$custom_phase"
        let num++
        sleep 0.1
        read check_status <$CHECK_STATUS_FILE
        if [ $custom_progress -gt 30 ]; then
            let check_start_from=35
            break
        elif [ "$check_status" = "1" ]; then
            echo "35" 1>$START_FROM_FILE
            exit 0
        else
            continue
        fi
    done

    while [ $check_start_from -le 35 -a $custom_progress -ge 35 ]
    do
        let index=num%4
        printf "%-31s %-50s \r" "[ ${postfix[$index]} ] [#######...................] (35%)" "$custom_phase"
        let num++
        sleep 0.1
        read check_status <$CHECK_STATUS_FILE
        if [ $custom_progress -gt 35 ]; then
            let check_start_from=40
            break
        elif [ "$check_status" = "1" ]; then
            echo "40" 1>$START_FROM_FILE
            exit 0
        else
            continue
        fi
    done

    while [ $check_start_from -le 40 -a $custom_progress -ge 40 ]
    do
        let index=num%4
        printf "%-31s %-50s \r" "[ ${postfix[$index]} ] [########..................] (40%)" "$custom_phase"
        let num++
        sleep 0.1
        read check_status <$CHECK_STATUS_FILE
        if [ $custom_progress -gt 40 ]; then
            let check_start_from=45
            break
        elif [ "$check_status" = "1" ]; then
            echo "45" 1>$START_FROM_FILE
            exit 0
        else
            continue
        fi
    done

    while [ $check_start_from -le 45 -a $custom_progress -ge 45 ]
    do
        let index=num%4
        printf "%-31s %-50s \r" "[ ${postfix[$index]} ] [#########.................] (45%)" "$custom_phase"
        let num++
        sleep 0.1
        read check_status <$CHECK_STATUS_FILE
        if [ $custom_progress -gt 45 ]; then
            let check_start_from=50
            break
        elif [ "$check_status" = "1" ]; then
            echo "50" 1>$START_FROM_FILE
            exit 0
        else
            continue
        fi
    done

    while [ $check_start_from -le 50 -a $custom_progress -ge 50 ]
    do
        let index=num%4
        printf "%-31s %-50s \r" "[ ${postfix[$index]} ] [##########................] (50%) " "$custom_phase"
        let num++
        sleep 0.1
        read check_status <$CHECK_STATUS_FILE
        if [ $custom_progress -gt 50 ]; then
            let check_start_from=55
            break
        elif [ "$check_status" = "1" ]; then
            echo "55" 1>$START_FROM_FILE
            exit 0
        else
            continue
        fi
    done

    while [ $check_start_from -le 55 -a $custom_progress -ge 55 ]
    do
        let index=num%4
        printf "%-31s %-50s \r" "[ ${postfix[$index]} ] [###########...............] (55%)" "$custom_phase"
        let num++
        sleep 0.1
        read check_status <$CHECK_STATUS_FILE
        if [ $custom_progress -gt 55 ]; then
            let check_start_from=60
            break
        elif [ "$check_status" = "1" ]; then
            echo "60" 1>$START_FROM_FILE
            exit 0
        else
            continue
        fi
    done

    while [ $check_start_from -le 60 -a $custom_progress -ge 60 ]
    do
        let index=num%4
        printf "%-31s %-50s \r" "[ ${postfix[$index]} ] [############..............] (60%)" "$custom_phase"
        let num++
        sleep 0.1
        read check_status <$CHECK_STATUS_FILE
        if [ $custom_progress -gt 60 ]; then
            let check_start_from=65
            break
        elif [ "$check_status" = "1" ]; then
            echo "65" 1>$START_FROM_FILE
            exit 0
        else
            continue
        fi
    done

    while [ $check_start_from -le 65 -a $custom_progress -ge 65 ]
    do
        let index=num%4
        printf "%-31s %-50s \r" "[ ${postfix[$index]} ] [#############.............] (65%)" "$custom_phase"
        let num++
        sleep 0.1
        read check_status <$CHECK_STATUS_FILE
        if [ $custom_progress -gt 65 ]; then
            let check_start_from=70
            break
        elif [ "$check_status" = "1" ]; then
            echo "70" 1>$START_FROM_FILE
            exit 0
        else
            continue
        fi
    done

    while [ $check_start_from -le 70 -a $custom_progress -ge 70 ]
    do
        let index=num%4
        printf "%-31s %-50s \r" "[ ${postfix[$index]} ] [##############............] (70%)" "$custom_phase"
        let num++
        sleep 0.1
        read check_status <$CHECK_STATUS_FILE
        if [ $custom_progress -gt 70 ]; then
            let check_start_from=75
            break
        elif [ "$check_status" = "1" ]; then
            echo "75" 1>$START_FROM_FILE
            exit 0
        else
            continue
        fi
    done

    while [ $check_start_from -le 75 -a $custom_progress -ge 75 ]
    do
        let index=num%4
        printf "%-31s %-50s \r" "[ ${postfix[$index]} ] [################..........] (75%)" "$custom_phase"
        let num++
        sleep 0.1
        read check_status <$CHECK_STATUS_FILE
        if [ $custom_progress -gt 75 ]; then
            let check_start_from=80
            break
        elif [ "$check_status" = "1" ]; then
            echo "80" 1>$START_FROM_FILE
            exit 0
        else
            continue
        fi
    done

    while [ $check_start_from -le 80 -a $custom_progress -ge 80 ]
    do
        let index=num%4
        printf "%-31s %-50s \r" "[ ${postfix[$index]} ] [###################.......] (80%)" "$custom_phase"
        let num++
        sleep 0.1
        read check_status <$CHECK_STATUS_FILE
        if [ $custom_progress -gt 80 ]; then
            let check_start_from=85
            break
        elif [ "$check_status" = "1" ]; then
            echo "85" 1>$START_FROM_FILE
            exit 0
        else
            continue
        fi
    done

    while [ $check_start_from -le 85 -a $custom_progress -ge 85 ]
    do
        let index=num%4
        printf "%-31s %-50s \r" "[ ${postfix[$index]} ] [#####################.....] (85%)" "$custom_phase"
        let num++
        sleep 0.1
        read check_status <$CHECK_STATUS_FILE
        if [ $custom_progress -gt 85 ]; then
            let check_start_from=90
            break
        elif [ "$check_status" = "1" ]; then
            echo "90" 1>$START_FROM_FILE
            exit 0
        else
            continue
        fi
    done

    while [ $check_start_from -le 90 -a $custom_progress -ge 90 ]
    do
        let index=num%4
        printf "%-31s %-50s \r" "[ ${postfix[$index]} ] [#######################...] (90%)" "$custom_phase"
        let num++
        sleep 0.1
        read check_status <$CHECK_STATUS_FILE
        if [ $custom_progress -gt 95 ]; then
            let check_start_from=95
            break
        elif [ "$check_status" = "1" ]; then
            echo "95" 1>$START_FROM_FILE
            exit 0
        else
            continue
        fi
    done

    while [ $check_start_from -le 95 -a $custom_progress -ge 95 ]
    do
        let index=num%4
        printf "%-31s %-50s \r" "[ ${postfix[$index]} ] [########################..] (95%)" "$custom_phase"
        let num++
        sleep 0.1
        read check_status <$CHECK_STATUS_FILE
        if [ $custom_progress -gt 95 ]; then
            let check_start_from=100
            break
        elif [ "$check_status" = "1" ]; then
            echo "100" 1>$START_FROM_FILE
            exit 0
        else
            continue
        fi
    done

    if [ $check_start_from -le 100 -a $custom_progress -ge 100 ]; then echo -ne "[ - ] [##########################] (100%) $custom_phase \r" ; delay; fi;
    if [ $check_start_from -le 100 -a $custom_progress -ge 100 ];then echo -ne 'done!                                                                               \r' ; delay; fi;
}


mkdir -p /opt/new_ngrok/log
touch /opt/new_ngrok/log/ngrok_log.log
log_file=/opt/new_ngrok/log/ngrok_log.log


function exit_program() {
    echo "exit program"
    exit 0
}

# get system release info ok
function get_release() {
    source /etc/os-release
    RELEASE=$ID
    VERSION=$VERSION
    CONF=`getconf LONG_BIT`
    CPU=`uname -m`
}

# check release ok
function check_release() {
    get_release
    echo "[ * ] checking system release infomation                             "
    if [ "$RELEASE" == "centos" ]; then
        red "[ × ] Sorry, CentOS is currently not supported. More functions are developing, thanx for your support! "
        exit_program
    elif [ "$RELEASE" == "debian" ]; then
        yellow "[ √ ] Detected system: $RELEASE, version: $VERSION_ID $CONF, chip arch: $CPU"
        green "[ √ ] check completed                                        "
    elif [ "$RELEASE" == "ubuntu" ]; then
        yellow "[ √ ] Detected system: $RELEASE, version: $VERSION_ID $CONF, chip arch: $CPU"
        green "[ √ ] check completed                                        "
    else 
        red "[ × ] Sorry, $RELEASE is currently not supported. More functions are developing, thanx for your support! "
        exit_program
    fi
}

# check network whether could access youtube ok
function check_network() {
    if ping -c 3 -w 3 www.baidu.com >/dev/null;then
        if ping -c 3 -w 3 www.youtube.com >/dev/null;then     
            green "[ √ ] Current internet detected: international                              "
            network=international >/dev/null
        else
            yellow "[ √ ] Current internet detected: cn                              "
            network=mainland >/dev/null
            sed -i '$a\13.114.40.48 github.com' /etc/hosts
            if ping -c 3 -w 5 github.com >/dev/null;then
                green "[ √ ] Internet configuration complete!                                        "
            else 
                red "[ × ] Cannot access to github, please check internet before continue! "
                exit_program
            fi
        fi
    else
        red "[ × ] Internet configuration error! Please check internet before continue!                        "
        exit_program
    fi
}

# check log file ok
function check_log() {
    if [ ! -f "$log_file" ]; then
        mkdir -p /opt/new_ngrok/log >/dev/null
    fi
}

apt_source_debian() {
cat > /etc/apt/sources.list <<-EOF
deb http://mirrors.ustc.edu.cn/debian buster main contrib non-free
deb http://mirrors.ustc.edu.cn/debian buster-updates main contrib non-free
deb http://mirrors.ustc.edu.cn/debian buster-backports main contrib non-free
deb http://mirrors.ustc.edu.cn/debian-security/ buster/updates main contrib non-free
# deb-src http://mirrors.ustc.edu.cn/debian buster main contrib non-free
# deb-src http://mirrors.ustc.edu.cn/debian buster-updates main contrib non-free
# deb-src http://mirrors.ustc.edu.cn/debian buster-backports main contrib non-free
# deb-src http://mirrors.ustc.edu.cn/debian-security/ buster/updates main contrib non-free
EOF
}

apt_source_ubuntu() {
cat > /etc/apt/sources.list <<-EOF
deb http://mirrors.ustc.edu.cn/ubuntu-ports/ bionic main multiverse restricted universe
deb-src http://mirrors.ustc.edu.cn/ubuntu-ports/ bionic main multiverse restricted universe
deb http://mirrors.ustc.edu.cn/ubuntu-ports/ bionic-backports main multiverse restricted universe
deb-src http://mirrors.ustc.edu.cn/ubuntu-ports/ bionic-backports main multiverse restricted universe
deb http://mirrors.ustc.edu.cn/ubuntu-ports/ bionic-proposed main multiverse restricted universe
deb-src http://mirrors.ustc.edu.cn/ubuntu-ports/ bionic-proposed main multiverse restricted universe
deb http://mirrors.ustc.edu.cn/ubuntu-ports/ bionic-security main multiverse restricted universe
deb-src http://mirrors.ustc.edu.cn/ubuntu-ports/ bionic-security main multiverse restricted universe
deb http://mirrors.ustc.edu.cn/ubuntu-ports/ bionic-updates main multiverse restricted universe
deb-src http://mirrors.ustc.edu.cn/ubuntu-ports/ bionic-updates main multiverse restricted universe
EOF
}

# apt update and choose whether to change source
apt_update() { 
yellow "[ - ] Do you want to update apt?（y/n)"
read apt_update
if [[ $apt_update == "y" ]]||[[ $apt_update == "Y" ]]; then
    yellow "[ - ] Do you want to change apt source?（y/n)"
    read apt_source
    if [[ $apt_source == "y" ]]||[[ $apt_source == "Y" ]]; then
        if [ "$RELEASE" == "debian" ]; then
            apt_source_debian
            green "[ √ ] apt source changed to USTC!"
        elif [ "$RELEASE" == "ubuntu" ]; then
            apt_source_ubuntu
            green "[ √ ] apt source changed to USTC! "
        else 
            red "[ × ] Sorry, $RELEASE is currently not supported. More functions are developing, thanx for your support!"
            exit_program
        fi
    elif [[ $apt_source == "n" ]]||[[ $apt_source == "N" ]]; then
        echo "[ * ] skipped"
    else 
        red "[ x ] error! Exiting program"
    fi
    echo "[ * ] Start updating apt"
    bar_start_from 0

    bar_hold_at 25 "apt updating" &
    sudo apt update -y >/dev/null 2>&1
    bar_continue

    bar_start_from 25
    bar_hold_at 50 "apt upgrading" &
    sudo apt upgrade -y >/dev/null 2>&1
    bar_continue

    bar_start_from 50
    bar_hold_at 75 "apt-get updating" &
    sudo apt-get update -y >/dev/null 2>&1
    bar_continue

    bar_start_from 75
    bar_hold_at 95 "apt-get upgrading" &
    sudo apt-get upgrade -y >/dev/null 2>&1
    bar_continue

    bar_hold_at 100 "done!"
    green "[ √ ] Successfully updated apt!                                             "

elif [[ $apt_update == "n" ]]||[[ $apt_update == "N" ]]; then
    green "[ * ] Jumped update apt                                             "
else
    red "[ x ] error! Exiting program"
    exit_program
fi

}
# # 检查apt是否能正常使用 ok
# function check_apt() {
#     echo "[ * ] 即将开始检查apt环境"
#     bar_start_from 0
#     bar_hold_at 50 "checking apt" &
#     apt update -y 2> /opt/new_ngrok/log/ngrok_log.log >/dev/null
#     # if cat $log_file| grep "apt" >> /dev/null; then
#     #     bar_continue
#     #     red "[ × ] apt error，please check apt before run the script!                              "
#     #     :> $log_file
#     #     exit_program
#     # else 
#     #     apt_update -y >/dev/null 2>&1
#     #     bar_continue
#     #     bar_hold_at 100 "done! "
#     #     green "[ √ ] apt检测完成                                             "
#     # fi
#     bar_continue
#     bar_hold_at 100 "done!"
#     green "[ √ ] apt检测完成                                                   "
# }

function check_firewalld() {
    firewalld 2> /opt/new_ngrok/log/ngrok_log.log 
    if cat $log_file| grep "firewalld" >> /dev/null; then
        red "[ × ] Firewalld not detected, now start installing firewalld                              "
        :> $log_file
        apt install firewalld -y >/dev/null 2>&1
    else 
        green "[ √ ] Firewall checked!                                            "
    fi
}

# check git ok
function check_git() {
    git version 2> /opt/new_ngrok/log/ngrok_log.log >/dev/null 
    if cat $log_file| grep "git" >> /dev/null; then
        red "[ × ] Git not detected, now start installing git"
        :> $log_file
        apt install git -y >/dev/null
        if [ "$network" == "mainland" ]; then
            git config --global  --unset http.https://github.com.proxy
            git config --global  --unset https.https://github.com.proxy
        else 
            pass 
        fi
    else 
        green "[ √ ] Git checked!                                     "
    fi
}

# check other tools ok
function check_tools() {
    apt install wget -y  >/dev/null 2>&1
    green "[ √ ] Wget checked!                                        "
    apt install curl -y  >/dev/null 2>&1
    green "[ √ ] Curl checkded!                                        "
    apt install sudo -y >/dev/null 2>&1
    green "[ √ ] Sudo checked!                                        "
    apt install make -y >/dev/null 2>&1
    green "[ √ ] Make checked!                                        "
    apt install firewalld -y >/dev/null 2>&1
    green "[ √ ] Firewalld checked!                                   "
}

# install go 1.12.6 ok
function install_go() {
    yellow "[ - ] Start installing go 1.12.6"
    sleep 0.5s
    bar_start_from 0
    mkdir /opt/new_ngrok >/dev/null 2>&1
    cd /opt/new_ngrok/ >/dev/null
    get_release
    bar_hold_at 50 "downloading go packages" &
    if [ "$CONF" == "32" ]; then
        if [ "${CPU%v}" == "arm" -o "${CPU%v}" == "ARM" ]; then # arm arm32
            go_pack="/opt/new_ngrok/go1.12.6.linux-armv6l.tar.gz"
            if [ ! -f "/opt/new_ngrok/$go_pack" ]; then
                wget -P /opt/new_ngrok/ -q -c https://golang.google.cn/dl/go1.12.6.linux-armv6l.tar.gz
            else
                yellow "[ * ] $go_pack detected，skip downloading                           "
            fi
        else #x86/amd 32
            go_pack="/opt/new_ngrok/go1.12.6.linux-386.tar.gz"
            if [ ! -f "/opt/new_ngrok/$go_pack" ]; then
                wget -P /opt/new_ngrok/ -q -c https://golang.google.cn/dl/go1.12.6.linux-386.tar.gz
            else
                yellow "[ * ] $go_pack detected，skip downloading                           "
            fi
        fi
    elif [ "$CONF" == "64" ]; then
        if [ "${CPU%64}" == "aarch" -o "${CPU%64}" == "arm" ]; then # arm arm64
            go_pack="/opt/new_ngrok/go1.12.6.linux-arm64.tar.gz"
            if [ ! -f "/opt/new_ngrok/$go_pack" ]; then
                wget -P /opt/new_ngrok/ -q -c https://golang.google.cn/dl/go1.12.6.linux-arm64.tar.gz
            else
                yellow "[ * ] $go_pack detected，skip downloading                           "
            fi
        else # x86/amd 64
            go_pack="/opt/new_ngrok/go1.12.6.linux-amd64.tar.gz"
            if [ ! -f "/opt/new_ngrok/$go_pack" ]; then
                wget -P /opt/new_ngrok/ -q -c https://golang.google.cn/dl/go1.12.6.linux-amd64.tar.gz
            else
                yellow "[ * ] $go_pack detected，skip downloading                           "
            fi
        fi
    else
        bar_continue
        red "[ x ] cannot download go 1.12.6，please download it mannually and place it into /opt/new_ngrok"
        red "[ x ] Link: https://golang.google.cn/dl/                  "
        red "[ x ] Notes: the version of go should be 1.12.6            "
        exit_program
    fi
    bar_continue

    bar_start_from 50
    bar_hold_at 90 "installing go 1.12.6" &
    cd /opt/new_ngrok/
    tar -C /opt/new_ngrok/ -xzf $go_pack >/dev/null
    export PATH=$PATH:/opt/new_ngrok/go/bin
    bar_continue
    # bar_start_from 90
    bar_hold_at 95 "checking installation" &
    if [[ `go version | grep "1.12.6"` != "" ]]; then
        bar_continue
        bar_hold_at 100 "done!"
        green "[ √ ] Go installation completed!                                        "
    else 
        bar_continue
        red "[ x ] Go installation failed! Please uninstall the current go environment before continue!              "
        exit_program
    fi
}

# check go ok
function check_go() {
    yellow "[ * ] Start go environment checking"
    cd /opt/new_ngrok/ && go version 2> /opt/new_ngrok/log/ngrok_log.log >/dev/null
    if cat $log_file | grep "go" > /dev/null; then
    # if [ $? -eq 0 ]; then
        red "[ × ] Cannot detected go                                              "
        :> $log_file
        sleep 0.5s
        install_go
    elif  [[ `go version | grep "1.12.6"` != "" ]]; then
        green "[ √ ] Go checked, the version is 1.12.6                          "
    else
        blue "[ - ] Go checked, but the version is not 1.12.6                                "
        blue "[ - ] Uninstallation command will start before installing go 1.12.6                        "
        yellow "[ - ] Uninstalling go"
        bar_start_from 0
        bar_hold_at 60 "uninstalling golang-go" &
        apt-get remove golang-go >/dev/null
        apt-get remove --auto-remove golang-go >/dev/null
        bar_continue
        bar_hold_at 90 "uninstalling gccgo-go" &
        apt-get remove gccgo-go >/dev/null
        bar_continue
        bar_hold_at 100 "done!"
        green "[ √ ] 原有go环境卸载完成                                             "
        install_go
    fi
}

# check environment
function check_environment() {
yellow "[ - ] Do you want to check environment?（y/n)"
read option_environment
if [[ $option_environment == "y" ]]||[[ $option_environment == "Y" ]]; then
    echo "[ * ] Start environment checking"
    bar_start_from 0
    bar_hold_at 20 "log checking" &
    check_log
    bar_continue

    bar_start_from 20
    bar_hold_at 30 "release checking" &
    check_release
    bar_continue

    bar_start_from 30
    bar_hold_at 40 "network checking" &
    check_network 
    bar_continue

    bar_start_from 40
    bar_hold_at 50 "tools checking" &
    check_tools
    bar_continue

    # bar_start_from 50
    # bar_hold_at 60 "firewalld checking" &
    # check_firewalld
    # bar_continue

    bar_start_from 50
    bar_hold_at 70 "git checking" &
    check_git
    bar_continue

    bar_start_from 70
    bar_hold_at 100 "done!"
    green "[ √ ] Environment check completed!                                             "

elif [[ $option_environment == "n" ]]||[[ $option_environment == "N" ]]; then
    green "[ * ] Environment check jumped                                             "
else
    red "[ x ] error! Exiting program"
    exit_program
fi
}

check_domain() {
echo "[ * ] Start checking domain information"
green "[ - ] =========Please Input Domain Name========="
green "[ - ] 注: Please input the domain name which resolved to this server"
read ngrokd_domain
yellow "[ - ] Domain: $ngrokd_domain"
yellow "[ - ] Please confirm（y/n)"
read domain_confirm
while [ $domain_confirm == "n" ]||[ $domain_confirm == "N" ]
do 
    green "[ * ] Please input domain name again: "
    read ngrokd_domain
    yellow "[ - ] Domain: $ngrokd_domain"
    yellow "[ - ] Please confirm（y/n)"
    read domain_confirm
done
export NGROK_DOMAIN="$ngrokd_domain"
ip_domain=`ping $ngrokd_domain -c 1 | sed '1{s/[^(]*(//;s/).*//;q}'`
ip_local=`curl ipv4.icanhazip.com`
blue "================================="
blue " domain_ip:  $ip_domain"
blue " current_ip: $ip_local"
blue "================================="
sleep 1s
if [[ $ip_domain == $ip_local ]]; then
    green "[ √ ] Domain checked"
else
    red "[ x ] DNS error!"
    red "[ x ] Please check domain name and ip address before running script!"
    exit_program
fi
}

# git clone 
git_clone() {

bar_start_from 0
bar_hold_at 70 "git cloning" &
cd /usr/local
git clone https://github.com/inconshreveable/ngrok.git >/dev/null
bar_continue

bar_hold_at 100 "done!"
green "[ √ ] Program has been cloned to /usr/local"
}

# git clone check (whether to jump)
check_git_clone() {
echo "[ * ] Checking program files"
    if [ ! -f "/usr/local/ngrok/Makefile" ]; then 
    echo "[ * ] Cannot find program files. Now start downloading, please keep this server online"
    echo "[ * ] Default path: /usr/local"
    git_clone
    else
        yellow "[ - ] Package detected. Please Select: "
        yellow "[ - ] 1) (recommend) Download and overwrite current package"
        yellow "[ - ] 2) Skip downloading"
        read clone_options
        case $clone_options in
            1) # overwrite
                git_clone
            ;;
            2) # skip downloading
                green "[ √ ] skip downloading, installation will start in a moment"
            ;;
            *)
            red "[ x ] Option error!"
            ;;
        esac 
    fi
}

conf_port_menu2() {
green "[ - ] ========= Please Select ========="
yellow "[ - ] 1) Automatically"
yellow "[ - ] 2) Mannually"
read port_option
case $port_option in
    1) # Automatically
        port1=80
        port2=443
        port3=4443
    ;;
    2) # Mannually
        yellow "[ - ] Please Input Port of http: "
        read port1
        yellow "[ - ] Please Input Port of https: "
        read port2
        yellow "[ - ] Please Input Port of tunnels: "
        read port3
    ;;
    *)
        red "Option Error!"
        exit_program
    ;;
esac

}

# install new server
menu_server_1() {
green "Preparing Ngrok Server Installation"

check_environment
apt_update
check_go
check_domain
check_git_clone
git config --global http.sslverify false 

echo "[ * ] Start install Ngrok Server"
bar_start_from 0

# generating CA certs
echo "[ * ] Start generating CA certs"
bar_hold_at 65 "generating CA certs" &
cd /usr/local/ngrok
openssl genrsa -out rootCA.key 2048 >/dev/null
openssl req -x509 -new -nodes -key rootCA.key -subj "/CN=$NGROK_DOMAIN" -days 5000 -out rootCA.pem >/dev/null
openssl genrsa -out device.key 2048 >/dev/null
openssl req -new -key device.key -subj "/CN=$NGROK_DOMAIN" -out device.csr >/dev/null
openssl x509 -req -in device.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out device.crt -days 5000 >/dev/null
bar_continue

# replace CA certs
bar_hold_at 95 "replacing certs" &
cp /usr/local/ngrok/rootCA.pem /usr/local/ngrok/assets/client/tls/ngrokroot.crt >/dev/null
cp /usr/local/ngrok/device.crt /usr/local/ngrok/assets/server/tls/snakeoil.crt >/dev/null
cp /usr/local/ngrok/device.key /usr/local/ngrok/assets/server/tls/snakeoil.key >/dev/null
bar_continue

bar_hold_at 100 "done!"
green "[ √ ] Certs generated! "

# compile server
echo "[ * ] compiling Ngrok Server"
bar_start_from 0

bar_hold_at 95 "compiling Ngrok Server" &
cd /usr/local/ngrok
make clean >/dev/null
make release-server >/dev/null
bar_continue

bar_hold_at 100 "done!"
green "[ √ ] Ngrok Server Successfully Installed!"

# port configuration
cd /usr/local/ngrok/bin
echo "[ * ] Start Configure Port"
echo "[ * ] -----------------------"
echo "[ * ] Tips: Here we need to configure 3 ports on Server:"
echo "[ * ] 1) http"
echo "[ * ] 2) https"
echo "[ * ] 3) tunnel: including tcp | udp, could be used on ssh"
echo "[ * ] -----------------------"
echo "[ * ] If you select Automatically in this step, the configuration will be: "
echo "[ * ] http:   80   "
echo "[ * ] https:  443  "
echo "[ * ] tunnel: 4443 "
echo "[ * ] (this configuration is editiable)"
conf_port_menu2

# port confirm

yellow "[ - ] ====================================="
yellow "[ - ] Here is information of port(server): "
yellow "[ - ] http:    $port1"
yellow "[ - ] https:   $port2"
yellow "[ - ] tunnel:  $port3"
yellow "[ - ] ======================================"
yellow "[ - ] Please confirm (y/n)"
read port_confirm
while [ $port_confirm == "n" ]||[ $port_confirm == "N" ]
do 
    conf_port_menu2
    yellow "[ - ] ====================================="
    yellow "[ - ] Here is information of port(server): "
    yellow "[ - ] http:    $port1"
    yellow "[ - ] https:   $port2"
    yellow "[ - ] tunnel:  $port3"
    yellow "[ - ] ======================================"
    yellow "[ - ] Please confirm (y/n)"
    read port_confirm
done
green "[ √ ] Port confirmed! "

#writing into systemd 
echo "Start installing server"
bar_start_from 0

bar_hold_at 20 "writing into systemd" &
mkdir -p /usr/lib/systemd/system >/dev/null
cat > /usr/lib/systemd/system/ngrokd.service <<-EOF
[Unit]
Description=ngrokd service

[Service]
Type=simple
ExecStart=/usr/local/ngrok/bin/ngrokd -domain="$NGROK_DOMAIN" -httpAddr=":$port1" -httpsAddr=":$port2" -tunnelAddr=":$port3"

[Install]
WantedBy=multi-user.target
EOF
bar_continue
green "[ √ ] Successfully written into systemd!"

# firewall release 
bar_hold_at 60 "releasing firewall" &
firewall-cmd --add-port=$port1/tcp --permanent >/dev/null
firewall-cmd --add-port=$port1/udp --permanent >/dev/null
firewall-cmd --add-port=$port2/tcp --permanent >/dev/null
firewall-cmd --add-port=$port2/udp --permanent >/dev/null
firewall-cmd --add-port=$port3/tcp --permanent >/dev/null
firewall-cmd --add-port=$port3/udp --permanent >/dev/null
firewall-cmd --reload >/dev/null
bar_continue
green "[ √ ] Port released!"

# initiating server
bar_hold_at 95 "initiating server" &
systemctl start ngrokd >/dev/null
systemctl enable ngrokd >/dev/null
systemctl daemon-reload >/dev/null
bar_continue

bar_hold_at 100 "ok"
green "[ √ ] 服务端已在后台启动"
green "[ * ] Tips: 可重新运行本脚本，继续选择编译客户端"
exit_program 
}

# make client
menu_server_2() {
# check server
echo "[ * ] Start checking program packages"
bar_start_from 0
bar_hold_at 95 "checking files" &
if [ ! -f "/usr/local/ngrok/bin/ngrokd" ]; then
    bar_continue
    red "[ x ] Server Files not found! Please check before contune!"
    exit_program
else
    bar_continue
    bar_hold_at 100 "done!"
    green "[ √ ] Files checked!"
fi

# make client options
ngrok_date=ngrok_$(date +%Y%m%d)_$(date +%H%M%S)
green "================================================="
green "    Please Select Clients you want to compile   "
green "     1）Linux 32         2）Linux 64      "
green "     3）Windows 32       4）Windows 64    "
green "     5）MacOS 32         6）MacOS 64      "
green "     7）ARM 32           8）ARM 64        "
green "     9) All Above                        "
green "================================================="
read client_make_options
bar_start_from 0
case $client_make_options in 
    1)
        echo "compiling  Linux 32"
        bar_hold_at 90 "compiling " &
        cd /usr/local/ngrok >/dev/null
        GOOS=linux GOARCH=386 make release-client >/dev/null
        bar_continue
        bar_hold_at 100 "compile complete!  "
        green "[ √ ] Linux 32 compiled!"
    ;;
    2)
        echo "compiling  Linux 64"
        bar_hold_at 90 "compiling " &
        cd /usr/local/ngrok >/dev/null
        GOOS=linux GOARCH=amd64 make release-client >/dev/null
        bar_continue
        bar_hold_at 100 "compile complete!  "
        green "[ √ ] Linux 64 compiled!"
    ;;
    3)
        echo "compiling  Windows 32"
        bar_hold_at 90 "compiling " &
        cd /usr/local/ngrok >/dev/null
        GOOS=windows GOARCH=386 make release-client >/dev/null
        bar_continue
        bar_hold_at 100 "compile complete!  "
        green "[ √ ] Windows 32 compiled!"
    ;;
    4)
        echo "compiling  Windows 64"
        bar_hold_at 90 "compiling " &
        cd /usr/local/ngrok >/dev/null
        GOOS=windows GOARCH=amd64 make release-client >/dev/null
        bar_continue
        bar_hold_at 100 "compile complete!  "
        green "[ √ ] Windows 64 compiled!"
    ;;
    5)
        echo "compiling  MacOS 32"
        bar_hold_at 90 "compiling " &
        cd /usr/local/ngrok >/dev/null
        GOOS=darwin GOARCH=386 make release-client >/dev/null
        bar_continue
        bar_hold_at 100 "compile complete!  "
        green "[ √ ] MacOS 32 compiled!"
    ;;
    6)
        echo "compiling  MacOS 64"
        bar_hold_at 90 "compiling " &
        cd /usr/local/ngrok >/dev/null
        GOOS=darwin GOARCH=amd64 make release-client >/dev/null
        bar_continue
        bar_hold_at 100 "compile complete!  "
        green "[ √ ] MacOS 64 compiled!"
    ;;
    7)
        echo "compiling  ARM 32"
        bar_hold_at 90 "compiling " &
        cd /usr/local/ngrok >/dev/null
        GOOS=linux GOARCH=arm make release-client >/dev/null
        bar_continue
        bar_hold_at 100 "compile complete!  "
        green "[ √ ] ARM 32 compiled!"
    ;;
    8)
        echo "compiling  ARM 64"
        bar_hold_at 90 "compiling " &
        cd /usr/local/ngrok >/dev/null
        GOOS=linux GOARCH=arm64 make release-client >/dev/null
        bar_continue
        bar_hold_at 100 "compile complete!  "
        green "[ √ ] ARM 64 compiled!"
    ;;
    9)
        echo "compiling 所有客户端，请稍候"
        cd /usr/local/ngrok >/dev/null
        bar_hold_at 20 "compiling linux 32!" &
        GOOS=linux GOARCH=386 make release-client >/dev/null
        bar_continue

        bar_start_from 20
        bar_hold_at 30 "compiling linux 64!" &
        GOOS=linux GOARCH=amd64 make release-client >/dev/null
        bar_continue

        bar_start_from 30
        bar_hold_at 40 "compiling Windows 32!" &
        GOOS=windows GOARCH=386 make release-client >/dev/null
        bar_continue

        bar_start_from 40
        bar_hold_at 50 "compiling Windows 64!" &
        GOOS=windows GOARCH=amd64 make release-client >/dev/null
        bar_continue

        bar_start_from 50
        bar_hold_at 60 "compiling MacOS 32!" &
        GOOS=darwin GOARCH=386 make release-client >/dev/null
        bar_continue

        bar_start_from 60
        bar_hold_at 70 "compiling MacOS 64!" &
        GOOS=darwin GOARCH=amd64 make release-client >/dev/null
        bar_continue

        bar_start_from 70
        bar_hold_at 80 "compiling ARM 32!" &
        GOOS=linux GOARCH=arm make release-client >/dev/null
        bar_continue

        bar_start_from 80
        bar_hold_at 90 "compiling ARM 64!" &
        GOOS=linux GOARCH=arm64 make release-client >/dev/null
        bar_continue

        bar_hold_at 100 "done! " 
        green "[ √ ] compile complete! "
    ;; 
    *)
        red "[ x ] Option Error!"
        exit_program
    ;;
esac

# Export Client
if [ ! -p "/opt/ngrok" ]; then
    # echo "[ * ] Creating default dictionary /opt/ngrok"
    mkdir -p /opt/ngrok_client/linux_amd64 >/dev/null 2>&1
    mkdir -p /opt/ngrok_client/linux_arm64 >/dev/null 2>&1
    mkdir -p /opt/ngrok_client/linux_arm32 >/dev/null 2>&1
    mv /usr/local/ngrok/bin/linux_386 /opt/ngrok_client/linux_amd32/ >/dev/null 2>&1 # linux amd 32
    mv /usr/local/ngrok/bin/ngrok /opt/ngrok_client/linux_amd64/ngrok >/dev/null 2>&1 # linux amd 64
    cp -r /usr/local/ngrok/bin/windows_386 /opt/ngrok_client >/dev/null 2>&1 # windows 32
    cp -r /usr/local/ngrok/bin/windows_amd64 /opt/ngrok_client >/dev/null 2>&1 # windows 64
    cp -r /usr/local/ngrok/bin/darwin_386 /opt/ngrok_client >/dev/null 2>&1 # macos 32
    cp -r /usr/local/ngrok/bin/darwin_amd64 /opt/ngrok_client >/dev/null 2>&1 # macos 64
    cp -r /usr/local/ngrok/bin/linux_arm/ngrok /opt/ngrok_client/linux_arm32 >/dev/null 2>&1 # linux arm 32
    cp -r /usr/local/ngrok/bin/linux_arm64 /opt/ngrok_client/ >/dev/null 2>&1 # linux arm 64
    green "[ √ ] Make done! Client Program File has been moved to /opt/ngrok_client"
else
    echo "[ * ] Default dictionary exists: /opt/ngrok. Client program will be moved to /opt/$ngrok_date"
    mkdir -p /opt/$ngrok_date/linux_amd64 >/dev/null 2>&1
    mkdir -p /opt/$ngrok_date/linux_arm64 >/dev/null 2>&1
    mkdir -p /opt/$ngrok_date/linux_arm32 >/dev/null 2>&1
    mv /usr/local/ngrok/bin/linux_386 /opt/$ngrok_date/linux_amd32/ >/dev/null 2>&1 # linux amd 32
    mv /usr/local/ngrok/bin/ngrok /opt/$ngrok_date/linux_amd64/ngrok >/dev/null 2>&1 # linux amd 64
    cp -r /usr/local/ngrok/bin/windows_386 /opt/$ngrok_date >/dev/null 2>&1 # windows 32
    cp -r /usr/local/ngrok/bin/windows_amd64 /opt/$ngrok_date >/dev/null 2>&1 # windows 64
    cp -r /usr/local/ngrok/bin/darwin_386 /opt/$ngrok_date >/dev/null 2>&1 # macos 32
    cp -r /usr/local/ngrok/bin/darwin_amd64 /opt/$ngrok_date >/dev/null 2>&1 # macos 64
    cp -r /usr/local/ngrok/bin/linux_arm/ngrok /opt/$ngrok_date/linux_arm32 >/dev/null 2>&1 # linux arm 32
    cp /usr/local/ngrok/bin/linux_arm64 /opt/$ngrok_date/ >/dev/null 2>&1 # linux arm 64
    green "[ √ ] Make done! Client Program File has been moved to /opt/$ngrok_date"
fi
green "[ √ ] Client Making Complete!"
exit_program
}

# check server info
conf_server_menu3() {
green "[ - ] =========Please Input Domain Name========="
read domain_name
green "[ - ] =========Please SelectDomain Protocol========="
echo "[ - ] 1) TCP（default）"
echo "[ - ] 2) Others（manual）"
read proto_option
case $proto_option in
    1) # tcp
        domain_proto=tcp
    ;;
    2) # other protocol
        echo "[ - ] Please Input Other Protocol:"
        read domain_proto
    ;;
    *) # error
        red "[ x ] Option Error!"
        exit_program
    ;;
esac

green "[ - ] =========Please SelectDomain Port========="
echo "[ - ] 1) 4443(default)"
echo "[ - ] 2) Others(mannual)"

read port_option
case $port_option in
    1) # 4443
        domain_port=4443
    ;;
    2) # Others
        echo "[ - ] Please Input Domain Port:"
        read domain_port
    ;;
    *) # errors
        red "[ x ] Option Error"
        exit_program
    ;;
esac
}

conf_client_menu3() {
green "[ - ] =========Please Select Input Type========="
echo "[ - ] 1) Automatically"
echo "[ - ] 2) Mannually"
read service_option
case $service_option in
    1) # automatically
        service_name=ssh
        local_port=22
        remote_port=2001
    ;;
    2) # mannaully
        yellow "[ - ] Please Input Service Name: "
        read service_name
        yellow "[ - ] Please Input Local Port: "
        read local_port
        yellow "[ - ] Please Input Remote Port: "
        read remote_port
    ;;
    *)
        red "[ x ] Option Error!"
        exit_program
    ;;
esac
}

# Install Client
menu_client_1() {
echo "[ * ] Preparing for install client"
echo "[ * ] Please make sure client program is in /opt as name of ngrok"
echo "[ - ] Program checking……"
if [ ! -f "/opt/ngrok" ]; then
    red "[ x ] Program file doesn't exist! Please check!"
    exit_program
else 
    chmod a+x /opt/ngrok >/dev/null
    green "[ √ ] Program check done!"
fi

apt_update
check_firewalld

echo "[ * ] Client Installation Starting "
bar_start_from 0
bar_hold_at 20 "deleting previous client" &
systemctl stop ngrok >/dev/null
systemctl disable ngrok >/dev/null
systemctl daemon-reload  >/dev/null
rm -r /usr/lib/systemd/system/ngrok.service >/dev/null
rm -r /usr/local/ngrok_client >/dev/null
bar_continue

# writing into systemd
bar_hold_at 30 "writing into systemd" &
if [ ! -d "/usr/local/ngrok_client" ]; then
    mkdir -p /usr/local/ngrok_client >/dev/null
else 
    red "[ x ] File '/usr/local/ngrok_client' exists"
    red "[ x ] System will delete this file before continue"
    rm -r /usr/local/ngrok_client >/dev/null
    mkdir -p /usr/local/ngrok_client >/dev/null
fi
cp /opt/ngrok /usr/local/ngrok_client/ngrok >/dev/null
bar_continue

# check server information
green "[ - ] Checking Server Infomation"
echo "[ * ] Tips: Here we need to check 3 configurations: "
echo "[ * ] 1) Domain Name: the domain resolved to your ngrok Server"
echo "[ * ] 2) Domain Port: the port access to your ngrok Server"
echo "[ * ] 3) Domain Protocol: protocol type of connection, default of tcp (other options like http ro https, could also be input) "
echo "[ * ] For instance: the domain we use is [testdomain.com], we use [tcp] as protocol and access through port [4443], then we input:"
echo "[ * ] Domain Name: testdomain.com"
echo "[ * ] Domain Port: 4443"
echo "[ * ] Domain Protocol: tcp"
conf_server_menu3
yellow "[ - ] ====================================="
yellow "[ - ] Here is information of ngrok server: "
yellow "[ - ] Domain Name:     $domain_name"
yellow "[ - ] Domain Port:     $domain_port"
yellow "[ - ] Domain Protocol: $domain_proto"
yellow "[ - ] ======================================"
yellow "[ - ] Please confirm (y/n)"
read service_confirm
while [ $service_confirm == "n" ]||[ $service_confirm == "N" ]
do 
    conf_client_menu3
    yellow "[ - ] ====================================="
    yellow "[ - ] Here is information of ngrok server: "
    yellow "[ - ] Domain Name:     $domain_name"
    yellow "[ - ] Domain Port:     $domain_port"
    yellow "[ - ] Domain Protocol: $domain_proto"
    yellow "[ - ] ======================================"
    yellow "[ - ] Please confirm (y/n)"
    read service_confirm
done
green "[ √ ] Server information confirmed!"

# check client infomation
green "[ - ] Now checking Client information"
echo " ----------------------------- "
echo "[ * ] Tips: Here we need to check 3 configurations:"
echo "[ * ] 1) Service Name: your local service which you want to penetrate"
echo "[ * ] 2) Local Port: access port of your service"
echo "[ * ] 3) Remote Port: access port for remote usage"
echo "[ * ] For instance: we access to service [XService] through port [2002] of [testdomain.com], then we input: "
echo "[ * ] Service Name: XService"
echo "[ * ] Local Port:   22"
echo "[ * ] Remote Port:  2002"
echo " ----------------------------- "
echo "[ * ] If you select Automatically in this step, the configuration will be: "
echo "[ * ] Service Name: ssh"
echo "[ * ] Local Port:   22"
echo "[ * ] Remote Port:  2001"
echo "[ * ] (this configuration is editiable)"
conf_client_menu3
yellow "[ - ] ====================================="
yellow "[ - ] Here is information of ngrok client: "
yellow "[ - ] Service Name:   $service_name"
yellow "[ - ] Local Port:     $local_port"
yellow "[ - ] Remote Port:    $remote_port"
yellow "[ - ] ======================================"
yellow "[ - ] Please confirm (y/n)"
read service_confirm
while [ $service_confirm == "n" ]||[ $service_confirm == "N" ]
do 
    conf_client_menu3
    yellow "[ - ] ====================================="
    yellow "[ - ] Here is information of ngrok client: "
    yellow "[ - ] Service Name:   $service_name"
    yellow "[ - ] Local Port:     $local_port"
    yellow "[ - ] Remote Port:    $remote_port"
    yellow "[ - ] ======================================"
    yellow "[ - ] Please confirm (y/n)"
    read service_confirm
done
green "[ √ ] Client information confirmed!"

# Creating configuration file
bar_hold_at 40 "creating configuration file" &
cat > /usr/local/ngrok_client/ngrok.yml <<-EOF
server_addr: "$domain_name:$domain_port"
trust_host_root_certs: false
tunnels:
  $service_name:
    remote_port: $remote_port
    proto:
      $domain_proto: $local_port
EOF
bar_continue

# Firewall Configuration
bar_hold_at 50 "checking firewalld" &
check_firewalld
# iptables -A INPUT -p tcp --dport $local_port -j ACCEPT
# iptables -A INPUT -p tcp --dport $remote_port -j ACCEPT
firewall-cmd --add-port=$local_port/tcp --permanent >/dev/null
firewall-cmd --add-port=$local_port/udp --permanent >/dev/null
firewall-cmd --add-port=$remote_port/tcp --permanent >/dev/null
firewall-cmd --add-port=$remote_port/udp --permanent >/dev/null
firewall-cmd --reload >/dev/null
bar_continue

# Writing into systemd
bar_hold_at 60 "writting into systemd" &
mkdir -p /usr/lib/systemd/system >/dev/null
cat > /usr/lib/systemd/system/ngrok.service <<-EOF
[Unit]
Description=ngrok service

[Service]
Type=simple
ExecStart=/usr/local/ngrok_client/ngrok -config=/usr/local/ngrok_client/ngrok.yml start-all

[Install]
WantedBy=multi-user.target
EOF
bar_continue

# Start ngrok client
bar_hold_at 90 "starting ngrok client" &
systemctl start ngrok >/dev/null
systemctl enable ngrok >/dev/null
sleep 1s >/dev/null
systemctl daemon-reload >/dev/null
bar_continue

bar_hold_at 100 "done!"
green "[ √ ] Ngrok Client Started!"
blue "------------"
blue "[ * ] You could use this command to check status of client: "
blue "[ * ] systemctl status ngrok"
exit_program
}

# Release port, one by one
menu_port() { 
check_firewalld
green "======================================"
green "Please Input Port you want to release"
green "======================================"
read port_new_allow
bar_start_from 0
bar_hold_at 90 "releasing port" &
firewall-cmd --add-port=$port_new_allow/tcp --permanent >/dev/null
firewall-cmd --add-port=$port_new_allow/udp --permanent >/dev/null
firewall-cmd --reload >/dev/null
bar_continue
bar_hold_at 100 "done!"
green "[ √ ] Port $port_new_allow is released successfully"
yellow "[ - ] Do you want to release other port? (y/n)"
read port_allow_option
while [ $port_allow_option == "y" ]||[ $port_allow_option == "Y" ]
do 
    clear
    green "======================================"
    green "Please Input Port you want to release"
    green "======================================"
    read port_new_allow
    bar_start_from 0
    bar_hold_at 90 "releasing port" &
    firewall-cmd --add-port=$port_new_allow/tcp --permanent >/dev/null
    firewall-cmd --add-port=$port_new_allow/udp --permanent >/dev/null
    firewall-cmd --reload >/dev/null
    bar_continue
    bar_hold_at 100 "done!"
    green "[ √ ] Port $port_new_allow is released successfully"
    yellow "[ - ] Do you want to release other port? (y/n)"
    read port_allow_option
done
exit_program
}

# Delete Ngrok Server
menu_server_3() { 
red "========================================="
red "            Important Notice             "
red "  This step will uninstall ngrok server  "
red "  which is irrevocable, please do check  "
red "  before continue.                       "
red "========================================="
red "  Do you want to continue? (y/n)"
read server_uninstall_confirm
if [[ $server_uninstall_confirm == "y" ]]||[[ $server_uninstall_confirm == "Y" ]]; then
    red "Please Select: "
    red "1) Delete systemd service (keep project packages) "
    red "2) Delete the whole Ngrok Server"
    read server_uninstall_option
    case $server_uninstall_option in
        1) # Delete systemd service
            bar_start_from 0
            bar_hold_at 90 "deleting systemd service" &
            systemctl stop ngrok >/dev/null
            systemctl disable ngrok  >/dev/null
            rm usr/lib/systemd/system/ngrokd.service >/dev/null
            bar_continue
            bar_hold_at 100 "done"
            green "[ √ ] Systemd service deleted                                   "
        ;;
        2) # Delete all
            bar_start_from 0
            bar_hold_at 90 "deleting ngrok server" &
            systemctl stop ngrok >/dev/null
            systemctl disable ngrok >/dev/null
            rm usr/lib/systemd/system/ngrokd.service >/dev/null
            rm -r /usr/local/ngrok/
            bar_continue
            bar_hold_at 100 "done"
            green "[ √ ] Server deleted                                   "
        ;;
        *) # others
            red "[ x ] Option Error!"
        ;;
    esac
else
    exit_program
fi
exit_program
}

# Delete Ngrok Client
menu_client_2() { 
red "========================================="
red "            Important Notice             "
red "  This step will uninstall ngrok client  "
red "  which is irrevocable, please do check  "
red "  before continue.                       "
red "========================================="
red "  Do you want to continue? (y/n)"
read client_uninstall_confirm
if [[ $client_uninstall_confirm == "y" ]]||[[ $client_uninstall_confirm == "Y" ]]; then
    bar_start_from 0
    bar_hold_at 95 "deleting ngrok client" &
    systemctl stop ngrok  >/dev/null
    systemctl disable ngrok >/dev/null
    rm -r /usr/lib/systemd/system/ngrok.service >/dev/null
    rm -r /usr/local/ngrok_client >/dev/null
    bar_continue
    bar_hold_at 100 "done"
    green "[ √ ] Ngrok Client deleted!                                          "
else
    exit_program
fi
exit_program
}

menu_server() {
clear
green "==================================="
green "        (Usage: Ngrok Server)      "
green "       Please select next step     "
green "         1) Install Server         "
green "         2) Make New Client        "
green "         3) Uninstall Server       "
green "         4) Release Port           "
green "==================================="
read options

case $options in 
    1)  # Install Server
        menu_server_1
    ;;
    2) # Make New Client
        menu_server_2
    ;;
    3) # Uninstall Server
        menu_server_3
    ;;
    4) # Release Port
        menu_port
    ;;
    *)
        red "[ x ] Option Error!"
    ;;
esac 
}

menu_client() {
clear
green "==================================="
green "        (Usage: Ngrok Client)      "
green "       Please select next step     "
green "         1) Install Client         "
green "         2) Uninstall Client        "
green "         3) Release Port           "
green "==================================="
read options

case $options in 
    1)  # Install Client
        menu_client_1
    ;;
    2) # Uninstall Client
        menu_client_2
    ;;
    3) # Release Port
        menu_port
    ;;
    *)
        red "[ x ] Option Error!"
    ;;
esac 
}

menu_start() {
clear
green "========== Ngrok Auto Install =========="
yellow "                Cocean               "
yellow "    Thanx Project: Inconshreveable      "
green "======================================="
green "          Usage of this machine         "
green "             1) Ngrok Server            "
green "             2) Ngrok Client            "
green "======================================="
read options

case $options in 
    1) 
        menu_server
    ;;
    2)
        menu_client
    ;;
    *)
        red "[ x ] Option Error!"
    ;;
esac 
}
menu_start
