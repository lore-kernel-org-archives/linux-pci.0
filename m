Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35268 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752427AbdGDPcr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jul 2017 11:32:47 -0400
Received: by mail-wm0-f42.google.com with SMTP id w126so199201527wme.0
        for <linux-pci@vger.kernel.org>; Tue, 04 Jul 2017 08:32:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170704161352.1cdb2670.wim.ten.have@oracle.com>
References: <20170704161352.1cdb2670.wim.ten.have@oracle.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 4 Jul 2017 10:32:24 -0500
Message-ID: <CAErSpo7PbSZgRtPJiXuOd6FPgLK5AGki51fTUm_-KUDZ96sRww@mail.gmail.com>
Subject: Fwd: Red Hat (Fedora) bug report 1467674 concerning your kernel
 functional performance enhancements causing PCI Express crashes,
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc: Sinan Kaya <okaya@codeaurora.org>,
        Wim ten Have <wim.ten.have@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-pci]

Thanks very much for the detailed problem report, Wim!  I'm taking the
liberty to forward to the linux-pci list in case others trip over the
same thing.


---------- Forwarded message ----------
From: Wim ten Have <wim.ten.have@oracle.com>
Date: Tue, Jul 4, 2017 at 9:13 AM
Subject: Red Hat (Fedora) bug report 1467674 concerning your kernel
functional performance enhancements causing PCI Express crashes,
To: Sinan Kaya <okaya@codeaurora.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Wim ten Have <wim.ten.have@oracle.com>


        Howdy,

I created Red Hat (Fedora) bug report 1467674.
        https://bugzilla.redhat.com/show_bug.cgi?id=1467674

This may be in your interest given fact you were involved in creating
code that is causing kernel (oops)/malfunction under;

commit 60db3a4d8cc9073cf56264785197ba75ee1caca4
Author: Sinan Kaya <okaya@codeaurora.org>
Date:   Fri Jan 20 09:16:51 2017 -0500

    PCI: Enable PCIe Extended Tags if supported

    Every PCIe device can generate 5-bit transaction Tags, which allow up to 32
    concurrent requests.  Some devices can generate 8-bit Extended Tags, which
    allow up to 256 concurrent requests.

    Per the ECN mentioned below, all PCIe Receivers are expected to support
    Extended Tags, so devices are allowed (but not required) to enable them by
    default.

    If a device supports Extended Tags but does not enable them by default,
    enable them.  This allows the device to have up to 256 outstanding
    transactions at a time, which may improve performance.

    [bhelgaas: changelog, check for PCIe device]
    Link: https://pcisig.com/sites/default/files/specification_documents/ECN_Extended_Tag_Enable_Default_05Sept2008_final.pdf
    Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>


>>>>>>>>>>>> REPORT <<<<<<<<<<<<<<<<
Wim ten Have 2017-07-04 10:06:19 EDT

Description of problem:
=======================
Systems with "eth0: Tigon3 [partno(BCM95721) rev 4201] (PCI Express)"
ethernet like DELL PowerEdge SC1435 fail their ethernet after
interface bind/ifconfig up.
  [    0.000000] SMBIOS 2.4 present.
  [    0.000000] DMI: Dell Inc. PowerEdge SC1435/0H313M, BIOS 2.2.5 03/21/2008


The problem is not specific to this piece of h/w.  I did pin-point the
issue to specific kernel code commit
60db3a4d8cc9073cf56264785197ba75ee1caca4
  * <wtenhave@hagen:55> git bisect good
    60db3a4d8cc9073cf56264785197ba75ee1caca4 is the first bad commit
    commit 60db3a4d8cc9073cf56264785197ba75ee1caca4
    Author: Sinan Kaya <okaya@codeaurora.org>
    Date:   Fri Jan 20 09:16:51 2017 -0500

      PCI: Enable PCIe Extended Tags if supported

The system will shortly after getting to the ifconfig up statement
report below kernel messages.
  Jul  4 15:00:12 hagen kernel: tg3 0000:01:00.0 eth0: Tigon3
[partno(BCM95721) rev 4201] (PCI Express) MAC address
00:22:19:27:cd:f8
  Jul  4 15:00:12 hagen kernel: tg3 0000:01:00.0 eth0: attached PHY is
5750 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[0])
  Jul  4 15:00:12 hagen kernel: tg3 0000:01:00.0 eth0: RXcsums[1]
