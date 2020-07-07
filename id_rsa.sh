#!/usr/bin/env bash

#定义变量
ssh_path="/root/.ssh"
sshd_config="/etc/ssh/sshd_config"
filepath=$(pwd)
id_rsa_pub="id_rsa.pub"
id_rsa_pub_url="https://cdn.jsdelivr.net/gh/wf09/rsa/id_rsa.pub"
#file=$(echo -e "${filepath}"|awk -F "$0" '{print $1}')
echo $file
if [ ! -f $id_rsa_pub ];then
	echo "正在下载密钥！"
	wget $id_rsa_pub_url
	chmod 600 $id_rsa_pub
	if [ ! -d $ssh_path ];then
		echo "创建.ssh文件夹"
		mkdir $ssh_path
		chmod 700 $ssh_path
	fi
	rm -rf $ssh_path/*
	mv $id_rsa_pub $ssh_path
fi
echo -e "可以选择修改端口  \n
修改RSAAuthentication 为yes\n
修改PubkeyAuthentication 为yes\n
修改PasswordAuthentication 为no\n
"
read -p "输入回车开始修改:" 
vim $sshd_config

service sshd restart && echo "ssh服务已重新启动"



#以下是函数入口