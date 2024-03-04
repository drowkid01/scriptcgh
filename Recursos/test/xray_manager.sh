#!/bin/sh

clear
config="/etc/xray/config.json"
configLOCK="/etc/xray/config.json.lock"
temp="/etc/xray/temp.json"
CGHlog='/var/log/xray/access.log'
v2rdir="/etc/xr" && [[ ! -d $v2rdir ]] && mkdir $v2rdir
user_conf="/etc/xr/user" && [[ ! -e $user_conf ]] && touch $user_conf
backdir="/etc/xr/back" && [[ ! -d ${backdir} ]] && mkdir ${backdir}
tmpdir="$backdir/tmp"
[[ ! -e $v2rdir/conf ]] && echo "autBackup 0" > $v2rdir/conf
if [[ $(cat $v2rdir/conf | grep "autBackup") = "" ]]; then
	echo "autBackup 0" >> $v2rdir/conf
fi
_v2=`if netstat -tunlp | grep xray 1> /dev/null 2> /dev/null; then
[[ -e ${config} ]] && echo -e "\033[1;32m[ INST \033[1;31m+ \033[1;32mWORK ] " 
else
[[ -e ${config} ]] && echo -e "\033[1;32m[ INST \033[1;31m+ \033[1;33mLOADING \033[1;32m] " || echo -e "\033[1;32m[ \033[1;31mNO INST \033[1;32m] "
fi`;
barra="\033[0;31m=====================================================\033[0m"
numero='^[0-9]+$'
hora=$(printf '%(%H:%M:%S)T') 
fecha=$(printf '%(%D)T')

Fun_bar () {
#==comando a ejecutar==
comando="$1"
#==interfas==
in=' ['
en=' ] '
full_in="➛"
full_en='100%'
bar=("--------------------"
"=-------------------"
"]=------------------"
"[-]=-----------------"
"=[-]=----------------"
"-=[-]=---------------"
"--=[-]=--------------"
"---=[-]=-------------"
"----=[-]=------------"
"-----=[-]=-----------"
"------=[-]=----------"
"-------=[-]=---------"
"--------=[-]=--------"
"---------=[-]=-------"
"----------=[-]=------"
"-----------=[-]=-----"
"------------=[-]=----"
"-------------=[-]=---"
"--------------=[-]=--"
"---------------=[-]=-"
"----------------=[-]="
"-----------------=[-]"
"------------------=["
"-------------------="
"------------------=["
"-----------------=[-]"
"----------------=[-]="
"---------------=[-]=-"
"--------------=[-]=--"
"-------------=[-]=---"
"------------=[-]=----"
"-----------=[-]=-----"
"----------=[-]=------"
"---------=[-]=-------"
"--------=[-]=--------"
"-------=[-]=---------"
"------=[-]=----------"
"-----=[-]=-----------"
"----=[-]=------------"
"---=[-]=-------------"
"--=[-]=--------------"
"-=[-]=---------------"
"=[-]=----------------"
"[-]=-----------------"
"]=------------------"
"=-------------------"
"--------------------");
#==color==
in="\033[1;33m$in\033[0m"
en="\033[1;33m$en\033[0m"
full_in="\033[1;31m$full_in"
full_en="\033[1;32m$full_en\033[0m"

 _=$(
$comando > /dev/null 2>&1
) & > /dev/null
pid=$!
while [[ -d /proc/$pid ]]; do
	for i in "${bar[@]}"; do
		echo -ne "\r $in"
		echo -ne "ESPERE $en $in \033[1;31m$i"
		echo -ne " $en"
		sleep 0.2
	done
done
echo -e " $full_in $full_en"
sleep 0.2s
}



usrCONEC() {
[[ $log0 -le 1 ]] && xray clean &> /dev/null && let log0++ && clear 
msg -bar
echo -e ""
echo -e " ESPERANDO A LA VERIFICACION DE IPS Y USUARIOS "
echo -e "      ESPERE UN MOMENTO PORFAVOR $log0"
echo -e ""
msg -bar
fun_bar
msg -bar
sleep 5s
clear&&clear
title2
msg -bar
users="$(cat $config | jq -r .inbounds[].settings.clients[].email)"
IP_tconex=$(netstat -nap | grep "$xrayports" | grep xray | grep ESTABLISHED | awk {'print $5'} | awk -F ":" '{print $1}' | sort | uniq)
n=1
[[ -z $IP_tconex ]] && echo -e " NO HAY USUARIOS CONECTADOS!"
for i in $IP_tconex
do
	USERauth=$(cat ${CGHlog} | grep $i | grep accepted |awk '{print $7}'| sort | uniq)
	Users+="$USERauth\n"
done
echo -e " N) USER - CONEXIONES "|column -t -s '-'
for U in $users
	do
	CConT=$(echo -e "$Users" | grep $U |wc -l)
	[[ $CConT = 0 ]] && continue
	UConc+=" $n) $U -$CConT\n"
	let n++
done
echo -e "$UConc"|column -t -s '-'
msg -bar
continuar
read foo
}