LinkChgREG[0] MIirq[0] ASF[1] TSOcap[1]
  Jul  4 15:00:12 hagen kernel: tg3 0000:01:00.0 eth0:
dma_rwctrl[76180000] dma_mask[64-bit]
  Jul  4 15:00:12 hagen kernel: tg3 0000:02:00.0 eth1: Tigon3
[partno(BCM95721) rev 4201] (PCI Express) MAC address
00:22:19:27:cd:f9
  Jul  4 15:00:12 hagen kernel: tg3 0000:02:00.0 eth1: attached PHY is
5750 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[0])
  Jul  4 15:00:12 hagen kernel: tg3 0000:02:00.0 eth1: RXcsums[1]
LinkChgREG[0] MIirq[0] ASF[1] TSOcap[1]
  Jul  4 15:00:12 hagen kernel: tg3 0000:02:00.0 eth1:
dma_rwctrl[76180000] dma_mask[64-bit]
     ...
  Jul  4 15:00:12 hagen kernel: tg3 0000:02:00.0 enp2s0: renamed from eth1
     ...
  Jul  4 15:00:39 hagen kernel: tg3 0000:01:00.0 enp1s0: Link is up at
1000 Mbps, full duplex
  Jul  4 15:00:39 hagen kernel: tg3 0000:01:00.0 enp1s0: Flow control
is on for TX and on for RX
     ...
  Jul  4 15:00:50 hagen kernel: NETDEV WATCHDOG: enp1s0 (tg3):
transmit queue 0 timed out
  Jul  4 15:00:50 hagen kernel: ------------[ cut here ]------------
  Jul  4 15:00:50 hagen kernel: WARNING: CPU: 6 PID: 0 at
net/sched/sch_generic.c:316 dev_watchdog+0x215/0x220
  Jul  4 15:00:50 hagen kernel: Modules linked in: ip6t_rpfilter
ip6t_REJECT nf_reject_ipv6 xt_conntrack ip_set nfnetlink ebtable_nat
ebtable_broute bridge stp llc ip6table_raw ip6table_security
ip6table_nat nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6
ip6table_mangle iptable_raw iptable_security iptable_nat
nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack
iptable_mangle ebtable_filter ebtables ip6table_filter ip6_tables
sunrpc xfs libcrc32c amd64_edac_mod edac_mce_amd kvm_amd kvm dcdbas
irqbypass ipmi_ssif acpi_cpufreq shpchp ipmi_si ipmi_devintf tpm_tis
pcspkr tpm_tis_core k10temp i2c_piix4 ipmi_msghandler tpm
target_core_mod amdkfd amd_iommu_v2 radeon i2c_algo_bit drm_kms_helper
ttm drm tg3 ptp ata_generic serio_raw pata_acpi pps_core
pata_serverworks sata_svw
  Jul  4 15:00:50 hagen kernel: CPU: 6 PID: 0 Comm: swapper/6 Not
tainted 4.12.0broken+ #16
  Jul  4 15:00:50 hagen kernel: Hardware name: Dell Inc. PowerEdge
SC1435/0H313M, BIOS 2.2.5 03/21/2008
  Jul  4 15:00:50 hagen kernel: task: ffff90a9ede5c980 task.stack:
ffffb123031b4000
  Jul  4 15:00:50 hagen kernel: RIP: 0010:dev_watchdog+0x215/0x220
  Jul  4 15:00:50 hagen kernel: RSP: 0018:ffff90a9efd83e60 EFLAGS: 00010286
  Jul  4 15:00:50 hagen kernel: RAX: 0000000000000039 RBX:
0000000000000000 RCX: 0000000000000000
  Jul  4 15:00:50 hagen kernel: RDX: 0000000000000000 RSI:
00000000000000f6 RDI: 0000000000000300
  Jul  4 15:00:50 hagen kernel: RBP: ffff90a9efd83e80 R08:
0000000000000000 R09: 0000000000000346
  Jul  4 15:00:50 hagen kernel: R10: ffff90a9efd92430 R11:
000000000000000f R12: ffff90a9ece46000
  Jul  4 15:00:50 hagen kernel: R13: 0000000000000006 R14:
0000000000000005 R15: ffff90a9ece46000
  Jul  4 15:00:50 hagen kernel: FS:  0000000000000000(0000)
GS:ffff90a9efd80000(0000) knlGS:0000000000000000
  Jul  4 15:00:50 hagen kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
  Jul  4 15:00:50 hagen kernel: CR2: 000055d4fa41f038 CR3:
