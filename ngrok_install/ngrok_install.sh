# !/bin/bash
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
    custom_progress=$1
    custom_phase=$2
    num=0
    postfix=('|' '/' '-' '\')
    read check_start_from <$START_FROM_FILE
    read check_status <$CHECK_STATUS_FILE

    while [ $check_start_from -le 0 -a $custom_progress -ge 0 ]; do
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

    while [ $check_start_from -le 5 -a $custom_progress -ge 5 ]; do
        let index=num%4
        printf "%-31s %-50s \r" "[ ${postfix[$index]} ] [#..........................] (5%)" "$custom_phase"
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

    while [ $check_start_from -le 10 -a $custom_progress -ge 10 ]; do
        let index=num%4
        printf "%-31s %-50s \r" "[ ${postfix[$index]} ] [##.........................] (10%)" "$custom_phase"
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

    while [ $check_start_from -le 15 -a $custom_progress -ge 15 ]; do
        let index=num%4
        printf "%-31s %-50s \r" "[ ${postfix[$index]} ] [###........................] (15%)" "$custom_phase"
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

    while [ $check_start_from -le 20 -a $custom_progress -ge 20 ]; do
        let index=num%4
        printf "%-31s %-50s \r" "[ ${postfix[$index]} ] [####.......................] (20%)" "$custom_phase"
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

    while [ $check_start_from -le 25 -a $custom_progress -ge 25 ]; do
        let index=num%4
        printf "%-31s %-50s \r" "[ ${postfix[$index]} ] [#####......................] (25%)" "$custom_phase"
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

    while [ $check_start_from -le 30 -a $custom_progress -ge 30 ]; do
        let index=num%4
        printf "%-31s %-50s \r" "[ ${postfix[$index]} ] [######.....................] (30%)" "$custom_phase"
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

    while [ $check_start_from -le 35 -a $custom_progress -ge 35 ]; do
        let index=num%4
        printf "%-31s %-50s \r" "[ ${postfix[$index]} ] [#######....................] (35%)" "$custom_phase"
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

    while [ $check_start_from -le 40 -a $custom_progress -ge 40 ]; do
        let index=num%4
        printf "%-31s %-50s \r" "[ ${postfix[$index]} ] [########...................] (40%)" "$custom_phase"
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

    while [ $check_start_from -le 45 -a $custom_progress -ge 45 ]; do
        let index=num%4
        printf "%-31s %-50s \r" "[ ${postfix[$index]} ] [#########..................] (45%)" "$custom_phase"
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

    while [ $check_start_from -le 50 -a $custom_progress -ge 50 ]; do
        let index=num%4
        printf "%-31s %-50s \r" "[ ${postfix[$index]} ] [##########.................] (50%) " "$custom_phase"
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

    while [ $check_start_from -le 55 -a $custom_progress -ge 55 ]; do
        let index=num%4
        printf "%-31s %-50s \r" "[ ${postfix[$index]} ] [###########................] (55%)" "$custom_phase"
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

    while [ $check_start_from -le 60 -a $custom_progress -ge 60 ]; do
        let index=num%4
        printf "%-31s %-50s \r" "[ ${postfix[$index]} ] [############...............] (60%)" "$custom_phase"
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

    while [ $check_start_from -le 65 -a $custom_progress -ge 65 ]; do
        let index=num%4
        printf "%-31s %-50s \r" "[ ${postfix[$index]} ] [#############..............] (65%)" "$custom_phase"
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

    while [ $check_start_from -le 70 -a $custom_progress -ge 70 ]; do
        let index=num%4
        printf "%-31s %-50s \r" "[ ${postfix[$index]} ] [##############.............] (70%)" "$custom_phase"
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

    while [ $check_start_from -le 75 -a $custom_progress -ge 75 ]; do
        let index=num%4
        printf "%-31s %-50s \r" "[ ${postfix[$index]} ] [################...........] (75%)" "$custom_phase"
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

    while [ $check_start_from -le 80 -a $custom_progress -ge 80 ]; do
        let index=num%4
        printf "%-31s %-50s \r" "[ ${postfix[$index]} ] [###################........] (80%)" "$custom_phase"
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

    while [ $check_start_from -le 85 -a $custom_progress -ge 85 ]; do
        let index=num%4
        printf "%-31s %-50s \r" "[ ${postfix[$index]} ] [#####################......] (85%)" "$custom_phase"
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

    while [ $check_start_from -le 90 -a $custom_progress -ge 90 ]; do
        let index=num%4
        printf "%-31s %-50s \r" "[ ${postfix[$index]} ] [#######################....] (90%)" "$custom_phase"
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

    while [ $check_start_from -le 95 -a $custom_progress -ge 95 ]; do
        let index=num%4
        printf "%-31s %-50s \r" "[ ${postfix[$index]} ] [########################...] (95%)" "$custom_phase"
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

    if [ $check_start_from -le 100 -a $custom_progress -ge 100 ]; then
        echo -ne "[ - ] [###########################] (100%) $custom_phase \r"
        delay
    fi
    if [ $check_start_from -le 100 -a $custom_progress -ge 100 ]; then
        echo -ne 'Done!                                                                               \r'
        delay
    fi
}

mkdir -p /opt/new_ngrok/log
touch /opt/new_ngrok/log/ngrok_log.log
log_file=/opt/new_ngrok/log/ngrok_log.log

function exit_program() {
    echo "退出程序"
    exit 0
}

# 获取系统版本信息
function get_release() {
    source /etc/os-release
    RELEASE=$ID
    VERSION=$VERSION
    CONF=$(getconf LONG_BIT)
    CPU=$(uname -m)
}

# 检查系统匹配性

function check_release() {
    get_release
    SYSTEM_TYPE=""
    echo "[ * ] 正在检测当前系统类型                                        "
    case "$RELEASE" in
    "centos" | "redhat")
        red "[ × ] 当前暂不支持$RELEASE，更多功能正在开发中，感谢支持！"
        exit_program
        ;;
    "debian" | "ubuntu")
        yellow "[ √ ] 检测到该系统为$RELEASE, 系统版本为$VERSION_ID，系统架构为$CONF位，芯片架构为$CPU"
        green "[ √ ] 系统检测完成"
        SYSTEM_TYPE="$RELEASE"
        ;;
    "fedora")
        yellow "[ √ ] 检测到该系统为Fedora, 系统版本为$VERSION_ID，系统架构为$CONF位，芯片架构为$CPU"
        green "[ √ ] 系统检测完成"
        SYSTEM_TYPE="fedora"
        ;;
    "opensuse")
        yellow "[ √ ] 检测到该系统为openSUSE, 系统版本为$VERSION_ID，系统架构为$CONF位，芯片架构为$CPU"
        green "[ √ ] 系统检测完成"
        SYSTEM_TYPE="opensuse"
        ;;
    "arch")
        yellow "[ √ ] 检测到该系统为Arch Linux, 系统版本为$VERSION_ID，系统架构为$CONF位，芯片架构为$CPU"
        green "[ √ ] 系统检测完成"
        SYSTEM_TYPE="arch"
        ;;
    *)
        red "[ × ] 当前暂不支持$RELEASE，更多功能正在开发中，感谢支持！"
        exit_program
        ;;
    esac
    echo "$RELEASE"
}

