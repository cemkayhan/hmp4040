package require http

####################################################################################################################
set ip 10.230.1.62
set port 5025

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
  puts $sd {*IDN?}
  puts [read $sd]
  close $sd
}

proc inst {ch ip port} {
  connect sd $ip $port
  puts $sd "INST OUT$ch"
  puts $sd {INST?}
  puts [read $sd]
  close $sd
}

proc setvol {vol ip port} {
  connect sd $ip $port
  puts $sd "VOLT $vol"
  puts $sd {VOLT?}
  puts "[read $sd] Volt"
  close $sd
}

proc setcur {amp ip port} {
  connect sd $ip $port
  puts $sd "CURR $amp"
  puts $sd {CURR?}
  puts "[read $sd] Amper"
  close $sd
}

proc supplyon {ip port} {
  connect sd $ip $port
  puts $sd {OUTP:SEL 1}
  puts $sd {OUTP?}
  puts [read $sd]
  close $sd
}

proc supplyoff {ip port} {
  connect sd $ip $port
  puts $sd {OUTP:SEL 0}
  puts $sd {OUTP?}
  puts [read $sd]
  close $sd
}

proc status {ip port} {
  connect sd $ip $port
  puts $sd {OUTP?}
  puts [read $sd]
  close $sd
}

proc screenshot {ip url headers} {
  set bmp hmp4040.bmp 
  set outchan [open $bmp w]
  ::http::register http 117 socket
  set token [http::geturl $url -headers $headers -channel $outchan]
  close $outchan
  exec {*}[list feh $bmp]
}
