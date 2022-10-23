# fwpurge
Check Point utility to clear individual connections out of kernel state table. This utility makes it easier to remove connections out of the state table leveraging an IP address instead of a tuple.

## Supported Sites:
github.com

## Usage:

*Run the fwpurge.tcl script to clear individual connections out of the state table.*

  `./fwpurge.tcl <ip address>`

### Extra Information:
*The connections table is stored in the following format:*

<direction,5-tuple-key;r_ctype,r_cflags,rule,service_id,handler,uuid1,uuid2,uuid3,uuid4,ifncin,ifncout,ifnsin,ifnsout,bits1,bits2,connection_module_kbufs@ttl/timeout>

*Example:*
<0,a2524aa2,748,455aec19,50,6;1c001,46080,20e,1e1,0,42b04f5e,31,2ca8c0,7b6,1,1,2,2,b341,0,0,0,0,0,0,86dbb006,0,0,0,dfb31006,0,0,0@0/25>

