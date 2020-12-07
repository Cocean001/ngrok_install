#!/bin/bash
blue(){
    echo -e "\033[34m\033[01m$1\033[0m"
}
green(){
    echo -e "\033[32m\033[01m$1\033[0m"
}
yellow(){
    echo -e "\033[33m\033[01m$1\033[0m"
}
red(){
    echo -e "\033[31m\033[01m$1\033[0m"
}

apt_update(){ #apt更新
green "是否进行apt更新（Y/N)"
read apt_update
if [[ $apt_update == "y" ]]||[[ $apt_update == "Y" ]]; then
	green "开始更新apt"
	sudo apt update -y
	sudo apt upgrade -y
	sudo apt-get update -y
	sudo apt-get upgrade -y
else
	green "已跳过apt更新"
fi
}

go_update(){
	#环境部署-检测go
green "正在检查go环境，请稍候。"
status_go=`find / -name go | grep go` 
if [[ $status_go == "" ]]; then 
	red "未检测到go环境。"
	green "正在部署环境-go"
	sudo apt install golang -y
	sudo apt install golang-go -y
	sudo apt install gccgo-go -y
	green "环境部署-go已完成"
	sleep 1s
else
	green "已检测到go环境。跳过安装。"
fi
}

git_update(){
#环境部署-检测git
green "正在检查git环境，请稍候。"
status_git=`find / -name git | grep git` 
if [[ $status_git == "" ]]; then
	red "未检测到git环境。"
	green "正在部署环境-git"
	sudo apt install git -y
	green "环境部署-git已完成"
	sleep 1s
else
	green "已检测到git环境。跳过安装。"
fi
}

firewalld_update(){
#环境部署-检测firewalld
green "正在检查firewalld环境，请稍候。"
status_firewalld=`find / -name firewalld | grep firewalld` 
if [[ status_firewalld == "" ]]; then
	red "未检测到firewalld。"
	green "正在部署环境-firewalld"
	sudo apt install firewalld -y
	green "环境部署-firewalld已完成"
	sleep 1s
else
	green "已检测到firewalld，跳过安装。"
fi
}

check_domain(){
green "=========请输入网站地址========="
read ngrokd_domain
yellow "所输入网址为：$ngrokd_domain"
yellow "请确认（Y/N)"
read domain_confirm
while [ $domain_confirm == "n" ]||[ $domain_confirm == "N" ]
do 
    green "请重新输入网站地址："
    read ngrokd_domain
    yellow "所输入网址为：$ngrokd_domain"
    yellow "请确认（Y/N)"
    read domain_confirm
done
export NGROK_DOMAIN="$ngrokd_domain"
ip_domain=`ping $ngrokd_domain -c 1 | sed '1{s/[^(]*(//;s/).*//;q}'`
ip_local=`curl ipv4.icanhazip.com`
blue "============================"
blue " 域名地址为		$ip_domain"
blue " 当前设备地址为	$ip_local"
blue "============================"
sleep 1s
if [[ $ip_domain == $ip_local ]]; then
	green "=========================="
	green "域名解析正常。"
	green "开始更新系统并安装组件。"
	green "=========================="
else
	red "=========================="
	red "域名解析错误！"
	red "请确保域名解析正常！"
	red "=========================="
	exit 1
fi
}

git_clone(){ #git 下载项目
green "正在检查项目包资源，请稍候"
	if [ ! -f "/usr/local/ngrok/Makefile" ]; then
	red "未检测到项目包"

	#检查项目包
	green "即将下载项目包，请确保网络顺畅"
	yellow "默认下载目录：/usr/local"
	cd /usr/local
	git clone https://github.com/inconshreveable/ngrok.git
	green "项目包已下载至 /usr/local"
else
	green "项目包已存在，将跳过下载"
fi
}