# 网络环境检查
function check_network() {
    if ping -c 1 -w 3 www.baidu.com >/dev/null 2>&1; then
        if ping -c 1 -w 3 www.youtube.com >/dev/null 2>&1; then
            green "[ √ ] 当前网络环境为：科学上网环境"
            network=international
        else
            yellow "[ √ ] 当前网络环境将切换为：正常上网环境"
            network=mainland
            echo "13.114.40.48 github.com" >>/etc/hosts
            check_github_access
        fi
    else
        red "[ × ] 当前网络配置错误，请检查网络环境！"
        exit_program
    fi
}

# 检查Github访问
function check_github_access() {
    if ping -c 1 -w 3 github.com >/dev/null 2>&1; then
        green "[ √ ] 网络配置完成"
    else
        red "[ × ] 无法访问github，请手动修改host文件或配置科学上网环境。"
        exit_program
    fi
}

# 检查log文件是否存在
function check_log() {
    if [ ! -f "$log_file" ]; then
        mkdir -p /opt/new_ngrok/log >/dev/null 2>&1
    fi
}

# apt换源
apt_source_debian() {
    cat >/etc/apt/sources.list <<-EOF
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
    cat >/etc/apt/sources.list <<-EOF
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

# apt更新，并选择是否换源
apt_update() {
    yellow "[ - ] 是否进行apt更新（y/n)"
    read apt_update
    if [[ $apt_update == "y" ]] || [[ $apt_update == "Y" ]]; then
        yellow "[ - ] 请选择是否换源（y/n)"
        read apt_source
        if [[ $apt_source == "y" ]] || [[ $apt_source == "Y" ]]; then
            if [ "$RELEASE" == "debian" ]; then
                apt_source_debian
                green "[ √ ] 换源完成"
            elif [ "$RELEASE" == "ubuntu" ]; then
                apt_source_ubuntu
                green "[ √ ] 已换源至中科大源"
            else
                red "[ × ] 当前暂不支持$RELEASE，更多功能正在开发中，感谢支持！"
                exit_program
            fi
        elif [[ $apt_source == "n" ]] || [[ $apt_source == "N" ]]; then
            echo "[ * ] 已跳过换源"
        else
            red "[ x ] 错误，即将退出程序"
        fi
        echo "[ * ] 即将开始更新apt"
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

        bar_hold_at 100 "更新完成！"
        green "[ √ ] apt更新完成                                             "

    elif [[ $apt_update == "n" ]] || [[ $apt_update == "N" ]]; then
        green "[ * ] 已跳过apt更新                                             "
    else
        red "[ x ] 错误，即将退出程序"
        exit_program
    fi

}
## 检查apt是否能正常使用
# function check_apt() {
#     echo "[ * ] 即将开始检查apt环境"
#     bar_start_from 0
#     bar_hold_at 50 "checking apt" &
#     apt update -y 2> /opt/new_ngrok/log/ngrok_log.log >/dev/null 2>&1
#     # if cat $log_file| grep "apt" >> /dev/null; then
#     #     bar_continue
#     #     red "[ × ] apt错误，请检查apt后再运行脚本！                              "
#     #     :> $log_file
#     #     exit_program
#     # else
#     #     apt_update -y >/dev/null 2>&1
#     #     bar_continue
#     #     bar_hold_at 100 "Done! "
#     #     green "[ √ ] apt检测完成                                             "
#     # fi
#     bar_continue
#     bar_hold_at 100 "Done!"
#     green "[ √ ] apt检测完成                                                   "
# }

# 选择是否返回主菜单
function return_to_main_menu() {
    yellow "[ - ] 是否返回主菜单？（y/n)"
    read menu_confirm

    if [[ $menu_confirm == "y" ]] || [[ $menu_confirm == "Y" ]]; then
        menu_start
    elif [[ $menu_confirm == "n" ]] || [[ $menu_confirm == "N" ]]; then
        exit_program
    else
        red "[ x ] 错误，即将退出程序"
        exit_program
    fi
}

function check_firewalld() {
    firewalld 2>/opt/new_ngrok/log/ngrok_log.log
    if cat $log_file | grep "firewalld" >>/dev/null 2>&1; then
        red "[ × ] 未检测到firewalld，即将开始安装                              "
        : >$log_file
        apt install firewalld -y >/dev/null 2>&1
    else
        green "[ √ ] 防火墙检测完成                                            "
    fi
}

# 检查是否安装git
function check_git() {
    git version 2>/opt/new_ngrok/log/ngrok_log.log >/dev/null 2>&1
    if cat $log_file | grep "git" >>/dev/null 2>&1; then
        red "[ × ] 未检测到git，即将开始安装"
        : >$log_file
        apt install git -y >/dev/null 2>&1
        if [ "$network" == "mainland" ]; then
            git config --global --unset http.https://github.com.proxy
            git config --global --unset https.https://github.com.proxy
        else
            pass
        fi
    else
        green "[ √ ] git检测完成                                     "
    fi
}

# 检测其他工具是否安装
function check_tools() {
    apt install wget -y >/dev/null 2>&1
    green "[ √ ] wget检测完成                                        "
    apt install curl -y >/dev/null 2>&1
    green "[ √ ] curl检测完成                                        "
    apt install sudo -y >/dev/null 2>&1
    green "[ √ ] sudo检测完成                                        "
    apt install make -y >/dev/null 2>&1
    green "[ √ ] make检测完成                                        "
    apt install firewalld -y >/dev/null 2>&1
    green "[ √ ] firewalld检测完成                                   "
}
# 安装 go 1.12.6
function install_go() {
    yellow "[ - ] 开始安装 go 1.12.6"
    sleep 0.5s
    bar_start_from 0
    mkdir /opt/new_ngrok >/dev/null 2>&1
    cd /opt/new_ngrok/ >/dev/null 2>&1
    get_release
    bar_hold_at 50 "downloading go packages" &
    if [ "$CONF" == "32" ]; then
        if [ "${CPU%v}" == "arm" -o "${CPU%v}" == "ARM" ]; then # arm架构 arm32
            go_pack="/opt/new_ngrok/go1.12.6.linux-armv6l.tar.gz"
            if [ ! -f "/opt/new_ngrok/$go_pack" ]; then
                wget -P /opt/new_ngrok/ -q -c https://golang.google.cn/dl/go1.12.6.linux-armv6l.tar.gz
            else
                yellow "[ * ] 已检测到 $go_pack，跳过下载                           "
            fi
        else # x86/amd架构 32
            go_pack="/opt/new_ngrok/go1.12.6.linux-386.tar.gz"
            if [ ! -f "/opt/new_ngrok/$go_pack" ]; then
                wget -P /opt/new_ngrok/ -q -c https://golang.google.cn/dl/go1.12.6.linux-386.tar.gz
            else
                yellow "[ * ] 已检测到 $go_pack，跳过下载                           "
            fi
        fi
    elif [ "$CONF" == "64" ]; then
        if [ "${CPU%64}" == "aarch" -o "${CPU%64}" == "arm" ]; then # arm架构 arm64
            go_pack="/opt/new_ngrok/go1.12.6.linux-arm64.tar.gz"
            if [ ! -f "/opt/new_ngrok/$go_pack" ]; then
                wget -P /opt/new_ngrok/ -q -c https://golang.google.cn/dl/go1.12.6.linux-arm64.tar.gz
            else
                yellow "[ * ] 已检测到 $go_pack，跳过下载                           "
            fi
        else # x86/amd架构 64
            go_pack="/opt/new_ngrok/go1.12.6.linux-amd64.tar.gz"
            if [ ! -f "/opt/new_ngrok/$go_pack" ]; then
                wget -P /opt/new_ngrok/ -q -c https://golang.google.cn/dl/go1.12.6.linux-amd64.tar.gz
            else
                yellow "[ * ] 已检测到 $go_pack，跳过下载                           "
            fi
        fi
    else
        bar_continue
        red "[ x ] 无法自动下载go 1.12.6，请前往官网手动下载，并将安装包放到/opt/new_ngrok下"
        red "[ x ] 下载地址：https://golang.google.cn/dl/                  "
        red "[ x ] 注：版本必须为1.12.6，使用其他版本搭建时容易报错！            "
        exit_program
    fi
    bar_continue

    bar_start_from 50
    bar_hold_at 90 "installing go 1.12.6" &
    cd /opt/new_ngrok/
    tar -C /opt/new_ngrok/ -xzf $go_pack >/dev/null 2>&1
    export PATH=$PATH:/opt/new_ngrok/go/bin
    bar_continue
    # bar_start_from 90
    bar_hold_at 95 "checking installation" &

    # 检查，只要是grep中带有1.12字样的，都算安装成功
    if [[ $(go version | grep "1.12") != "" ]]; then
        bar_continue
        bar_hold_at 100 "Done!"
        green "[ √ ] go环境安装成功!                                        "
    else
        bar_continue
        red "[ x ] go 安装失败，请卸载原有go环境后，手动安装go环境               "
        exit_program
    fi
}

# 检查go是否安装，并执行安装go
function check_go() {
    yellow "[ * ] 正在检测go环境"
    cd /opt/new_ngrok/ && go version 2>/opt/new_ngrok/log/ngrok_log.log >/dev/null 2>&1
    if cat $log_file | grep "go" >/dev/null 2>&1; then
        red "[ × ] go环境未安装"
        : >$log_file
        sleep 0.5s
        install_go

    elif [[ $(go version | grep "1.12.6") != "" ]]; then
        green "[ √ ] go环境检测完成，当前版本为1.12.6"

    else
        blue "[ - ] 检测到go环境，但不是指定版本"
        blue "[ - ] 即将卸载后安装指定版本 go (1.12.6)"
        echo "[ - ] 正在卸载原有go环境"
        bar_start_from 0
        bar_hold_at 60 "uninstalling golang-go" &
        apt-get remove golang-go -y >/dev/null 2>&1
        apt-get remove --auto-remove golang-go >/dev/null 2>&1
        bar_continue
        bar_hold_at 90 "uninstalling gccgo-go" &
        apt-get remove gccgo-go -y >/dev/null 2>&1
        bar_continue
        bar_hold_at 100 "Done!"
        green "[ √ ] 原有go环境卸载完成"
        install_go
    fi
}

# 检查服务配置，用于服务端安装
function check_environment() {
    yellow "[ - ] 是否进行环境检查（y/n)"
    read option_environment
    if [[ $option_environment == "y" ]] || [[ $option_environment == "Y" ]]; then
        echo "[ * ] 即将检测系统配置环境"
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

        bar_start_from 50
        bar_hold_at 60 "firewalld checking" &
        check_firewalld
        bar_continue

        bar_start_from 50
        bar_hold_at 70 "git checking" &
        check_git
        bar_continue

        bar_start_from 70
        bar_hold_at 100 "环境检测完成！"
        green "[ √ ] 环境检测已完成！                                            "

    elif [[ $option_environment == "n" ]] || [[ $option_environment == "N" ]]; then
        green "[ * ] 已跳过环境检测                                             "
    else
        red "[ x ] 错误，即将退出程序"
        exit_program
    fi
}

check_domain() {
    echo "[ * ] 即将开始确认域名信息"
    green "[ - ] =========请输入域名========="
    green "[ - ] 注：请输入已解析到本服务器ip的域名"
    while true; do
        read -p "请输入域名: " ngrokd_domain
        yellow "[ - ] 所输入网址为：$ngrokd_domain"
        read -p "请确认（Y/n): " domain_confirm
        domain_confirm=${domain_confirm:-Y}
        [[ $domain_confirm =~ ^[Yy]$ ]] && break
    done
    export NGROK_DOMAIN="$ngrokd_domain"
    ip_domain=$(ping -c 1 "$ngrokd_domain" | sed -nE 's/^PING[^(]+\(([^)]+)\).+/\1/p')
    ip_local=$(curl -s ipv4.icanhazip.com)
    blue "================================="
    blue " 域名解析地址为: $ip_domain"
    blue " 当前设备地址为: $ip_local"
    blue "================================="
    sleep 1s
    if [[ $ip_domain == $ip_local ]]; then
        green "[ √ ] 域名解析正常"
    else
        red "[ x ] 域名解析错误！"
        red "请确保域名解析正常！"
        exit_program
    fi
}

# git clone 下载项目
git_clone() {
    bar_start_from 0
    bar_hold_at 70 "正在下载项目包" &

    cd /usr/local
    git clone https://github.com/inconshreveable/ngrok.git >/dev/null 2>&1

    bar_continue
    bar_hold_at 100 "完成！"
    green "[ √ ] 项目包已下载至 /usr/local"
}

# 确认项目是否已安装
check_git_clone() {
    echo "[ * ] 正在检查项目包资源，请稍候"
    if [ ! -f "/usr/local/ngrok/Makefile" ]; then # 检查项目包
        echo "[ * ] 未检测到项目包，即将开始下载"
        echo "[ * ] 默认下载目录：/usr/local"
        git_clone
    else
        yellow "[ - ] 检测到项目包已存在，请选择："
        yellow "[ - ] 1) 重新下载，覆盖已有项目包"
        yellow "[ - ] 2) 跳过下载，直接开始安装服务端"
        read clone_options
        case $clone_options in
        1) # 重新安装，覆盖已有项目包
            git_clone
            ;;
        2) # 跳过下载直接安装
            green "[ √ ] 跳过下载，即将开始安装服务"
            ;;
        *)
            red "[ x ] 错误选项，请重新选择！"
            ;;
        esac
    fi
}

