source sleep.tcl
package require http

####################################################################################################################
set ip 10.253.1.55
set port 5025
set http_port 80
set image_viewer {pqiv -i}

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
  fconfigure $localsd -buffersize 10000000 -buffering line -blocking 0 -eofchar {\n}
}

proc myread {sd} {
  set tmp {}
  while {![eof $sd]} {
    append tmp [read $sd]
  }
  return $tmp
}

proc mysend {sd str} {
  puts $sd $str; flush $sd; sleep 1
}

proc idn {ip port} {
  connect sd $ip $port
  mysend $sd {*IDN?}
  puts [myread $sd]
  close $sd
}

proc getinst {ip port} {
  connect sd $ip $port
  mysend $sd {INST?}
  puts [myread $sd]
  close $sd
}

proc setinst {ch ip port} {
  connect sd $ip $port
  mysend $sd "INST OUT$ch"
  close $sd
}

proc getvol {ip port} {
  connect sd $ip $port
  mysend $sd {VOLT?}
  puts "[myread $sd] Volt"
  close $sd
}

proc setvol {vol ip port} {
  connect sd $ip $port
  mysend $sd "VOLT $vol"
  close $sd
}

proc measvol {ip port} {
  connect sd $ip $port
  mysend $sd {MEAS:VOLT?}
  puts "[myread $sd] Volt"
  close $sd
}

proc setcur {amp ip port} {
  connect sd $ip $port
  mysend $sd "CURR $amp"
  close $sd
}

proc getcur {ip port} {
  connect sd $ip $port
  mysend $sd {CURR?}
  puts "[myread $sd] Amper"
  close $sd
}

proc meascur {ip port} {
  connect sd $ip $port
  mysend $sd {MEAS:CURR?}
  puts "[myread $sd] Amper"
  close $sd
}

proc getoutp {ip port} {
  connect sd $ip $port
  mysend $sd {OUTP?}
  puts [myread $sd]
  close $sd
}

proc setoutp {onoff ip port} {
  connect sd $ip $port
  mysend $sd "OUTP $onoff"
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
