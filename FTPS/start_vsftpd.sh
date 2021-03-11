#!/bin/sh
rc-update add vsftpd default
openrc boot
rc-service vsftpd start
sleep infinity & wait