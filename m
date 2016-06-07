Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Rui Wang <rui.y.wang@intel.com>
To: tglx@linutronix.de, rjw@rjwysocki.net, tony.luck@intel.com,
	bhelgaas@google.com
Cc: linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, rui.y.wang@intel.com
Subject: [PATCH 2/2] x86/ioapic: Fix wrong pointers in ioapic_setup_resources()
Date: Tue,  7 Jun 2016 15:21:13 +0800
Message-Id: <1465284073-354-3-git-send-email-rui.y.wang@intel.com>
In-Reply-To: <1465284073-354-1-git-send-email-rui.y.wang@intel.com>
References: <1465284073-354-1-git-send-email-rui.y.wang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On a 4-socket brickland, hot-removing one ioapic is fine. Hot-removing
the 2nd one causes panic:

[  453.422259] BUG: unable to handle kernel NULL pointer dereference at
0000000000000030
[  453.431059] IP: [<ffffffff8109a8c2>] release_resource+0x22/0x80
[  453.437713] PGD 0
[  453.439976] Oops: 0000 [#1] SMP
[  453.443610] Modules linked in: fuse btrfs xor raid6_pq msdos ext4
mbcache jbd2 binfmt_misc xt_CHECKSUM ipt_MAS
QUERADE nf_nat_masquerade_ipv4 tun ip6t_rpfilter ip6t_REJECT
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrac
k ebtable_nat ebtable_broute bridge stp llc ebtable_filter ebtables
ip6table_nat nf_conntrack_ipv6 nf_defrag_ipv6
 nf_nat_ipv6 ip6table_mangle ip6table_security ip6table_raw
ip6table_filter ip6_tables iptable_nat nf_conntrack_i
pv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack iptable_mangle
iptable_security iptable_raw iptable_filter vfa
t fat x86_pkg_temp_thermal intel_powerclamp coretemp kvm sb_edac
irqbypass edac_core aesni_intel ipmi_ssif iTCO_w
dt iTCO_vendor_support lpc_ich glue_helper ipmi_si ablk_helper sg shpchp
pcspkr mfd_core i2c_i801 ipmi_msghandler
 wmi acpi_pad nfsd
[  453.523040]  auth_rpcgss nfs_acl lockd grace sunrpc ip_tables xfs
libcrc32c sr_mod cdrom sd_mod mgag200 drm_km
s_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm drm ixgbe igb
ahci libahci libata mdio i2c_algo_bit pt
p i2c_core megaraid_sas pps_core dca dm_mirror dm_region_hash dm_log
dm_mod
[  453.551438] CPU: 34 PID: 1146 Comm: kworker/u288:1 Not tainted
4.5.0-rc1+ #69
[  453.559418] Hardware name: Intel Corporation BRICKLAND/BRICKLAND,
BIOS BRHSXSD1.86B.0063.R00.1503261059 03/26/
2015
[  453.570994] Workqueue: kacpi_hotplug acpi_hotplug_work_fn
[  453.577041] task: ffff880463325800 ti: ffff88046267c000 task.ti:
ffff88046267c000
[  453.585415] RIP: 0010:[<ffffffff8109a8c2>]  [<ffffffff8109a8c2>]
release_resource+0x22/0x80
[  453.594768] RSP: 0018:ffff88046267fcc8  EFLAGS: 00010246
[  453.600706] RAX: 00000000ffffffea RBX: ffff88087fffde00 RCX:
0000000000000000
[  453.608684] RDX: 00000000000000ff RSI: ffffea0011b72180 RDI:
ffffffff81e3c0f8
[  453.616663] RBP: ffff88046267fcd0 R08: ffff88046dc86fc0 R09:
00000001802a0028
[  453.624641] R10: 000000006dc86f01 R11: ffffea0011b72180 R12:
0000000000000003
[  453.632619] R13: ffffffff81e1d450 R14: 00000000000000d8 R15:
0000000000000003
[  453.640598] FS:  0000000000000000(0000) GS:ffff88086f000000(0000)
knlGS:0000000000000000
[  453.649645] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  453.656069] CR2: 0000000000000030 CR3: 0000000001a6e000 CR4:
00000000001406e0
[  453.664047] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[  453.672027] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[  453.680005] Stack:
[  453.682251]  00000000000000d8 ffff88046267fd08 ffffffff81057965
0000000000000048
[  453.690567]  ffffffff81b43bd8 ffff88086b125358 ffff88086b783ea0
ffff88086b125300
[  453.698876]  ffff88046267fd20 ffffffff8104e3ff 0000000000000000
ffff88046267fd58
[  453.707195] Call Trace:
[  453.709935]  [<ffffffff81057965>] mp_unregister_ioapic+0x125/0x180
[  453.716846]  [<ffffffff8104e3ff>] acpi_unregister_ioapic+0x1f/0x40
[  453.723759]  [<ffffffff8140cfe3>] acpi_ioapic_remove+0x5f/0xf0
[  453.730283]  [<ffffffff813e0645>] acpi_pci_root_remove+0x2c/0x80
[  453.737002]  [<ffffffff813da86b>] acpi_bus_trim+0x5a/0x8d
[  453.743039]  [<ffffffff813dc31d>] acpi_device_hotplug+0x1b7/0x418
[  453.749851]  [<ffffffff813d4f8a>] acpi_hotplug_work_fn+0x1e/0x29
[  453.756570]  [<ffffffff810ad67f>] process_one_work+0x14f/0x3d0
[  453.763092]  [<ffffffff810adf35>] worker_thread+0x125/0x4b0
[  453.769325]  [<ffffffff816fd5c1>] ? __schedule+0x2b1/0x700
[  453.775459]  [<ffffffff810ade10>] ? rescuer_thread+0x370/0x370
[  453.781981]  [<ffffffff810b3a58>] kthread+0xd8/0xf0
[  453.787435]  [<ffffffff810b3980>] ? kthread_park+0x60/0x60
[  453.793570]  [<ffffffff8170190f>] ret_from_fork+0x3f/0x70
[  453.800203]  [<ffffffff810b3980>] ? kthread_park+0x60/0x60
[  453.806914] Code: 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 55 48 89
e5 53 48 89 fb 48 c7 c7 f8 c0 e3 81 e8 87 69 66 00 48 8b 4b 20 b8 ea ff
ff ff <48> 8b 51 30 48 85 d2 74 1d 48 39 d3 75 0a eb 3f 48 39 c3 74 1b
[  453.829861] RIP  [<ffffffff8109a8c2>] release_resource+0x22/0x80
[  453.837188]  RSP <ffff88046267fcc8>
[  453.841673] CR2: 0000000000000030