# 修复无法正常编译的问题
fix_compilation_issues() {
    bar_start_from 0
    bar_hold_at 20 "正在检查并修复编译问题" &

    # 定义目录变量
    local ngrok_dir="/usr/local/ngrok"
    local rivo_dir="${ngrok_dir}/src/github.com/rivo"
    local uniseg_dir="${rivo_dir}/uniseg"
    local gen_tools_dir="${rivo_dir}/gen_tools"

    bar_continue
    bar_hold_at 40 "正在检查并修复编译问题" &
    make clean >/dev/null 2>&1

    bar_continue
    bar_hold_at 60 "正在检查并修复编译问题" &
    make release-server >/dev/null 2>&1

    # 尝试编译并捕捉错误
    bar_continue
    bar_hold_at 90 "正在检查并修复编译问题" &
    if ! make release-server 2>/dev/null; then
        echo "[ * ] 检测到编译错误，正在修复"

        # 检查并转移 gen_breaktest.go 和 gen_properties.go
        cd "$uniseg_dir"
        if [ -f gen_breaktest.go ] || [ -f gen_properties.go ]; then
            # 如果目标文件夹不存在，则创建它
            if [ ! -d "$gen_tools_dir" ]; then
                mkdir -p "$gen_tools_dir"
            fi

            # 移动文件
            [ -f gen_breaktest.go ] && mv gen_breaktest.go "$gen_tools_dir/"
            [ -f gen_properties.go ] && mv gen_properties.go "$gen_tools_dir/"
        fi
    fi
    bar_hold_at 100 "Done!"
}

