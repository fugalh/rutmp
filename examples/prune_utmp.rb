#!/usr/local/bin/ruby
require 'rutmp'
include Rutmp

new = []

def pid_exist?(pid)
    File.exist? "/proc/#{pid}"
end

setutent
while ut = getutent
    new << ut.dup if ut.ut_type != DEAD_PROCESS and (pid_exist?(ut.ut_pid) or ut.ut_type < INIT_PROCESS) 
end
endutent

tmp = `mktemp /tmp/utmp.XXXXXX`.strip
system "chmod 664 #{tmp}; chgrp utmp #{tmp}"
utmpname(tmp)
setutent
new.each {|ut| pututline(ut)}
endutent

system "mv #{tmp} /var/run/utmp"
