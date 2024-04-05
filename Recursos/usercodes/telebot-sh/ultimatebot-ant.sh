#!/bin/bash
apt-get install jq -y > /dev/null 2>&1

#169.254.125.161
#   Máscara de subred . . . . . . . . . . . . : 255.255.0.0

[[ -e ./liberados ]] && UsersID=$(cat ./liberados)

#VARIAVEL ENTRADA TOKEN
[[ "$1" = "" ]] && exit 1
if [[ "$2" != "" ]]; then
idioma="$2"
else
idioma="pt"
fi

#IMPORTANDO API
source ShellBot.sh

ShellBot.init --token "$1"
ShellBot.username
TOKEN=$1
#ARQUIVOS USADOS NA MESMA PASTA
#infousers / infousers-txt > informação usuarios
#onlines / onlines-txt > usuarios conectados
#criarusr / criarusr-txt > criar usuario
#userdelete  > deletar usuario infovps-txt

#IMPORTANDO TEXTOS
txt[1]="USUARIOS LIBERADOS EN EL BOT"
txt[2]=" Usuario"
txt[3]=" NO PUEDES USAR EL BOT"
txt[4]=" Comandos Bloqueados"
txt[5]=" EL ACCESO YA ESTÁ LIBERADO"
txt[6]=" ya estás liberado"
txt[7]=" "
txt[8]="NO PUEDE USAR ESTE BOT"
txt[9]="No tienes permiso para usar"
txt[10]="Tentativa de acesso negada!"
txt[11]="LANZAMIENTO REALIZADO CON ÉXITO!"
txt[12]="¡Ahora puedes administrar el bot!"
txt[13]="13¡Buen uso!"
txt[14]="INFORMACIÓN DEL SERVIDOR"
txt[15]="HOLA ADMIN, BIENVENIDO"
txt[16]=" SEA BIENVENIDO AL BOT"
txt[17]=" Aqui Esta a lista de Comandos Disponiveis!"
txt[18]=" COMANDOS"
txt[19]=" usuarios conectados"
txt[20]=" adicionar usuario"
txt[21]=" remover usuario"
txt[22]=" informacoes dos usuarios"
txt[23]=" informacao do servidor"
txt[24]=" usuarios liberados no bot"
txt[25]=" gerador de payload"
txt[26]=" libera o bot"
txt[27]=" Usuario Clave"
txt[28]=" comando nao foi executado"
txt[29]=" Usuario"
txt[30]=" Contraseña"
txt[31]=" Dias Restantes"
txt[32]=" Limite"
txt[33]=" Comando Reconocido"
txt[34]=" Usuario"
txt[35]=" Conexines"
txt[36]=" MODO DE USO"
txt[37]=" Usuario Senha Dias Limite"
txt[38]=" Exemplo"
txt[39]=" Usuario Nao Foi Criado"
txt[40]=" USUARIO CRIADO"
txt[41]=" Usuario"
txt[42]=" Senha"
txt[43]=" Duracao"
txt[44]=" Limite"
txt[45]=" MODO DE USO"
txt[46]=" Usuario"
txt[47]=" Ejemplo:"
txt[48]=" Usuario No Eliminado"
txt[49]=" Removido con exito!"
txt[50]=" MODO DE USO"
txt[51]=" Host Requisicao Conexao"
txt[52]=" Ejemplo"
txt[53]=" Metodos Requisicao"
txt[54]=" Metodos Conexao"
txt[55]=" PAYLOADS GENERADOS EXITOSAMENTE"
txt[56]=" PAYLOADS NO GENERADOS"
txt[57]=" Algo deu Errado"


call.mensaje () {
ID=$1
mensaje=$2
#--reply_to_message_id ${ID} 
[[ -z ${ID} ]] && return
		    ShellBot.sendMessage --chat_id ${ID} \
							--text "$(echo -e "${mensaje}")" \
							--parse_mode html
}

