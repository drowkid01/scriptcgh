#!/bin/bash
test "$(uname -m)" != 'armv7l'
	[[ $? != '0' ]] && patodir="." || patodir='/etc/patoscp'


declare -A sdir=( [sbin]="${patodir}/sbin" [0]="${patodir}" [tmp]="$patodir/tmp" )
declare -A sfile=( [src]="${sdir[bin]}/colores" [tmp]="${sdir[0]}/tmp.json" [ins]="${sdir[tmp]}/inst.log" )


init()
{
 if [[ $1 == '--check' ]]; then
	[[ ! -e ${sfile[src]} ]] && {
		[[ ! -d ${sdir[@]} ]] && echo -e "${sdir[@]}" | xargs mkdir
		wget -O ${sfile[src]} https://github.com/drowkid01/scriptcgh/raw/main/Recursos/test/colores &> /dev/null
		chmod 777 ${sfile[src]}
	}
    source ${sfile[src]}
	[[ ! -e ${sfile[ins]} ]] && {
		clear
		tittle 'INICIANDO INSTALACIÓN DE PAQUETES'

		for((a=0;a<${#soft[@]};a++));do
			msg -ama "INSTALANDO ==>> ${soft[$a]}"
			sleep 0.3
		done
	}
 fi
}

init --check
