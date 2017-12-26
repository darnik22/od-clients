# Config file for collectd(1).
#
# Some plugins need additional configuration and are disabled by default.
# Please read collectd.conf(5) for details.
#
# You should also read /usr/share/doc/collectd-core/README.Debian.plugins
# before enabling any more plugins.

##############################################################################
# Global                                                                     #
#----------------------------------------------------------------------------#
# Global settings for the daemon.                                            #
##############################################################################

#Hostname "localhost"
FQDNLookup true
#BaseDir "/var/lib/collectd"
#PluginDir "/usr/lib/collectd"
#TypesDB "/usr/share/collectd/types.db" "/etc/collectd/my_types.db"

#----------------------------------------------------------------------------#
# When enabled, plugins are loaded automatically with the default options    #
# when an appropriate <Plugin ...> block is encountered.                     #
# Disabled by default.                                                       #
#----------------------------------------------------------------------------#
#AutoLoadPlugin false

#----------------------------------------------------------------------------#
# When enabled, internal statistics are collected, using "collectd" as the   #
# plugin name.                                                               #
# Disabled by default.                                                       #
#----------------------------------------------------------------------------#
#CollectInternalStats false

#----------------------------------------------------------------------------#
# Interval at which to query values. This may be overwritten on a per-plugin #
# base by using the 'Interval' option of the LoadPlugin block:               #
#   <LoadPlugin foo>                                                         #
#       Interval 60                                                          #
#   </LoadPlugin>                                                            #
#----------------------------------------------------------------------------#
#Interval 10

#MaxReadInterval 86400
#Timeout         2
#ReadThreads     5
#WriteThreads    5

# Limit the size of the write queue. Default is no limit. Setting up a limit
# is recommended for servers handling a high volume of traffic.
#WriteQueueLimitHigh 1000000
#WriteQueueLimitLow   800000

##############################################################################
# Logging                                                                    #
#----------------------------------------------------------------------------#
# Plugins which provide logging functions should be loaded first, so log     #
# messages generated when loading or configuring other plugins can be        #
# accessed.                                                                  #
##############################################################################

#LoadPlugin logfile
LoadPlugin syslog
#LoadPlugin log_logstash

#<Plugin logfile>
#	LogLevel "info"
#	File STDOUT
#	Timestamp true
#	PrintSeverity false
#</Plugin>

<Plugin syslog>
	LogLevel info
</Plugin>

#<Plugin log_logstash>
#	LogLevel info
#	File "/var/log/collectd.json.log"
#</Plugin>

##############################################################################
# LoadPlugin section                                                         #
#----------------------------------------------------------------------------#
# Specify what features to activate.                                         #
##############################################################################

#LoadPlugin aggregation
#LoadPlugin amqp
#LoadPlugin apache
#LoadPlugin apcups
#LoadPlugin ascent
#LoadPlugin barometer
LoadPlugin battery
#LoadPlugin bind
#LoadPlugin ceph
#LoadPlugin cgroups
#LoadPlugin conntrack
#LoadPlugin contextswitch
LoadPlugin cpu
#LoadPlugin cpufreq
#LoadPlugin csv
#LoadPlugin curl
#LoadPlugin curl_json
#LoadPlugin curl_xml
#LoadPlugin dbi
LoadPlugin df
LoadPlugin disk
#LoadPlugin dns
#LoadPlugin drbd
#LoadPlugin email
LoadPlugin entropy
#LoadPlugin ethstat
#LoadPlugin exec
#LoadPlugin fhcount
#LoadPlugin filecount
#LoadPlugin fscache
#LoadPlugin gmond
#LoadPlugin hddtemp
LoadPlugin interface
#LoadPlugin ipc
#LoadPlugin ipmi
#LoadPlugin iptables
#LoadPlugin ipvs
LoadPlugin irq
#LoadPlugin java
LoadPlugin load
#LoadPlugin lvm
#LoadPlugin madwifi
#LoadPlugin mbmon
#LoadPlugin md
#LoadPlugin memcachec
#LoadPlugin memcached
LoadPlugin memory
#LoadPlugin modbus
#LoadPlugin multimeter
#LoadPlugin mysql
#LoadPlugin netlink
#LoadPlugin network
#LoadPlugin nfs
#LoadPlugin nginx
#LoadPlugin notify_desktop
#LoadPlugin notify_email
#LoadPlugin ntpd
#LoadPlugin numa
#LoadPlugin nut
#LoadPlugin olsrd
#LoadPlugin openldap
#LoadPlugin openvpn
#LoadPlugin perl
#LoadPlugin pinba
#LoadPlugin ping
#LoadPlugin postgresql
#LoadPlugin powerdns
LoadPlugin processes
#LoadPlugin protocols
#LoadPlugin python
#LoadPlugin redis
#LoadPlugin rrdcached
LoadPlugin rrdtool
#LoadPlugin sensors
#LoadPlugin serial
#LoadPlugin sigrok
#LoadPlugin smart
#LoadPlugin snmp
#LoadPlugin statsd
LoadPlugin swap
#LoadPlugin table
#LoadPlugin tail
#LoadPlugin tail_csv
#LoadPlugin tcpconns
#LoadPlugin teamspeak2
#LoadPlugin ted
#LoadPlugin thermal
#LoadPlugin tokyotyrant
#LoadPlugin turbostat
#LoadPlugin unixsock
#LoadPlugin uptime
LoadPlugin users
#LoadPlugin uuid
#LoadPlugin varnish
#LoadPlugin virt
#LoadPlugin vmem
#LoadPlugin vserver
#LoadPlugin wireless
LoadPlugin write_graphite
#LoadPlugin write_http
#LoadPlugin write_kafka
#LoadPlugin write_log
#LoadPlugin write_redis
#LoadPlugin write_riemann
#LoadPlugin write_sensu
#LoadPlugin write_tsdb
#LoadPlugin zfs_arc
#LoadPlugin zookeeper

