#!/bin/bash
# -*- coding: utf-8 -*-

#==============================================================================
# Titre            : scriptinstall.sh
# Description      : Script de configuration de Samba 4 comme AD
# Auteur           : MELONI Sébastien
# Date             : 27/03/2020
# Modification     : 29/03/2020
# Version          : 1.00
# Utilisation      : ./scriptinstall.sh
# Notes            : Ce script est destiné à être lancé par ansible pour
#                    la configuration de Samba 4.
# Version de bash  : 4.2.46
#==============================================================================

# Création de la clé et du certificat
openssl req -new -x509 -days 365 -nodes  -config ./monit.cnf \
            -out monit01.pem -keyout monit01.pem \
            -subj "/C=FR/ST=FRANCE/L=PARIS/O=Sccooperastux intl. CN=odin.raison.lan /emailAddress=monit@dsi.sccooperastux.lan"
            -batch

# Generates the  Diffie-Hellman Parameters
#openssl dhparam -2 2048 >> monit01.pem

# Set mode
chmod 600 monit01.pem

# Prints out the certificate information
#openssl x509 -text -noout -in monit01.pem

#========================== Partie Ansible ==================================
# Conversion du certificat.
openssl x509 -in certificat.crt -out certificat.pem -outform PEM

cat cleprivee.pem certificat.pem dhparam.pem > monit.pem
