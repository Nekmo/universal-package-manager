#!/usr/bin/env bash
# UPM v0.1
BS=2048
UPM=http://...

if which upm > /dev/null; then
    upm -i "${BASH_SOURCE[0]}"
    exit 0
fi

detect_show_method(){
    if which kdialog > /dev/null; then
        show_mehod='kdialog'
    elif which zenity > /dev/null; then
        show_mehod='zenity'
    else
        show_mehod='cli'
    fi
}
if [ ! $show_mehod ]; then
    detect_show_method
fi

msgyesno(){
    if [ "$show_mehod" == 'kdialog' ]; then
        kdialog --title="$2" --yesno "$1"
        echo "$?"
    elif [ "$show_mehod" == 'kdialog' ]; then
        zenity --question --title="$2" --text "$1"
        echo "$?"
    else
        while true; do
            echo "$1"  1>&2
            read -p "[y/n] " resp
            resp=`echo $resp | tr '[:upper:]' '[:lower:]'`
            if [[ ${resp[0]} != "y" && ${resp[0]} != "n" ]]; then
                echo "[!!] Invalid response"  1>&2
            else
                if [[ ${resp[0]} == "y" ]]; then
                    resp="0"
                else
                    resp="1"
                fi
                break
            fi
        done
        if [ "$resp" == "0" ]; then
            echo ""
        else
            echo "1"
        fi
    fi
}

resp=$(msgyesno "Do yoy want to install a package manager to install this package easily?" "Install Universal Package Manager")

if [ $resp == "1" ]; then
    tofile="/tmp/"`date +%s`.sh
    wget $UPM_URL -O $tofile
    bash $tofile
else
    datasize=`stat -c%s "${BASH_SOURCE[0]}"` - $BS
    tail -c $datasize | tar xjv
fi