Fix it by assigning the correct pointers to ioapics[i].iomem_res in
ioapic_setup_resources(). Also simplify the function by removing
the redundant 'num' variable.

Signed-off-by: Rui Wang <rui.y.wang@intel.com>
---
 arch/x86/kernel/apic/io_apic.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index f253218..a90b131 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2563,29 +2563,25 @@ static struct resource * __init ioapic_setup_resources(void)
 	unsigned long n;
 	struct resource *res;
 	char *mem;
-	int i, num = 0;
+	int i;
 
-	for_each_ioapic(i)
-		num++;
-	if (num == 0)
+	if (nr_ioapics == 0)
 		return NULL;
 
 	n = IOAPIC_RESOURCE_NAME_SIZE + sizeof(struct resource);
-	n *= num;
+	n *= nr_ioapics;
 
 	mem = alloc_bootmem(n);
 	res = (void *)mem;
 
-	mem += sizeof(struct resource) * num;
+	mem += sizeof(struct resource) * nr_ioapics;
 
-	num = 0;
 	for_each_ioapic(i) {
-		res[num].name = mem;
-		res[num].flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+		res[i].name = mem;
+		res[i].flags = IORESOURCE_MEM | IORESOURCE_BUSY;
 		snprintf(mem, IOAPIC_RESOURCE_NAME_SIZE, "IOAPIC %u", i);
 		mem += IOAPIC_RESOURCE_NAME_SIZE;
-		num++;
-		ioapics[i].iomem_res = res;
+		ioapics[i].iomem_res = &res[i];
 	}
 
 	ioapic_resources = res;
-- 
1.8.3.1