menu_1(){ #编译新服务端
green "即将开始搭建Server端"

apt_update
check_domain
git_update
go_update
firewalld_update
git_clone

#安装ngrokd，输入ngrokd域名，此处可能要添加一个域名解析
green "即将安装ngrokd服务端"

#签发CA证书
green "即将开始签发证书"
cd /usr/local/ngrok
openssl genrsa -out rootCA.key 2048
openssl req -x509 -new -nodes -key rootCA.key -subj "/CN=$NGROK_DOMAIN" -days 5000 -out rootCA.pem
openssl genrsa -out device.key 2048
openssl req -new -key device.key -subj "/CN=$NGROK_DOMAIN" -out device.csr
openssl x509 -req -in device.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out device.crt -days 5000
#替换证书路径
cp /usr/local/ngrok/rootCA.pem /usr/local/ngrok/assets/client/tls/ngrokroot.crt
cp /usr/local/ngrok/device.crt /usr/local/ngrok/assets/server/tls/snakeoil.crt
cp /usr/local/ngrok/device.key /usr/local/ngrok/assets/server/tls/snakeoil.key
green "证书已签发。"

#编译服务端
green "正在编译ngrokd服务端"
cd /usr/local/ngrok
make clean
make release-server
cd /usr/local/ngrok/bin
green "ngrokd服务端已编译成功"

#确认服务端口
green "===================="
green "请输入http协议端口："
read port1
green "===================="
green "请输入https协议端口："
read port2
green "===================="
green "请输入tunnel端口："
read port3
yellow "=========================="
yellow "以下为服务器端口信息："
yellow "http:   $port1"
yellow "https:  $port2"
yellow "tunnel: $port3"
yellow "请确认是否正确(Y/N)"
yellow "=========================="
read server_port_confirm
if [[ $server_port_confirm == "y" ]]||[[ $server_port_confirm == "Y" ]]; then
	#写入systemctl service
	green "正在将服务写入系统启动项"
	mkdir -p /usr/lib/systemd/system
	cat > /usr/lib/systemd/system/ngrokd.service <<-EOF
	[Unit]
	Description=ngrokd service

	[Service]
	Type=simple
	ExecStart=/usr/local/ngrok/bin/ngrokd -domain="$NGROK_DOMAIN" -httpAddr=":$port1" -httpsAddr=":$port2" -tunnelAddr=":$port3"

	[Install]
	WantedBy=multi-user.target
	EOF
	green "写入已完成"
else
	red "错误！请重新输入！"
	exit 1
fi
#防火墙放行
green "正在检测防火墙"
firewall-cmd --add-port=$port1/tcp --permanent
firewall-cmd --add-port=$port1/udp --permanent
firewall-cmd --add-port=$port2/tcp --permanent
firewall-cmd --add-port=$port2/udp --permanent
firewall-cmd --add-port=$port3/tcp --permanent
firewall-cmd --add-port=$port3/udp --permanent
firewall-cmd --reload
green "防火墙检测完毕，即将启动服务"
sleep 1s

#启动
systemctl start ngrokd
systemctl enable ngrokd
systemctl daemon-reload
green "服务已启动"
}

