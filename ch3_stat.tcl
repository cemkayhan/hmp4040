source hmp4040.tcl
idn $ip $port

inst 2 $ip $port
getvol $ip $port
getcur $ip $port
measvol $ip $port
meascur $ip $port
status $ip $port