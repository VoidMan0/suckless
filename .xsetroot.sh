DATETIME=`date +"%D %T"`
UPTIME=`uptime -p | sed 's/.*ups*//'`
BATTERYSTATE=$( acpi -b | awk '{ split($5,a,":"); print substr($3,0,2), $4, "["a[1]":"a[2]"]" }' | tr -d ',' )
CPU=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}' )
MEMORY=$(free -m | grep '^Mem' | awk '{print "RAM: " $3 "MB/" $2"MB"}')
xsetroot -name "${MEMORY} | CPU: ${CPU}% | Uptime ${UPTIME} | ${DATETIME} | ${BATTERYSTATE}"