install_ini () {
add-apt-repository universe
apt update -y; apt upgrade -y
clear
msg -bar
echo -e "\033[92m        -- INSTALANDO PAQUETES NECESARIOS -- "
msg -bar
#bc
[[ $(dpkg --get-selections|grep -w "bc"|head -1) ]] || apt-get install bc -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "bc"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "bc"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install bc................... $ESTATUS "
#uuidgen
[[ $(dpkg --get-selections|grep -w "uuid-runtime"|head -1) ]] || sudo apt-get install uuid-runtime -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "uuid-runtime"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "uuid-runtime"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install uuid-runtime......... $ESTATUS "
#python
[[ $(dpkg --get-selections|grep -w "python"|head -1) ]] || apt-get install python -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "python"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "python"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install python-pip........... $ESTATUS "
#pip
[[ $(dpkg --get-selections|grep -w "python-pip"|head -1) ]] || apt-get install python-pip -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "python-pip"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "python-pip"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install python-pip........... $ESTATUS "
#python3
[[ $(dpkg --get-selections|grep -w "python3"|head -1) ]] || apt-get install python3 -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "python3"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "python3"|head -1) ]] && ESTATUS=`echo -e "\e[3;32mINSTALADO\e[0m"` &>/dev/null
echo -e "\033[97m  # apt-get install python3.............. $ESTATUS "
#python3-pip
[[ $(dpkg --get-selections|grep -w "python3-pip"|head -1) ]] || apt-get install python3-pip -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "python3-pip"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "python3-pip"|head -1) ]] && ESTATUS=`echo -e "\e[3;32mINSTALADO\e[0m"` &>/dev/null
echo -e "\033[97m  # apt-get install python3-pip.......... $ESTATUS "
#QRENCODE
[[ $(dpkg --get-selections|grep -w "qrencode"|head -1) ]] || apt-get install qrencode -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "qrencode"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "qrencode"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install qrencode............. $ESTATUS "
#jq
[[ $(dpkg --get-selections|grep -w "jq"|head -1) ]] || apt-get install jq -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "jq"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "jq"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install jq................... $ESTATUS "
#curl
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] || apt-get install curl -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install curl................. $ESTATUS "
#npm
[[ $(dpkg --get-selections|grep -w "npm"|head -1) ]] || apt-get install npm -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "npm"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "npm"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install npm.................. $ESTATUS "
#nodejs
[[ $(dpkg --get-selections|grep -w "nodejs"|head -1) ]] || apt-get install nodejs -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "nodejs"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "nodejs"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install nodejs............... $ESTATUS "
#socat
[[ $(dpkg --get-selections|grep -w "socat"|head -1) ]] || apt-get install socat -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "socat"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "socat"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install socat................ $ESTATUS "
#netcat
[[ $(dpkg --get-selections|grep -w "netcat"|head -1) ]] || apt-get install netcat -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "netcat"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "netcat"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install netcat............... $ESTATUS "
#netcat-traditional
[[ $(dpkg --get-selections|grep -w "netcat-traditional"|head -1) ]] || apt-get install netcat-traditional -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "netcat-traditional"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "netcat-traditional"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install netcat-traditional... $ESTATUS "
#net-tools
[[ $(dpkg --get-selections|grep -w "net-tools"|head -1) ]] || apt-get net-tools -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "net-tools"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "net-tools"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install net-tools............ $ESTATUS "
#cowsay
[[ $(dpkg --get-selections|grep -w "cowsay"|head -1) ]] || apt-get install cowsay -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "cowsay"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "cowsay"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install cowsay............... $ESTATUS "
#figlet
[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] || apt-get install figlet -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install figlet............... $ESTATUS "
#lolcat
apt-get install lolcat -y &>/dev/null
sudo gem install lolcat &>/dev/null
[[ $(dpkg --get-selections|grep -w "lolcat"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "lolcat"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install lolcat............... $ESTATUS "

msg -bar
echo -e "\033[92m La instalacion de paquetes necesarios a finalizado"
msg -bar
echo -e "\033[97m Si la instalacion de paquetes tiene fallas"
echo -ne "\033[97m Puede intentar de nuevo [s/n]: "
read inst
[[ $inst = @(s|S|y|Y) ]] && install_ini
}


autB(){
	if [[ ! $(cat $v2rdir/conf | grep "autBackup" | cut -d " " -f2) = "0" ]]; then
		autBackup
	fi
 }
 
restore(){
	clear

	unset num
	unset opcion
	unset _res

	if [[ -z $(ls $backdir) ]]; then
		title "	no se encontraron respaldos"
		sleep 0.5
		return
	fi

	num=1
	title "	   Lista de Respaldos creados"
	blanco "	      nom  \033[0;31m| \033[1;37mfechas \033[0;31m|  \033[1;37mhora"
	msg -bar
	for i in $(ls $backdir); do
		col "$num)" "$i"
		_res[$num]=$i
		let num++
	done
	msg -bar
	col "0)" "VOLVER"
	msg -bar
	blanco " cual desea restaurar?" 0
	read opcion

	[[ $opcion = 0 ]] && return
	[[ -z $opcion ]] && blanco "\n deves seleccionar una opcion!" && sleep 0.1 && return
	[[ ! $opcion =~ $numero ]] && blanco "\n solo deves ingresar numeros!" && sleep 0.1 && return
	[[ $opcion -gt ${#_res[@]} ]] && blanco "\n solo numeros entre 0 y ${#_res[@]}" && sleep 0.1 && return

	mkdir $backdir/tmp
	tar xpf $backdir/${_res[$opcion]} -C $backdir/tmp/

	clear
	title "	Archivos que se restauran"

	if rm -rf $config && cp $tmpdir/config.json $temp; then
		sleep 0.1
		echo "cat $temp | jq '.inbounds[].streamSettings.tlsSettings += {certificates:[{certificateFile:\"/data/xray.crt\",keyFile:\"/data/xray.key\"}]}' >> $config" | bash
		chmod 777 $config
		rm $temp
		blanco " /etc/xray/config.json..." && verde "[ok]" 
	else
		blanco " /etc/xray/config.json..." && rojo "[fail]"	
	fi

	if rm -rf $user_conf && cp $tmpdir/user $user_conf; then
		blanco " /etc/xr/user..." && verde "[ok]"
	else
		blanco " /etc/xr/user..." && rojo "[fail]"
	fi
    [[ -e $tmpdir/fullchain.cer ]] && mv $tmpdir/fullchain.cer $tmpdir/fullchain.crt
	if rm -rf /data && mkdir /data && cp $tmpdir/*.crt /data/xray.crt && cp $tmpdir/*.key /data/xray.key; then
		blanco " /data/xray.crt..." && verde "[ok]"
		blanco " /data/xray.key..." && verde "[ok]"
	else
		blanco " /data/xray.crt..." && rojo "[fail]"
		blanco " /data/xray.key..." && rojo "[fail]"
		msg -bar
		echo -e "VALIDA TU CERTIFICADO SSL "
		xray tls 
	fi
	rm -rf $tmpdir
	msg -bar
	continuar
	read foo
}

server(){
	clear

	if [[ $(npm ls -g | grep "http-server") = "" ]]; then
		npm install --global http-server
		clear
	fi

	if [[ $(ps x | grep "http-server" | grep -v grep) = "" ]]; then
		screen -dmS online http-server /etc/xr/back/ --port 95 -s
		title "	Respaldos en linea"
		col "su url:" "http://$(wget -qO- ipv4.icanhazip.com):95"
		msg -bar
		continuar
		read foo
	else
		killall http-server
		title "	servidor detenido..."
		sleep 0.1
	fi
 }
 
autBackup(){
	unset fecha
	unset hora
	unset tmp
	unset back
	unset cer
	unset key
	#fecha=`date +%d-%m-%y-%R`
	fecha=`date +%d-%m-%y`
	hora=`date +%R`
	tmp="$backdir/tmp" && [[ ! -d ${tmp} ]] && mkdir ${tmp}
	back="$backdir/v2r___${fecha}___${hora}.tar"
	cer=$(cat /etc/xray/config.json | jq -r ".inbounds[].streamSettings.tlsSettings.certificates[].certificateFile")
	key=$(cat /etc/xray/config.json | jq -r ".inbounds[].streamSettings.tlsSettings.certificates[].keyFile")

	cp $user_conf $tmp
	cp $config $tmp
	[[ ! $cer = null ]] && [[ -e $cer ]] && cp $cer $tmp
	[[ ! $key = null ]] && [[ -e $cer ]] && cp $key $tmp

	cd $tmp
	tar -cpf $back *
	cp $back /var/www/html/xrayBack.tar && echo -e "
 Descargarlo desde cualquier sitio con acceso WEB
  LINK : http://$(wget -qO- ifconfig.me):81/xrayBack.tar \033[0m
-------------------------------------------------------"
read -p "ENTER PARA CONTINUAR"
	rm -rf $tmp
 }
 
on_off_res(){
	if [[ $(cat $v2rdir/conf | grep "autBackup" | cut -d " " -f2) = "0" ]]; then
		echo -e "\033[0;31m[off]"
	else
		echo -e "\033[1;92m[on]"
	fi
 }

blanco(){
	[[ !  $2 = 0 ]] && {
		echo -e "\033[1;37m$1\033[0m"
	} || {
		echo -ne " \033[1;37m$1:\033[0m "
	}
}

verde(){
	[[ !  $2 = 0 ]] && {
		echo -e "\033[1;32m$1\033[0m"
	} || {
		echo -ne " \033[1;32m$1:\033[0m "
	}
}

rojo(){
	[[ !  $2 = 0 ]] && {
		echo -e "\033[1;31m$1\033[0m"
	} || {
		echo -ne " \033[1;31m$1:\033[0m "
	}
}

col(){

	nom=$(printf '%-55s' "\033[0;92m${1} \033[0;31m>> \033[1;37m${2}")
	echo -e "	$nom\033[0;31m${3}   \033[0;92m${4}\033[0m"
}

col2(){

	echo -e " \033[1;91m$1\033[0m \033[1;37m$2\033[0m"
}

vacio(){

	blanco "\n no se puede ingresar campos vacios..."
}

cancelar(){

	echo -e "\n \033[3;49;31minstalacion cancelada...\033[0m"
}

continuar(){

	echo -e " \033[3;49;32mEnter para continuar...\033[0m"
}

title2(){
xrayports=`lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN" | grep xray | awk '{print substr($9,3); }' > /tmp/xray.txt && echo | cat /tmp/xray.txt | tr '\n' ' ' > /etc/VPS-MX/xrayports.txt && cat /etc/VPS-MX/xrayports.txt` > /dev/null 2>&1
xrayports=$(echo $xrayports | awk {'print $1'})
_tconex=$(netstat -nap | grep "$xrayports" | grep xray | grep ESTABLISHED | awk {'print $5'} | awk -F ":" '{print $1}' | sort | uniq | wc -l)
	v1='V10X'
	v2='V10X'
	msg -bar
	[[ $v1 = $v2 ]] && echo -e "   \e[97m\033[1;44m MENU XRAY LITE [$v1] POWER BY @drowkid01 \033[0m" || echo -e " \e[97m\033[1;44m MENU XRAY LITE POWER BY @drowkid01 [$v1] >> \033[1;92m[$v2] \033[0m"
[[ ! -z $xrayports ]] && echo -e "       \e[97m\033[1;41mPUERTO ACTIVO :\033[0m \033[3;32m$xrayports\033[0m   \e[97m\033[1;41m ACTIVOS:\033[0m \033[3;32m\e[97m\033[1;41m $_tconex " ||  echo -e "  \e[97m\033[1;41mERROR A INICIAR xray : \033[0m \033[3;32m FAIL\033[3;32m"
	}

title(){
	msg -bar
	blanco "$1"
	msg -bar
}

userDat(){
	blanco "	N°    Usuarios 		  fech exp   dias"
	msg -bar
}

#============================================
domain_check() {
	ssl_install_fun
    clear
    msg -bar
    echo -e "   \033[1;49;37mgenerador de certificado ssl/tls\033[0m"
    msg -bar
    echo -e " \033[1;49;37mingrese su dominio (ej: midominio.com.ar)\033[0m"
    echo -ne ' \033[3;49;31m>>>\033[0m '
    read domain

    echo -e "\n \033[1;49;36mOteniendo resolucion dns de su dominio...\033[0m"
    domain_ip=$(ping "${domain}" -c 1 | sed '1{s/[^(]*(//;s/).*//;q}')

    echo -e "\n \033[1;49;36mOteniendo IP local...\033[0m"
    local_ip=$(wget -qO- ipv4.icanhazip.com)
    sleep 0.5

    while :
    do
    if [[ $(echo "${local_ip}" | tr '.' '+' | bc) -eq $(echo "${domain_ip}" | tr '.' '+' | bc) ]]; then
            clear
            msg -bar
            echo -e " \033[1;49;37mSu dominio: ${domain}\033[0m"
            msg -bar
            echo -e " \033[1;49;37mIP dominio:\033[0m  \033[1;49;32m${domain_ip}\033[0m"
            echo -e " \033[1;49;37mIP local:\033[0m    \033[1;49;32m${local_ip}\033[0m"
            msg -bar
            echo -e "      \033[1;49;32mComprovacion exitosa\033[0m"
            echo -e " \033[1;49;37mLa IP de su dominio coincide\n con la IP local, desea continuar?\033[0m"
            msg -bar
            echo -ne " \033[1;49;37msi o no [S/N]:\033[0m "
            read opcion
            case $opcion in
                [Yy]|[Ss]) port_exist_check;;
                [Nn]) cancelar && sleep 0.5;;
                *) echo -e "\n \033[1;49;37mselecione (S) para si o (N) para no!\033[0m" && sleep 0.5 && continue;;
            esac
    else
            clear
            msg -bar
            echo -e " \033[1;49;37mSu dominio: ${domain}\033[0m"
            msg -bar
            echo -e " \033[1;49;37mIP dominio:\033[0m  \033[3;49;31m${domain_ip}\033[0m"
            echo -e " \033[1;49;37mIP local:\033[0m    \033[3;49;31m${local_ip}\033[0m"
            msg -bar
            echo -e "      \033[3;49;31mComprovacion fallida\033[0m"
            echo -e " \033[4;49;97mLa IP de su dominio no coincide\033[0m\n         \033[4;49;97mcon la IP local\033[0m"
            msg -bar
            echo -e " \033[1;49;36m> Asegúrese que se agrego el registro"
            echo -e "   (A) correcto al nombre de dominio."
            echo -e " > Asegurece que su registro (A)"
            echo -e "   no posea algun tipo de seguridad"
            echo -e "   adiccional y que solo resuelva DNS."
            echo -e " > De lo contrario, xray no se puede"
            echo -e "   utilizar normalmente...\033[0m"
            msg -bar
            echo -e " \033[1;49;37mdesea continuar?"
            echo -ne " si o no [S/N]:\033[0m "
            read opcion
            case $opcion in
                [Yy]|[Ss]) port_exist_check;;
                [Nn]) cancelar && sleep 0.5;;
                *) echo -e "\n \033[1;49;37mselecione (S) para si o (N) para no!\033[0m" && sleep 0.2 && continue;;
            esac
        fi
        break
    done
}

