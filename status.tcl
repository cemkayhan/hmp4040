source sleep.tcl
source hmp4040.tcl
idn $ip $port

inst 1 $ip $port
getvol $ip $port
getcur $ip $port
measvol $ip $port
meascur $ip $port
status $ip $port
sleep 1

inst 2 $ip $port
getvol $ip $port
getcur $ip $port
measvol $ip $port
meascur $ip $port
status $ip $port
sleep 1

inst 3 $ip $port
getvol $ip $port
getcur $ip $port
measvol $ip $port
meascur $ip $port
status $ip $port
sleep 1

inst 4 $ip $port
getvol $ip $port
getcur $ip $port
measvol $ip $port
meascur $ip $port
status $ip $port