00000004c3e09000 CR4: 00000000000006e0
  Jul  4 15:00:50 hagen kernel: Call Trace:
  Jul  4 15:00:50 hagen kernel: <IRQ>
  Jul  4 15:00:50 hagen kernel: ? qdisc_rcu_free+0x50/0x50
  Jul  4 15:00:50 hagen kernel: call_timer_fn+0x35/0x130
  Jul  4 15:00:50 hagen kernel: run_timer_softirq+0x1d1/0x420
  Jul  4 15:00:50 hagen kernel: ? sched_clock+0x9/0x10
  Jul  4 15:00:50 hagen kernel: ? sched_clock+0x9/0x10
  Jul  4 15:00:50 hagen kernel: ? sched_clock_cpu+0x11/0xb0
  Jul  4 15:00:50 hagen kernel: __do_softirq+0x10c/0x2a5
  Jul  4 15:00:50 hagen kernel: irq_exit+0xff/0x110
  Jul  4 15:00:50 hagen kernel: smp_apic_timer_interrupt+0x3d/0x50
  Jul  4 15:00:50 hagen kernel: apic_timer_interrupt+0x93/0xa0
  Jul  4 15:00:50 hagen kernel: RIP: 0010:native_safe_halt+0x6/0x10
  Jul  4 15:00:50 hagen kernel: RSP: 0018:ffffb123031b7e60 EFLAGS:
00000246 ORIG_RAX: ffffffffffffff10
  Jul  4 15:00:50 hagen kernel: RAX: 6874754100002548 RBX:
ffff90a9ede5c980 RCX: 0000000000000000
  Jul  4 15:00:50 hagen kernel: RDX: 0000000000000000 RSI:
0000000000000000 RDI: 0000000000000000
  Jul  4 15:00:50 hagen kernel: RBP: ffffb123031b7e60 R08:
00000009c80ff365 R09: ffffb1230837fa38
  Jul  4 15:00:50 hagen kernel: R10: 0000000000000000 R11:
00000000fffc0fe9 R12: 0000000000000006
  Jul  4 15:00:50 hagen kernel: R13: ffff90a9ede5c980 R14:
0000000000000000 R15: 0000000000000000
  Jul  4 15:00:50 hagen kernel: </IRQ>
  Jul  4 15:00:50 hagen kernel: default_idle+0x20/0x100
  Jul  4 15:00:50 hagen kernel: amd_e400_idle+0x3f/0x50
  Jul  4 15:00:50 hagen kernel: arch_cpu_idle+0xf/0x20
  Jul  4 15:00:50 hagen kernel: default_idle_call+0x23/0x30
  Jul  4 15:00:50 hagen kernel: do_idle+0x174/0x1e0
  Jul  4 15:00:50 hagen kernel: cpu_startup_entry+0x71/0x80
  Jul  4 15:00:50 hagen kernel: start_secondary+0x154/0x190
  Jul  4 15:00:50 hagen kernel: secondary_startup_64+0x9f/0x9f
  Jul  4 15:00:50 hagen kernel: Code: 8c 24 64 04 00 00 eb 8f 4c 89 e7
c6 05 ef 0e 88 00 01 e8 4f 6b fd ff 89 d9 48 89 c2 4c 89 e6 48 c7 c7
60 a0 d1 86 e8 12 cc a5 ff <0f> ff eb c1 0f 1f 80 00 00 00 00 0f 1f 44
00 00 48 c7 47 08 00
  Jul  4 15:00:50 hagen kernel: ---[ end trace 6fdc4540cb931145 ]---
  Jul  4 15:00:50 hagen kernel: tg3 0000:01:00.0 enp1s0: transmit
timed out, resetting
  Jul  4 15:00:52 hagen abrt-dump-journal-oops:
abrt-dump-journal-oops: Found oopses: 1
  Jul  4 15:00:52 hagen abrt-dump-journal-oops:
abrt-dump-journal-oops: Creating problem directories
  Jul  4 15:00:52 hagen kernel: tg3 0000:01:00.0 enp1s0: 0x00000000:
0x165914e4, 0x00100406, 0x02000021, 0x00000010
  Jul  4 15:00:52 hagen kernel: tg3 0000:01:00.0 enp1s0: 0x00000010:
0xefef0004, 0x00000000, 0x00000000, 0x00000000
    ...
  Jul  4 15:00:53 hagen kernel: tg3 0000:01:00.0 enp1s0: 0x00007810:
