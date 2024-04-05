#!/bin/bash
#01/06/2022
# UPDATE 26/11/2023
#By @ChumoGH|Plus

function chekKEY {
[[ -z ${IP} ]] && IP=$(cat < /bin/ejecutar/IPcgh)
[[ -z ${IP} ]] && IP=$(wget -qO- ifconfig.me)
Key="$(cat /etc/cghkey)"
_double=$(curl -sSL "https://raw.githubusercontent.com/drowkid01/scriptcgh/main/Control/Control-Bot.txt")
IiP="$(ofus "$Key" | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')"
[[ -e /file ]] && _double=$(cat < /file) ||  {
wget -q -O /file https://raw.githubusercontent.com/drowkid01/scriptcgh/main/Control/Control-Bot.txt
_double=$(cat < /file)
}
_check2="$(echo -e "$_double" | grep ${IiP})"
[[ ! -e /etc/folteto ]] && {
wget --no-check-certificate -O /etc/folteto $IiP:81/ChumoGH/checkIP.log 
cheklist="$(cat /etc/folteto)"
echo -e "$(echo -e "$cheklist" | grep ${IP})" > /etc/folteto
}
[[ -z ${_check2} ]] && {
mss_='\n BotGEN NO AUTORIZADO POR @ChumoGH '
cat <<EOF >/bin/menu
clear && clear
echo -e "\n\n\033[1;31m==================================================\n ¡¡ 🚫 KEY BANEADA  🚫 ! CONTACTE Su ADMINISTRADOR! \n==================================================\n ¡¡ FECHA DE BANEO :$(date +%d/%m/%Y) HORA :$(date +%H:%M:%S) \n==================================================\n\n¡¡ ${mss_} \n\n==================================================\n"
echo -e " \e[1;32m     --- SI CONSIDERA QUE FUE UN ERROR  ---  " | pv -qL 60
echo -e " \e[1;32m     -- ${mss_} --  " | pv -qL 60
echo -e "\n \e[1;93m           --- TECLEA  \e[1;93m --- \e[1;97mcgh -fix\e[1;93m ---  " | pv -qL 50
echo -e "\n\033[1;31m==================================================\n\n"
#echo "/etc/adm-lite/menu" > /bin/menu && chmod +x /bin/menu
EOF

rm -f /etc/folteto
rm -f /etc/adm-lite/menu*
 			MENSAJE="${TTini}${m3ssg}MSG RECIVIDO${m3ssg}${TTfin}\n"
			MENSAJE+=" ---------------------------------------------\n"
			MENSAJE+=" IP Clon: ${IP} Rechazada\n"
			MENSAJE+=" ---------------------------------------------\n"
			MENSAJE+=" INSECTO DETECTADO EN BadVPN Plus\n"
			MENSAJE+=" ---------------------------------------------\n"
			MENSAJE+=" Key : ${Key}\n"
			MENSAJE+=" ---------------------------------------------\n"
			MENSAJE+=" HORA : $(printf '%(%D-%H:%M:%S)T')\n"
			MENSAJE+=" ---------------------------------------------\n"
			MENSAJE+="       ${rUlq} Bot ADMcgh de keyS ${rUlq}\n"
			MENSAJE+="           ${pUn5A} By @ChumoGH ${pUn5A} \n"
			MENSAJE+=" ---------------------------------------------\n"	
			curl -s --max-time 10 -d "chat_id=$ID&disable_web_page_preview=1&text=$(echo -e "$MENSAJE")" $urlBOT &>/dev/null 	
exit && exit
}
}