##############################################################################
# Plugin configuration                                                       #
#----------------------------------------------------------------------------#
# In this section configuration stubs for each plugin are provided. A desc-  #
# ription of those options is available in the collectd.conf(5) manual page. #
##############################################################################

#<Plugin aggregation>
#	<Aggregation>
#		#Host "unspecified"
#		Plugin "cpu"
#		PluginInstance "/[0,2,4,6,8]$/"
#		Type "cpu"
#		#TypeInstance "unspecified"
#
#		SetPlugin "cpu"
#		SetPluginInstance "even-%{aggregation}"
#
#		GroupBy "Host"
#		GroupBy "TypeInstance"
#
#		CalculateNum false
#		CalculateSum false
#		CalculateAverage true
#		CalculateMinimum false
#		CalculateMaximum false
#		CalculateStddev false
#	</Aggregation>
#</Plugin>

#<Plugin amqp>
#	<Publish "name">
#		Host "localhost"
#		Port "5672"
#		VHost "/"
#		User "guest"
#		Password "guest"
#		Exchange "amq.fanout"
#		RoutingKey "collectd"
#		Persistent false
#		StoreRates false
#		ConnectionRetryDelay 0
#	</Publish>
#</Plugin>

#<Plugin apache>
#	<Instance "foo">
#		URL "http://localhost/server-status?auto"
#		User "www-user"
#		Password "secret"
#		VerifyPeer false
#		VerifyHost false
#		CACert "/etc/ssl/ca.crt"
#		Server "apache"
#	</Instance>
#
#	<Instance "bar">
#		URL "http://some.domain.tld/status?auto"
#		Host "some.domain.tld"
#		Server "lighttpd"
#	</Instance>
#</Plugin>

#<Plugin apcups>
#	Host "localhost"
#	Port "3551"
#	ReportSeconds true
#</Plugin>

#<Plugin ascent>
#	URL "http://localhost/ascent/status/"
#	User "www-user"
#	Password "secret"
#	VerifyPeer false
#	VerifyHost false
#	CACert "/etc/ssl/ca.crt"
#</Plugin>

#<Plugin barometer>
#	Device            "/dev/i2c-0";
#	Oversampling      512
#	PressureOffset    0.0
#	TemperatureOffset 0.0
#	Normalization     2
#	Altitude          238.0
#	TemperatureSensor "myserver/onewire-F10FCA000800/temperature"
#</Plugin>

#<Plugin battery>
#	ValuesPercentage false
#	ReportDegraded false
#</Plugin>

#<Plugin bind>
#	URL "http://localhost:8053/"
#
#	ParseTime false
#
#	OpCodes true
#	QTypes true
#	ServerStats true
#	ZoneMaintStats true
#	ResolverStats false
#	MemoryStats true
#
#	<View "_default">
#		QTypes true
#		ResolverStats true
#		CacheRRSets true
#
#		Zone "127.in-addr.arpa/IN"
#	</View>
#</Plugin>

