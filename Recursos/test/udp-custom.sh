#!/bin/bash  
clear  
dir_user="/etc/VPS-MX/userDIR"
pausa(){
echo -ne "\033[1;37m"
read -p " Presiona Enter para Continuar "
}

  info() {
  puerto=$1
  
  msg -bar
  echo
  msg -ama "         INSTALADOR UDPserver | @botlatmx"
  echo 
  msg -bar
  msg -ama "         SOURCE OFICIAL DE Epro Dev Team"
  echo -e "             https://t.me/ePro_Dev_Team"
  msg -bar
  msg -ama "         CODIGO REFACTORIZADO POR @darnix0"
  [[ -z ${puerto} ]] || add.user ${puerto}
  pausa
  clear
  }


cd

# change to time GMT+7
#ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# install udp-custom
#echo downloading udp-custom
#wget -q --show-progress --load-cookies /tmp/cookies.txt https://www.dropbox.com/s/muzdqkid5ganb7c/udp-custom-linux-amd64?dl=0 -O /bin/UDP-Custom && rm -rf /tmp/cookies.txt
#chmod +x /bin/UDP-Custom

#echo downloading default config
#wget -q --show-progress --load-cookies /tmp/cookies.txt https://www.dropbox.com/s/pccfmw4h830wbn4/config.json?dl=0 -O /etc/VPS-MX/config.json && rm -rf /tmp/cookies.txt
#chmod 644 /etc/VPS-MX/config.json


#echo reboot



