###edit the following
service=Runner
email=nmajumda@domain.com
###stop editing

host=`hostname -f`
if (( $(ps -ef | grep -v grep | grep $service | wc -l) > 0 )); then
echo "$service is running"
else
rm /w/apps/domains/dmsstg/deploy/applications/dmsPubAgtApp/$HOSTNAME.pid
cd /w/apps/domains/dmsstg/deploy/applications/dmsPubAgtApp/
sh runAgent.sh start
if (( $(ps -ef | grep -v grep | grep $service | wc -l) > 0 ))
then
subject="$service at $host has been started"
echo "$service at $host wasn't running and has been started" | mailx -s "$subject" $email
else
subject="$service at $host is not running"
echo "$service at $host is stopped and cannot be started!!!" | mailx -s "$subject" $email
fi
fi