#<Plugin ceph>
#	LongRunAvgLatency false
#	ConvertSpecialMetricTypes true
#	<Daemon "osd.0">
#		SocketPath "/var/run/ceph/ceph-osd.0.asok"
#	</Daemon>
#	<Daemon "osd.1">
#		SocketPath "/var/run/ceph/ceph-osd.1.asok"
#	</Daemon>
#	<Daemon "mon.a">
#		SocketPath "/var/run/ceph/ceph-mon.ceph1.asok"
#	</Daemon>
#	<Daemon "mds.a">
#		SocketPath "/var/run/ceph/ceph-mds.ceph1.asok"
#	</Daemon>
#</Plugin>

#<Plugin cgroups>
#	CGroup "libvirt"
#	IgnoreSelected false
#</Plugin>

#<Plugin cpu>
#	ReportByCpu true
#	ReportByState true
#	ValuesPercentage false
#</Plugin>

#<Plugin csv>
#	DataDir "/var/lib/collectd/csv"
#	StoreRates false
#</Plugin>

#<Plugin curl>
#	<Page "stock_quotes">
#		URL "http://finance.google.com/finance?q=NYSE%3AAMD"
#		User "foo"
#		Password "bar"
#		Digest false
#		VerifyPeer true
#		VerifyHost true
#		CACert "/path/to/ca.crt"
#		Header "X-Custom-Header: foobar"
#		Post "foo=bar"
#
#		MeasureResponseTime false
#		MeasureResponseCode false
#		<Match>
#			Regex "<span +class=\"pr\"[^>]*> *([0-9]*\\.[0-9]+) *</span>"
#			DSType "GaugeAverage"
#			Type "stock_value"
#			Instance "AMD"
#		</Match>
#	</Page>
#</Plugin>

#<Plugin curl_json>
## See: http://wiki.apache.org/couchdb/Runtime_Statistics
#  <URL "http://localhost:5984/_stats">
#    Instance "httpd"
#    <Key "httpd/requests/count">
#      Type "http_requests"
#    </Key>
#
#    <Key "httpd_request_methods/*/count">
#      Type "http_request_methods"
#    </Key>
#
#    <Key "httpd_status_codes/*/count">
#      Type "http_response_codes"
#    </Key>
#  </URL>
## Database status metrics:
#  <URL "http://localhost:5984/_all_dbs">
#    Instance "dbs"
#    <Key "*/doc_count">
#      Type "gauge"
#    </Key>
#    <Key "*/doc_del_count">
#      Type "counter"
#    </Key>
#    <Key "*/disk_size">
#      Type "bytes"
#    </Key>
#  </URL>
#</Plugin>

#<Plugin curl_xml>
#	<URL "http://localhost/stats.xml">
#		Host "my_host"
#		Instance "some_instance"
#		User "collectd"
#		Password "thaiNg0I"
#		Digest false
#		VerifyPeer true
#		VerifyHost true
#		CACert "/path/to/ca.crt"
#		Header "X-Custom-Header: foobar"
#		Post "foo=bar"
#
#		<XPath "table[@id=\"magic_level\"]/tr">
#			Type "magic_level"
#			InstancePrefix "prefix-"
#			InstanceFrom "td[1]"
#			ValuesFrom "td[2]/span[@class=\"level\"]"
#		</XPath>
#	</URL>
#</Plugin>

#<Plugin dbi>
#	<Query "num_of_customers">
#		Statement "SELECT 'customers' AS c_key, COUNT(*) AS c_value \
#				FROM customers_tbl"
#		MinVersion 40102
#		MaxVersion 50042
#		<Result>
#			Type "gauge"
#			InstancePrefix "customer"
#			InstancesFrom "c_key"
#			ValuesFrom "c_value"
#		</Result>
#	</Query>
#
#	<Database "customers_db">
#		Driver "mysql"
#		DriverOption "host" "localhost"
#		DriverOption "username" "collectd"
#		DriverOption "password" "secret"
#		DriverOption "dbname" "custdb0"
#		SelectDB "custdb0"
#		Query "num_of_customers"
#		Query "..."
#		Host "..."
#	</Database>
#</Plugin>

<Plugin df>
#	Device "/dev/sda1"
#	Device "192.168.0.2:/mnt/nfs"
#	MountPoint "/home"
#	FSType "ext3"

	# ignore rootfs; else, the root file-system would appear twice, causing
	# one of the updates to fail and spam the log
	FSType rootfs
	# ignore the usual virtual / temporary file-systems
	FSType sysfs
	FSType proc
	FSType devtmpfs
	FSType devpts
	FSType tmpfs
	FSType fusectl
	FSType cgroup
	IgnoreSelected true

#	ReportByDevice false
#	ReportInodes false

#	ValuesAbsolute true
#	ValuesPercentage false
</Plugin>