conf_port_menu2() {
    yellow "[ - ] =========请选择端口输入方式========="
    yellow "[ - ] 1) 自动输入 2）手动输入"
    read port_option

    case $port_option in
    1) # 自动输入
        port1=80
        port2=443
        port3=4443
        ;;
    2) # 手动输入
        yellow "[ - ] 请输入http协议的端口："
        read port1
        yellow "[ - ] 请输入https协议端口："
        read port2
        yellow "[ - ] 请输入tunnel端口："
        read port3
        ;;
    *)
        red "错误！请重新选择！"
        exit_program
        ;;
    esac
}

# 写入系统启动项
configure_systemctl_service() {
    echo "开始写入系统启动项"
    bar_start_from 0
    bar_hold_at 20 "正在写入启动项" &

    mkdir -p /usr/lib/systemd/system >/dev/null 2>&1
    cat >/usr/lib/systemd/system/ngrokd.service <<-EOF
[Unit]
Description=ngrokd service

[Service]
Type=simple
ExecStart=/usr/local/ngrok/bin/ngrokd -domain="$NGROK_DOMAIN" -httpAddr=":$port1" -httpsAddr=":$port2" -tunnelAddr=":$port3"

[Install]
WantedBy=multi-user.target
EOF
    bar_continue
    green "[ √ ] 系统启动项写入完成"

    # 防火墙放行
    bar_hold_at 60 "正在放行端口" &
    firewall-cmd --permanent \
        --add-port=$port1/tcp \
        --add-port=$port1/udp \
        --add-port=$port2/tcp \
        --add-port=$port2/udp \
        --add-port=$port3/tcp \
        --add-port=$port3/udp >/dev/null 2>&1 &
    wait
    firewall-cmd --reload >/dev/null 2>&1
    bar_continue
    green "[ √ ] 端口放行完毕"

    # 服务端启动
    bar_hold_at 95 "正在启动服务端" &
    systemctl start ngrokd >/dev/null 2>&1
    systemctl enable ngrokd >/dev/null 2>&1
    systemctl daemon-reload >/dev/null 2>&1
    bar_continue

    bar_hold_at 100 "Done!"
    green "[ √ ] 服务端已在后台启动"
}

# 配置端口
configure_port() {
    cd /usr/local/ngrok/bin
    echo "[ * ] 即将开始配置端口信息"
    echo "[ * ] Tips: 服务端默认有3个端口：http/https/tunnel"
    echo "[ * ] 若选择自动输入，端口将分别配置为："
    echo "[ * ] http：  80   端口"
    echo "[ * ] https： 443  端口"
    echo "[ * ] tunnel：4443 端口"
    echo "[ * ] 其中，tunnel包括tcp、udp等穿透，可用于ssh"
    echo "[ * ] 若选择手动输入，则可自定义三个端口"
    conf_port_menu2

    # 确认端口
    yellow "[ - ] ============================"
    yellow "[ - ] 以下为服务器端口信息"
    yellow "[ - ] http:   $port1"
    yellow "[ - ] https:  $port2"
    yellow "[ - ] tunnel: $port3"
    yellow "[ - ] ============================"
    yellow "[ - ] 请确认(y/n)"
    read port_confirm

    while [ $port_confirm == "n" ] || [ $port_confirm == "N" ]; do
        conf_port_menu2
        yellow "[ - ] =========================="
        yellow "[ - ] 以下为服务器端口信息"
        yellow "[ - ] http:   $port1"
        yellow "[ - ] https:  $port2"
        yellow "[ - ] tunnel: $port3"
        yellow "[ - ] =========================="
        yellow "[ - ] 请确认(y/n)"
        read port_confirm
    done

    green "[ √ ] 端口已确认"

    # 询问是否写入 systemctl service
    yellow "[ - ] 是否将服务端写入系统启动项?（y/n)"
    read systemctl_service_confirm

    if [[ $systemctl_service_confirm == "y" ]] || [[ $systemctl_service_confirm == "Y" ]]; then
        configure_systemctl_service
    elif [[ $systemctl_service_confirm == "n" ]] || [[ $systemctl_service_confirm == "N" ]]; then
        green "[ √ ] 已跳过写入系统启动项"
    else
        red "[ x ] 错误，即将退出程序"
        exit_program
    fi
}