make_service(){
if [ -z "$1" ]; then
cat <<EOF > /etc/systemd/system/udp-custom.service
[Unit]
Description=udp-custom by ePro Dev. Team

[Service]
User=root
Type=simple
ExecStart=/bin/UDP-Custom server --config /etc/VPS-MX/config.json
WorkingDirectory=/etc/VPS-MX/
Restart=always
RestartSec=2s

[Install]
WantedBy=default.target
EOF
else
cat <<EOF > /etc/systemd/system/udp-custom.service
[Unit]
Description=udp-custom by ePro Dev. Team

[Service]
User=root
Type=simple
ExecStart=/bin/UDP-Custom server -exclude $1 --config /etc/VPS-MX/config.json
WorkingDirectory=/etc/VPS-MX/
Restart=always
RestartSec=2s

[Install]
WantedBy=default.target
EOF
fi

#echo start service udp-custom
systemctl start udp-custom &>/dev/null

#echo enable service udp-custom

	msg -nama '        Habilitando servicio UDPserver ------'
	if systemctl enable udp-custom &>/dev/null &>/dev/null ; then
		msg -verd 'OK'
		#_mssBOT "ACTIVADO!!"
	else
		msg -verm2 'fail'
		#_mssBOT " FALLIDO!!"
	fi
	
	msg -nama '         Iniciando servicio UDPserver -------'
	if systemctl start udp-custom &>/dev/null &>/dev/null &>/dev/null ; then
		msg -verd 'OK'
		#_mssBOT "ACTIVADO!!"
	else
		msg -verm2 'fail'
		#_mssBOT " FALLIDO!!"
	fi
msg -bar
	while true; do
	msg -nama '         Digita un Puerto para el Servicio de\n'
	msg -nama '              Prederteminado ( ENTER )\n'
    read -p "                   UDP-Custom: " udpPORT
	tput cuu1 >&2 && tput dl1 >&2
	checkPORT=`netstat -tlpn | awk -F '[: ]+' '$1=="tcp"{print $5}' | grep -w $udpPORT`
	[[ -n "$checkPORT" ]] || break
    prococup=`netstat -tlpn | awk -F '[: ]+' '$5=="$udpPORT"{print $9}'`
    echo -e "\033[1;33m  EL PUERTO SE ENCUENTRA OCUPADO POR $prococup"
	msg -bar
	return
    done
	tput cuu1 >&2 && tput dl1 >&2
	tput cuu1 >&2 && tput dl1 >&2
	tput cuu1 >&2 && tput dl1 >&2
[[ -z ${udpPORT} ]] && udpPORT='36712'
	msg -nama '         Iniciando servicio UDPserver -------'
if  sed -i "s/36712/${udpPORT}/" /etc/VPS-MX/config.json ; then
		msg -verd 'OK'
	else
		msg -verm2 'fail'
fi
reset_slow
port=$(lsof -V -i UDP -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND"|grep -E 'UDP-Custom'| cut -d ":" -f2)	
tput cuu1 >&2 && tput dl1 >&2
tput cuu1 >&2 && tput dl1 >&2
tput cuu1 >&2 && tput dl1 >&2
tput cuu1 >&2 && tput dl1 >&2
tput cuu1 >&2 && tput dl1 >&2
add.user ${port}
	#iptables -t nat -F &>/dev/null
	#iptables -t mangle -F &>/dev/null
	#iptables -X &>/dev/null
	#iptables -P INPUT ACCEPT &>/dev/null
	#iptables -P FORWARD ACCEPT &>/dev/null
	#iptables -P OUTPUT ACCEPT &>/dev/null
pausa
}



download_udpServer(){
	msg -nama '     Descargando binario UDPserver V 1.2 ----'
[[ $(uname -m 2> /dev/null) != x86_64 ]] && {
	if wget -O /bin/UDP-Custom 'https://raw.githubusercontent.com/drowkid01/scriptcgh/main/Recursos/binarios/UDP/udp-arm64.bin' &>/dev/null ; then
		chmod +x /bin/UDP-Custom
		msg -verd ' ARM64 - OK'
	else
		msg -verm2 'fail'
		rm -rf /bin/UDP-Custom*
	fi
} || {
	if wget -O /bin/UDP-Custom 'https://raw.githubusercontent.com/drowkid01/scriptcgh/main/Recursos/binarios/UDP/udp-amd64.bin' &>/dev/null ; then
		chmod +x /bin/UDP-Custom
		msg -verd ' X64 OK'
	else
		msg -verm2 'fail'
		rm -rf /bin/UDP-Custom*
fi	
}
	msg -nama '         Descargando Config UDPserver -------'
	if wget -O /etc/VPS-MX/config.json 'https://raw.githubusercontent.com/drowkid01/scriptcgh/main/Recursos/binarios/UDP/config.json' &>/dev/null ; then
		chmod 644 /etc/VPS-MX/config.json
		msg -verd 'OK'
	else
		msg -verm2 'fail'
		rm -f /etc/VPS-MX/config.json*
	fi
#chekKEY &> /dev/null 2>&1	
make_service
}

  reset_slow(){
  msg -bar
  msg -ama "        Reiniciando UDPserver...."
  #screen -ls | grep udp-custom | cut -d. -f1 | awk '{print $1}' | xargs kill
  if systemctl restart udp-custom &>/dev/null ;then
  msg -verd "        Con exito!!!"    
  msg -bar
  else    
  msg -verm "        Con fallo!!!"    
  msg -bar
  fi
  pausa
  }  
  
  stop_slow(){
  clear
  msg -bar
  msg -ama "        Deteniendo UDPserver...."
  if systemctl stop udp-custom ; then
  msg -verd "         Con exito!!!"   msg -bar
  else
  msg -verm "        Con fallo!!!"    msg -bar
  fi
  pausa
  }    
  
  remove() {
  stop_slow
  systemctl disable udp-custom
  rm -f /etc/systemd/system/udp-custom.service
  rm -f /bin/UDP-Custom*
  rm -f /etc/VPS-MX/config*
  rm -rf /root/udp
	iptables -t nat -F &>/dev/null
	iptables -t mangle -F &>/dev/null
	iptables -X &>/dev/null
	iptables -P INPUT ACCEPT &>/dev/null
	iptables -P FORWARD ACCEPT &>/dev/null
	iptables -P OUTPUT ACCEPT &>/dev/null
  #_mssBOT "REMOVIDO!!"
  }

 add.user () {
 port=$1
 user='botlatmx'
 clave='darnix0'
 #$(cat /etc/VPS-MX/config.json | grep user | cut -d '"' -f4)
 #user=$(cat /etc/VPS-MX/config.json | jq .user)
 #clave=$(cat /etc/VPS-MX/config.json | jq .auth.pass[])
valid=$(date '+%C%y-%m-%d' -d " +2 days") 
if useradd -M -s /bin/false $user -e $valid ; then
(echo $clave; echo $clave)|passwd $user >/dev/null 2>&1 &
echo "senha: $clave" > $dir_user/$user
echo "limite: 2" >> $dir_user/$user
echo "data: $valid" >> $dir_user/$user
msg -verd " USER : botlatmx  | DEMOSTRACION AGREGADO!!!"    
else 
echo -e "${cor[5]} ⚠️ Usuario DEMO ya Existe ⚠️"
msg -verm " USER : darnix0 | No Agregado!!!"    
fi
 msg -bar
 echo
 msg -bar
 echo -e "      ESTO ES UNA GUIA DEL FORMATO DEL USUARIO"
 echo -e "         VE AL MENU DE USUARIOS Y CREA UNO"
 msg -bar
 echo 
 echo -e "【 CONFIG >${cor[4]} $(wget -qO- ifconfig.me)${cor[2]}:${cor[5]}1-65535${cor[2]}@${cor[4]}$user${cor[2]}:${cor[4]}${clave}   】" | pv -qL 80
 echo 
 msg -bar
 msg -ama "        RECUERDA CREAR TUS USUARIOS SSH NORMAL"
 msg -bar
 }
 
 edit_json() {
 msg -bar
 msg -ama "        PARA EDITAR EL USUARIO EDITA"
 msg -ama "            /etc/VPS-MX/config.json"
 msg -bar
echo -e "\033[1;37m Para Salir Ctrl + C o 0 Para Regresar\033[1;33m"
echo -e " \033[1;31m[ !!! ]\033[1;33m EDITA LAS CREDENCIALES   \033[1;31m\033[1;33m"
msg -bar
echo -e " \033[1;31mLuego de Editar..  Presiona Ctrl + O y Enter \033[1;33m \033[1;31m\033[1;33m"
echo -e " \033[1;31m          Por Ultimo Ctrl + X  \033[1;33m \033[1;31m\033[1;33m"
pausa
nano config.json -o /etc/VPS-MX
reset_slow
 }

while : 
do
unset port
  tittle
  msg -ama "      BINARIO OFICIAL DE Epro Dev Team 1.2"
  msg -bar
  [[ $(ps x | grep UDP-Custom| grep -v grep) ]] && {
    _pid="\033[1;32m[ ON ]" 
  port=$(lsof -V -i UDP -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND"|grep -E 'UDP-Custo'| cut -d ":" -f2)
  msg -ama "      PUERTO EN EJECUCION DE UDPserver : ${port}"
  msg -bar
  } || _pid="\033[1;31m[ OFF ]"
  msg -ama "         INSTALADOR UDPserver | @botlatmx"
  msg -bar
  menu_func "Instalar UDPserver $_pid" "$(msg -ama "Reiniciar UDPserver")" "$(msg -verm2 "Detener UDPserver")" "$(msg -verm2 "Remover UDPserver")" "$(msg -ama "Info de Proyecto")"
  msg -bar
  echo -ne "$(msg -verd "  [0]") $(msg -verm2 "=>>") " && msg -bra "\033[1;41m Volver "
  msg -bar
  opcion=$(selection_fun 5)  
  case $opcion in
  1)download_udpServer;;
  #2)edit_json;;
  2)reset_slow;;
  3)stop_slow;;
  4)remove;;
  5)info ${port};;
  0)exit;;
  esac  
done