#<Plugin disk>
#	Disk "hda"
#	Disk "/sda[23]/"
#	IgnoreSelected false
#	UseBSDName false
#	UdevNameAttr "DEVNAME"
#</Plugin>

#<Plugin dns>
#	Interface "eth0"
#	IgnoreSource "192.168.0.1"
#	SelectNumericQueryTypes false
#</Plugin>

#<Plugin email>
#	SocketFile "/var/run/collectd-email"
#	SocketGroup "collectd"
#	SocketPerms "0770"
#	MaxConns 5
#</Plugin>

#<Plugin ethstat>
#	Interface "eth0"
#	Map "rx_csum_offload_errors" "if_rx_errors" "checksum_offload"
#	Map "multicast" "if_multicast"
#	MappedOnly false
#</Plugin>

#<Plugin exec>
#	Exec user "/path/to/exec"
#	Exec "user:group" "/path/to/exec"
#	NotificationExec user "/path/to/exec"
#</Plugin>

#<Plugin fhcount>
#	ValuesAbsolute true
#	ValuesPercentage false
#</Plugin>

#<Plugin filecount>
#	<Directory "/path/to/dir">
#		Instance "foodir"
#		Name "*.conf"
#		MTime "-5m"
#		Size "+10k"
#		Recursive true
#		IncludeHidden false
#	</Directory>
#</Plugin>

#<Plugin gmond>
#	MCReceiveFrom "239.2.11.71" "8649"
#
#	<Metric "swap_total">
#		Type "swap"
#		TypeInstance "total"
#		DataSource "value"
#	</Metric>
#
#	<Metric "swap_free">
#		Type "swap"
#		TypeInstance "free"
#		DataSource "value"
#	</Metric>
#</Plugin>

#<Plugin hddtemp>
#	Host "127.0.0.1"
#	Port 7634
#</Plugin>

#<Plugin interface>
#	Interface "eth0"
#	IgnoreSelected false
#</Plugin>

#<Plugin ipmi>
#	Sensor "some_sensor"
#	Sensor "another_one"
#	IgnoreSelected false
#	NotifySensorAdd false
#	NotifySensorRemove true
#	NotifySensorNotPresent false
#</Plugin>

#<Plugin iptables>
#	Chain "table" "chain"
#	Chain6 "table" "chain"
#</Plugin>

#<Plugin irq>
#	Irq 7
#	Irq 8
#	Irq 9
#	IgnoreSelected true
#</Plugin>

#<Plugin java>
#	JVMArg "-verbose:jni"
#	JVMArg "-Djava.class.path=/usr/share/collectd/java/collectd-api.jar"
#
#	LoadPlugin "org.collectd.java.GenericJMX"
#	<Plugin "GenericJMX">
#		# See /usr/share/doc/collectd/examples/GenericJMX.conf
#		# for an example config.
#	</Plugin>
#</Plugin>

#<Plugin load>
#	ReportRelative true
#</Plugin>

#<Plugin madwifi>
#	Interface "wlan0"
#	IgnoreSelected false
#	Source "SysFS"
#	WatchSet "None"
#	WatchAdd "node_octets"
#	WatchAdd "node_rssi"
#	WatchAdd "is_rx_acl"
#	WatchAdd "is_scan_active"
#</Plugin>

#<Plugin mbmon>
#	Host "127.0.0.1"
#	Port 411
#</Plugin>

#<Plugin md>
#	Device "/dev/md0"
#	IgnoreSelected false
#</Plugin>

#<Plugin memcachec>
#	<Page "plugin_instance">
#		Server "localhost"
#		Key "page_key"
#		<Match>
#			Regex "(\\d+) bytes sent"
#			ExcludeRegex "<lines to be excluded>"
#			DSType CounterAdd
#			Type "ipt_octets"
#			Instance "type_instance"
#		</Match>
#	</Page>
#</Plugin>

#<Plugin memcached>
#	<Instance "local">
#		Socket "/var/run/memcached.sock"
# or:
#		Host "127.0.0.1"
#		Port "11211"
#	</Instance>
#</Plugin>

#<Plugin memory>
#	ValuesAbsolute true
#	ValuesPercentage false
#</Plugin>

#<Plugin modbus>
#	<Data "data_name">
#		RegisterBase 1234
#		RegisterCmd ReadHolding
#		RegisterType float
#		Type gauge
#		Instance "..."
#	</Data>
#
#	<Host "name">
#		Address "addr"
#		Port "1234"
#		Interval 60
#
#		<Slave 1>
#			Instance "foobar" # optional
#			Collect "data_name"
#		</Slave>
#	</Host>
#</Plugin>