# 编译新服务端
menu_server_1() {
    green "即将开始搭建Server端"

    # 检查环境
    check_environment
    apt_update
    check_go
    check_domain

    # 检查项目包与git
    check_git_clone
    git config --global http.sslverify false >/dev/null 2>&1

    # 准备编译
    echo "[ * ] 即将开始编译 ngrokd 服务端"
    bar_start_from 0

    # 签发证书
    echo "[ * ] 即将开始签发证书"
    bar_hold_at 30 "正在签发证书" &
    cd /usr/local/ngrok

    # 生成根证书的密钥
    openssl genrsa -out rootCA.key 2048 >/dev/null 2>&1

    # 生成根证书（自签名）
    openssl req -x509 -new -nodes -key rootCA.key -subj "/CN=$NGROK_DOMAIN" -days 5000 -out rootCA.pem >/dev/null 2>&1

    # 生成设备密钥
    openssl genrsa -out device.key 2048 >/dev/null 2>&1

    # 生成证书签名请求（CSR）
    openssl req -new -key device.key -subj "/CN=$NGROK_DOMAIN" -out device.csr >/dev/null 2>&1

    # 使用根证书签发设备证书
    openssl x509 -req -in device.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out device.crt -days 5000 >/dev/null 2>&1

    # 替换证书路径
    bar_continue
    bar_hold_at 80 "正在替换证书路径" &
    cp /usr/local/ngrok/rootCA.pem /usr/local/ngrok/assets/client/tls/ngrokroot.crt >/dev/null 2>&1
    cp /usr/local/ngrok/device.crt /usr/local/ngrok/assets/server/tls/snakeoil.crt >/dev/null 2>&1
    cp /usr/local/ngrok/device.key /usr/local/ngrok/assets/server/tls/snakeoil.key >/dev/null 2>&1
    bar_hold_at 100 "Done!"
    green "[ √ ] 证书已签发"

    # 修复无法正常编译的问题
    fix_compilation_issues

    # 编译服务端
    bar_start_from 0
    bar_hold_at 50 "正在编译服务端" &

    cd /usr/local/ngrok
    make clean >/dev/null 2>&1
    make release-server >/dev/null 2>&1
    bar_continue

    # 检查编译结果
    bar_hold_at 80 "正在检查编译结果" &
    if [ ! -f "/usr/local/ngrok/bin/ngrokd" ]; then
        bar_continue
        red "[ x ] ngrokd服务端编译失败，请检查编译环境！"
        exit_program
    fi

    bar_hold_at 100 "Done!"
    green "[ √ ] ngrokd服务端已编译成功"

    # 确认是否配置端口
    yellow "[ - ] 是否需要配置端口信息？（y/n)"
    read port_confirm

    if [[ $port_confirm == "y" ]] || [[ $port_confirm == "Y" ]]; then
        configure_port
    elif [[ $port_confirm == "n" ]] || [[ $port_confirm == "N" ]]; then
        green "[ √ ] 已跳过配置端口"
    else
        red "[ x ] 错误，即将退出程序"
        exit_program
    fi

    # 选择是否返回主菜单
    return_to_main_menu
}

