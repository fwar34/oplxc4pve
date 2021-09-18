#!/usr/bin/perl
#This script is placed in host /var/lib/vz/snippets by default. 
use strict;
use warnings;
print "GUEST HOOK: " . join(' ', @ARGV). "\n";
my $vmid = shift;
my $phase = shift;
if ($phase eq 'pre-start') {
	#You can also load kernel modules via host /etc/modules. More or less kmods are needed depending on different use cases. Hook script is prefered this time. 
	system("modprobe tun");
	system("modprobe xt_FULLCONENAT");
	system("modprobe xt_multiport");
	system("modprobe xt_connmark");
	system("modprobe xt_comment");
	system("modprobe xt_length");
	system("modprobe xt_time");
	system("modprobe xt_string");
	system("modprobe xt_statistic");
	system("modprobe xt_state");
	system("modprobe xt_socket");
	system("modprobe xt_recent");
	system("modprobe xt_quota");
	system("modprobe xt_pkttype");
	system("modprobe xt_owner");
	system("modprobe xt_mac");
	system("modprobe xt_helper");
	system("modprobe xt_hl");
	system("modprobe xt_esp");
	system("modprobe xt_ecn");
	system("modprobe xt_dscp");
	system("modprobe xt_connlimit");
	system("modprobe xt_connbytes");
	system("modprobe xt_bpf");
	system("modprobe xt_LOG");
	system("modprobe xt_HL");
	system("modprobe xt_DSCP");
	system("modprobe xt_CT");
	system("modprobe xt_CLASSIFY");
	system("modprobe xt_iprange");
	system("modprobe xt_TPROXY");
	system("modprobe ipt_ah");
	system("modprobe ipt_ECN");
	system("modprobe ip6t_NPT");
	system("modprobe ip_vs");
	system("modprobe ip_tunnel");
	system("modprobe ip_set_hash_ip");
	system("modprobe ip_set_hash_ipportnet");
	system("modprobe ip_set_hash_netport");
	system("modprobe ip_set_bitmap_ip");
	system("modprobe ip_set_hash_ipmac");
	system("modprobe ip_set_hash_mac");
	system("modprobe ip_set_hash_netportnet");
	system("modprobe ip_set_bitmap_ipmac");
	system("modprobe ip_set_hash_ipport");
	system("modprobe ip_set_hash_netiface");
	system("modprobe ip_set_bitmap_port");
	system("modprobe ip_set_hash_ipportip");
	system("modprobe ip_set_hash_netnet");
	system("modprobe nf_conntrack_amanda");
	system("modprobe nf_conntrack_bridge");
	system("modprobe nf_conntrack_broadcast");
	system("modprobe nf_conntrack_ftp");
	system("modprobe nf_conntrack_h323");
	system("modprobe nf_conntrack_irc");
	system("modprobe nf_conntrack_netbios_ns");
	system("modprobe nf_conntrack_pptp");
	system("modprobe nf_conntrack_sane");
	system("modprobe nf_conntrack_sip");
	system("modprobe nf_conntrack_snmp");
	system("modprobe nf_conntrack_tftp");
	system("modprobe nf_conntrack_netlink");
	system("modprobe nf_dup_netdev");
	system("modprobe nf_flow_table_ipv4");
	system("modprobe nf_log_bridge");
	system("modprobe nf_log_ipv6");
	system("modprobe nf_nat_ftp");
	system("modprobe nf_nat_pptp");
	system("modprobe nf_nat_tftp");
	system("modprobe nf_dup_ipv4");
	system("modprobe nf_flow_table");
	system("modprobe nf_flow_table_ipv6");
	system("modprobe nf_log_common");
	system("modprobe nf_log_netdev");
	system("modprobe nf_nat_h323");
	system("modprobe nf_nat_sip");
	system("modprobe nf_synproxy_core");
	system("modprobe nf_dup_ipv6");
	system("modprobe nf_flow_table_inet");
	system("modprobe nf_log_arp");
	system("modprobe nf_log_ipv4");
	system("modprobe nf_nat_amanda");
	system("modprobe nf_nat_irc");
	system("modprobe nf_nat_snmp_basic");
	system("modprobe nf_tables_set");

	system("modprobe sch_fq_codel");
	system("modprobe sch_tbf");
	system("modprobe cls_basic");
	system("modprobe cls_route");
	system("modprobe cls_tcindex");
	system("modprobe act_gact");
	system("modprobe act_skbedit");
	system("modprobe cls_matchall");
	system("modprobe act_ctinfo");
	system("modprobe sch_cake");
	system("modprobe sch_mqprio");
	system("modprobe em_ipset");
	system("modprobe cls_bpf");
	system("modprobe cls_flower");
	system("modprobe act_bpf");
	system("modprobe act_vlan");
	system("modprobe ifb");
	system("modprobe gre");
	system("modprobe pptp");
	#Needed by nft_chain_nat
	system("modprobe nft_chain_nat");
	#Use dedicated device file for the lxc instance.
	# system("mkdir -p /dev_lxc/");
	# system("mknod -m 600 /dev_lxc/ppp c 108 0");
	# system("chown 100000:100000 /dev_lxc/ppp");
	# #Make dir for shared bind mount among CTs 
	# system("mkdir -p /run/ctshare");
	# #Make ctshare owned by container root, thus rw by CT is possible.
	# system("chown 100000:100000 /run/ctshare");
	#Caution: making ctshare rw by everyone has security implications. Only uncomment the line below if it fits your case. 
	#system("chmod 777 /run/ctshare");
} elsif ($phase eq 'post-start') {
	system("lxc-device add -n $vmid /dev/ppp");
	system("lxc-device add -n $vmid /dev/net/tun");
} elsif ($phase eq 'pre-stop') {
} elsif ($phase eq 'post-stop') {
	#Cleanup
	system("rm /dev_lxc/ppp");
} else {
	die "got unknown phase '$phase'\n";
}
exit(0);