BadVPN () {
msg -bar 
pid_badvpn=$(ps x | grep badvpn | grep -v grep | awk '{print $1}')
unset bot_ini
if [ "$pid_badvpn" = "" ]; then
msg -ama " FUNCION EXPERIMENTAL AGREGARA PUERTO 7300 en BADVPN-UDP"
msg -ama "  ADICIONAL APERTURARENOS EL 7200 PARA UN DUAL CHANNEL"
#msg -ama "        MAXIMO DE 100 CONEXIONES POR CLIENTE"
msg -bar 
[[ $(dpkg --get-selections|grep -w "toilet"|head -1) ]] || apt-get install toilet -y &>/dev/null
    if [[ ! -e /bin/badvpn-udpgw ]]; then
	echo -ne "	    DESCARGANDO BINARIO UDP .."
  [[ $(uname -m 2> /dev/null) != x86_64 ]] && {
  chekKEY &> /dev/null 2>&1
  if wget -O /bin/badvpn-udpgw https://github.com/emirjorge/Script-Z/raw/master/CHUMO/Recursos/ferramentas/badvpn-udpgw-arm &>/dev/null ; then
  chmod 777 /bin/badvpn-udpgw
  msg -verd "[OK]"  
  else    
  msg -verm "[fail]"    
  msg -bar    
  msg -ama "No se pudo descargar el binario"    
  msg -verm "Instalacion canselada"    
  read -p "ENTER PARA CONTINUAR"
  exit 0    
  fi
  } || {   
  chekKEY &> /dev/null 2>&1
  if wget -O /bin/badvpn-udpgw https://github.com/emirjorge/Script-Z/raw/master/CHUMO/Recursos/ferramentas/badvpn-udpgw-plus &>/dev/null ; then
  chmod 777 /bin/badvpn-udpgw
  msg -verd "[OK]"    
  else    
  msg -verm "[fail]"    
  msg -bar    
  msg -ama "No se pudo descargar el binario"    
  msg -verm "Instalacion canselada"    
  read -p "ENTER PARA CONTINUAR"
  exit 0    
  fi
  }
	msg -ama "                   ACTIVANDO BADVPN Plus"
	msg -bar
	tput cuu1 && tput dl1
	tput cuu1 && tput dl1
    fi
    (
	screen -dmS badvpn $(which badvpn-udpgw) --listen-addr 127.0.0.1:7300 --max-clients 1000 --max-connections-for-client 10 #--client-socket-sndbuf 10000
	screen -dmS badUDP72 $(which badvpn-udpgw) --listen-addr 127.0.0.1:7200 --max-clients 1000 --max-connections-for-client 10 #--client-socket-sndbuf 10000
#	screen -dmS badvpn $(which badvpn-udpgw) --listen-addr 127.0.0.1:7300 --max-clients 1000 --max-connections-for-client 10 
#	screen -dmS badUDP72 $(which badvpn-udpgw) --listen-addr 127.0.0.1:7200 --max-clients 1000 --max-connections-for-client 10 
	) || msg -ama "                Error al Activar BadVPN" 
	sleep 2s 
	msg -bar
    [[ ! -z $(ps x | grep badvpn | grep -v grep ) ]] && { 
	msg -verd "                  ACTIVADO CON EXITO" 
		msg -bar
	echo -e "  PREGUNTA PREVIA POR 15 SEGUNDOS !!!"
	msg -bar
	read -t 15 -p " $(echo -e "\033[1;97m Poner en linea despues de un reinicio [s/n]: ")" -e -i "s" bot_ini
	msg -bar
	tput cuu1 && tput dl1
	tput cuu1 && tput dl1
	tput cuu1 && tput dl1
	tput cuu1 && tput dl1
	tput cuu1 && tput dl1
		[[ $bot_ini = @(s|S|y|Y) ]] && {
	[[ $(grep -wc "badvpn" /bin/autoboot) = '0' ]] && {
						echo -e " AUTOREINICIO EN INACTIVIDAD PREACTIVADO !! " && sleep 2s
						tput cuu1 && tput dl1
						echo -e "netstat -tlpn | grep -w 7300 > /dev/null || {  screen -r -S 'badvpn' -X quit;  screen -dmS badvpn $(which badvpn-udpgw) --listen-addr 127.0.0.1:7300 --max-clients 1000 --max-connections-for-client 10; }" >>/bin/autoboot
						echo -e "netstat -tlpn | grep -w 7200 > /dev/null || {  screen -r -S 'badUDP72' -X quit;  screen -dmS badUDP72 $(which badvpn-udpgw) --listen-addr 127.0.0.1:7200 --max-clients 10000 --max-connections-for-client 10; }" >>/bin/autoboot
					} || {
						sed -i '/badvpn/d' /bin/autoboot
						echo -e " AUTOREINICIO EN INACTIVIDAD REACTIVADO !! " && sleep 2s
						tput cuu1 && tput dl1
						echo -e "netstat -tlpn | grep -w 7300 > /dev/null || {  screen -r -S 'badvpn' -X quit;  screen -dmS badvpn $(which badvpn-udpgw) --listen-addr 127.0.0.1:7300 --max-clients 1000 --max-connections-for-client 10; }" >>/bin/autoboot
						echo -e "netstat -tlpn | grep -w 7200 > /dev/null || {  screen -r -S 'badUDP72' -X quit;  screen -dmS badUDP72 $(which badvpn-udpgw) --listen-addr 127.0.0.1:7200 --max-clients 1000 --max-connections-for-client 10; }" >>/bin/autoboot
					}
	#-------------------------
} ||  sed -i '/badvpn-udpgw/d' /bin/autoboot
}

else
clear&&clear
msg -bar
msg -ama "      Administrador BadVPN UDP | @ChumoGH•Plus"
msg -bar
menu_func "AÑADIR 1+ PUERTO BadVPN $_pid" "$(msg -verm2 "Detener BadVPN")" #"$(msg -ama "Reiniciar BadVPN")"
 echo -ne "$(msg -verd " [0]") $(msg -verm2 "=>>") " && msg -bra "\033[1;41m Volver "
  msg -bar
  opcion=$(selection_fun 2)  
  case $opcion in
  1)
msg -bar 
msg -ama " FUNCION EXPERIMENTAL AGREGARA PUERTO en BADVPN-UDP"
#msg -ama "  ADICIONAL APERTURARENOS EL 7200 PARA UN DUAL CHANNEL"
#msg -ama "        MAXIMO DE 100 CONEXIONES POR CLIENTE"
msg -bar 
read -p " DIJITA TU PUERTO CUSTOM PARA BADVPN :" -e -i "7100" port
echo -e " VERIFICANDO BADVPN "
msg -bar 
screen -dmS badvpn$port /bin/badvpn-udpgw --listen-addr 127.0.0.1:${port} --max-clients 1000 --max-connections-for-client 10 && msg -ama "               BadVPN ACTIVADA CON EXITO"  || msg -ama "                Error al Activar BadVPN" 
echo -e "netstat -tlpn | grep -w ${port} > /dev/null || {  screen -r -S 'badvpn'$port -X quit;  screen -dmS badvpn $(which badvpn-udpgw) --listen-addr 127.0.0.1:${port} --max-clients 1000 --max-connections-for-client 10; }" >>/bin/autoboot
msg -bar
return
  ;;
  2)
msg -ama "                DESACTIVANDO BADVPN"
    msg -bar
	kill -9 $(ps x | grep badvpn | grep -v grep | awk '{print $1'}) > /dev/null 2>&1
    killall badvpn-udpgw > /dev/null 2>&1
	sed -i '/badvpn/d' /bin/autoboot
	echo -e " AUTOREINICIO EN INACTIVIDAD ELIMINADO !! " && sleep 2s
	tput cuu1 && tput dl1
    [[ ! "$(ps x | grep badvpn | grep -v grep | awk '{print $1}')" ]] && msg -ama "                APAGADO EXITOSAMENTE \n" || msg -verm "                ERROR AL DETENER BadVPN!! \n"
    unset pid_badvpn
	msg -bar
return
  ;;
  3) exit;;
  0) exit;;
 esac   	
fi
unset pid_badvpn
}
BadVPN
msg -bar
clear&&clear
msg -bar
toilet -f pagga "ChumoGH-UDP" | lolcat
msg -bar
return