source sleep.tcl
source hmp4040.tcl

idn $ip $port

setinst 1 $ip $port
getinst $ip $port
getvol $ip $port
getcur $ip $port
measvol $ip $port
meascur $ip $port
getoutp $ip $port
sleep 1

setinst 2 $ip $port
getinst $ip $port
getvol $ip $port
getcur $ip $port
measvol $ip $port
meascur $ip $port
getoutp $ip $port
sleep 1

setinst 3 $ip $port
getinst $ip $port
getvol $ip $port
getcur $ip $port
measvol $ip $port
meascur $ip $port
getoutp $ip $port
sleep 1

setinst 4 $ip $port
getinst $ip $port
getvol $ip $port
getcur $ip $port
measvol $ip $port
meascur $ip $port
getoutp $ip $port