# 编译新客户端
menu_server_2() {
    # 检查服务端是否已安装
    echo "[ * ] 即将开始检查编译文件"
    bar_start_from 0
    bar_hold_at 95 "正在检查编译文件……" &
    if [ ! -f "/usr/local/ngrok/bin/ngrokd" ]; then
        bar_continue
        red "[ x ] 服务端未安装！请安装后再编译客户端！"
        exit_program
    else
        bar_continue
        bar_hold_at 100 "Done!"
        green "[ √ ] 服务端检查ok"
    fi

    # 编译方式选择
    ngrok_date=ngrok_$(date +%Y%m%d)_$(date +%H%M%S)
    green "======================================="
    green "        请选择需要生成的 Client 端        "
    green "    1）Linux 32位    2）Linux 64位      "
    green "    3）Windows 32位  4）Windows 64位    "
    green "    5）MacOS 32位    6）MacOS 64位      "
    green "    7）ARM 32位      8）ARM 64位        "
    green "    9) 以上所有                         "
    green "======================================="
    read client_make_options
    bar_start_from 0
    case $client_make_options in
    1)
        echo "正在编译 Linux 32位客户端，请稍候"
        bar_hold_at 90 "正在编译" &
        cd /usr/local/ngrok >/dev/null 2>&1
        GOOS=linux GOARCH=386 make release-client >/dev/null 2>&1
        bar_continue
        bar_hold_at 100 "编译完成！"
        green "[ √ ] Linux 32位客户端已编译完成"
        ;;
    2)
        echo "正在编译 Linux 64位客户端，请稍候"
        bar_hold_at 90 "正在编译" &
        cd /usr/local/ngrok >/dev/null 2>&1
        GOOS=linux GOARCH=amd64 make release-client >/dev/null 2>&1
        bar_continue
        bar_hold_at 100 "编译完成！"
        green "[ √ ] Linux 64位客户端已编译完成"
        ;;
    3)
        echo "正在编译 Windows 32位客户端，请稍候"
        bar_hold_at 90 "正在编译" &
        cd /usr/local/ngrok >/dev/null 2>&1
        GOOS=windows GOARCH=386 make release-client >/dev/null 2>&1
        bar_continue
        bar_hold_at 100 "编译完成！"
        green "[ √ ] Windows 32位客户端已编译完成"
        ;;
    4)
        echo "正在编译 Windows 64位客户端，请稍候"
        bar_hold_at 90 "正在编译" &
        cd /usr/local/ngrok >/dev/null 2>&1
        GOOS=windows GOARCH=amd64 make release-client >/dev/null 2>&1
        bar_continue
        bar_hold_at 100 "编译完成！"
        green "[ √ ] Windows 64位客户端已编译完成"
        ;;
    5)
        echo "正在编译 MacOS 32位客户端，请稍候"
        bar_hold_at 90 "正在编译" &
        cd /usr/local/ngrok >/dev/null 2>&1
        GOOS=darwin GOARCH=386 make release-client >/dev/null 2>&1
        bar_continue
        bar_hold_at 100 "编译完成！"
        green "[ √ ] MacOS 32位客户端已编译完成"
        ;;
    6)
        echo "正在编译 MacOS 64位客户端，请稍候"
        bar_hold_at 90 "正在编译" &
        cd /usr/local/ngrok >/dev/null 2>&1
        GOOS=darwin GOARCH=amd64 make release-client >/dev/null 2>&1
        bar_continue
        bar_hold_at 100 "编译完成！"
        green "[ √ ] MacOS 64位客户端已编译完成"
        ;;
    7)
        echo "正在编译 ARM 32位客户端，请稍候"
        bar_hold_at 90 "正在编译" &
        cd /usr/local/ngrok >/dev/null 2>&1
        GOOS=linux GOARCH=arm make release-client >/dev/null 2>&1
        bar_continue
        bar_hold_at 100 "编译完成！"
        green "[ √ ] ARM 32位客户端已编译完成"
        ;;
    8)
        echo "正在编译 ARM 64位客户端，请稍候"
        bar_hold_at 90 "正在编译" &
        cd /usr/local/ngrok >/dev/null 2>&1
        GOOS=linux GOARCH=arm64 make release-client >/dev/null 2>&1
        bar_continue
        bar_hold_at 100 "编译完成！"
        green "[ √ ] ARM 64位客户端已编译完成"
        ;;
    9)
        echo "正在编译所有客户端，请稍候"
        cd /usr/local/ngrok >/dev/null 2>&1
        bar_hold_at 20 "正在编译linux 32位客户端" &
        GOOS=linux GOARCH=386 make release-client >/dev/null 2>&1
        bar_continue

        bar_start_from 20
        bar_hold_at 30 "正在编译linux 64位客户端" &
        GOOS=linux GOARCH=amd64 make release-client >/dev/null 2>&1
        bar_continue

        bar_start_from 30
        bar_hold_at 40 "正在编译Windows 32位客户端" &
        GOOS=windows GOARCH=386 make release-client >/dev/null 2>&1
        bar_continue

        bar_start_from 40
        bar_hold_at 50 "正在编译Windows 64位客户端" &
        GOOS=windows GOARCH=amd64 make release-client >/dev/null 2>&1
        bar_continue

        bar_start_from 50
        bar_hold_at 60 "正在编译MacOS 32位客户端" &
        GOOS=darwin GOARCH=386 make release-client >/dev/null 2>&1
        bar_continue

        bar_start_from 60
        bar_hold_at 70 "正在编译MacOS 64位客户端" &
        GOOS=darwin GOARCH=amd64 make release-client >/dev/null 2>&1
        bar_continue

        bar_start_from 70
        bar_hold_at 80 "正在编译ARM 32位客户端" &
        GOOS=linux GOARCH=arm make release-client >/dev/null 2>&1
        bar_continue

        bar_start_from 80
        bar_hold_at 90 "正在编译ARM 64位客户端" &
        GOOS=linux GOARCH=arm64 make release-client >/dev/null 2>&1
        bar_continue

        bar_hold_at 100 "编译已完成！"
        green "[ √ ] 所有客户端编译已完成！"
        ;;
    *)
        red "[ x ] 错误！请重新选择！"
        exit_program
        ;;
    esac

    # 导出到文件夹
    if [ ! -p "/opt/ngrok" ]; then
        # echo "[ * ] 正在创建默认文件夹/opt/ngrok"
        mkdir -p /opt/ngrok_client/linux_amd64 >/dev/null 2>&1
        # mkdir -p /opt/ngrok_client/linux_arm64 >/dev/null 2>&1
        mkdir -p /opt/ngrok_client/linux_arm32 >/dev/null 2>&1
        mv /usr/local/ngrok/bin/linux_386 /opt/ngrok_client/linux_amd32/ >/dev/null 2>&1         # linux amd 32
        mv /usr/local/ngrok/bin/ngrok /opt/ngrok_client/linux_amd64/ngrok >/dev/null 2>&1        # linux amd 64
        cp -r /usr/local/ngrok/bin/windows_386 /opt/ngrok_client >/dev/null 2>&1                 # windows 32
        cp -r /usr/local/ngrok/bin/windows_amd64 /opt/ngrok_client >/dev/null 2>&1               # windows 64
        cp -r /usr/local/ngrok/bin/darwin_386 /opt/ngrok_client >/dev/null 2>&1                  # macos 32
        cp -r /usr/local/ngrok/bin/darwin_amd64 /opt/ngrok_client >/dev/null 2>&1                # macos 64
        cp -r /usr/local/ngrok/bin/linux_arm/ngrok /opt/ngrok_client/linux_arm32 >/dev/null 2>&1 # linux arm 32
        cp -r /usr/local/ngrok/bin/linux_arm64 /opt/ngrok_client/ >/dev/null 2>&1                # linux arm 64
        green "[ √ ] 客户端已存入/opt/ngrok_client文件夹，编译完成"
    else
        echo "[ * ] 默认文件夹/opt/ngrok已存在，将创建存储目录/opt/$ngrok_date"
        mkdir -p /opt/$ngrok_date/linux_amd64 >/dev/null 2>&1
        mkdir -p /opt/$ngrok_date/linux_arm64 >/dev/null 2>&1
        mkdir -p /opt/$ngrok_date/linux_arm32 >/dev/null 2>&1
        mv /usr/local/ngrok/bin/linux_386 /opt/$ngrok_date/linux_amd32/ >/dev/null 2>&1         # linux amd 32
        mv /usr/local/ngrok/bin/ngrok /opt/$ngrok_date/linux_amd64/ngrok >/dev/null 2>&1        # linux amd 64
        cp -r /usr/local/ngrok/bin/windows_386 /opt/$ngrok_date >/dev/null 2>&1                 # windows 32
        cp -r /usr/local/ngrok/bin/windows_amd64 /opt/$ngrok_date >/dev/null 2>&1               # windows 64
        cp -r /usr/local/ngrok/bin/darwin_386 /opt/$ngrok_date >/dev/null 2>&1                  # macos 32
        cp -r /usr/local/ngrok/bin/darwin_amd64 /opt/$ngrok_date >/dev/null 2>&1                # macos 64
        cp -r /usr/local/ngrok/bin/linux_arm/ngrok /opt/$ngrok_date/linux_arm32 >/dev/null 2>&1 # linux arm 32
        cp /usr/local/ngrok/bin/linux_arm64 /opt/$ngrok_date/ >/dev/null 2>&1                   # linux arm 64
        yellow "[ - ] 默认文件夹/opt/ngrok已存在"
        green "[ √ ] 客户端已存入/opt/$ngrok_date文件夹，编译完成"
    fi
    green "[ √ ] 客户端编译完毕"

    # 选择是否返回主菜单
    return_to_main_menu
}

# 输入端口
conf_server_menu3() {
    green "[ - ] =========请输入访问域名========="
    read domain_name
    green "[ - ] =========请选择访问协议========="
    echo "[ - ] 1) tcp（默认）"
    echo "[ - ] 2) 其他（手动输入）"
    read proto_option
    case $proto_option in
    1) # tcp
        domain_proto=tcp
        ;;
    2) # http
        echo "[ - ] 请输入其他协议类型:"
        read domain_proto
        ;;
    *) # 其他
        red "[ x ] 错误，请重新选择"
        exit_program
        ;;
    esac

    green "[ - ] =========请选择访问端口========="
    echo "[ - ] 1) 4443"
    echo "[ - ] 2) 其他"

    read port_option
    case $port_option in
    1) # 4443端口
        domain_port=4443
        ;;
    2) # 其他端口
        echo "[ - ] 请输入访问端口:"
        read domain_port
        ;;
    *) # 其他
        red "[ x ] 错误，请重新选择"
        exit_program
        ;;
    esac
}