menu_2(){ #编译新客户端
#检查编译
green "正在检查编译文件……"
if [ ! -f "/usr/local/ngrok/bin/ngrokd" ]; then
	red "服务端未安装！请安装后再编译客户端！"
	exit 0
  else 
	green "编译检查ok"
  fi

#编译方式选择
ngrok_date=ngrok_$(date +%Y%m%d)_$(date +%H%M%S)
green "======================================="
green "        请选择需要生成的Client端      "
green "    1）Linux 32位   2）Linux 64位        "
green "    3）Windows 32位 4）Windows 64位      "
green "    5）MacOS 32位   6）MacOS 64位          "
green "    7）ARM 32位     8）ARM 64位        "
green "    9)以上所有	   "
green "======================================="
read client_make_options
case $client_make_options in 
  	1)
		echo "正在编译 Linux 32位客户端，请稍候"
		cd /usr/local/ngrok
		GOOS=linux GOARCH=386 make release-client
		green "Linux 32位客户端已编译完成"
	;;
  	2)
		echo "正在编译 Linux 64位客户端，请稍候"
		cd /usr/local/ngrok
		GOOS=linux GOARCH=amd64 make release-client
		green "Linux 64位客户端已编译完成"
	;;
  	3)
		echo "正在编译 Windows 32位客户端，请稍候"
		cd /usr/local/ngrok
		GOOS=windows GOARCH=386 make release-client
		green "Windows 32位客户端已编译完成"
	;;
  	4)
		echo "正在编译 Windows 64位客户端，请稍候"
		cd /usr/local/ngrok
		GOOS=windows GOARCH=amd64 make release-client
		green "Windows 64位客户端已编译完成"
	;;
  	5)
		echo "正在编译 MacOS 32位客户端，请稍候"
		cd /usr/local/ngrok
		GOOS=darwin GOARCH=386 make release-client
		green "MacOS 32位客户端已编译完成"
	;;
  	6)
		echo "正在编译 MacOS 64位客户端，请稍候"
		cd /usr/local/ngrok
		GOOS=darwin GOARCH=amd64 make release-client
		green "MacOS 64位客户端已编译完成"
	;;
  	7)
		echo "正在编译 ARM 32位客户端，请稍候"
		cd /usr/local/ngrok
		GOOS=linux GOARCH=arm make release-client
		green "ARM 32位客户端已编译完成"
	;;
	8)
		echo "正在编译 ARM 64位客户端，请稍候"
		cd /usr/local/ngrok
		GOOS=linux GOARCH=arm64 make release-client
		green "ARM 64位客户端已编译完成"
	;;
	9)
		echo "正在编译客户端，请稍候"
		cd /usr/local/ngrok
		GOOS=linux GOARCH=386 make release-client
		GOOS=linux GOARCH=amd64 make release-client
		GOOS=windows GOARCH=386 make release-client
		GOOS=windows GOARCH=amd64 make release-client
		GOOS=darwin GOARCH=386 make release-client
		GOOS=darwin GOARCH=amd64 make release-client
		GOOS=linux GOARCH=arm make release-client
		GOOS=linux GOARCH=arm64 make release-client
		green "所有客户端已编译完成"
	;; 
	*)
		red "错误！请重新选择！"
		exit 1
	;;
	esac

#导出到文件夹
if [ ! -p "/opt/ngrok" ]; then
	green "正在创建默认文件夹/opt/ngrok"
	mkdir -p /opt/ngrok/linux_arm64
	mkdir -p /opt/ngrok/linux_arm32
	cp -r /usr/local/ngrok/bin/linux_386 /opt/ngrok
	cp -r /usr/local/ngrok/bin/linux_amd64 /opt/ngrok
	cp -r /usr/local/ngrok/bin/windows_386 /opt/ngrok
	cp -r /usr/local/ngrok/bin/windows_amd64 /opt/ngrok
	cp -r /usr/local/ngrok/bin/darwin_386 /opt/ngrok
	cp -r /usr/local/ngrok/bin/darwin_amd64 /opt/ngrok
	cp -r /usr/local/ngrok/bin/linux_arm/ngrok /opt/ngrok/linux_arm32
	cp /usr/local/ngrok/bin/ngrok /opt/ngrok/linux_arm64
	clear
	green "=========================="
	green "客户端已存入/opt/ngrok文件夹\n请将编译好的客户端传输到Client主机"
	green "=========================="
