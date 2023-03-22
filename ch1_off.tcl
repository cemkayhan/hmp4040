source hmp4040.tcl
source ch1_settings.tcl

idn $ip $port
setinst $channel $ip $port
getinst $ip $port
supplyoff $ip $port