add_admin(){
IDadd="$1"
[[ -z $(cat ./liberados|grep ${IDadd}) ]] || {
local msg
          msg='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
          msg+="ACCESO YA ESTA ACTIVO\n"
          msg+='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
          msg+="EL ID DE REGISTRO NO AFECTADO\n"
          msg+='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
		call.mensaje "${message_chat_id[$id]}" "$msg"
return 0
}
# verificaruser "${usuario}:${senha}"
[[ $(cat ./liberados | head -1 | grep -w ${message_chat_id[$id]}) ]] && {
[[ ${#IDadd} -gt 6 ]] && {
[[ -e ./liberados ]] && echo "${IDadd}" >> ./liberados
local msg
          msg='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
          msg+="AUTORIZACION REALIZADA EXITOSAMENTE\n"
          msg+='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
          msg+=" YA PUEDES ADMINISTRAR ESTE BOT\n"
          msg+='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
          msg+=' Presiona /start \n'
          msg+='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
		ShellBot.sendMessage	--chat_id "${message_chat_id[$id]}" \
					--reply_to_message_id "${message_message_id[$id]}" \
					--text "<i>$(echo -e $msg)</i>" \
					--parse_mode html
		call.mensaje "${IDadd}" "$msg"
return 0
} 
} || { 
local msg
          msg='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
          msg+="NO TIENES AUTORIZACION\n"
          msg+='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
          msg+="   ACCESO DENEGADO\n"
          msg+="CONTACTA CON EL ADMIN\n"
          msg+='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
						ShellBot.sendMessage	--chat_id "${message_chat_id[$id]}" \
							--reply_to_message_id "${message_message_id[$id]}" \
							--text "<i>$(echo -e $msg)</i>" \
							--parse_mode html
return 0
}
}

#IDENTIFICA USUARIO USANDO
loguin_fun () {
local msg
          msg='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
          msg+="USUARIOS PERMITIDOS A USAR ESTE BOT\n"
          msg+='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
          msg+=" $(cat -n ./liberados) \n"
          msg+='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
		  call.mensaje "${message_chat_id[$id]}" "$msg"
return 0
}

blockfun () {
local msg
          msg='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
          msg+="NO PUEDES USAR EL BOT\n"
          msg+='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
          msg+="AUTORIZACION INVALIDA\n"
          msg+='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
	      ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
							--text "$(echo -e $msg)" \
							--parse_mode markdown
	return 0
}


verificaruser () {
base_de_dados="./bottokens"
if [[ $(cat $base_de_dados|head -1|awk '{print $1}') = "$1" ]]; then
return 0
 else
return 1
fi
}

ativarid () {
usuario="$1"
senha="$2"
usrid="$chatuser"
if [[ "$(cat ./liberados|grep "$usrid")" != "" ]]; then
local msg
          msg='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
          msg+="ACCESO AUTORIZADO CON EXITO\n"
          msg+='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
          msg+="Ahora ya puedes administrar\n"
          msg+="  - BUEN USO -\n"
          msg+='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
	      ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
							--text "$(echo -e $msg)" \
							--parse_mode markdown
return 0
fi
verificaruser "${usuario}:${senha}"
if [[ "$?" = "1" ]]; then
local msg
          msg='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
          msg+="NO TIENES AUTORIZACION\n"
          msg+='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
          msg+="   ACCESO DENEGADO\n"
          msg+="CONTACTA CON EL ADMIN\n"
          msg+='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
	      ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
							--text "$(echo -e $msg)" \
							--parse_mode markdown
return 0
else
[[ -e ./liberados  ]] && echo "$usrid" >> ./liberados || echo "$usrid" > ./liberados
local msg
          msg='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
          msg+="AUTORIZACION REALIZADA EXITOSAMENTE\n"
          msg+='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
          msg+=" YA PUEDES ADMINISTRAR ESTE BOT\n"
          msg+='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
	      ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
							--text "$(echo -e $msg)" \
							--parse_mode markdown
return 0
fi
}

infovps () {
bash ./bot_codes infovps
local msg
          msg='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
          msg+=" - HOLA ADMIN - \n"
          msg+='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
          msg+=' $(cat ./infovps-txt) \n'
          msg+='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
#          while read line; do
#          [[ "$line" = "" ]] && break
#          msg+="$line\n"
#          done < ./infovps-txt
#          msg+='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
	      ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
							--text "$(echo -e $msg)" \
							--parse_mode html
	return 0
}

infoporta () {
#echo "DISEÑANDO MENSAJES!"
bash ./bot_codes ports_
local msg
          msg='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
          msg+=" LISTA DE PUERTAS ACTIVAS EN VPS\n"
          msg+='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
          while read line; do
          [[ "$line" = "" ]] && break
          msg+="$line\n"
          done < ./textoports
          msg+='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
	      ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
							--text "$(echo -e $msg)" \
							--parse_mode markdown
	return 0
}


ajuda_fun () {
chatuser="${message_chat_id[$id]}"
_ADMIN=$(cat ./liberados | grep -w ${chatuser})
[[ -z $(cat ./liberados | grep -w ${chatuser}) ]] && msg=" BIENVENIDO USUARIO \n" || msg=" BIENVENIDO ADMIN @${callback_query_from_username}\n"
		msg+='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
		msg+=" 😀  <b>MENU DE ACCIONES RAPIDAS</b> 😀\n"
		msg+='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
msg+="COMANDOS DISPONIBLES \n"
[[ -z ${_ADMIN} ]] || msg+="/agregar ( AGREGAR USUARIO )\n"
[[ -z ${_ADMIN} ]] || msg+="/usuarios ( MUESTRA USUARIOS REGISTRADOS )\n"
[[ -z ${_ADMIN} ]] || msg+="/conectados ( MUESTRA USUARIOS CONECTADOS)\n"
[[ -z ${_ADMIN} ]] || msg+="/borrar ( ELIMINAR USUARIO SSH)\n"
[[ -z ${_ADMIN} ]] || msg+="/v2ray ( AGREGAR USUARIO V2RAY )\n"
[[ -z ${_ADMIN} ]] || msg+="/puertos ( PUERTOS ACTIVOS EN VPS )\n"
[[ -z ${_ADMIN} ]] || msg+="/infovps ( INFORMACION DEL VPS )\n"
[[ -z ${_ADMIN} ]] || msg+="/liberados ( USUARIOS LIBERADOS POR EL BOT )\n"
[[ -z ${_ADMIN} ]] || msg+="/gerar (${txt[25]})\n"
[[ -z ${_ADMIN} ]] && msg+="/access LIBERAR ACCESO ( /access user pass )\n"
[[ $(cat ./liberados | head -1 | grep -w ${chatuser} ) ]] && msg+="/aggADM AGREGAR ADMIN ( /aggADM 19283764 )\n"
        msg+='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
				ShellBot.sendMessage	--chat_id "${message_chat_id[$id]}" \
									--reply_to_message_id "${message_message_id[$id]}" \
									--text "<i>$(echo -e $msg)</i>" \
									--parse_mode html
	return 0	
}

info_fun () {
bash ./bot_codes infousers
if [ "$?" = "1" ]; then
local msg
          msg='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
          msg+="${txt[28]}\n"
          msg+='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'   
				ShellBot.sendMessage	--chat_id "${message_chat_id[$id]}" \
							--reply_to_message_id "${message_message_id[$id]}" \
							--text "<i>$(echo -e $msg)</i>" \
							--parse_mode html
	return 0
else
    local msg
	msg=' =================================== \n'
	cont=1
    while read lines; do
    [[ -z ${lines} ]] && break
          user=$(echo "$lines" | awk '{print $1}')
          sen=$(echo "$lines" | awk '{print $2}')
          limit=$(echo "$lines" | awk '{print $3}')
          data=$(echo "$lines" | awk '{print $4}')
          msg+=" USER (${cont}) : $user\n"
          msg+=" PASSWD : $sen\n"
          msg+=" EXPIRA : $data\n"
          msg+=" LIMITE : $limit\n"
          msg+=' =================================== \n'
		  let cont++;
    done < ./infousers-txt
			ShellBot.sendMessage	--chat_id "${message_chat_id[$id]}" \
							--reply_to_message_id "${message_message_id[$id]}" \
							--text "<i>$(echo -e $msg)</i>" \
							--parse_mode html
    return 0
fi
}

online_fun () {
bash ./bot_codes onlines
if [ "$?" = "1" ]; then
local msg
         msg='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
         msg+="${txt[33]}\n"
         msg+='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'   
         ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
							--text "$(echo -e $msg)" \
							--parse_mode markdown
	return 0
else
local msg
unset msg
while read lines; do
[[ "$lines" = "" ]] && break
          user=$(echo "$lines" | awk '{print $1}')
          conex=$(echo "$lines" | awk '{print $2}')
          msg+=' -----------------------\n'
          msg+=" USER : $user\n"
          msg+=" CONEXIONES : $conex\n"
          msg+=' ----------------------- \n'   
done < ./onlines-txt
				ShellBot.sendMessage	--chat_id "${message_chat_id[$id]}" \
									--reply_to_message_id "${message_message_id[$id]}" \
									--text "<i>$(echo -e $msg)</i>" \
									--parse_mode html
    return 0
fi
}

usv2link () {
[[ ! -z $1 ]] && v2link=$1
[[ ! -z $2 ]] && Img=$2
[[ ! -z $3 ]] && usr=$3

		  ShellBot.sendDocument --chat_id ${message_chat_id[$id]} \
                             --document @${Img} \
                             --caption  "$(echo -e "<code>$v2link</code> ")" \
							 --parse_mode html 


}

useradd_fun () {
[[ "$1" = "" ]] && exec="error"
[[ "$2" = "" ]] && exec="error"
[[ "$3" = "" ]] && exec="error"
[[ "$4" = "" ]] && exec="error"
if [ "$exec" = "error" ]; then
local msg
         msg='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
         msg+=" FORMA DE USAR ESTA OPC\n"
         msg+='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
		 msg+=" DEBES ENVIAR EL COMANDO \n /agregar Nombre_User Clave Tiempo Limite\n"
		 msg+="▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n"
         msg+='agregar admin admin 30 1\n'
         msg+='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
						ShellBot.sendMessage	--chat_id "${message_chat_id[$id]}" \
									--reply_to_message_id "${message_message_id[$id]}" \
									--text "<i>$(echo -e $msg)</i>" \
									--parse_mode html
   return 0
fi
bash ./bot_codes criarusr "$1" "$2" "$3" "$4"
if [ "$?" = "1" ]; then
local msg
         msg='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
         msg+=" ERROR INTERNO RETURN 0x0012\n"
         msg+='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'   
         ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
							--text "$(echo -e $msg)" \
							--parse_mode markdown
return 0
else
while read lines; do
[[ "$lines" = "" ]] && break
bash ./bot_codes ports_
local msg
          usr=$(echo "$lines" | awk '{print $1}')
          sen=$(echo "$lines"  | awk '{print $2}')
          dia=$(echo "$lines" | awk '{print $3}')
          limit=$(echo "$lines" | awk '{print $4}')
          msg='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
		  while read line; do
          [[ "$line" = "" ]] && break
          msg+="$line\n"
          done < ./textoports
          msg+='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
          msg+="Host/IP-Address : <pre>$(wget -qO- ifconfig.me)</pre>\n"
          msg+="USUARIO : <code>$usr</code>\n"
          msg+="PASSWD  : <code>$sen</code>\n"
          msg+="DURACION: $dia\n"
          msg+="LIMITE  : $limit\n"
          msg+='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
[[ -e /etc/adm-lite/slow/dnsi/domain_ns ]] && msg+=" DOMINIO NS : <code>$(cat < /etc/adm-lite/slow/dnsi/domain_ns)</code> \n"
[[ -e /etc/adm-lite/slow/dnsi/server.pub ]] && msg+=" KEY PUBLIC : <code>$(cat < /etc/adm-lite/slow/dnsi/server.pub)</code> \n"
[[ -e /etc/adm-lite/slow/dnsi/protc && -e /etc/adm-lite/slow/dnsi/puerto ]] && msg+="PROTOCOLO : $(cat < /etc/adm-lite/slow/dnsi/protc) -> <code>$(cat < /etc/adm-lite/slow/dnsi/puerto)</code> \n"
		  msg+='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
		  #URG="https://api.telegram.org/bot$TOKEN/sendPhoto"
		  #curl -s -X POST $URG -F chat_id=${message_chat_id[$id]} -F photo="@${Img}"
						ShellBot.sendMessage	--chat_id "${message_chat_id[$id]}" \
									--reply_to_message_id "${message_message_id[$id]}" \
									--text "<i>$(echo -e $msg)</i>" \
									--parse_mode html
		  unset msg
done < ./criarusr-txt
return 0
fi
}

userdell_fun () {
[[ "$1" = "" ]] && exec="error"
if [ "$exec" = "error" ]; then
local msg
         msg='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
         msg+="${txt[45]}\n"
         msg+='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
		 msg+=" DEBES ENVIAR EL COMANDO \n borrar Nombre_User\n"
		 msg+="▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n"
         msg+='borrar USUARIO\n'
         msg+='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
	     				ShellBot.sendMessage	--chat_id "${message_chat_id[$id]}" \
									--reply_to_message_id "${message_message_id[$id]}" \
									--text "<i>$(echo -e $msg)</i>" \
									--parse_mode html
   return 0
fi
bash ./bot_codes userdelete "$1"
if [ "$?" = "1" ]; then
local msg
          msg='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
          msg+=" ERROR INTERNO RETURN 0x0012\n"
          msg+='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'   
          				ShellBot.sendMessage	--chat_id "${message_chat_id[$id]}" \
									--reply_to_message_id "${message_message_id[$id]}" \
									--text "<i>$(echo -e $msg)</i>" \
									--parse_mode html
return 0
else
local msg
          msg='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
          msg+=" USUARIO ELIMINADO EXITOSAMENTE \n"
          msg+='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'   
          				ShellBot.sendMessage	--chat_id "${message_chat_id[$id]}" \
									--reply_to_message_id "${message_message_id[$id]}" \
									--text "<i>$(echo -e $msg)</i>" \
									--parse_mode html
return 0
fi
}

price () {
local msg
          msg=' --------------------------------------------------\n'
          msg+="|       [•] @drowkid01 [•]       |\n"
		  msg+='-------------------------------------------------\n' 
          msg+=' $1.50 USD - Acceso ilimitado al BOT 15 dias \n'   
		  msg+=' $3.00 USD - Acceso ilimitado al BOT 120 dias\n' 
		  msg+=' $5.00 USD - Acceso ilimitado al BOT 180 dias\n' 
		  msg+=' $8.00 USD - Acceso ilimitado al BOT 365 dias\n' 
		  msg+='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n' 
		  msg+=" Recuerda que con el Bot Premium tienes acceso Ilimitado \n Incluyendo tu reseller en la Key! \n Soporte, Actualizaciones y MAS!!)\n"
		  msg+='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'  
          ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
							--text "$(echo -e $msg)" \
							--parse_mode markdown
return 0
}

_v2fun() {
usr="$1"
_day="$2"
[[ "$1" = "" ]] && exec="error"
[[ "$2" = "" ]] && exec="error"
if [ "$exec" = "error" ]; then
local msg
         msg='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
         msg+="${txt[36]}\n"
         msg+='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
		 msg+=" DEBES ENVIAR EL COMANDO \n v2ray Nombre_User Tiempo\n"
		 msg+="▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n"
         msg+='v2ray nameUSER 30 \n'
         msg+='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
         				ShellBot.sendMessage	--chat_id "${message_chat_id[$id]}" \
									--reply_to_message_id "${message_message_id[$id]}" \
									--text "<i>$(echo -e $msg)</i>" \
									--parse_mode html
   return 0
fi
[[ $_day < 1 ]] && _day='1'
bash ./bot_codes v2r_ "${usr}" "${_day}" 
if [ "$?" = "1" ]; then
local msg
         msg='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
         msg+="USUARIO V2RAY NO CREADO\n"
         msg+='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'   
         				ShellBot.sendMessage	--chat_id "${message_chat_id[$id]}" \
									--reply_to_message_id "${message_message_id[$id]}" \
									--text "<i>$(echo -e $msg)</i>" \
									--parse_mode html
return 0
else
local msg
		  v2link=$(cat < /bin/ejecutar/${usr}_vmess.txt)
          msg='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
		  #[[ -e /var/www/html/${usr}_vmess_qr.png ]] && valid=$(date '+%C%y-%m-%d' -d " +$daysrnf days")
		  [[ -e /var/www/html/${usr}_vmess_qr.png ]] && datexp=$(date "+%d/%m/%Y" -d " +$_day days")
          msg+=" USUARIO : ${usr}\n"
          msg+=" EXPIRA  : ${datexp}\n"
          #done < ./textoports
		  msg+='• 𝄘𝄘𝄘𝄘𝄘𝄘 URL VMESS 𝄘𝄘𝄘𝄘𝄘 •\n'  
          msg+="<pre>${v2link}</pre> \n"
		  [[ -e /var/www/html/${usr}_vmess_qr.png ]] && msg+=" http://$(wget -qO- ifconfig.me):81/${usr}_vmess_qr.png \n"
		  msg+='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'  
		  				ShellBot.sendMessage	--chat_id "${message_chat_id[$id]}" \
									--reply_to_message_id "${message_message_id[$id]}" \
									--text "<i>$(echo -e $msg)</i>" \
									--parse_mode html
		  unset msg
return 0
fi
}


paygen_fun () {
[[ "$1" = "" ]] && fail="0"
[[ "$2" = "" ]] && fail="0"
[[ "$3" = "" ]] && fail="0"
if [[ "$fail" = "0" ]]; then
local msg
          msg+='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
          msg+="${txt[50]}:\n"
          msg+="/gerar ${txt[51]}\n"
          msg+="${txt[52]}:\n"
          msg+="/gerar claro.com 1/9 1/3\n"
          msg+="${txt[53]}\n1-GET, 2-CONNECT, 3-PUT, 4-OPTIONS, 5-DELETE, 6-HEAD, 7-TRACE, 8-PROPATCH, 9-PATCH\n"
          msg+="${txt[54]}\n1-REALDATA, 2-NETDATA, 3-RAW\n"
          msg+='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'  
          ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
							--text "$(echo -e $msg)" \
							--parse_mode markdown
		  unset msg
return 0
fi
host="$1"
req="$2"
conex="$3"
bash ./bot_codes paygen "$host" "$req" "$conex"
if [ "$?" = "0" ]; then
local msg
          msg+='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
          msg+="${txt[55]}\n"
          msg+='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'  
          ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
							--text "$(echo -e $msg)" \
							--parse_mode markdown
local msg2
          ShellBot.sendDocument --chat_id ${message_chat_id[$id]} \
                             --document @$HOME/payloads.txt
return 0                           
else
local msg
          msg+='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'
          msg+="${txt[56]}\n"
          msg+="${txt[57]}\n"
          msg+='▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n'  
          ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
							--text "$(echo -e $msg)" \
							--parse_mode markdown
return 0
fi
}

fun_chat () {
	   (	
	    chatuser="${message_chat_id[$id]}"
	    comando=(${message_text[$id]})
		[[ "${comando[0]}" = @(/teste|teste) ]] && teste
		[[ "${comando[0]}" = @(/ajuda|ajuda|help|/help|/menu) ]] && ajuda_fun
		[[ "${comando[0]}" = @(/start|start|comecar|/comecar) ]] && ajuda_fun
		[[ "${comando[0]}" = @(/access|access|loguin|/loguin) ]] && ativarid "${comando[1]}" "${comando[2]}" "$chatuser"
        if [[ "$(cat ./liberados|grep "$chatuser")" != "" ]]; then
        [[ "${comando[0]}" = @(activos|/activos|conectados|/conectados) ]] && online_fun
		[[ "${comando[0]}" = @(/puertos|puertos) ]] && infoporta
        [[ "${comando[0]}" = @(agregar|/agregar|add|/add) ]] && useradd_fun "${comando[1]}" "${comando[2]}" "${comando[3]}" "${comando[4]}"
        [[ "${comando[0]}" = @(v2ray|/v2ray|addv2|/addv2) ]] && _v2fun "${comando[1]}" "${comando[2]}" "${comando[3]}"
        [[ "${comando[0]}" = @(borrar|/borrar|dell|/dell) ]] && userdell_fun "${comando[1]}"
        [[ "${comando[0]}" = @(usuarios|/usuarios) ]] && info_fun
        [[ "${comando[0]}" = @(infovps|/infovps) ]] && infovps
        [[ "${comando[0]}" = @(gerar|/gerar|pay|/pay) ]] && paygen_fun "${comando[1]}" "${comando[2]}" "${comando[3]}"
        [[ "${comando[0]}" = @(liberados|/liberados|libres|/libres) ]] && loguin_fun 
        [[ "${comando[0]}" = @(aggADM|/aggADM) ]] && add_admin "${comando[1]}" "${comando[2]}" "${comando[3]}"
		[[ "${comando[0]}" = @(precios|/precios) ]] && price
        else
        [[ "${comando[0]}" != "" ]] && blockfun
        fi
        ) &
}

[[ ! -e ./liberados ]] && touch ./liberados
while :
do
	ShellBot.getUpdates --limit 100 --offset $(ShellBot.OffsetNext) --timeout 30
	for id in $(ShellBot.ListUpdates); do
	  case ${message_text[$id]} in
			*)
				:
			fun_chat
			;;
	        esac
	done
done