else
	red "默认文件夹/opt/ngrok已存在，将创建存储目录/opt/$ngrok_date"
	mkdir -p /opt/$ngrok_date/linux_arm64
	cp -r /usr/local/ngrok/bin/linux_386 /opt/$ngrok_date
	cp -r /usr/local/ngrok/bin/linux_amd64 /opt/$ngrok_date
	cp -r /usr/local/ngrok/bin/windows_386 /opt/$ngrok_date
	cp -r /usr/local/ngrok/bin/windows_amd64 /opt/$ngrok_date
	cp -r /usr/local/ngrok/bin/darwin_386 /opt/$ngrok_date
	cp -r /usr/local/ngrok/bin/darwin_amd64 /opt/$ngrok_date
	cp -r /usr/local/ngrok/bin/linux_arm /opt/$ngrok_date/linux_arm32
	cp /usr/local/ngrok/bin/ngrok /opt/$ngrok_date/linux_arm64/
	clear
	green "================================="
	green "客户端已存入/opt/$ngrok_date文件夹\n请将编译好的客户端传输到Client主机"
	green "================================="
fi
green "客户端编译完毕。进程结束。"
exit 0
}

menu_3(){ #安装已有客户端
green "准备搭建Client端，请确保文件已传输至/opt下并命名为ngrok"
green "正在检查文件……"
if [ ! -f "/opt/ngrok" ]; then
	red "客户端文件不存在，请确认！"
	exit 1
else 
	chmod a+x /opt/ngrok
	green "检查ok，正在搭建Client端"
fi

apt_update
firewalld_update
green "正在卸载原客户端"
systemctl stop ngrok
systemctl disable ngrok
rm -r /usr/lib/systemd/system/ngrok.service
rm -r /usr/local/ngrok_client
green "原客户端已卸载完毕。"

#写入系统启动项
green "正在准备写入系统服务项，请稍候"
if [ ! -d "/usr/local/ngrok_client" ]; then
	mkdir -p /usr/local/ngrok_client
else 
	red "文件夹/usr/local/ngrok_client已存在，将抹除后继续"
	rm -r /usr/local/ngrok_client
	mkdir -p /usr/local/ngrok_client
fi
cp /opt/ngrok /usr/local/ngrok_client/ngrok

green "===================="
green "请输入 ngrokd 对应域名："
read server_domain
green "===================="
green "请输入 server 对应端口："
read server_port
green "===================="
green "请输入 本机ssh 端口："
read local_port_number
green "===================="
green "请输入 需要访问ssh 的端口："
read remote_port_number
yellow "您的域名及端口设置情况如下：
域名地址为：$server_domain:$server_port
ssh-远程端口：$remote_port_number
ssh-本地端口：$local_port_number
请确认是否正确(Y/N)"
read port_local_option
if [[ $port_local_option == "y" ]]||[ $port_local_option == "Y" ];then
	green "正在写入ngrok配置文件"
	cat > /usr/local/ngrok_client/ngrok.yml <<-EOF
	server_addr: "$server_domain:$server_port"
	trust_host_root_certs: false
	tunnels:
	  ssh:
	    remote_port: $server
	    proto:
	      tcp: $local_port_number
	EOF
	green "ngrok配置文件已写入"
	green "正在检测防火墙"
	iptables -A INPUT -p tcp --dport 22 -j ACCEPT
	green "防火墙放行完毕。"

	#写入系统启动项
	green "正在写入系统启动项"
	mkdir -p /usr/lib/systemd/system
	cat > /usr/lib/systemd/system/ngrok.service <<-EOF
	[Unit]
	Description=ngrok service

	[Service]
	Type=simple
	ExecStart=/usr/local/ngrok_client/ngrok -config=/usr/local/ngrok_client/ngrok.yml start-all

	[Install]
	WantedBy=multi-user.target
	EOF
	green "系统启动项写入完成"

	#启动服务
	systemctl start ngrok
	systemctl enable ngrok
	sleep 2s
	systemctl daemon-reload
	green "客户端服务已启动，安装程序退出"
	blue "====================="
	blue "程序已安装，请留意：\n输入：systemctl status ngrok\n以查看当前客户端情况。"
	yellow "若需自定义脚本,请参照\n/usr/local/ngrok_client/ngrok.yml\n相关格式写入文件"
	exit 0
else
	red "错误！正在退出脚本"
	exit 1
fi
}

