package require http

####################################################################################################################
set ip 10.230.1.62
set port 5025
set http_port 117
set image_viewer {~/pqiv/pqiv -i}

set url "http://$ip/crt_print.bmp?lang=en&update=Update"
set headers [list Accept {text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8} \
Accept-Language {en-US,tr-TR;q=0.8,tr;q=0.5,en;q=0.3} \
Connection {keep-alive} \
Referer "http://$ip/scrdata.htm?lang=en" \
Upgrade-Insecure-Requests 1 \
User-Agent {Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101 Firefox/102.0}]
####################################################################################################################

proc connect {sd ip port} {
  upvar $sd localsd
  set localsd [socket $ip $port]
  fconfigure $localsd -buffering line -eofchar {\n}
}

proc idn {ip port} {
  connect sd $ip $port
  puts $sd {*IDN?}; flush $sd
  puts [read $sd]
  close $sd
}

proc getinst {ip port} {
  connect sd $ip $port
  puts $sd {INST?}; flush $sd
  puts [read $sd]
  close $sd
}

proc setinst {ch ip port} {
  connect sd $ip $port
  puts $sd "INST OUT$ch"; flush $sd
  close $sd
}

proc getvol {ip port} {
  connect sd $ip $port
  puts $sd {VOLT?}
  puts "[read $sd] Volt"
  close $sd
}

proc setvol {vol ip port} {
  connect sd $ip $port
  puts $sd "VOLT $vol"
  close $sd
}

proc measvol {ip port} {
  connect sd $ip $port
  puts $sd {MEAS:VOLT?}
  puts "[read $sd] Volt"
  close $sd
}

proc setcur {amp ip port} {
  connect sd $ip $port
  puts $sd "CURR $amp"
  close $sd
}

proc getcur {ip port} {
  connect sd $ip $port
  puts $sd {CURR?}
  puts "[read $sd] Amper"
  close $sd
}

proc meascur {ip port} {
  connect sd $ip $port
  puts $sd {MEAS:CURR?}
  puts "[read $sd] Amper"
  close $sd
}

proc getoutp {ip port} {
  connect sd $ip $port
  puts $sd {OUTP?}; flush $sd
  puts [read $sd]
  close $sd
}

proc setoutp {onoff ip port} {
  connect sd $ip $port
  puts $sd "OUTP $onoff"; flush $sd
  close $sd
}

proc supplyoff {ip port} {
  setoutp 0 $ip $port
  getoutp $ip $port
}

proc supplyon {ip port} {
  setoutp 1 $ip $port
  getoutp $ip $port
}

proc screenshot {ip url headers} {
  global image_viewer
  global http_port

  set bmp hmp4040.bmp
  set outchan [open $bmp w]
  ::http::register http $http_port socket
  set token [http::geturl $url -headers $headers -channel $outchan]
  close $outchan
  exec {*}[list {*}$image_viewer $bmp]
}