conf_client_menu3() {
    green "[ - ] =========请选择服务输入方式========="
    echo "[ - ] 1) 自动输入"
    echo "[ - ] 2) 手动输入"
    read service_option
    case $service_option in
    1) # 自动输入
        service_name=ssh
        local_port=22
        remote_port=2001
        ;;
    2) # 手动输入
        yellow "[ - ] 请输入服务名："
        read service_name
        yellow "[ - ] 请输入该服务对应的本地端口："
        read local_port
        yellow "[ - ] 请输入远程访问的端口："
        read remote_port
        ;;
    *)
        red "[ x ] 错误，请重新选择"
        exit_program
        ;;
    esac
}

# 安装已有客户端
menu_client_1() {
    echo "[ * ] 准备搭建Client端，请确保文件已传输至/opt下并命名为ngrok"
    echo "[ - ] 正在检查文件……"
    if [ ! -f "/opt/ngrok" ]; then
        red "[ x ] 客户端文件不存在，请确认！"
        exit_program
    else
        chmod a+x /opt/ngrok >/dev/null 2>&1
        green "[ √ ] 文件检查ok"
    fi

    apt_update
    check_firewalld

    echo "[ * ] 即将开始搭建客户端"
    bar_start_from 0
    bar_hold_at 20 "正在删除原有客户端" &
    systemctl stop ngrok >/dev/null 2>&1
    systemctl disable ngrok >/dev/null 2>&1
    systemctl daemon-reload >/dev/null 2>&1
    rm -r /usr/lib/systemd/system/ngrok.service >/dev/null 2>&1
    rm -r /usr/local/ngrok_client >/dev/null 2>&1
    bar_continue

    # 写入系统服务项
    bar_hold_at 30 "正在写入系统服务项" &
    if [ ! -d "/usr/local/ngrok_client" ]; then
        mkdir -p /usr/local/ngrok_client >/dev/null 2>&1
    else
        red "[ x ] 文件夹/usr/local/ngrok_client已存在，将抹除后继续"
        rm -r /usr/local/ngrok_client >/dev/null 2>&1
        mkdir -p /usr/local/ngrok_client >/dev/null 2>&1
    fi
    cp /opt/ngrok /usr/local/ngrok_client/ngrok >/dev/null 2>&1
    bar_continue

    # 确认服务端信息
    green "[ - ] 正在确认服务端信息"
    echo -e "[ * ] Tips: 确认服务端信息时，需要确认3个配置信息：\n[ * ] 1) 访问域名：绑定在服务端VPS上的域名\n[ * ] 2) 域名端口: 远程域名访问的端口\n[ * ] 3) 访问协议: 远程连接的协议类型。默认为tcp（其他可选: http | https 其他方式请参照官网）\n[ * ] 如：远程访问域名为[testdomain.com]，域名开放的端口为[4443]，访问协议为[tcp]，则输入如下：\n[ * ] 访问域名：testdomain.com\n[ * ] 域名端口：4443\n[ * ] 访问协议：tcp"
    conf_server_menu3

    yellow "[ - ] =========================="
    yellow "[ - ] 以下为服务端信息"
    yellow "[ - ] 访问域名: $domain_name"
    yellow "[ - ] 域名端口: $domain_port"
    yellow "[ - ] 访问协议: $domain_proto"
    yellow "[ - ] =========================="
    yellow "[ - ] 请确认(y/n)"
    read service_confirm
    while [ $service_confirm == "n" ] || [ $service_confirm == "N" ]; do
        conf_client_menu3
        yellow "[ - ] =========================="
        yellow "[ - ] 以下为服务端信息"
        yellow "[ - ] 访问域名: $domain_name"
        yellow "[ - ] 域名端口: $domain_port"
        yellow "[ - ] 访问协议: $domain_proto"
        yellow "[ - ] =========================="
        yellow "[ - ] 请确认(y/n)"
        read service_confirm
    done
    green "[ √ ] 服务端信息已确认"

    # 确认客户端信息
    green "[ - ] 正在确认客户端信息"
    echo "[ * ] Tips：确认客户端信息时，需要输入3个配置："
    echo "[ * ] 1) 服务名：即自定义的服务名称"
    echo "[ * ] 2) 本地端口：即本地服务对应的本地端口"
    echo "[ * ] 3) 远程端口：即需要通过远程穿透出的端口"
    echo "[ * ] 如：通过[testdomain.com]的[2002]端口访问本地[22]服务[XService]，则输入配置信息如下："
    echo "[ * ] 服务名：XService"
    echo "[ * ] 本地端口：22"
    echo "[ * ] 远程端口：2002"
    echo "[ * ] 若选择自动配置，则默认配置: 服务名为ssh，远程端口为2001，本地端口为22"
    echo "[ * ] 配置文件后续可修改"
    conf_client_menu3

    yellow "[ - ] =========================="
    yellow "[ - ] 以下为客户端信息"
    yellow "[ - ] 服务名:   $service_name"
    yellow "[ - ] 本地端口: $local_port"
    yellow "[ - ] 远程端口: $remote_port"
    yellow "[ - ] =========================="
    yellow "[ - ] 请确认(y/n)"
    read service_confirm
    while [ $service_confirm == "n" ] || [ $service_confirm == "N" ]; do
        conf_client_menu3
        yellow "[ - ] =========================="
        yellow "[ - ] 以下为客户端信息"
        yellow "[ - ] 服务名:   $service_name"
        yellow "[ - ] 本地端口: $local_port"
        yellow "[ - ] 远程端口: $remote_port"
        yellow "[ - ] =========================="
        yellow "[ - ] 请确认(y/n)"
        read service_confirm
    done
    green "[ √ ] 客户端信息已确认"

    # 写入文件
    bar_hold_at 40 "将服务配置写入文件" &
    cat >/usr/local/ngrok_client/ngrok.yml <<-EOF
server_addr: "$domain_name:$domain_port"
trust_host_root_certs: false
tunnels:
  $service_name:
    remote_port: $remote_port
    proto:
      $domain_proto: $local_port
EOF
    bar_continue

    # 防火墙放行
    bar_hold_at 50 "正在检测防火墙" &
    check_firewalld
    # iptables -A INPUT -p tcp --dport $local_port -j ACCEPT
    # iptables -A INPUT -p tcp --dport $remote_port -j ACCEPT
    firewall-cmd --add-port=$local_port/tcp --permanent \
        --add-port=$local_port/udp --permanent \
        --add-port=$remote_port/tcp --permanent \
        --add-port=$remote_port/udp --permanent >/dev/null 2>&1
    firewall-cmd --reload >/dev/null 2>&1
    bar_continue

    # 写入系统启动项
    bar_hold_at 60 "正在写入系统启动项" &
    mkdir -p /usr/lib/systemd/system >/dev/null 2>&1
    cat >/usr/lib/systemd/system/ngrok.service <<-EOF
[Unit]
Description=ngrok service

[Service]
Type=simple
ExecStart=/usr/local/ngrok_client/ngrok -config=/usr/local/ngrok_client/ngrok.yml start-all

[Install]
WantedBy=multi-user.target
EOF
    bar_continue

    # 启动服务
    bar_hold_at 90 "正在启动客户端" &
    systemctl start ngrok >/dev/null 2>&1
    systemctl enable ngrok >/dev/null 2>&1
    sleep 1s >/dev/null 2>&1
    systemctl daemon-reload >/dev/null 2>&1
    bar_continue

    bar_hold_at 100 "Done!"
    green "[ √ ] 客户端已启动"
    blue "------------"
    blue "[ * ] 可输入："
    blue "[ * ] systemctl status ngrok"
    blue "[ * ] 查看当前客户端状态"
    exit_program
}