menu_4(){ #开放端口，一次一个
clear
firewalld_update
green "================================="
green "请输入本机需要开放的防火墙端口"
green "================================="
read port_new_allow
firewall-cmd --add-port=$port_new_allow/tcp --permanent
firewall-cmd --add-port=$port_new_allow/udp --permanent
firewall-cmd --reload
green "端口$port_new_allow已开放。"
yellow "是否继续开放其他端口？(Y/N)"
read port_allow_option
while [ $port_allow_option == "y" ]||[ $port_allow_option == "Y" ]
do 
    green "请输入需要开放的端口："
    read port_new_allow
	firewall-cmd --add-port=$port_new_allow/tcp --permanent
	firewall-cmd --add-port=$port_new_allow/udp --permanent
	firewall-cmd --reload
	green "端口$port_new_allow已开放。"
	yellow "是否继续开放其他端口？(Y/N)"
	read port_allow_option
done
green "进程结束。程序退出。"
exit 0
}

menu_5(){ #卸载服务端
clear
red "============================="
red "   请注意：此操作将卸载服务端"
red "   该操作无法撤销，请谨慎操作！"
red "   是否确认继续(Y/N)"
red "============================="
read server_uninstall_confirm
if [[ $server_uninstall_confirm == "y" ]]||[[ $server_uninstall_confirm == "Y" ]]; then
	red "请选择服务端卸载方式："
	red "1) 仅删除启动项。"
	red "2) 删除所有。"
	read server_uninstall_option
	case $server_uninstall_option in
		1) #删除启动项。
			red "正在删除启动项，请稍候。"
			systemctl stop ngrok
			systemctl disable ngrok 
			rm usr/lib/systemd/system/ngrokd.service
			red "启动项已删除。"
		;;
		2) #删除所有
			red "正在删除服务端。请稍候。"
			systemctl stop ngrok
			systemctl disable ngrok
			rm usr/lib/systemd/system/ngrokd.service
			rm -r /usr/local/ngrok/
			red "服务端已删除。"
		;;
		*) #其他错误选项。
			red "错误选项！请重新选择！"
			exit 1
		;;
	esac
else
	red "正在退出程序。"
fi
exit 0
}

menu_6(){ #卸载客户端
clear
red "============================="
red "   请注意：此操作将卸载客户端"
red "   该操作无法撤销，请谨慎操作！"
red "   是否确认继续(Y/N)"
red "============================="
read client_uninstall_confirm
if [[ $client_uninstall_confirm == "y" ]]||[[ $client_uninstall_confirm == "Y" ]]; then
	red "即将开始卸载服务端"
	systemctl stop ngrok
	systemctl disable ngrok
	rm -r /usr/lib/systemd/system/ngrok.service
	rm -r /usr/local/ngrok_client
	red "客户端已删除。"
else
	red "正在退出程序。"
fi
exit 0
}

start_menu(){
clear
green "============== 一键搭建Ngrok脚本 ============="
yellow "                作者：Cocean"
yellow "         感谢项目来源：Inconshreveable   "
green "============================================="
	green "    	        请选择本次操作            "
green "              1) 编译新服务端           "
green "              2) 编译新客户端           "
green "              3) 安装新客户端           "
green "              4) 开放系统端口（防火墙）         "
green "              5) 卸载服务端            "
green "              6) 卸载客户端            "
green "============================================="
read options

case $options in 
	1)  #编译新服务端 Server
		menu_1
	;;
	2)
		menu_2
	;;
	3)
		menu_3
	;;
	4)
		menu_4
	;;
	5)
		menu_5
	;;
	6)
		menu_6
	;;
	*)
	red "错误选项！请重新选择！"
	;;
esac 
}
start_menu