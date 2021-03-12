#!/usr/bin/tclsh

#-----------------------------------------
# fwpurge -- 1.00
# Utility to clear individual connections out of state table
# Created by Steven W. Balch Jr.
#-----------------------------------------

#-----------------------------------------
puts ""
puts "Starting FW Purge Process"
puts ""

set src [lindex $argv 0]
#-----------------------------------------

#-----------------------------------------
if {$src == ""} {
puts {}
puts { -- It looks like you are missing the source IP address -- }
puts {}
exit
                }
#-----------------------------------------

#-----------------------------------------
proc parsesrc {} {
global src srchex

set srcrw [split $src .]
set 1st [lindex $srcrw 0]
set 2nd [lindex $srcrw 1]
set 3rd [lindex $srcrw 2]
set 4th [lindex $srcrw 3]

#puts "$1st $2nd $3rd $4th"

set inhex1 [format %02X $1st]
set inhex2 [format %02X $2nd]
set inhex3 [format %02X $3rd]
set inhex4 [format %02X $4th]

set srchex "$inhex1$inhex2$inhex3$inhex4"

#puts $srchex
                 }
#-----------------------------------------

#-----------------------------------------
proc gettable {} {
global src srchex

set x 0

if [catch {set rtable [exec fw tab -t connections -u]} err] {
puts $err
} else {
#puts $rtable

set content [split $rtable \n]

puts "Searching connection table for IP address: $src = $srchex"

foreach line $content {

set liner1 [split $line >]
set liner2 [lindex $liner1 0]
set linerw [split $liner2 ,]
set k1r1 [lindex $linerw 0]
set k1r2 [string trimleft $k1r1 ?<?]
set k1 [string trim $k1r2 ]
set k2r [lindex $linerw 1]
set k2 [string trim $k2r ]
set k3r [lindex $linerw 2]
set k3 [string trim $k3r ]
set k4r [lindex $linerw 3]
set k4 [string trim $k4r ]
set k5r [lindex $linerw 4]
set k5 [string trim $k5r ]
set k6r1 [lindex $linerw 5]
set k6r2 [lappend k6r1 \;]
set k6r3 [split $k6r2 ;]
set k6r4 [lindex $k6r3 0]
set k6 [string trim $k6r4 \{\;\}]

#puts $k2

set keys "$k1,$k2,$k3,$k4,$k5,$k6"

if {[string compare -nocase $k2 $srchex] == 0} {
#puts "Found a match for IP Address: $src, $k2 = $srchex"
puts ""
#puts $keys
after 250
puts "Found a matching record of $k2, purging active connection tuple: $keys"
puts ""
exec fw tab -t connections -x -e $keys
incr x 1

} else {
#puts "Did not find a match for IP Address: $src"
       }
                      }
       }
puts "Total purged connections for $src: $x" 
                  }
#-----------------------------------------

#-----------------------------------------
parsesrc
gettable
#-----------------------------------------
puts ""
puts "Finished FW Purge Process"
#-----------------------------------------