#<Plugin mysql>
#	<Database db_name>
#		Host "database.serv.er"
#		Port "3306"
#		User "db_user"
#		Password "secret"
#		Database "db_name"
#		MasterStats true
#		ConnectTimeout 10
#		InnodbStats true
#	</Database>
#
#	<Database db_name2>
#		Alias "squeeze"
#		Host "localhost"
#		Socket "/var/run/mysql/mysqld.sock"
#		SlaveStats true
#		SlaveNotifications true
#	</Database>
#</Plugin>

#<Plugin netlink>
#	Interface "All"
#	VerboseInterface "All"
#	QDisc "eth0" "pfifo_fast-1:0"
#	Class "ppp0" "htb-1:10"
#	Filter "ppp0" "u32-1:0"
#	IgnoreSelected false
#</Plugin>

#<Plugin network>
#	# client setup:
#	Server "ff18::efc0:4a42" "25826"
#	<Server "239.192.74.66" "25826">
#		SecurityLevel Encrypt
#		Username "user"
#		Password "secret"
#		Interface "eth0"
#		ResolveInterval 14400
#	</Server>
#	TimeToLive 128
#
#	# server setup:
#	Listen "ff18::efc0:4a42" "25826"
#	<Listen "239.192.74.66" "25826">
#		SecurityLevel Sign
#		AuthFile "/etc/collectd/passwd"
#		Interface "eth0"
#	</Listen>
#	MaxPacketSize 1452
#
#	# proxy setup (client and server as above):
#	Forward true
#
#	# statistics about the network plugin itself
#	ReportStats false
#
#	# "garbage collection"
#	CacheFlush 1800
#</Plugin>

#<Plugin nginx>
#	URL "http://localhost/status?auto"
#	User "www-user"
#	Password "secret"
#	VerifyPeer false
#	VerifyHost false
#	CACert "/etc/ssl/ca.crt"
#</Plugin>

#<Plugin notify_desktop>
#	OkayTimeout 1000
#	WarningTimeout 5000
#	FailureTimeout 0
#</Plugin>

#<Plugin notify_email>
#	SMTPServer "localhost"
#	SMTPPort 25
#	SMTPUser "my-username"
#	SMTPPassword "my-password"
#	From "collectd@main0server.com"
#	# <WARNING/FAILURE/OK> on <hostname>.
#	# Beware! Do not use not more than two placeholders (%)!
#	Subject "[collectd] %s on %s!"
#	Recipient "email1@domain1.net"
#	Recipient "email2@domain2.com"
#</Plugin>

#<Plugin ntpd>
#	Host "localhost"
#	Port 123
#	ReverseLookups false
#	IncludeUnitID true
#</Plugin>

#<Plugin nut>
#	UPS "upsname@hostname:port"
#</Plugin>

#<Plugin olsrd>
#	Host "127.0.0.1"
#	Port "2006"
#	CollectLinks "Summary"
#	CollectRoutes "Summary"
#	CollectTopology "Summary"
#</Plugin>

#<Plugin openldap>
#	<Instance "localhost">
#		URL "ldap://localhost:389"
#		StartTLS false
#		VerifyHost true
#		CACert "/path/to/ca.crt"
#		Timeout -1
#		Version 3
#	</Instance>
#</Plugin>

#<Plugin openvpn>
#	StatusFile "/etc/openvpn/openvpn-status.log"
#	ImprovedNamingSchema false
#	CollectCompression true
#	CollectIndividualUsers true
#	CollectUserCount false
#</Plugin>

#<Plugin perl>
#	IncludeDir "/my/include/path"
#	BaseName "Collectd::Plugins"
#	EnableDebugger ""
#	LoadPlugin Monitorus
#	LoadPlugin OpenVZ
#
#	<Plugin foo>
#		Foo "Bar"
#		Qux "Baz"
#	</Plugin>
#</Plugin>

#<Plugin pinba>
#	Address "::0"
#	Port "30002"
#	<View "name">
#		Host "host name"
#		Server "server name"
#		Script "script name"
#	<View>
#</Plugin>

#<Plugin ping>
#	Host "host.foo.bar"
#	Host "host.baz.qux"
#	Interval 1.0
#	Timeout 0.9
#	TTL 255
#	SourceAddress "1.2.3.4"
#	Device "eth0"
#	MaxMissed -1
#</Plugin>

