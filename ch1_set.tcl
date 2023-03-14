source hmp4040.tcl
source ch1_settings.tcl
idn $ip $port
inst $channel $ip $port
supplyoff $ip $port
setvol $vol $ip $port
setcur $amp $ip $port