# 开放端口，一次一个
menu_port() {
    check_firewalld
    green "================================="
    green "  请输入需要开放的端口（空格分隔）  "
    green "================================="
    read -a ports_new_allow

    for port_new_allow in "${ports_new_allow[@]}"; do
        bar_start_from 0
        bar_hold_at 90 "正在开放端口 $port_new_allow" &
        firewall-cmd --add-port=$port_new_allow/tcp --permanent \
            --add-port=$port_new_allow/udp --permanent >/dev/null 2>&1
        firewall-cmd --reload >/dev/null 2>&1
        bar_continue
        bar_hold_at 100 "done"
        green "[ √ ] 端口 $port_new_allow 已开放。"
    done

    yellow "[ - ] 是否继续开放其他端口？(y/n)"
    read port_allow_option
    if [ "$port_allow_option" = "y" ] || [ "$port_allow_option" = "Y" ]; then
        clear
        menu_port # 递归调用以继续开放其他端口
    else
        exit_program
    fi
}

# 卸载服务端
menu_server_3() {
    red "============================="
    red "   请注意：此操作将卸载服务端"
    red "   该操作无法撤销，请谨慎操作！"
    red "   是否确认继续(y/n)"
    red "============================="
    read server_uninstall_confirm
    if [[ $server_uninstall_confirm == "y" ]] || [[ $server_uninstall_confirm == "Y" ]]; then
        red "请选择服务端卸载方式："
        red "1) 仅删除启动项，保留服务包。"
        red "2) 删除所有。"
        read server_uninstall_option
        case $server_uninstall_option in
        1) # 删除启动项。
            bar_start_from 0
            bar_hold_at 90 "正在删除启动项" &
            systemctl stop ngrok >/dev/null 2>&1
            systemctl disable ngrok >/dev/null 2>&1
            rm usr/lib/systemd/system/ngrokd.service >/dev/null 2>&1
            bar_continue
            bar_hold_at 100 "done"
            green "[ √ ] 启动项已删除。                                   "
            ;;
        2) # 删除所有
            bar_start_from 0
            bar_hold_at 90 "正在删除服务端" &
            systemctl stop ngrok >/dev/null 2>&1
            systemctl disable ngrok >/dev/null 2>&1
            rm usr/lib/systemd/system/ngrokd.service >/dev/null 2>&1
            rm -r /usr/local/ngrok/
            bar_continue
            bar_hold_at 100 "done"
            green "[ √ ] 服务端已删除。                                   "
            ;;
        *) # 其他错误选项
            red "[ x ] 错误选项, 请重新选择!"
            ;;
        esac
    else
        exit_program
    fi

    # 选择是否返回主菜单
    return_to_main_menu
}

# 卸载客户端
menu_client_2() {
    red "============================="
    red "    请注意：此操作将卸载客户端   "
    red "    该操作无法撤销，请谨慎操作！  "
    red "       是否确认继续(y/n)       "
    red "============================="
    read client_uninstall_confirm
    if [[ $client_uninstall_confirm == "y" ]] || [[ $client_uninstall_confirm == "Y" ]]; then
        bar_start_from 0
        bar_hold_at 95 "即将开始卸载服务端" &
        systemctl stop ngrok >/dev/null 2>&1
        systemctl disable ngrok >/dev/null 2>&1
        rm -r /usr/lib/systemd/system/ngrok.service >/dev/null 2>&1
        rm -r /usr/local/ngrok_client >/dev/null 2>&1
        bar_continue
        bar_hold_at 100 "done"
        green "[ √ ] 客户端已删除。                                          "
    else
        exit_program
    fi
    exit_program
}

menu_server() {
    clear
    green "==================================="
    green "          (当前环境：服务端)          "
    green "           请选择下一步操作           "
    green "            1) 安装服务端            "
    green "            2) 编译新客户端          "
    green "            3) 卸载服务端            "
    green "            4) 开放端口            "
    green "==================================="
    read options

    case $options in
    1) # 安装服务端
        menu_server_1
        ;;
    2) # 编译新客户端
        menu_server_2
        ;;
    3) # 卸载服务端
        menu_server_3
        ;;
    4) # 开放端口
        menu_port
        ;;
    *)
        red "[ x ] 错误选项！请重新选择！"
        ;;
    esac
}

menu_client() {
    clear
    green "==================================="
    green "          (当前环境：客户端)          "
    green "           请选择下一步操作           "
    green "            1) 安装客户端            "
    green "            2) 卸载客户端            "
    green "            3) 开放端口              "
    green "==================================="
    read options

    case $options in
    1) # 安装客户端
        menu_client_1
        ;;
    2) # 卸载客户端
        menu_client_2
        ;;
    3) # 开放端口
        menu_port
        ;;
    *)
        red "[ x ] 错误选项！请重新选择！"
        ;;
    esac
}

menu_start() {
    clear
    green "========== 一键搭建 Ngrok 脚本 =========="
    yellow "             作者：Cocean              "
    yellow "     感谢项目来源：Inconshreveable      "
    green "======================================="
    green "              请选择本机性质            "
    green "               1) 服务端               "
    green "               2) 客户端               "
    green "======================================="
    read options

    case $options in
    1) # 编译新服务端 Server
        menu_server
        ;;
    2)
        menu_client
        ;;
    *)
        red "[ x ] 错误选项！请重新选择！"
        ;;
    esac
}
menu_start
