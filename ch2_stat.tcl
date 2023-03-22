source hmp4040.tcl
source ch2_settings.tcl

idn $ip $port
setinst $channel $ip $port
getinst $ip $port
getvol $ip $port
getcur $ip $port
measvol $ip $port
meascur $ip $port
getoutp $ip $port