#<Plugin postgresql>
#	<Query magic>
#		Statement "SELECT magic FROM wizard WHERE host = $1;"
#		Param hostname
#
#		<Result>
#			Type gauge
#			InstancePrefix "magic"
#			ValuesFrom "magic"
#		</Result>
#	</Query>
#
#	<Query rt36_tickets>
#		Statement "SELECT COUNT(type) AS count, type \
#		                  FROM (SELECT CASE \
#		                               WHEN resolved = 'epoch' THEN 'open' \
#		                               ELSE 'resolved' END AS type \
#		                               FROM tickets) type \
#		                  GROUP BY type;"
#
#		<Result>
#			Type counter
#			InstancePrefix "rt36_tickets"
#			InstancesFrom "type"
#			ValuesFrom "count"
#		</Result>
#	</Query>
#
#	<Writer sqlstore>
#		# See /usr/share/doc/collectd-core/examples/postgresql/collectd_insert.sql for details
#		Statement "SELECT collectd_insert($1, $2, $3, $4, $5, $6, $7, $8, $9);"
#		StoreRates true
#	</Writer>
#
#	<Database foo>
#		Host "hostname"
#		Port 5432
#		User "username"
#		Password "secret"
#
#		SSLMode "prefer"
#		KRBSrvName "kerberos_service_name"
#
#		Query magic
#	</Database>
#
#	<Database bar>
#		Interval 60
#		Service "service_name"
#
#		Query backend # predefined
#		Query rt36_tickets
#	</Database>
#
#	<Database qux>
#		Service "collectd_store"
#		Writer sqlstore
#		# see collectd.conf(5) for details
#		CommitInterval 30
#	</Database>
#</Plugin>

#<Plugin powerdns>
#	<Server "server_name">
#		Collect "latency"
#		Collect "udp-answers" "udp-queries"
#		Socket "/var/run/pdns.controlsocket"
#	</Server>
#	<Recursor "recursor_name">
#		Collect "questions"
#		Collect "cache-hits" "cache-misses"
#		Socket "/var/run/pdns_recursor.controlsocket"
#	</Recursor>
#	LocalSocket "/opt/collectd/var/run/collectd-powerdns"
#</Plugin>

#<Plugin processes>
#	Process "name"
#	ProcessMatch "foobar" "/usr/bin/perl foobar\\.pl.*"
#</Plugin>

#<Plugin protocols>
#	Value "/^Tcp:/"
#	IgnoreSelected false
#</Plugin>

#<Plugin python>
#	ModulePath "/path/to/your/python/modules"
#	LogTraces true
#	Interactive true
#	Import "spam"
#
#	<Module spam>
#		spam "wonderful" "lovely"
#	</Module>
#</Plugin>

#<Plugin redis>
#	<Node example>
#		Host "redis.example.com"
#		Port "6379"
#		Timeout 2000
#	</Node>
#</Plugin>

#<Plugin rrdcached>
#	DaemonAddress "unix:/var/run/rrdcached.sock"
#	DataDir "/var/lib/rrdcached/db/collectd"
#	CreateFiles true
#	CreateFilesAsync false
#	CollectStatistics true
#
# The following settings are rather advanced
# and should usually not be touched:
#	StepSize 10
#	HeartBeat 20
#	RRARows 1200
#	RRATimespan 158112000
#	XFF 0.1
#</Plugin>

<Plugin rrdtool>
	DataDir "/var/lib/collectd/rrd"
#	CacheTimeout 120
#	CacheFlush 900
#	WritesPerSecond 30
#	CreateFilesAsync false
#	RandomTimeout 0
#
# The following settings are rather advanced
# and should usually not be touched:
#	StepSize 10
#	HeartBeat 20
#	RRARows 1200
#	RRATimespan 158112000
#	XFF 0.1
</Plugin>

#<Plugin sensors>
#	SensorConfigFile "/etc/sensors3.conf"
#	Sensor "it8712-isa-0290/temperature-temp1"
#	Sensor "it8712-isa-0290/fanspeed-fan3"
#	Sensor "it8712-isa-0290/voltage-in8"
#	IgnoreSelected false
#</Plugin>

#<Plugin sigrok>
#	LogLevel 3
#	<Device "AC Voltage">
#		Driver "fluke-dmm"
#		MinimumInterval 10
#		Conn "/dev/ttyUSB2"
#	</Device>
#	<Device "Sound Level">
#		Driver "cem-dt-885x"
#		Conn "/dev/ttyUSB1"
#	</Device>
#</Plugin>

#<Plugin smart>
#	Disk "/^[hs]d[a-f][0-9]?$/"
#	IgnoreSelected false
#</Plugin>

