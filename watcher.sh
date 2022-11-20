#!/bin/bash
# Skript, um Websites runterzuladen und Hashwert abzuspeichern
# Aufruf <skriptname> <website-url>
#set -x
# ------------ VARIABLEN --------------
WEBSITE=$1
FILE=${WEBSITE}

# ------------  PFADE ---------------
CFGFILE="watcher.cfg"
WATCHFILES=""
WORKDIR="work/"

# ------------  UMGEBUNG EINRICHTEN  ---------------
WEBSITE=$(echo "${WEBSITE}" | tr -d ' ')
if [ "${WEBSITE}" == "" ]; then
  echo "Falscher Aufruf! Argument <url> fehlt"
  exit 1
fi

# Filename skripten
for ARG in $(cat ${CFGFILE})
do
#	echo "$ARG"
	FILE=$(echo "${FILE}" | tr -d $ARG )
done

# ------------ ---------------
# download
wget ${WEBSITE} -q -O ${WORKDIR}${FILE}
# hashwert ermitteln
HASH=$(sha256sum ${WORKDIR}${FILE})
# download loeschen
rm ${WORKDIR}${FILE}
#echo $HASH
# In File speichern
echo $HASH >> ${WATCHFILES}${FILE}.watch

# ------------ ---------------
# letzte beiden Zeilen vergleichen, wenn beide existieren
[ "$(tail -2 ${WATCHFILES}${FILE}.watch | head -1 | cut -d' ' -f1)" != "$(tail -1 ${WATCHFILES}${FILE}.watch | cut -d' ' -f1)" ] && {
	echo "Es gab Aenderungen auf ${WEBSITE} seit der letzen Pruefung!"
}
