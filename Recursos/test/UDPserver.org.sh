#!/bin/bash  

source <(curl -sSL https://raw.githubusercontent.com/drowkid01/scriptcgh/main/msg-bar/colores)
os_system(){ 
 system=$(cat -n /etc/issue |grep 1 |cut -d ' ' -f6,7,8 |sed 's/1//' |sed 's/      //') 
 distro=$(echo "$system"|awk '{print $1}') 
 case $distro in 
 Debian) vercion=$(echo $system|awk '{print $3}'|cut -d '.' -f1);; 
 Ubuntu) vercion=$(echo $system|awk '{print $2}'|cut -d '.' -f1,2);; 
 esac 
 }

download_udpServer(){
	msg -nama '        Descargando binario UDPserver ----'
	if wget -O /usr/bin/udpServer 'https://bitbucket.org/iopmx/udprequestserver/downloads/udpServer' &>/dev/null ; then
		chmod +x /usr/bin/udpServer
		msg -verd 'OK'
	else
		msg -verm2 'fail'
		rm -rf /usr/bin/udpServer*
	fi
make_service
}

make_service(){
	ip_nat=$(ip -4 addr | grep inet | grep -vE '127(\.[0-9]{1,3}){3}' | cut -d '/' -f 1 | grep -oE '[0-9]{1,3}(\.[0-9]{1,3}){3}' | sed -n 1p)
	interfas=$(ip -4 addr | grep inet | grep -vE '127(\.[0-9]{1,3}){3}'|grep "$ip_nat"|awk {'print $NF'})
	ip_publica=$(grep -m 1 -oE '^[0-9]{1,3}(\.[0-9]{1,3}){3}$' <<< "$(wget -T 10 -t 1 -4qO- "http://ip1.dynupdate.no-ip.com/" || curl -m 10 -4Ls "http://ip1.dynupdate.no-ip.com/")")

	#ip_nat=$(fun_ip nat)
	#interfas=$(ip -4 addr | grep inet | grep -vE '127(\.[0-9]{1,3}){3}'|grep "$ip_nat"|awk {'print $NF'})
	#ip_publica=$(fun_ip)
	msg -nama '        Ejecutando servicio UDPserver .....'
	if screen -dmS UDPserver /usr/bin/udpServer -ip=$ip_publica -net=$interfas -mode=system &>/dev/null ; then
		msg -verd 'OK'
	else
		msg -verm2 'fail'
	fi
}

 
  reset_slow(){
  clear
  msg -bar
  msg -ama "        Reiniciando UDPserver...."
  screen -ls | grep UDPserver | cut -d. -f1 | awk '{print $1}' | xargs kill
  if screen -dmS UDPserver /usr/bin/udpServer -ip=$ip_publica -net=$interfas -mode=system ;then
  msg -verd "        Con exito!!!"    
  msg -bar
  else    
  msg -verm "        Con fallo!!!"    
  msg -bar
  fi
  read -p "ENTER PARA CONTINUAR"
  }  
  
  stop_slow(){
  clear
  msg -bar
  msg -ama "        Deteniendo UDPserver...."
  if screen -ls | grep UDPserver | cut -d. -f1 | awk '{print $1}' | xargs kill ; then
  msg -verd "         Con exito!!!"   msg -bar
  else
  msg -verm "        Con fallo!!!"    msg -bar
  fi
  read -p "ENTER PARA CONTINUAR"
  }    
  
  remove() {
  stop_slow
  rm -f /usr/bin/udpServer*
  }
  
  info() {
  msg -bar
  echo
  msg -ama "         INSTALADOR UDPserver | @botlatmx"
  echo 
  msg -bar
  msg -ama "         SOURCE OFICIAL DE NewToolWorks"
  echo -e "      https://bitbucket.org/iopmx/udprequestserver/src/master/"
  msg -bar
  msg -ama "         URL DE APP OFICIAL "
  echo -e "https://play.google.com/store/apps/details?id=com.newtoolsworks.sockstunnel"
  msg -bar
  msg -ama "         CÓDIGO REFACTORIZADO POR @darnix0"
  msg -bar
  read -p " PRESIONA ENTER PARA CONTINUAR"
  clear
  }
os_system
  
while : 
do
  [[ $(ps x | grep udpServer| grep -v grep) ]] && _pid="\033[1;32m[ON]" || _pid="\033[1;31m[OFF]"
  tittle
  msg -ama "         BINARIO OFICIAL DE NewToolWorks"

[[ $(echo -e "${vercion}") < 20  ]] && {
msg -bar
echo -e "\e[1;31m  SISTEMA:  \e[33m$distro $vercion \e[1;31m	CPU:  \e[33m$(lscpu | grep "Vendor ID" | awk '{print $3}')" 
echo -e " "
echo -e "  UTILIZA LAS VARIANTES MENCIONADAS DENTRO DEL MENU "
echo ""
msg -ama "        SE RECOMIENDA USAR UBUNTU 20.04 "
echo ""
msg -ama "                  O SUPERIOR"
echo ""
echo -e "         [ ! ]  Power by @darnix0  [ ! ]"
echo ""
msg -bar
read -p " PRESIONA ENTER PARA CONTINUAR"
return
}
  msg -bar
  msg -ama "         INSTALADOR UDPserver | @botlatmx"
  msg -bar
[[ $(uname -m 2> /dev/null) != x86_64 ]] && {

msg -ama "    BINARIO NO COMPATIBLE CON PLATAFORMAS ARM "
echo ""
echo -e "		[ ! ]  Power by @darnix0  [ ! ]"
echo ""
msg -bar
read -p " PRESIONA ENTER PARA CONTINUAR"
return
}
  menu_func "Instalar UDPserver $_pid" "$(msg -ama "Reiniciar UDPserver")" "$(msg -verm2 "Detener UDPserver")" "$(msg -verm2 "Remover UDPserver")" "$(msg -ama "Info de Proyecto")"
  msg -bar
  echo -ne "$(msg -verd "  [0]") $(msg -verm2 "=>>") " && msg -bra "\033[1;41m Volver "
  msg -bar
  opcion=$(selection_fun 6)  
  case $opcion in
  1)download_udpServer;;
  2)reset_slow;;
  3)stop_slow;;
  4)remove;;
  5)info;;
  0)exit;;
  esac  
done