# See /usr/share/doc/collectd/examples/snmp-data.conf.gz for a
# comprehensive sample configuration.
#<Plugin snmp>
#	<Data "powerplus_voltge_input">
#		Type "voltage"
#		Table false
#		Instance "input_line1"
#		Scale 0.1
#		Values "SNMPv2-SMI::enterprises.6050.5.4.1.1.2.1"
#	</Data>
#	<Data "hr_users">
#		Type "users"
#		Table false
#		Instance ""
#		Shift -1
#		Values "HOST-RESOURCES-MIB::hrSystemNumUsers.0"
#	</Data>
#	<Data "std_traffic">
#		Type "if_octets"
#		Table true
#		InstancePrefix "traffic"
#		Instance "IF-MIB::ifDescr"
#		Values "IF-MIB::ifInOctets" "IF-MIB::ifOutOctets"
#	</Data>
#
#	<Host "some.switch.mydomain.org">
#		Address "192.168.0.2"
#		Version 1
#		Community "community_string"
#		Collect "std_traffic"
#		Inverval 120
#	</Host>
#	<Host "some.server.mydomain.org">
#		Address "192.168.0.42"
#		Version 2
#		Community "another_string"
#		Collect "std_traffic" "hr_users"
#	</Host>
#	<Host "some.ups.mydomain.org">
#		Address "192.168.0.3"
#		Version 1
#		Community "more_communities"
#		Collect "powerplus_voltge_input"
#		Interval 300
#	</Host>
#</Plugin>

#<Plugin statsd>
#	Host "::"
#	Port "8125"
#	DeleteCounters false
#	DeleteTimers   false
#	DeleteGauges   false
#	DeleteSets     false
#	TimerPercentile 90.0
#	TimerPercentile 95.0
#	TimerPercentile 99.0
#	TimerLower     false
#	TimerUpper     false
#	TimerSum       false
#	TimerCount     false
#</Plugin>

#<Plugin swap>
#	ReportByDevice false
#	ReportBytes true
#</Plugin>

#<Plugin table>
#	<Table "/proc/slabinfo">
#		Instance "slabinfo"
#		Separator " "
#		<Result>
#			Type gauge
#			InstancePrefix "active_objs"
#			InstancesFrom 0
#			ValuesFrom 1
#		</Result>
#		<Result>
#			Type gauge
#			InstancePrefix "objperslab"
#			InstancesFrom 0
#			ValuesFrom 4
#		</Result>
#	</Table>
#</Plugin>

#<Plugin tail>
#	<File "/var/log/exim4/mainlog">
#		Instance "exim"
#		Interval 60
#		<Match>
#			Regex "S=([1-9][0-9]*)"
#			DSType "CounterAdd"
#			Type "ipt_bytes"
#			Instance "total"
#		</Match>
#		<Match>
#			Regex "\\<R=local_user\\>"
#			ExcludeRegex "\\<R=local_user\\>.*mail_spool defer"
#			DSType "CounterInc"
#			Type "counter"
#			Instance "local_user"
#		</Match>
#	</File>
#</Plugin>

#<Plugin tail_csv>
#	<Metric "dropped">
#		Type "percent"
#		Instance "dropped"
#		ValueFrom 1
#	</Metric>
#	<Metric "mbps">
#		Type "bytes"
#		Instance "wire-realtime"
#		ValueFrom 2
#	</Metric>
#	<Metric "alerts">
#		Type "alerts_per_second"
#		ValueFrom 3
#	</Metric>
#	<Metric "kpps">
#		Type "kpackets_wire_per_sec.realtime"
#		ValueFrom 4
#	</Metric>
#	<File "/var/log/snort/snort.stats">
#		Instance "snort-eth0"
#		Interval 600
#		Collect "dropped" "mbps" "alerts" "kpps"
#		TimeFrom 0
#	</File>
#</Plugin>

#<Plugin tcpconns>
#	ListeningPorts false
#	AllPortsSummary false
#	LocalPort "25"
#	RemotePort "25"
#</Plugin>

#<Plugin teamspeak2>
#	Host "127.0.0.1"
#	Port "51234"
#	Server "8767"
#</Plugin>

#<Plugin ted>
#	Device "/dev/ttyUSB0"
#	Retries 0
#</Plugin>

#<Plugin thermal>
#	ForceUseProcfs false
#	Device "THRM"
#	IgnoreSelected false
#</Plugin>

#<Plugin tokyotyrant>
#	Host "localhost"
#	Port "1978"
#</Plugin>