port_exist_check() {
    while :
    do
    clear
    msg -bar
    echo -e " \033[1;49;37mPara la compilacion del certificado"
    echo -e " se requiere que los siguientes puerto"
    echo -e " esten libres."
    echo -e "        '80' '443'"
    echo -e " este script intentara detener"
    echo -e " cualquier proseso que este"
    echo -e " usando estos puertos\033[0m"
    msg -bar
    echo -e " \033[1;49;37mdesea continuar?"
    echo -ne " [S/N]:\033[0m "
    read opcion

    case $opcion in
        [Ss]|[Yy])         
                    ports=('80' '443')
                    clear
                        msg -bar
                        echo -e "      \033[1;49;37mcomprovando puertos...\033[0m"
                        msg -bar
                        sleep 0.2
                        for i in ${ports[@]}; do
                            [[ 0 -eq $(lsof -i:$i | grep -i -c "listen") ]] && {
                                echo -e "    \033[3;49;32m$i [OK]\033[0m" 
                            } || {
                                echo -e "    \033[3;49;31m$i [fail]\033[0m"
                            }
                        done
                        msg -bar
                        for i in ${ports[@]}; do
                            [[ 0 -ne $(lsof -i:$i | grep -i -c "listen") ]] && {
                                echo -ne "       \033[1;49;37mliberando puerto $i...\033[1;49;37m "
                                lsof -i:$i | awk '{print $2}' | grep -v "PID" | xargs kill -9
                                echo -e "\033[1;49;32m[OK]\033[0m"
                            }
                        done
                        ;;
        [Nn]) cancelar && sleep 0.2 && break;;
        *) echo -e "\n \033[1;49;37mselecione (S) para si o (N) para no!\033[0m" && sleep 0.2;;
    esac
    continuar
    read foo
    ssl_install
    break
    done
}

