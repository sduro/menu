#!/bin/bash
#init

function action_1(){
    dialog --backtitle "Resultado" --clear --msgbox "${1}"
    pause 3
}

#Funcion de pause con paso de parametros
function  action_2(){
 read -t $1 -p "I am going to wait for $1 seconds only ..."
}

#Despertar PC Lan
function action_3(){
    echo "WOL wake up"
    sudo wakeonlan xx:yy:zz:mm:nn
    pause 3
    menu.sh
}

#Conectar con Revo y al volver arrancar menu otra vez
function action_4(){
    menu.sh
}

function action_5(){
    echo "Suspender Revo"
    ssh -t user@192.168.1.31 "sudo pm-suspend"
}

# Creamos la varaible action en la que almacenamos la 
# orden dialog con la opción --separate-output
action=(dialog --menu "Opciones:" 10 35 0 \
    1 "action_1" \
    2 "action_2" \
    3 "action_3 " \
    4 "action_4" \
    5 "action_5")

# Creamos la funcion selecciones que ejecuta funcheck con opciones 
# y reenvia la salida al terminal para que el for siguiente ejecute
# los comandos
selecciones=$("${action[@]}" 2>&1 >/dev/tty)

# limpiamos la pantalla
clear

# añadimos un for para que ejecute un comando en función de 
# las selecciones realizadas puedes cambiar el echo por 
# cualquier comando o secuencias de comandos
for seleccion in $selecciones
do
 case $seleccion in
 1)
 action_1
 ;;
 2)
 #conectar SSH Revo
action_2
 ;;
 3)
 #connectar SSH KODI
action_3
 ;;
 4)
action_4
 ;;
 5)
action_5
  esac
done
