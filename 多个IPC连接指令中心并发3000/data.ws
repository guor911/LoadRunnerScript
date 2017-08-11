;WSRData 2 1

send buf0 142
	"SKSOCKET 100001 01 20 <snn> 0001 0c23"
recv buf1 28

send buf2 142
    "SKSOCKET 100001 03 9 HEARTBEAT"

recv buf3 23

-1
