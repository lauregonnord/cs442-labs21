#!/bin/sh

# Script d'installation de Lustre
# Thierry Excoffier pour MIF25, juin 2016
# Modifié par Laure Gonnord pour CS444, sept 2021

###################################################
# Détermine les paquets à installer sur le système
###################################################

NEED=""
[ "$(which avr-gcc)" = "" ] && NEED="$NEED gcc-avr"
[ "$(which arduino)" = "" ] && NEED="$NEED arduino"
[ "$(which tclsh)"   = "" ] && NEED="$NEED tcl"
if [ "$NEED" != "" ]
then
    echo "Vous devez installer les paquets suivants :"
    echo "    apt-get install    $NEED"
    exit 1
fi >&2

set -e # Arrête le script en cas de problème



###################################################
# Installation de  LUSTRE
###################################################

# http://www-verimag.imag.fr/~raymond/?p=148
case "$1" in
    linux64) V="linux64/lustre-v4-XX-0-linux64" ;;
    macosx)  V="macosx/lustre-v4-III-c-macosx"    ;;
    *)
	echo "Indiquez comme paramètre: linux64 | macosx" >&2
	exit 1
esac

NOM="$(basename "$V")"
TGZ="https://www-verimag.imag.fr/DIST-TOOLS/SYNCHRONE/lustre-v4/distrib/$V.tgz"
if [ ! -d "$NOM" ]
then
    if [ ! -f "$NOM.tgz" ]
    then
	wget "$TGZ"
    fi
    zcat <"$NOM.tgz" | tar -xvf -
fi

###################################################
# Ajoute la commande wish si elle manque
###################################################

if [ "$(which wish)" = "" ]
then
    for I in tclsh8.5 tclsh8.6
    do
	J="$(which $I)"
	if  [ "$J" != "" ]
	then
	    ln -s "$J" "$NOM"/bin/wish || true
	    break
	fi
    done
fi

###################################################
# Configure l'environnement
###################################################

cd "$NOM"
export LUSTRE_INSTALL="$(pwd)"
. ./setenv.sh
cd ..
export PS1="###LUSTRE###$ "
echo "############################################################
Pour tester un exemple lustre :
   cd $LUSTRE_INSTALL/examples/minus # Lire le README pour avoir + d'infos
   # Vérifier si le programme Lustre respecte les contraintes
   lesar minus.lus minus -v          # minus.lus => minus.ec
   # Compile
   lustre minus.lus minus -v         # minus.lus => minus.ec minus.oc
   # Génère le code C (2 méthodes)
   poc minus.oc                      # minus.oc  => minus.c minus.h
   lus2c minus.lus minus -v          # minus.lus => minus.ec minus.c minus.h
   # Génère l'automate avec le moins d'état
   ocmin minus.oc -v                 # minus.oc  => minus_min.oc
   # Interaction graphique avec l'automate (la sortie ok est toujours vrai)
   luciole minus.ec
############################################################
Pour tester l'afficheur 7 led Arduino :
   cd $(pwd)/$TP_DIR/Arduino7seg
   make all upload
############################################################
Pour tester un exemple lustre/Arduino :
   cd $(pwd)/$TP_DIR/LustreExamples
   make demo
############################################################
Si vous quittez ce shell, vous quittez l'environnement LUSTRE
############################################################
"

exec /bin/bash --norc
