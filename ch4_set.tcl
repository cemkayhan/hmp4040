source hmp4040.tcl
source ch4_settings.tcl

idn $ip $port
setinst $channel $ip $port
getinst $ip $port
supplyoff $ip $port
setvol $vol $ip $port
getvol $ip $port
setcur $amp $ip $port
getcur $ip $port