#<Plugin turbostat>
##	None of the following option should be set manually
##	This plugin automatically detect most optimal options
##	Only set values here if:
##	- The module ask you to
##	- You want to disable the collection of some data
##	- Your (intel) CPU is not supported (yet) by the module
##	- The module generate a lot of errors 'MSR offset 0x... read failed'
##	In the last two cases, please open a bug request
#
#	TCCActivationTemp "100"
#	CoreCstates "392"
#	PackageCstates "396"
#	SystemManagementInterrupt true
#	DigitalTemperatureSensor true
#	PackageThermalManagement true
#	RunningAveragePowerLimit "7"
#</Plugin>

#<Plugin unixsock>
#	SocketFile "/var/run/collectd-unixsock"
#	SocketGroup "collectd"
#	SocketPerms "0660"
#	DeleteSocket false
#</Plugin>

#<Plugin uuid>
#	UUIDFile "/etc/uuid"
#</Plugin>

#<Plugin varnish>
#	<Instance>
#		CollectBackend true
#		CollectBan false           # Varnish 3 and above
#		CollectCache true
#		CollectConnections true
#		CollectDirectorDNS false   # Varnish 3 only
#		CollectESI false
#		CollectFetch false
#		CollectHCB false
#		CollectObjects false
#		CollectPurge false         # Varnish 2 only
#		CollectSession false
#		CollectSHM true
#		CollectSMA false           # Varnish 2 only
#		CollectSMS false
#		CollectSM false            # Varnish 2 only
#		CollectStruct false
#		CollectTotals false
#		CollectUptime false        # Varnish 3 and above
#		CollectdVCL false
#		CollectVSM false           # Varnish 4 only
#		CollectWorkers false
#	</Instance>
#
#	<Instance "myinstance">
#		CollectCache true
#	</Instance>
#</Plugin>

#<Plugin virt>
#	Connection "xen:///"
#	RefreshInterval 60
#	Domain "name"
#	BlockDevice "name:device"
#	InterfaceDevice "name:device"
#	IgnoreSelected false
#	HostnameFormat name
#	InterfaceFormat name
#	PluginInstanceFormat name
#</Plugin>

#<Plugin vmem>
#	Verbose false
#</Plugin>

<Plugin write_graphite>
	<Node "example">
		Host "${graphite_host}"
		Port "2003"
		Protocol "tcp"
		LogSendErrors true
		Prefix "collectd."
		Postfix ""
		StoreRates true
		AlwaysAppendDS false
		EscapeCharacter "_"
	</Node>
</Plugin>

#<Plugin write_http>
#	<Node "example">
#		URL "http://example.com/collectd-post"
#		User "collectd"
#		Password "secret"
#		VerifyPeer true
#		VerifyHost true
#		CACert "/etc/ssl/ca.crt"
#		CAPath "/etc/ssl/certs/"
#		ClientKey "/etc/ssl/client.pem"
#		ClientCert "/etc/ssl/client.crt"
#		ClientKeyPass "secret"
#		SSLVersion "TLSv1"
#		Format "Command"
#		StoreRates false
#		BufferSize 4096
#		LowSpeedLimit 0
#		Timeout 0
#	</Node>
#</Plugin>

#<Plugin write_kafka>
#	Property "metadata.broker.list" "localhost:9092"
#	<Topic "collectd">
#		Format JSON
#	</Topic>
#</Plugin>

#<Plugin write_riemann>
#	<Node "example">
#		Host "localhost"
#		Port 5555
#		Protocol TCP
#		Batch true
#		BatchMaxSize 8192
#		StoreRates true
#		AlwaysAppendDS false
#		TTLFactor 2.0
#		Notifications true
#		CheckThresholds false
#		EventServicePrefix ""
#	</Node>
#	Tag "foobar"
#	Attribute "foo" "bar"
#</Plugin>

#<Plugin write_sensu>
#	<Node "example">
#		Host "localhost"
#		Port 3030
#		StoreRates true
#		AlwaysAppendDS false
#		Notifications true
#		Metrics true
#		EventServicePrefix ""
#		MetricHandler "influx"
#		MetricHandler "default"
#		NotificationHandler "flapjack"
#		NotificationHandler "howling_monkey"
#	</Node>
#	Tag "foobar"
#	Attribute "foo" "bar"
#</Plugin>

#<Plugin write_tsdb>
#	<Node>
#		Host "localhost"
#		Port "4242"
#		HostTags "status=production"
#		StoreRates false
#		AlwaysAppendDS false
#	</Node>
#</Plugin>

#<Plugin zookeeper>
#	Host "localhost"
#	Port "2181"
#</Plugin>

<Include "/etc/collectd/collectd.conf.d">
	Filter "*.conf"
</Include>