0x00000000, 0x00000060, 0x00000000, 0x00000000
  Jul  4 15:00:53 hagen kernel: tg3 0000:01:00.0 enp1s0: 0: Host
status block [00000001:00000014:(0000:0005:0000):(0005:000c)]
  Jul  4 15:00:53 hagen kernel: tg3 0000:01:00.0 enp1s0: 0: NAPI info
[00000014:00000014:(0010:000c:01ff):0005:(00cd:0000:0000:0000)]
  Jul  4 15:00:53 hagen kernel: tg3 0000:01:00.0: tg3_stop_block timed
out, ofs=4800 enable_bit=2
  Jul  4 15:00:53 hagen kernel: tg3 0000:01:00.0 enp1s0: Link is down
  Jul  4 15:00:53 hagen abrt-dump-journal-oops: Reported 1 kernel oopses to Abrt
  Jul  4 15:00:53 hagen abrt-server: Deleting problem directory
oops-2017-07-04-15:00:52-889-0 (dup of oops-2017-07-03-12:49:03-930-0)


Version-Release number of selected component (if applicable):
=============================================================
The issue was first noticeable under Fedora 25 updating the kernel
from version 4.10.x => 4.11.0.

Given I needed to move forward with latest version of available kernel
i decided to hunt the bug and report.
I found it to be cause under all (linux) kernels from commit
60db3a4d8cc9073cf56264785197ba75ee1caca4

* <wtenhave@hagen:55> git bisect good
  60db3a4d8cc9073cf56264785197ba75ee1caca4 is the first bad commit
  commit 60db3a4d8cc9073cf56264785197ba75ee1caca4
  Author: Sinan Kaya <okaya@codeaurora.org>
  Date:   Fri Jan 20 09:16:51 2017 -0500

    PCI: Enable PCIe Extended Tags if supported



How reproducible:
=================
It is 100% reproducible.  In fact you can take latest kernel out today
and back-out the change as done under;
  commit 60db3a4d8cc9073cf56264785197ba75ee1caca4

  <wtenhave@hagen:55> git log 60db3a4d8cc9073cf56264785197ba75ee1caca4
  commit 60db3a4d8cc9073cf56264785197ba75ee1caca4
  Author: Sinan Kaya <okaya@codeaurora.org>
  Date:   Fri Jan 20 09:16:51 2017 -0500

    PCI: Enable PCIe Extended Tags if supported

    Every PCIe device can generate 5-bit transaction Tags, which allow up to 32
    concurrent requests.  Some devices can generate 8-bit Extended Tags, which
    allow up to 256 concurrent requests.

    Per the ECN mentioned below, all PCIe Receivers are expected to support
    Extended Tags, so devices are allowed (but not required) to enable them by
    default.

    If a device supports Extended Tags but does not enable them by default,
    enable them.  This allows the device to have up to 256 outstanding
    transactions at a time, which may improve performance.

    [bhelgaas: changelog, check for PCIe device]
    Link: https://pcisig.com/sites/default/files/specification_documents/ECN_Extended_Tag_Enable_Default_05Sept2008_final.pdf
    Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>


To back-out take any kernel later then 4.11 and apply below code
change.  Then build and install that kernel.

  <wtenhave@hagen:58> git diff
  diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
  index 19c8950..1005e9d 100644
  --- a/drivers/pci/probe.c
  +++ b/drivers/pci/probe.c
  @@ -1707,7 +1707,7 @@ static void pci_configure_device(struct pci_dev *dev)
          int ret;

          pci_configure_mps(dev);
  -       pci_configure_extended_tags(dev);
  +       // pci_configure_extended_tags(dev);

          memset(&hpp, 0, sizeof(hpp));
          ret = pci_get_hp_params(dev, &hpp);


Steps to Reproduce:
===================
1. Take a machine with appropriate h/w like a Dell Inc. PowerEdge
SC1435/0H313M, BIOS 2.2.5 03/21/2008 with Tigon3 [partno(BCM95721) rev
4201] (PCI Express) controller
2. Install Fedora25 or (other) with kernel including specific
code/commit like kernel-4.11.7-200.fc25.x86_64
3. Boot and see it crash as soon it starts to operate on specific PCI
Express Ethernet controller.

Actual results:

Expected results:

Additional info:
================
If you need further input please drop me a line at;
"Wim ten Have <wim.ten.have@oracle.com>"

Regards,
- Wim.
