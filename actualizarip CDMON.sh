#!/bin/bash
USUARIO= #usuario asignado a dominio a actualizar
PASSMD5= #password de usuario asignado a dominio
HOST= #dominio a verificar
IP_DNS_ONLINE=$(host $HOST dinamic1.cdmon.net | grep -m1 $HOST | awk {'print $4'})
IP_ACTUAL="$(wget -qO- ifconfig.me/ip)"
if [ "$IP_ACTUAL" ]; then
	if [ "$IP_DNS_ONLINE" != "$IP_ACTUAL" ]; then
			CHANGE_IP="https://dinamico.cdmon.org/onlineService.php?enctype=MD5&n=$USUARIO&p=$PASSMD5"
			RESULTADO=`wget $CHANGE_IP -o /dev/null -O /dev/stdout --no-check-certificate`
			echo "Se han realizado cambios de IP en los servidores DNS de CDMON :"
			echo  "IP Anterior en CDMON = $IP_DNS_ONLINE"  
			echo  "IP Actual = $IP_ACTUAL  (Actualizada)" 
			#echo $RESULTADO
		else 
echo -e "La Direccion IP no a cambiado en CDMON: \n IP CDMON: $IP_DNS_ONLINE \n IP Actual $IP_ACTUAL"
fi
fi