ssl_install() {
    while :
    do

    if [[ -f "/data/xray.key" || -f "/data/xray.crt" ]]; then
        clear
        msg -bar
        echo -e " \033[1;49;37mya existen archivos de certificados"
        echo -e " en el directorio asignado.\033[0m"
        msg -bar
        echo -e " \033[1;49;37mENTER para canselar la instacion."
        echo -e " 'S' para eliminar y continuar\033[0m"
        msg -bar
        echo -ne " opcion: "
        read ssl_delete
        case $ssl_delete in
        [Ss]|[Yy])
                    rm -rf /data/*
                    echo -e " \033[3;49;32marchivos removidos..!\033[0m"
                    sleep 0.2
                    ;;
        *) cancelar && sleep 0.2 && break;;
        esac
    fi

    if [[ -f "$HOME/.acme.sh/${domain}_ecc/${domain}.key" || -f "$HOME/.acme.sh/${domain}_ecc/${domain}.cer" ]]; then
        msg -bar
        echo -e " \033[1;49;37mya existe un almacer de certificado"
        echo -e " bajo este nombre de dominio\033[0m"
        msg -bar
        echo -e " \033[1;49;37m'ENTER' cansela la instalacion"
        echo -e " 'D' para eliminar y continuar"
        echo -e " 'R' para restaurar el almacen crt\033[0m"
        msg -bar
        echo -ne " opcion: "
        read opcion
        case $opcion in
            [Dd])
                        echo -e " \033[1;49;92meliminando almacen cert...\033[0m"
                        sleep 0.2
                        rm -rf $HOME/.acme.sh/${domain}_ecc
                        ;;
            [Rr])
                        echo -e " \033[1;49;92mrestaurando certificados...\033[0m"
                        sleep 0.2
                        "$HOME"/.acme.sh/acme.sh --installcert -d "${domain}" --fullchainpath /data/xray.crt --keypath /data/xray.key --ecc
			            echo "cat $temp | jq '.inbounds[].streamSettings.tlsSettings += {certificates:[{certificateFile:\"/data/xray.crt\",keyFile:\"/data/xray.key\"}]}' | jq '.inbounds[] += {domain:\"$domi\"}' | jq '.inbounds[].streamSettings += {security:\"tls\"}' >> $config" | bash
			            restart_v2r
                        echo -e " \033[1;49;37mrestauracion completa...\033[0m\033[1;49;92m[ok]\033[0m"
                        break
                        ;;
            *) cancelar && sleep 0.2 && break;;
        esac
    fi
    acme
    break
    done 
}

ssl_install_fun() {
    apt install socat netcat -y
    curl https://get.acme.sh | sh
}

acme() {
    clear
    msg -bar
    echo -e " \033[1;49;37mcreando nuevos certificado ssl/tls\033[0m"
	#msg -bar
#	read -p " Ingrese correo Para Validar el acme SSL : " corrio
	msg -bar
	wget -O -  https://get.acme.sh | sh -s email=$corrio
    msg -bar
    if "$HOME"/.acme.sh/acme.sh --issue -d "${domain}" --standalone -k ec-256 --force --test; then
        echo -e "\n           \033[1;49;37mSSL La prueba del certificado\n se emite con éxito y comienza la emisión oficial\033[0m\n"
        rm -rf "$HOME/.acme.sh/${domain}_ecc"
        sleep 0.2
    else
        echo -e "\n \033[4;49;31mError en la emisión de la prueba del certificado SSL\033[0m"
        msg -bar
        rm -rf "$HOME/.acme.sh/${domain}_ecc"
        stop=1
    fi

    if [[ 0 -eq $stop ]]; then

    if "$HOME"/.acme.sh/acme.sh --issue -d "${domain}" --standalone -k ec-256 --force; then
        echo -e "\n \033[1;49;37mSSL El certificado se genero con éxito\033[0m"
        msg -bar
        sleep 0.2
        [[ ! -d /data ]] && mkdir /data
        if "$HOME"/.acme.sh/acme.sh --installcert -d "${domain}" --fullchainpath /data/xray.crt --keypath /data/xray.key --ecc --force; then
            msg -bar
            mv $config $temp
            echo "cat $temp | jq '.inbounds[].streamSettings.tlsSettings += {certificates:[{certificateFile:\"/data/xray.crt\",keyFile:\"/data/xray.key\"}]}' | jq '.inbounds[] += {domain:\"$domain\"}' | jq '.inbounds[].streamSettings += {security:\"tls\"}' >> $config" | bash
            chmod 777 $config
            rm $temp
            restart_v2r
            echo -e "\n \033[1;49;37mLa configuración del certificado es exitosa\033[0m"
            msg -bar
            echo -e "      /data/xray.crt"
            echo -e "      /data/xray.key"
            msg -bar
            sleep 0.2
        fi
    else
        echo -e "\n \033[4;49;31mError al generar el certificado SSL\033[0m"
        msg -bar
        rm -rf "$HOME/.acme.sh/${domain}_ecc"
    fi
    fi
    continuar
    read foo
}

#============================================

restart_v2r(){
	xray restart
	#echo "reiniciando"
}


fun_lock(){
	unset seg
	local seg=$(date +%s)
	while :
	do
	clear
	users=$(cat $config | jq .inbounds[].settings.clients[] | jq -r .email)
	title " BLOQUEAR USUARIO Y MANDARLO AL LIMBOOOOO"
	userDat
	local n=1
	for i in $users
	do
		unset DateExp
		unset seg_exp
		unset exp
		[[ $i = null ]] || {
			DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
			seg_exp=$(date +%s --date="$DateExp")
			exp="[$(($(($seg_exp - $seg)) / 86400))]"
			col "$n)" "$i" "$DateExp" "$exp"
			local uid[$n]="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f2|tr -d '[[:space:]]')"
			local user[$n]=$i
			local p=$n
			let n++
		}
	done
	msg -bar
	col "0)" "VOLVER"
	msg -bar
	blanco "NUMERO DE USUARIO A BLOQUEAR" 0
	read opcion

	[[ -z $opcion ]] && vacio && sleep 0.3 && continue
	[[ $opcion = 0 ]] && break

	[[ ! $opcion =~ $numero ]] && {
		blanco " solo numeros apartir de 1"
		sleep 0.2
	} || {
		let n--
		[[ $opcion -gt ${n} ]] && {
			blanco "solo numero entre 1 y $n"
			sleep 0.2
		} || {
		#echo -e " OPCION ${opcion} / USER : ${user[$opcion]}"
		local LOCKDATA="$(cat ${user_conf}|grep -w "${user[$opcion]}"|cut -d'|' -f3)"
		local tempo=$(date +%s --date="$LOCKDATA")
		local dias="$(($(($tempo - $seg)) / 86400))"
			[[ $opcion>=${p} ]] && {
			echo "${user[$opcion]} | ${uid[$opcion]} | $(date '+%y-%m-%d' -d " +$dias days") |${dias}" >> $configLOCK
			#echo "${user[$opcion]} | ${uid[$opcion]} | $(date '+%y-%m-%d' -d " +$dias days") |${dias}" 
			mv $config $temp
			echo jq \'del\(.inbounds[].settings.clients[$opcion]\)\' $temp \> $config | bash
			chmod 777 $config
			sed -i "/${user[$opcion]}/d" $user_conf
			rm $temp
			chmod 777 $configLOCK
			#read -p "PAUSE"
			} || {
			echo "${user[$opcion]} | ${uid[$opcion]} | $(date '+%y-%m-%d' -d " +$dias days") |${dias}" >> $configLOCK
			#echo "${user[$opcion]} | ${uid[$opcion]} | $(date '+%y-%m-%d' -d " +$dias days") |${dias}"
			mv $config $temp
			echo jq \'del\(.inbounds[].settings.clients[$opcion]\)\' $temp \> $config | bash
			chmod 777 $config
			rm $temp
			sed -i "/${user[$opcion]}/d" $user_conf
			chmod 777 $configLOCK
			#read -p "PAUSE"
			clear
			msg -bar
			#blanco "	Usuario $(jq .inbounds[].settings.clients[$opcion].email $config) eliminado"
			blanco " USUARIO ${user[$opcion]} NUM: ${opcion} ENVIADO AL LIMBOOOO !!"
			msg -bar
			restart_v2r
			}
			sleep 0.2
		}
	}
done
}

fun_unlock(){
#echo "${user[$opcion]} | ${uid[$opcion]} | $(date '+%y-%m-%d' -d " +$dias days")" >> $configLOCK
	while :
	do
		unset user n
		clear
		title " DESBOQUEAR USUARIOS DEL LIMBOOOOO!!!"
		userDat
		userEpx=$(cut -d " " -f1 $configLOCK)
		n=1
		for i in $userEpx
		do
			DateExp="$(cat ${configLOCK}|grep -w "${i}"|cut -d'|' -f4)"
			#seg_exp=$(date +%s --date="$DateExp")
			#[[ "$seg" -gt "$seg_exp" ]] && {
				col "$n)" "$i" "$DateExp DIAS" "\033[0;31m[LOCK]"
				#col "$n)" "$i" "\033[0;31m[LOCK]"
				local uid[$n]="$(cat ${configLOCK}|grep -w "${i}"|cut -d'|' -f2|tr -d '[[:space:]]')"
				local user[$n]=$i
				local tiempito[$n]="$(cat ${configLOCK}|grep -w "${i}"|cut -d'|' -f4|tr -d '[[:space:]]')"
				let n++
			#}
		done
		[[ -z ${user[1]} ]] && blanco "		No hay bloqueados!!!"
		msg -bar
		col "0)" "VOLVER"
		msg -bar
		blanco "NUMERO DE USUARIO A DESBLOQUEAR" 0
		read opcion

		[[ -z $opcion ]] && vacio && sleep 0.3 && continue
		[[ $opcion = 0 ]] && break

		[[ ! $opcion =~ $numero ]] && {
			blanco " solo numeros apartir de 1"
			sleep 0.2
		} || {
			[[ $opcion>=${n} ]] && {
				let n--
				blanco "solo numero entre 1 y $n"
				sleep 0.2
		} || {
			#blanco "DURACION EN DIAS" 0
			local dias=${tiempito[$opcion]}
			mv $config $temp
			num=$(jq '.inbounds[].settings.clients | length' $temp)
			aid=$(jq '.inbounds[].settings.clients[0].alterId' $temp)
			echo "cat $temp | jq '.inbounds[].settings.clients[$num] += {alterId:${aid},id:\"${uid[$opcion]}\",email:\"${user[$opcion]}\"}' >> $config" | bash
			sed -i "/${user[$opcion]}/d" ${configLOCK}
			echo "${user[$opcion]} | ${uid[$opcion]} | $(date '+%y-%m-%d' -d " +$dias days")" >> $user_conf
			chmod 777 $config
			rm $temp
			clear
			msg -bar
			blanco " USUARIO ${user[$opcion]} RETIRADO DEL LIMBOOOOOOO!!"
			msg -bar
			restart_v2r
			sleep 0.2
		  }
		}
	done
}

_lo_un(){
clear
msg -bar
echo -e "\033[0;35m [${cor[2]}1\033[0;35m]\033[0;33m ${flech}\033[0;33m [!] BLOQUEAR USUARIO V2RAY "
echo -e "\033[0;35m [${cor[2]}2\033[0;35m]\033[0;33m ${flech}\033[0;33m [!] DESBLOQUEAR USUARIO V2RAY "
msg -bar
echo -e " \033[0;35m[${cor[2]}0\033[0;35m]\033[0;33m ${flech} $(msg -bra "\033[1;43m[ Salir ]\e[0m")"
msg -bar 
	selection=$(selection_fun 2)
	case ${selection} in
		1)
			fun_lock
		;;
		2)
			fun_unlock
		;;
		esac
}



add_user(){
	unset seg
	seg=$(date +%s)
	while :
	do
	clear
	users="$(cat $config | jq -r .inbounds[].settings.clients[].email)"

	title "		CREAR USUARIO xray"
	userDat

	n=0
	for i in $users
	do
		unset DateExp
		unset seg_exp
		unset exp

		[[ $i = null ]] && {
			i="default"
			a='*'
			DateExp=" unlimit"
			col "$a)" "$i" "$DateExp"
		} || {
			DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
			seg_exp=$(date +%s --date="$DateExp")
			exp="[$(($(($seg_exp - $seg)) / 86400))]"

			col "$n)" "$i" "$DateExp" "$exp"
		}
		let n++
	done
	msg -bar
	col "0)" "VOLVER"
	msg -bar
	blanco "NOMBRE DEL NUEVO USUARIO" 0
	read opcion

	[[ -z $opcion ]] && vacio && sleep 0.3 && continue

	[[ $opcion = 0 ]] && break

	blanco "DURACION EN DIAS" 0
	read dias

	espacios=$(echo "$opcion" | tr -d '[[:space:]]')
	opcion=$espacios

	mv $config $temp
	num=$(jq '.inbounds[].settings.clients | length' $temp)
	new=".inbounds[].settings.clients[$num]"
	new_id=$(uuidgen)
	new_mail="email:\"$opcion\""
	aid=$(jq '.inbounds[].settings.clients[0].alterId' $temp)
	echo jq \'$new += \{alterId:${aid},id:\"$new_id\","$new_mail"\}\' $temp \> $config | bash
	echo "$opcion | $new_id | $(date '+%y-%m-%d' -d " +$dias days")" >> $user_conf
	chmod 777 $config
	rm $temp
	clear
	msg -bar
	blanco "	Usuario $opcion creado Exitosamente"
	msg -bar
	restart_v2r
	sleep 0.2
		#-------------------------------------------------------------
		ps=${opcion} #$(jq .inbounds[].settings.clients[$opcion].email $config) && [[ $ps = null ]] && ps="default"
		id=${new_id} #$(jq .inbounds[].settings.clients[$opcion].id $config)
		aid=$(jq .inbounds[].settings.clients[].alterId $config | head -1)
		add=$(jq '.inbounds[].domain' $config) && [[ $add = null ]] && add=$(wget -qO- ipv4.icanhazip.com)
		host=$(jq '.inbounds[].streamSettings.wsSettings.headers.Host' $config) && [[ $host = null ]] && host='aqui.tu.host'
		net=$(jq '.inbounds[].streamSettings.network' $config)
		[[ $net = '"grpc"' ]] && path=$(jq '.inbounds[].streamSettings.grpcSettings.serviceName'  $config) || path=$(jq '.inbounds[].streamSettings.wsSettings.path' $config)
		port=$(jq '.inbounds[].port' $config)
		tls=$(jq '.inbounds[].streamSettings.security' $config)
		addip=$(wget -qO- ifconfig.me)
		clear
		msg -bar
		blanco " Usuario: $ps"
		msg -bar
		col2 "Remarks:" "$ps"
		col2 "Domain:" "$add" 
		col2 "IP-Address:" "$addip"
		col2 "Port:" "$port"
		col2 "id:" "$id"
		col2 "alterId:" "$aid"
		col2 "network:" "$net"
		[[ $tls = '"tls"' ]] && col2 "TLS:" "ABIERTO" || col2 "TLS:" " CERRADO"
		[[ $net = '"grpc"' ]] && col2 "Mode:" " GUN" || col2 "Head Type:" "none"
		col2 "security:" "none"
		[[ ! $host = '' ]] && col2 "Host/SNI:" "$host"
		[[ $net = '"grpc"' ]] && col2 "ServiceName:" "$path" || col2 "Path:" "$path"
		msg -bar
		blanco "              VMESS LINK CONFIG"
		msg -bar
		vmess
		msg -bar
		echo -e "  ESTA CONFIG SOLO SE MUESTRA UNA VEZ AQUI \n SI QUIERES VOLVER A VERLA VE A LA OPCION 4 \n  Y BALLASE A LA BERGA PERRO :V"
		msg -bar
		continuar
		read foo
	#---------------------------------------------------------------------
    done
}

renew(){
	while :
	do
		unset user
		clear
		title "		RENOVAR USUARIOS"
		userDat
		userEpx=$(cut -d " " -f1 $user_conf)
		n=1
		for i in $userEpx
		do
			DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
			seg_exp=$(date +%s --date="$DateExp")
			[[ "$seg" -gt "$seg_exp" ]] && {
				col "$n)" "$i" "$DateExp" "\033[0;31m[Exp]"
				uid[$n]="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f2|tr -d '[[:space:]]')"
				user[$n]=$i
				let n++
			}
		done
		[[ -z ${user[1]} ]] && blanco "		No hay expirados"
		msg -bar
		col "0)" "VOLVER"
		msg -bar
		blanco "NUMERO DE USUARIO A RENOVAR" 0
		read opcion

		[[ -z $opcion ]] && vacio && sleep 0.3 && continue
		[[ $opcion = 0 ]] && break

		[[ ! $opcion =~ $numero ]] && {
			blanco " solo numeros apartir de 1"
			sleep 0.2
		} || {
			[[ $opcion>${n} ]] && {
				let n--
				blanco "solo numero entre 1 y $n"
				sleep 0.2
		} || {
			blanco "DURACION EN DIAS" 0
			read dias

			mv $config $temp
			num=$(jq '.inbounds[].settings.clients | length' $temp)
			aid=$(jq '.inbounds[].settings.clients[0].alterId' $temp)
			echo "cat $temp | jq '.inbounds[].settings.clients[$num] += {alterId:${aid},id:\"${uid[$opcion]}\",email:\"${user[$opcion]}\"}' >> $config" | bash
			sed -i "/${user[$opcion]}/d" $user_conf
			echo "${user[$opcion]} | ${uid[$opcion]} | $(date '+%y-%m-%d' -d " +$dias days")" >> $user_conf
			chmod 777 $config
			rm $temp
			clear
			msg -bar
			blanco "	Usuario ${user[$opcion]} renovado Exitosamente"
			msg -bar
			restart_v2r
			sleep 0.2
		  }
		}
	done
}

autoDel(){
	seg=$(date +%s)
	while :
	do
		unset users
		users=$(cat $config | jq .inbounds[].settings.clients[] | jq -r .email)
		n=0
		for i in $users
		do
			[[ ! $i = null ]] && {
				DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
				seg_exp=$(date +%s --date="$DateExp")
				[[ "$seg" -gt "$seg_exp" ]] && {
					mv $config $temp
					echo jq \'del\(.inbounds[].settings.clients[$n]\)\' $temp \> $config | bash
					chmod 777 $config
					rm $temp
					continue
				}
			}
			let n++
			done
			break
		done
		restart_v2r
	}

dell_user(){
	unset seg
	seg=$(date +%s)
	while :
	do
	clear
	users=$(cat $config | jq .inbounds[].settings.clients[] | jq -r .email)

	title "	ELIMINAR USUARIO xray"
	userDat
	n=0
	for i in $users
	do
		userd[$n]=$i
		unset DateExp
		unset seg_exp
		unset exp

		[[ $i = null ]] && {
			i="default"
			a='*'
			DateExp=" unlimit"
			col "$a)" "$i" "$DateExp"
		} || {
			DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
			seg_exp=$(date +%s --date="$DateExp")
			exp="[$(($(($seg_exp - $seg)) / 86400))]"
			col "$n)" "$i" "$DateExp" "$exp"
		}
		p=$n
		let n++
	done
	userEpx=$(cut -d " " -f 1 $user_conf)
	for i in $userEpx
	do	
		DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
		seg_exp=$(date +%s --date="$DateExp")
		[[ "$seg" -gt "$seg_exp" ]] && {
			col "$n)" "$i" "$DateExp" "\033[0;31m[Exp]"
			expUser[$n]=$i
		}
		let n++
	done
	msg -bar
	col "0)" "VOLVER"
	msg -bar
	blanco "NUMERO DE USUARIO A ELIMINAR" 0
	read opcion

	[[ -z $opcion ]] && vacio && sleep 0.3 && continue
	[[ $opcion = 0 ]] && break

	[[ ! $opcion =~ $numero ]] && {
		blanco " solo numeros apartir de 1"
		sleep 0.2
	} || {
		let n--
		[[ $opcion>=${n} ]] && {
			blanco "solo numero entre 1 y $n"
			sleep 0.2
		} || {
			[[ $opcion>${p} ]] && {
				sed -i "/${expUser[$opcion]}/d" $user_conf
			} || {
			sed -i "/${userd[$opcion]}/d" $user_conf
			mv $config $temp
			echo jq \'del\(.inbounds[].settings.clients[$opcion]\)\' $temp \> $config | bash
			chmod 777 $config
			rm $temp
			clear
			msg -bar
			blanco "	Usuario eliminado"
			msg -bar
			restart_v2r
			}
			sleep 0.2
		}
	}
	done
}

view_user(){
	unset seg
	seg=$(date +%s)
	while :
	do

		clear
		users=$(cat $config | jq .inbounds[].settings.clients[] | jq -r .email)

		title "	VER USUARIO xray"
		userDat

		n=1
		for i in $users
		do
			unset DateExp
			unset seg_exp
			unset exp

			[[ $i = null ]] && {
				i="Admin"
				DateExp=" Ilimitado"
			} || {
				DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
				seg_exp=$(date +%s --date="$DateExp")
				exp="[$(($(($seg_exp - $seg)) / 86400))]"
			}

			col "$n)" "$i" "$DateExp" "$exp"
			let n++
		done

		msg -bar
		col "0)" "VOLVER"
		msg -bar
		blanco "VER DATOS DEL USUARIO" 0
		read opcion

		[[ -z $opcion ]] && vacio && sleep 0.3 && continue
		[[ $opcion = 0 ]] && break

		let opcion--

		ps=$(jq .inbounds[].settings.clients[$opcion].email $config) && [[ $ps = null ]] && ps="default"
		id=$(jq .inbounds[].settings.clients[$opcion].id $config)
		aid=$(jq .inbounds[].settings.clients[$opcion].alterId $config)
		add=$(jq '.inbounds[].domain' $config) && [[ $add = null ]] && add=$(wget -qO- ipv4.icanhazip.com)
		host=$(jq '.inbounds[].streamSettings.wsSettings.headers.Host' $config) && [[ $host = null ]] && host='aqui.tu.host'
		net=$(jq '.inbounds[].streamSettings.network' $config)
		[[ $net = '"grpc"' ]] && path=$(jq '.inbounds[].streamSettings.grpcSettings.serviceName'  $config) || path=$(jq '.inbounds[].streamSettings.wsSettings.path' $config)
		port=$(jq '.inbounds[].port' $config)
		tls=$(jq '.inbounds[].streamSettings.security' $config)
		addip=$(wget -qO- ifconfig.me)
		clear
		msg -bar
		blanco " Usuario: $ps"
		msg -bar
		col2 "Remarks:" "$ps"
		col2 "Domain:" "$add" 
		col2 "IP-Address:" "$addip"
		col2 "Port:" "$port"
		col2 "id:" "$id"
		col2 "alterId:" "$aid"
		col2 "network:" "$net"
		[[ $tls = '"tls"' ]] && col2 "TLS:" "ABIERTO" || col2 "TLS:" " CERRADO"
		[[ $net = '"grpc"' ]] && col2 "Mode:" " GUN" || col2 "Head Type:" "none"
		col2 "security:" "none"
		[[ ! $host = '' ]] && col2 "Host/SNI:" "$host"
		[[ $net = '"grpc"' ]] && col2 "ServiceName:" "$path" || col2 "Path:" "$path"
		msg -bar
		blanco "              VMESS LINK CONFIG"
		msg -bar
		vmess
		msg -bar
		continuar
		read foo
	done
}

vmess() {
[[ $net = '"grpc"' ]] && echo -e "\033[3;32mvmess://$(echo {\"v\": \"2\", \"ps\": $ps, \"add\": $addip, \"port\": $port, \"aid\": $aid, \"type\": \"none\", \"net\": $net, \"path\": $path, \"host\": $host, \"id\": $id, \"tls\": $tls} | base64 -w 0)\033[3;32m" || {
[[ $net = '"ws"' ]] && echo -e "\033[3;32mvmess://$(echo {\"v\": \"2\", \"ps\": $ps, \"add\": $addip, \"port\": $port, \"aid\": $aid, \"type\": \"gun\", \"net\": $net, \"path\": $path, \"host\": $host, \"id\": $id, \"tls\": $tls} | base64 -w 0)\033[3;32m"
}
}

alterid(){
	while :
	do
		aid=$(jq '.inbounds[].settings.clients[0].alterId' $config)
	clear
	msg -bar
	blanco "        configuracion alterId"
	msg -bar
	col2 "	alterid:" "$aid"
	msg -bar
	col "x)" "VOLVER"
	msg -bar
	blanco "NUEVO VALOR" 0
	read opcion

	[[ -z $opcion ]] && vacio && sleep 0.3 && break
	[[ $opcion = x ]] && break

	mv $config $temp
	new=".inbounds[].settings.clients[0]"
	echo jq \'$new += \{alterId:${opcion}\}\' $temp \> $config | bash
	chmod 777 $config
	rm $temp
	clear
	msg -bar
	blanco "Nuevo AlterId fijado"
	msg -bar
	restart_v2r
	sleep 0.2
	done
}

port(){
	while :
	do
	port=$(jq '.inbounds[].port' $config)
	clear
	msg -bar
	blanco "       configuracion de puerto"
	msg -bar
	col2 " Puerto:" "$port"
	msg -bar
	col "0)" "VOLVER"
	msg -bar
	blanco "NUEVO PUERTO" 0
	read opcion

	[[ -z $opcion ]] && vacio && sleep 0.3 && break
	[[ $opcion = 0 ]] && break

	mv $config $temp
	new=".inbounds[]"
	echo jq \'$new += \{port:${opcion}\}\' $temp \> $config | bash
	chmod 777 $config
	rm $temp
	clear
	msg -bar
	blanco "	Nuevo Puerto fijado"
	msg -bar
	sleep 0.2
	restart_v2r
	done
}

address(){
	while :
	do
	add=$(jq '.inbounds[].domain' $config) && [[ $add = null ]] && add=$(wget -qO- ipv4.icanhazip.com)
	clear
	msg -bar
	blanco "       configuracion address"
	msg -bar
	col2 "address:" "$add"
	msg -bar
	col "0)" "VOLVER"
	msg -bar
	blanco "NUEVO ADDRESS" 0
	read opcion

	[[ -z $opcion ]] && vacio && sleep 0.3 && break
	[[ $opcion = 0 ]] && break

	mv $config $temp
	echo "cat $temp | jq '.inbounds[] += {domain:\"$opcion\"}' >> $config" | bash
	chmod 777 $config
	rm $temp
	clear
	msg -bar
	blanco "Nuevo address fijado"
	msg -bar
	restart_v2r
	sleep 0.2
	done
}

host(){
	while :
	do
	host=$(jq '.inbounds[].streamSettings.wsSettings.headers.Host' $config) && [[ $host = null ]] && host='sin host'
	clear
	msg -bar
	blanco "       configuracion Host"
	msg -bar
	col2 "Host:" "$host"
	msg -bar
	col "0)" "VOLVER"
	msg -bar
	blanco "NUEVO HOST" 0
	read opcion

	[[ -z $opcion ]] && vacio && sleep 0.3 && break
	[[ $opcion = 0 ]] && break
	mv $config $temp
	echo "cat $temp | jq '.inbounds[].streamSettings.wsSettings.headers += {Host:\"$opcion\"}' >> $config" | bash
	chmod 777 $config
	rm $temp
	clear
	msg -bar
	blanco "Nuevo Host fijado"
	msg -bar
	restart_v2r
	sleep 0.2
	done
}

path(){
	while :
	do
	path=$(jq '.inbounds[].streamSettings.wsSettings.path' $config) && [[ $path = null ]] && path=''
	clear
	msg -bar
	blanco "       configuracion Path"
	msg -bar
	col2 "path:" "$path"
	msg -bar
	col "0)" "VOLVER"
	msg -bar
	blanco "NUEVO Path" 0
	read opcion

	[[ -z $opcion ]] && vacio && sleep 0.3 && break
	[[ $opcion = 0 ]] && break

	mv $config $temp
	echo "cat $temp | jq '.inbounds[].streamSettings.wsSettings += {path:\"$opcion\"}' >> $config" | bash
	chmod 777 $config
	rm $temp
	clear
	msg -bar
	blanco "Nuevo path fijado"
	msg -bar
	sleep 0.2
	restart_v2r
	done
}

crt_man(){
	while :
	do
		clear
		msg -bar
		blanco "configuracion de certificado manual"
		msg -bar

		chek=$(jq '.inbounds[].streamSettings.tlsSettings' $config)
		[[ ! $chek = {} ]] && {
			crt=$(jq '.inbounds[].streamSettings.tlsSettings.certificates[].certificateFile' $config)
			key=$(jq '.inbounds[].streamSettings.tlsSettings.certificates[].keyFile' $config)
			dom=$(jq '.inbounds[].domain' $config)
			echo -e "		\033[4;49minstalado\033[0m"
			col2 "crt:" "$crt"
			col2 "key:" "$key"
			col2 "dominio:" "$dom"
		} || {
			blanco "	certificado no instalado"
		}

		msg -bar
		col "1)" "ingresar nuevo crt"
		msg -bar
		col "0)" "VOLVER"
		msg -bar
		blanco "opcion" 0
		read opcion

		[[ -z $opcion ]] && vacio && sleep 0.3 && break
		[[ $opcion = 0 ]] && break

		clear
		msg -bar
		blanco "ingrese su archivo de certificado\n ej: /root/crt/certif.crt"
		msg -bar
		blanco "crt" 0
		read crts

		clear
		msg -bar
		blanco "	nuevo certificado"
		msg -bar
		blanco "	$crts"
		msg -bar
		blanco "ingrese su archivo key\n ej: /root/crt/certif.key"
		msg -bar
		blanco "key" 0
		read keys

		clear
		msg -bar
		blanco "	nuevo certificado"
		msg -bar
		blanco "	$crts"
		blanco "	$keys"
		msg -bar
		blanco "ingrese su dominio\n ej: netfree.xyz"
		msg -bar
		blanco "dominio" 0
		read domi

		clear
		msg -bar
		blanco "verifique sus datos sean correctos!"
		msg -bar
		blanco "	$crts"
		blanco "	$keys"
		blanco "	$domi"
		msg -bar
		continuar
		read foo

		mv $config $temp
		echo "cat $temp | jq '.inbounds[].streamSettings.tlsSettings += {certificates:[{certificateFile:\"$crts\",keyFile:\"$keys\"}]}' | jq '.inbounds[] += {domain:\"$domi\"}' | jq '.inbounds[].streamSettings += {security:\"tls\"}' >> $config" | bash
		chmod 777 $config
		rm $temp
		clear
		msg -bar
		blanco "nuevo certificado agregado"
		msg -bar
		restart_v2r
		sleep 0.2
	done
}

install(){
	clear
	install_ini
	msg -bar
	blanco "	Esta por intalar xray!"
	msg -bar
	blanco " La instalacion puede tener\n alguna fallas!\n por favor observe atentamente\n el log de intalacion,\n este podria contener informacion\n sobre algunos errores!\n estos deveras ser corregidos de\n forma manual antes de continual\n usando el script"
	msg -bar
	sleep 0.2
	blanco "Enter para continuar..."
	read foo
	config='/etc/xray/config.json'
    tmp='/etc/xray/temp.json'
	#source <(curl -sL https://raw.githubusercontent.com/DrowKid/ADMRufu/main/Utils/xray/xray.sh)
	#restart_v2r
	echo "source <(curl -sSL https://raw.githubusercontent.com/drowkid01/scriptcgh/main/Recursos/test/xray_manager.sh)" > /bin/v2r.sh
	chmod +x /bin/r.sh
}

xray_tls(){
	clear
	msg -bar
	blanco "		certificado tls xray"
	echo -e "Ingrese Correo Temporal o Fijo \n  Para Validar su Cerficicado SSL " 
	read -p " Ejemplo > email=my@example.com : " -e -i $(date | md5sum | head -c15)@gmail.com crreo
	msg -bar
	wget -O -  https://get.acme.sh | sh -s email=$crreo
	xray tls
	msg -bar
	continuar
	read foo
}

xray_stream(){
	clear
	msg -bar
	blanco "	instalacion de protocolos xray"
	msg -bar
	xray stream
	msg -bar
	continuar
	read foo
}

xray_menu(){
	clear
	msg -bar
	blanco "		MENU xray"
	msg -bar
	xray
}

backups(){
	while :
	do
		unset opcion
		unset PID
		if [[ $(ps x | grep "http-server" | grep -v grep) = "" ]]; then
			PID="\033[0;31m[offline]"
		else
			PID="\033[1;92m[online]"
		fi

	clear
	title "	Config de Respaldos"
	col "1)" "Respaldar Ahora"
	col "2)" "\033[1;92mRestaurar Respaldo"
	col "3)" "\033[0;31mEliminiar Respaldos"
	col "4)" "\033[1;34mRespaldo en linea $PID"
	col "5)" "\033[1;33mRespaldos automatico $(on_off_res)"
	msg -bar
	
	col "6)" "\033[1;33m RESTAURAR Online PORT :81 "
	msg -bar
	col "0)" "VOLVER"
	msg -bar
	blanco "opcion" 0
	read opcion

	case $opcion in
		1)	autBackup
			clear
			title "	Nuevo Respaldo Creado..."
			sleep 0.2;;
		2)	restore;;
		3)	rm -rf $backdir/*.tar
			clear
			title "	Almacer de Respaldo limpia..."
			sleep 0.2;;
		4)	server;;


		5)	if [[ $(cat $v2rdir/conf | grep "autBackup" | cut -d " " -f2) = "0" ]]; then
				sed -i 's/autBackup 0/autBackup 1/' $v2rdir/conf
			else
				sed -i 's/autBackup 1/autBackup 0/' $v2rdir/conf
			fi;;
		6)
		clear
		echo -e "\033[0;33m
         ESTA FUNCION EXPERIMENTAL 
Una vez que se descarge tu Fichero, Escoje el BackOnline
	
				  + OJO +
				 
   Luego de Restaurarlo, Vuelve Activar el TLS 
 Para Validar la Configuracion de tu certificao"
msg -bar
echo -n "INGRESE LINK Que Mantienes Online en GitHub, o VPS \n" 
read -p "Pega tu Link : " url1
wget -q -O $backdir/BakcOnline.tar $url1 && echo -e "\033[1;31m- \033[1;32mFile Exito!"  && restore || echo -e "\033[1;31m- \033[1;31mFile Fallo" && sleep 0.2
		;;
		0)	break;;
		*)	blanco "opcion incorrecta..." && sleep 0.2;;
	esac
	done
}


restablecer_v2r(){
	clear
	title "   restablecer ajustes xray"
	echo -e " \033[0;31mEsto va a restablecer los\n ajustes predeterminados de xray"
	echo -e " Se perdera ajuste previos,\n incluido los Usuarios\033[0m"
	msg -bar
	blanco "quiere continuar? [S/N]" 0
	read opcion
	msg -bar
	case $opcion in
		[Ss]|[Yy]) xray new;;
		[Nn]) continuar && read foo;;
	esac
}

remove_all(){
	sed -i '/net.core.default_qdisc/d' /etc/sysctl.conf
    sed -i '/net.ipv4.tcp_congestion_control/d' /etc/sysctl.conf
    sed -i '/fs.file-max/d' /etc/sysctl.conf
	sed -i '/net.core.rmem_max/d' /etc/sysctl.conf
	sed -i '/net.core.wmem_max/d' /etc/sysctl.conf
	sed -i '/net.core.rmem_default/d' /etc/sysctl.conf
	sed -i '/net.core.wmem_default/d' /etc/sysctl.conf
	sed -i '/net.core.netdev_max_backlog/d' /etc/sysctl.conf
	sed -i '/net.core.somaxconn/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_syncookies/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_tw_reuse/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_tw_recycle/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_fin_timeout/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_keepalive_time/d' /etc/sysctl.conf
	sed -i '/net.ipv4.ip_local_port_range/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_max_syn_backlog/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_max_tw_buckets/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_rmem/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_wmem/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_mtu_probing/d' /etc/sysctl.conf
	sed -i '/net.ipv4.ip_forward/d' /etc/sysctl.conf
	sed -i '/fs.inotify.max_user_instances/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_syncookies/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_fin_timeout/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_tw_reuse/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_max_syn_backlog/d' /etc/sysctl.conf
	sed -i '/net.ipv4.ip_local_port_range/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_max_tw_buckets/d' /etc/sysctl.conf
	sed -i '/net.ipv4.route.gc_timeout/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_synack_retries/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_syn_retries/d' /etc/sysctl.conf
	sed -i '/net.core.somaxconn/d' /etc/sysctl.conf
	sed -i '/net.core.netdev_max_backlog/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_timestamps/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_max_orphans/d' /etc/sysctl.conf
	clear
	echo -e "  \033[0;92mLa aceleración está Desinstalada."
	sleep 0.1
}

bbr(){
	while :
	do
	clear
	title "		ACELERACION BBR"
	blanco "	Esto activara la aceleracion\n	por defecto de su kernel.\n	no se modoficar nada del sistema."
	msg -bar
	col "1)" "Acivar aceleracion"
	col "2)" "quitar toda aceleracion"
	msg -bar
	col "0)" "volver"
	msg -bar
	blanco "opcion" 0
	read opcion
	case $opcion in
		1)
			remove_all
			echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
			echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
			sysctl -p
			echo -e "  \033[0;92m¡BBR comenzó con éxito!";;
		2)remove_all;;
		0)break;;
		*)blanco " seleccione una opcion" && sleep 0.2;;
	esac
	done
}

settings(){
	while :
	do
	clear
	msg -bar
	blanco "	  Ajustes e instalacion xray"
	msg -bar
	col "1)" "address"
	col "2)" "puerto"
	col "3)" "alterId"
	col "4)" "Host"
	col "5)" "Path"
	msg -bar
	col "6)" "certif ssl/tls (script)"
	col "7)" "certif menu nativo"
	col "8)" "certif ingreso manual"
	msg -bar
	col "9)" "protocolo menu nativo"
	col "10)" "conf xray menu nativo"
	col "11)" "restablecer ajustes"
	msg -bar
	col "12)" "BBR nativo del sistema"
	col "13)" "install/re-install xray"
	msg -bar
	col "14)" "Conf. Copias de Respaldos"
	msg -bar
	col "0)" "Volver"
	msg -bar
	blanco "opcion" 0
	read opcion

	[[ -z $opcion ]] && vacio && sleep 0.3 && break
	[[ $opcion = 0 ]] && break

	case $opcion in
		1)address;;
		2)port;;
		3)alterid;;
		4)host;;
		5)path;;
		6)domain_check && clear ;;
		7)xray_tls;;
		8)crt_man;;
		9)xray_stream;;
		10)xray_menu;;
		11)restablecer_v2r;;
		12)bbr;;
		13)install;;
		14)backups;;
		*) blanco " solo numeros de 0 a 14" && sleep 0.2;;
	esac
    done
}
enon(){
echo "source <(curl -sSL https://raw.githubusercontent.com/drowkid01/scriptcgh/main/Recursos/test/xray_manager.sh)" > /bin/xr.sh
chmod +x /bin/xr.sh
		clear
		msg -bar
		blanco " Se ha agregado un autoejecutor en el Sector de Inicios Rapidos"
		msg -bar
		blanco "	  Para Acceder al menu Rapido \n	     Utilize * xr.sh * !!!"
		msg -bar
		echo -e "		\033[4;31mNOTA importante\033[0m"
		echo -e " \033[0;31mSi deseas desabilitar esta opcion, apagala"
		echo -e " Y te recomiendo, no alterar nada en este menu, para"
		echo -e "             Evitar Errores Futuros"
		echo -e " y causar problemas en futuras instalaciones.\033[0m"
		msg -bar
		continuar
		read foo
}
enoff(){
rm -f $(which xr.sh)
		msg -bar
		echo -e "		\033[4;31mNOTA importante\033[0m"
		echo -e " \033[0;31mSe ha Desabilitado el menu Rapido de v2r.sh"
		echo -e " Y te recomiendo, no alterar nada en este menu, para"
		echo -e "             Evitar Errores Futuros"
		echo -e " y causar problemas en futuras instalaciones.\033[0m"
		msg -bar
		continuar
		read foo
}

enttrada () {

	while :
	do
	clear
	msg -bar
	blanco "	  Ajustes e Entrasda Rapida de Menu xray"
	msg -bar
	col "1)" "Habilitar xr.sh, Como entrada Rapida"
	col "2)" "Eliminar xr.sh, Como entrada Rapida"
	msg -bar
	col "0)" "Volver"
	msg -bar
	blanco "opcion" 0
	read opcion

	[[ -z $opcion ]] && vacio && sleep 0.3 && break
	[[ $opcion = 0 ]] && break

	case $opcion in
		1)enon;;
		2)enoff;;
		*) blanco " solo numeros de 0 a 2" && sleep 0.1;;
	esac
    done

}


main(){
	[[ ! -e $config ]] && {
		clear
		msg -bar
		blanco " No se encontro ningun archovo de configracion xray"
		msg -bar
		blanco "	  No instalo xray o esta usando\n	     una vercion diferente!!!"
		msg -bar
		echo -e "		\033[4;31mNOTA importante\033[0m"
		echo -e " \033[0;31mSi esta usando una vercion xray diferente"
		echo -e " y opta por cuntinuar usando este script."
		echo -e " Este puede; no funcionar correctamente"
		echo -e " y causar problemas en futuras instalaciones.\033[0m"
		msg -bar
		continuar
		read foo
	}
	while :
	do
		_usor=$(printf '%-8s' "$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')")
		_usop=$(printf '%-1s' "$(top -bn1 | awk '/Cpu/ { cpu = "" 100 - $8 "%" }; END { print cpu }')")
		[[ -e /bin/v2r.sh ]] && enrap="\033[1;92m[ON]" || enrap="\033[0;31m[OFF]"
		[[ -e /etc/xray/config.json ]] && _v2Reg="$(cat /etc/xray/config.json | jq .inbounds[].settings.clients[].email|wc -l)" || _v2Reg=0
		[[ -e /etc/xray/config.json.lock ]] && _v2LOCK="$(cat /etc/xray/config.json.lock|wc -l)" || _v2LOCK=0
		clear
		title2
		title "   Ram: \033[1;32m$_usor  \033[0;31m<<< \033[1;37mMENU xray \033[0;31m>>>  \033[1;37mCPU: \033[1;32m$_usop"
		col "1)" "CREAR USUARIO"
		col "2)" "\033[0;92mRENOVAR USUARIO"
		col "3)" "\033[0;31mREMOVER USUARIO"
		col "4)" "VER DATOS DE USUARIOS \033[1;32m ( ${_v2Reg} )"
		col "5)" "VER USUARIOS CONECTADOS"
		col "b)" "LOCK/UNLOCK USUARIOS \033[1;32m ( ${_v2LOCK} ) "
		msg -bar
		col "6)" "\033[1;33mAJUSTES XRAY $_v2"
		msg -bar
		col "7)" "\033[1;33mENTRAR CON \033[1;32mxr.sh $enrap"
		msg -bar
		col "8)" "SALIR \033[0;31m|| $(blanco "Respaldos automaticos") $(on_off_res)"
		msg -bar
		blanco "opcion" 0
		read opcion

		case $opcion in
			1) add_user;;
			2) renew;;
			3) dell_user;;
			4) view_user;;
			5) usrCONEC ;;
			6) settings;;
			7) enttrada;;
			b) _lo_un;;
			0) break;;
			*) blanco "\n selecione una opcion del 0 al 7" && sleep 0.1;;
		esac
	done
}

[[ $1 = "autoDel" ]] && {
	autoDel
} || {
	autoDel
	main
}
