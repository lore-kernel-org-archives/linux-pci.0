Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:57473 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755289Ab2EUBqM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 20 May 2012 21:46:12 -0400
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id E2C283EE0C1
	for <linux-pci@vger.kernel.org>; Mon, 21 May 2012 10:46:09 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
	by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id AF65745DE4F
	for <linux-pci@vger.kernel.org>; Mon, 21 May 2012 10:46:09 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
	by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 59EB745DE55
	for <linux-pci@vger.kernel.org>; Mon, 21 May 2012 10:46:09 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 41E61E38003
	for <linux-pci@vger.kernel.org>; Mon, 21 May 2012 10:46:09 +0900 (JST)
Received: from m107.s.css.fujitsu.com (m107.s.css.fujitsu.com [10.240.81.147])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id D6F161DB8040
	for <linux-pci@vger.kernel.org>; Mon, 21 May 2012 10:46:08 +0900 (JST)
Date: Mon, 21 May 2012 10:45:59 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jiang Liu <liuj97@gmail.com>, Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 0/6] PCI, x86: update MMCFG information when
 hot-plugging PCI host bridges
Message-Id: <20120521104559.92c3246b.izumi.taku@jp.fujitsu.com>
In-Reply-To: <CAErSpo6SFyRCGoTP5TsEK8Zr8ZZ9ZUwjGucXQ2F6yYQq+WvaJg@mail.gmail.com>
References: <1336186830-10765-1-git-send-email-jiang.liu@huawei.com>
	<20120508172153.b67a8cc6.izumi.taku@jp.fujitsu.com>
	<4FA950A5.6040106@gmail.com>
	<20120509162117.63d8c155.izumi.taku@jp.fujitsu.com>
	<4FAA4754.1010803@gmail.com>
	<CAErSpo6SFyRCGoTP5TsEK8Zr8ZZ9ZUwjGucXQ2F6yYQq+WvaJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Mon__21_May_2012_10_45_59_+0900_E9OWCe_pY1gi0z05"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a multi-part message in MIME format.

--Multipart=_Mon__21_May_2012_10_45_59_+0900_E9OWCe_pY1gi0z05
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 18 May 2012 10:36:09 -0600
Bjorn Helgaas <bhelgaas@google.com> wrote:

> On Wed, May 9, 2012 at 4:30 AM, Jiang Liu <liuj97@gmail.com> wrote:
> > Thanks, Taku!
> >
> > On 05/09/2012 03:21 PM, Taku Izumi wrote:
> >> On Wed, 09 May 2012 00:58:13 +0800
> >> Jiang Liu <liuj97@gmail.com> wrote:
> >>
> >>> Hi Taku,
> >>>      Thanks for testing. Could you please help to try the patch below?
> >>
> >>   Hi Jian,
> >>   I confirmed this patch solves my problem.
> 
> Can you fold this patch in, Jian?
> 
> Taku, I'm curious about your machine.  Are there devices on [bus
> 14-ff]?  I assume that with Jian's patch, we only map MMCONFIG space
> for [bus 00-13], but I'd like to confirm that.  A complete dmesg log
> would answer both questions.
> 
> I think the right thing is to map MMCONFIG space for [bus 00-13].  If
> there are devices on [bus 14-ff], they should still work; it's just
> that we wouldn't be able to access their extended config space.
> 
> Bjorn
> 

 Hi Bjorn,
 I attached a dmesg output (this patchset is NOT applied)
 Only one device seems to exist on bus 0x14.
  
[root@TX150-F14 ~]# lspci
00:00.0 Host bridge: Intel Corporation E7230/3000/3010 Memory Controller Hub (rev c0)
00:01.0 PCI bridge: Intel Corporation E7230/3000/3010 PCI Express Root Port (rev c0)
00:1c.0 PCI bridge: Intel Corporation N10/ICH 7 Family PCI Express Port 1 (rev 01)
00:1c.4 PCI bridge: Intel Corporation 82801GR/GH/GHM (ICH7 Family) PCI Express Port 5 (rev 01)
00:1c.5 PCI bridge: Intel Corporation 82801GR/GH/GHM (ICH7 Family) PCI Express Port 6 (rev 01)
00:1d.0 USB Controller: Intel Corporation N10/ICH 7 Family USB UHCI Controller #1 (rev 01)
00:1d.1 USB Controller: Intel Corporation N10/ICH 7 Family USB UHCI Controller #2 (rev 01)
00:1d.2 USB Controller: Intel Corporation N10/ICH 7 Family USB UHCI Controller #3 (rev 01)
00:1d.3 USB Controller: Intel Corporation N10/ICH 7 Family USB UHCI Controller #4 (rev 01)
00:1d.7 USB Controller: Intel Corporation N10/ICH 7 Family USB2 EHCI Controller (rev 01)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev e1)
00:1f.0 ISA bridge: Intel Corporation 82801GB/GR (ICH7 Family) LPC Interface Bridge (rev 01)
00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE Controller (rev 01)
00:1f.2 IDE interface: Intel Corporation N10/ICH7 Family SATA IDE Controller (rev 01)
00:1f.3 SMBus: Intel Corporation N10/ICH 7 Family SMBus Controller (rev 01)
01:00.0 PCI bridge: Intel Corporation 6702PXH PCI Express-to-PCI Bridge A (rev 09)
02:05.0 SCSI storage controller: LSI Logic / Symbios Logic SAS1068 PCI-X Fusion-MPT SAS (rev 01)
02:09.0 Ethernet controller: Intel Corporation 82546GB Gigabit Ethernet Controller (rev 03)
02:09.1 Ethernet controller: Intel Corporation 82546GB Gigabit Ethernet Controller (rev 03)
0d:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5721 Gigabit Ethernet PCI Express (rev 21)
14:03.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200e [Pilot] ServerEngines (SEP1) (rev 02)

-- 
Taku Izumi <izumi.taku@jp.fujitsu.com>

--Multipart=_Mon__21_May_2012_10_45_59_+0900_E9OWCe_pY1gi0z05
Content-Type: text/plain;
 name="dmesg.txt"
Content-Disposition: attachment;
 filename="dmesg.txt"
Content-Transfer-Encoding: quoted-printable

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.4.0-rc4 (root@TX150-F14) (gcc version 4.5.1 =
20100924 (Red Hat 4.5.1-4) (GCC) ) #12 SMP Mon May 21 10:04:56 JST 2012
[    0.000000] Command line: ro root=3DUUID=3D60f201b4-4f3c-4261-a40a-8728a=
1492ef2 rd_NO_LUKS rd_NO_LVM rd_NO_MD rd_NO_DM LANG=3Dja_JP.UTF-8 KEYTABLE=
=3Djp106 crashkernel=3Dauto
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
[    0.000000]  BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000ce000 - 00000000000d0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000efee0000 (usable)
[    0.000000]  BIOS-e820: 00000000efee0000 - 00000000efeed000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000efeed000 - 00000000eff00000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000eff00000 - 00000000f4000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fed00000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
[    0.000000]  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 0000000190000000 (usable)
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] DMI present.
[    0.000000] DMI: FUJITSU-SV      PRIMERGY            /D2399, BIOS 4.06  =
Rev. 1.06.2399             05/04/2007
[    0.000000] e820 update range: 0000000000000000 - 0000000000010000 (usab=
le) =3D=3D> (reserved)
[    0.000000] e820 remove range: 00000000000a0000 - 0000000000100000 (usab=
le)
[    0.000000] No AGP bridge found
[    0.000000] last_pfn =3D 0x190000 max_arch_pfn =3D 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-C7FFF write-protect
[    0.000000]   C8000-E3FFF uncachable
[    0.000000]   E4000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0F0000000 mask FF0000000 uncachable
[    0.000000]   1 base 000000000 mask F00000000 write-back
[    0.000000]   2 base 100000000 mask F80000000 write-back
[    0.000000]   3 base 180000000 mask FF0000000 write-back
[    0.000000]   4 base 0EFF00000 mask FFFF00000 uncachable
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x701060007=
0106
[    0.000000] original variable MTRRs
[    0.000000] reg 0, base: 3840MB, range: 256MB, type UC
[    0.000000] reg 1, base: 0GB, range: 4GB, type WB
[    0.000000] reg 2, base: 4GB, range: 2GB, type WB
[    0.000000] reg 3, base: 6GB, range: 256MB, type WB
[    0.000000] reg 4, base: 3839MB, range: 1MB, type UC
[    0.000000] total RAM covered: 6143M
[    0.000000] Found optimal setting for mtrr clean up
[    0.000000]  gran_size: 64K 	chunk_size: 512M 	num_reg: 6  	lose cover R=
AM: 0G
[    0.000000] New variable MTRRs
[    0.000000] reg 0, base: 0GB, range: 4GB, type WB
[    0.000000] reg 1, base: 3839MB, range: 1MB, type UC
[    0.000000] reg 2, base: 3840MB, range: 256MB, type UC
[    0.000000] reg 3, base: 4GB, range: 2GB, type WB
[    0.000000] reg 4, base: 6GB, range: 512MB, type WB
[    0.000000] reg 5, base: 6400MB, range: 256MB, type UC
[    0.000000] e820 update range: 00000000eff00000 - 0000000100000000 (usab=
le) =3D=3D> (reserved)
[    0.000000] last_pfn =3D 0xefee0 max_arch_pfn =3D 0x400000000
[    0.000000] found SMP MP-table at [ffff8800000f7530] f7530
[    0.000000] initial memory mapped : 0 - 20000000
[    0.000000] Base memory trampoline at [ffff880000099000] 99000 size 20480
[    0.000000] init_memory_mapping: 0000000000000000-00000000efee0000
[    0.000000]  0000000000 - 00efe00000 page 2M
[    0.000000]  00efe00000 - 00efee0000 page 4k
[    0.000000] kernel direct mapping tables up to efee0000 @ 1fffa000-20000=
000
[    0.000000] init_memory_mapping: 0000000100000000-0000000190000000
[    0.000000]  0100000000 - 0190000000 page 2M
[    0.000000] kernel direct mapping tables up to 190000000 @ efed8000-efee=
0000
[    0.000000] RAMDISK: 378a0000 - 37ff0000
[    0.000000] crashkernel: memory value expected
[    0.000000] ACPI: RSDP 00000000000f7590 00024 (v02 PTLTD )
[    0.000000] ACPI: XSDT 00000000efee8680 0005C (v01 PTLTD  ? XSDT   06040=
001  LTP 00000000)
[    0.000000] ACPI: FACP 00000000efee8750 000F4 (v03 FSC             06040=
001      000F4240)
[    0.000000] ACPI: DSDT 00000000efee8844 0439E (v01 FSC    D2399    06040=
001 MSFT 03000000)
[    0.000000] ACPI: FACS 00000000efeedfc0 00040
[    0.000000] ACPI: SPCR 00000000efeecbe2 00050 (v01 PTLTD  $UCRTBL$ 06040=
001 PTL  00000001)
[    0.000000] ACPI: SSDT 00000000efeecc32 0017C (v01 FSC    EISTCPU0 06040=
001  CSF 00000001)
[    0.000000] ACPI: SSDT 00000000efeecdae 0017C (v01 FSC    EISTCPU1 06040=
001  CSF 00000001)
[    0.000000] ACPI: MCFG 00000000efeecf2a 00040 (v01 PTLTD    MCFG   06040=
001  LTP 00000000)
[    0.000000] ACPI: APIC 00000000efeecf6a 0006E (v01 FSC    ? APIC   06040=
001  CSF 00000000)
[    0.000000] ACPI: BOOT 00000000efeecfd8 00028 (v01 PTLTD  $SBFTBL$ 06040=
001  LTP 00000001)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-0000000190000000
[    0.000000] Initmem setup node 0 0000000000000000-0000000190000000
[    0.000000]   NODE_DATA [000000018ffec000 - 000000018fffffff]
[    0.000000]  [ffffea0000000000-ffffea00063fffff] PMD -> [ffff88018960000=
0-ffff88018f5fffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x00190000
[    0.000000] Movable zone start PFN for each node
[    0.000000] Early memory PFN ranges
[    0.000000]     0: 0x00000010 -> 0x0000009e
[    0.000000]     0: 0x00000100 -> 0x000efee0
[    0.000000]     0: 0x00100000 -> 0x00190000
[    0.000000] On node 0 totalpages: 1572462
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 5 pages reserved
[    0.000000]   DMA zone: 3913 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 16320 pages used for memmap
[    0.000000]   DMA32 zone: 962336 pages, LIFO batch:31
[    0.000000]   Normal zone: 9216 pages used for memmap
[    0.000000]   Normal zone: 580608 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0xf008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-=
23
[    0.000000] ACPI: IOAPIC (id[0x03] address[0xfecc0000] gsi_base[24])
[    0.000000] IOAPIC[1]: apic_id 3, version 32, address 0xfecc0000, GSI 24=
-47
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] SMP: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] nr_irqs_gsi: 64
[    0.000000] PM: Registered nosave memory: 000000000009e000 - 00000000000=
9f000
[    0.000000] PM: Registered nosave memory: 000000000009f000 - 00000000000=
a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000=
ce000
[    0.000000] PM: Registered nosave memory: 00000000000ce000 - 00000000000=
d0000
[    0.000000] PM: Registered nosave memory: 00000000000d0000 - 00000000000=
e0000
[    0.000000] PM: Registered nosave memory: 00000000000e0000 - 00000000001=
00000
[    0.000000] PM: Registered nosave memory: 00000000efee0000 - 00000000efe=
ed000
[    0.000000] PM: Registered nosave memory: 00000000efeed000 - 00000000eff=
00000
[    0.000000] PM: Registered nosave memory: 00000000eff00000 - 00000000f40=
00000
[    0.000000] PM: Registered nosave memory: 00000000f4000000 - 00000000fec=
00000
[    0.000000] PM: Registered nosave memory: 00000000fec00000 - 00000000fed=
00000
[    0.000000] PM: Registered nosave memory: 00000000fed00000 - 00000000fee=
00000
[    0.000000] PM: Registered nosave memory: 00000000fee00000 - 00000000fef=
00000
[    0.000000] PM: Registered nosave memory: 00000000fef00000 - 00000000ffb=
00000
[    0.000000] PM: Registered nosave memory: 00000000ffb00000 - 00000001000=
00000
[    0.000000] Allocating PCI resources starting at f4000000 (gap: f4000000=
:ac00000)
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:256 nr_cpumask_bits:256 nr_cpu_ids:2 n=
r_node_ids:1
[    0.000000] PERCPU: Embedded 27 pages/cpu @ffff88018fc00000 s81856 r8192=
 d20544 u1048576
[    0.000000] pcpu-alloc: s81856 r8192 d20544 u1048576 alloc=3D1*2097152
[    0.000000] pcpu-alloc: [0] 0 1=20
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Tota=
l pages: 1546857
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: ro root=3DUUID=3D60f201b4-4f3c-4261-a40=
a-8728a1492ef2 rd_NO_LUKS rd_NO_LVM rd_NO_MD rd_NO_DM LANG=3Dja_JP.UTF-8 KE=
YTABLE=3Djp106 crashkernel=3Dauto
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 6103396k/6553600k available (4841k kernel code, 2637=
52k absent, 186452k reserved, 6170k data, 900k init)
[    0.000000] SLUB: Genslabs=3D15, HWalign=3D64, Order=3D0-3, MinObjects=
=3D0, CPUs=3D2, Nodes=3D1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] NR_IRQS:16640 nr_irqs:512 16
[    0.000000] Extended CMOS year: 2000
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] allocated 25165824 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=3Dmemory' option if you don't wan=
t memory cgroups
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 1862.141 MHz processor.
[    0.003005] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 3724.28 BogoMIPS (lpj=3D1862141)
[    0.003493] pid_max: default: 32768 minimum: 301
[    0.003771] Security Framework initialized
[    0.004017] SELinux:  Initializing.
[    0.004269] SELinux:  Starting in permissive mode
[    0.005703] Dentry cache hash table entries: 1048576 (order: 11, 8388608=
 bytes)
[    0.013304] Inode-cache hash table entries: 524288 (order: 10, 4194304 b=
ytes)
[    0.016883] Mount-cache hash table entries: 256
[    0.017373] Initializing cgroup subsys cpuacct
[    0.017619] Initializing cgroup subsys memory
[    0.018029] Initializing cgroup subsys devices
[    0.018272] Initializing cgroup subsys freezer
[    0.018514] Initializing cgroup subsys net_cls
[    0.018757] Initializing cgroup subsys blkio
[    0.019047] CPU: Physical Processor ID: 0
[    0.019290] CPU: Processor Core ID: 0
[    0.019532] mce: CPU supports 6 MCE banks
[    0.019781] CPU0: Thermal monitoring enabled (TM2)
[    0.020005] using mwait in idle threads.
[    0.020798] ACPI: Core revision 20120320
[    0.024032] ftrace: allocating 22099 entries in 87 pages
[    0.032547] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.042817] CPU0: Intel(R) Xeon(R) CPU            3040  @ 1.86GHz steppi=
ng 02
[    0.043996] Performance Events: PEBS fmt0-, 4-deep LBR, Core2 events, In=
tel PMU driver.
[    0.043996] PEBS disabled due to CPU errata.
[    0.043996] ... version:                2
[    0.043999] ... bit width:              40
[    0.044240] ... generic registers:      2
[    0.044481] ... value mask:             000000ffffffffff
[    0.044723] ... max period:             000000007fffffff
[    0.044998] ... fixed-purpose events:   3
[    0.045238] ... event mask:             0000000700000003
[    0.045774] Booting Node   0, Processors  #1 Ok.
[    0.058021] Brought up 2 CPUs
[    0.058263] Total of 2 processors activated (7448.56 BogoMIPS).
[    0.059133] devtmpfs: initialized
[    0.064239] PM: Registering ACPI NVS region [mem 0xefeed000-0xefefffff] =
(77824 bytes)
[    0.066025] atomic64 test passed for x86-64 platform with CX8 and with S=
SE
[    0.066290] RTC time:  1:10:13, date: 05/21/12
[    0.066581] NET: Registered protocol family 16
[    0.067343] ACPI: bus type pci registered
[    0.067663] PCI: MMCONFIG for domain 0000 [bus 00-13] at [mem 0xf0000000=
-0xf13fffff] (base 0xf0000000)
[    0.067997] PCI: MMCONFIG at [mem 0xf0000000-0xf13fffff] reserved in E820
[    0.071459] PCI: Using configuration type 1 for base access
[    0.073453] bio: create slab <bio-0> at 0
[    0.073453] ACPI: Added _OSI(Module Device)
[    0.073997] ACPI: Added _OSI(Processor Device)
[    0.074239] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.074481] ACPI: Added _OSI(Processor Aggregator Device)
[    0.075836] ACPI: EC: Look up EC in DSDT
[    0.078701] ACPI: Interpreter enabled
[    0.078940] ACPI: (supports S0 S1 S4 S5)
[    0.079305] ACPI: Using IOAPIC for interrupt routing
[    0.084583] ACPI: No dock devices found.
[    0.084828] PCI: Ignoring host bridge windows from ACPI; if necessary, u=
se "pci=3Duse_crs" and report a bug
[    0.085104] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.085513] pci_root PNP0A03:00: host bridge window [io  0x0000-0x0cf7] =
(ignored)
[    0.085518] pci_root PNP0A03:00: host bridge window [io  0x0d00-0xffff] =
(ignored)
[    0.085521] pci_root PNP0A03:00: host bridge window [mem 0x000a0000-0x00=
0bffff] (ignored)
[    0.085525] pci_root PNP0A03:00: host bridge window [mem 0x000c8000-0x00=
0dffff] (ignored)
[    0.085529] pci_root PNP0A03:00: host bridge window [mem 0xf4000000-0xfe=
bfffff] (ignored)
[    0.085532] pci_root PNP0A03:00: host bridge window [mem 0xfed00000-0xfe=
dfffff] (ignored)
[    0.085536] pci_root PNP0A03:00: host bridge window [mem 0xfef00000-0xff=
afffff] (ignored)
[    0.085539] pci_root PNP0A03:00: host bridge window [mem 0xffc00000-0xff=
efffff] (ignored)
[    0.085543] PCI: root bus 00: using default resources
[    0.085589] PCI host bridge to bus 0000:00
[    0.085996] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.086242] pci_bus 0000:00: root bus resource [mem 0x00000000-0xfffffff=
ff]
[    0.086499] pci 0000:00:00.0: [8086:2778] type 00 class 0x060000
[    0.086551] pci 0000:00:01.0: [8086:2779] type 01 class 0x060400
[    0.086599] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.086647] pci 0000:00:1c.0: [8086:27d0] type 01 class 0x060400
[    0.086721] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.086753] pci 0000:00:1c.4: [8086:27e0] type 01 class 0x060400
[    0.086828] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.086854] pci 0000:00:1c.5: [8086:27e2] type 01 class 0x060400
[    0.087065] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    0.087090] pci 0000:00:1d.0: [8086:27c8] type 00 class 0x0c0300
[    0.087133] pci 0000:00:1d.0: reg 20: [io  0x2000-0x201f]
[    0.087167] pci 0000:00:1d.1: [8086:27c9] type 00 class 0x0c0300
[    0.087209] pci 0000:00:1d.1: reg 20: [io  0x2400-0x241f]
[    0.087243] pci 0000:00:1d.2: [8086:27ca] type 00 class 0x0c0300
[    0.087286] pci 0000:00:1d.2: reg 20: [io  0x2800-0x281f]
[    0.087320] pci 0000:00:1d.3: [8086:27cb] type 00 class 0x0c0300
[    0.087362] pci 0000:00:1d.3: reg 20: [io  0x2c00-0x2c1f]
[    0.087403] pci 0000:00:1d.7: [8086:27cc] type 00 class 0x0c0320
[    0.087422] pci 0000:00:1d.7: reg 10: [mem 0xfd000000-0xfd0003ff]
[    0.087499] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.087519] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401
[    0.087589] pci 0000:00:1f.0: [8086:27b8] type 00 class 0x060100
[    0.087677] pci 0000:00:1f.0: Force enabled HPET at 0xfed00000
[    0.087685] pci 0000:00:1f.0: quirk: [io  0xf000-0xf07f] claimed by ICH6=
 ACPI/GPIO/TCO
[    0.087998] pci 0000:00:1f.0: quirk: [io  0xf180-0xf1bf] claimed by ICH6=
 GPIO
[    0.088248] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at 0800 (=
mask 00ff)
[    0.088699] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 2 PIO at 0ca0 (=
mask 0007)
[    0.088996] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 3 PIO at 0e00 (=
mask 007f)
[    0.089447] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 4 PIO at 0400 (=
mask 000f)
[    0.090034] pci 0000:00:1f.1: [8086:27df] type 00 class 0x01018a
[    0.090049] pci 0000:00:1f.1: reg 10: [io  0x0000-0x0007]
[    0.090059] pci 0000:00:1f.1: reg 14: [io  0x0000-0x0003]
[    0.090070] pci 0000:00:1f.1: reg 18: [io  0x0000-0x0007]
[    0.090080] pci 0000:00:1f.1: reg 1c: [io  0x0000-0x0003]
[    0.090090] pci 0000:00:1f.1: reg 20: [io  0x3400-0x340f]
[    0.090129] pci 0000:00:1f.2: [8086:27c0] type 00 class 0x01018f
[    0.090144] pci 0000:00:1f.2: reg 10: [io  0x3430-0x3437]
[    0.090154] pci 0000:00:1f.2: reg 14: [io  0x3424-0x3427]
[    0.090163] pci 0000:00:1f.2: reg 18: [io  0x3428-0x342f]
[    0.090172] pci 0000:00:1f.2: reg 1c: [io  0x3420-0x3423]
[    0.090181] pci 0000:00:1f.2: reg 20: [io  0x3410-0x341f]
[    0.090191] pci 0000:00:1f.2: reg 24: [mem 0xfd000400-0xfd0007ff]
[    0.090223] pci 0000:00:1f.2: PME# supported from D3hot
[    0.090240] pci 0000:00:1f.3: [8086:27da] type 00 class 0x0c0500
[    0.090293] pci 0000:00:1f.3: reg 20: [io  0x3000-0x301f]
[    0.090368] pci 0000:01:00.0: [8086:032c] type 01 class 0x060400
[    0.090387] pci 0000:01:00.0: PXH quirk detected; SHPC device MSI disabl=
ed
[    0.090696] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    0.090719] pci 0000:01:00.0: disabling ASPM on pre-1.1 PCIe device.  Yo=
u can enable it with 'pcie_aspm=3Dforce'
[    0.091005] pci 0000:00:01.0: PCI bridge to [bus 01-02]
[    0.091249] pci 0000:00:01.0:   bridge window [io  0x4000-0x4fff]
[    0.091253] pci 0000:00:01.0:   bridge window [mem 0xfd100000-0xfd3fffff]
[    0.091312] pci 0000:02:05.0: [1000:0054] type 00 class 0x010000
[    0.091334] pci 0000:02:05.0: reg 10: [io  0x4000-0x40ff]
[    0.091350] pci 0000:02:05.0: reg 14: [mem 0xfd110000-0xfd113fff 64bit]
[    0.091366] pci 0000:02:05.0: reg 1c: [mem 0xfd100000-0xfd10ffff 64bit]
[    0.091386] pci 0000:02:05.0: reg 30: [mem 0x00000000-0x000fffff pref]
[    0.091435] pci 0000:02:05.0: supports D1 D2
[    0.091468] pci 0000:02:09.0: [8086:1079] type 00 class 0x020000
[    0.091493] pci 0000:02:09.0: reg 10: [mem 0xfd120000-0xfd13ffff 64bit]
[    0.091508] pci 0000:02:09.0: reg 18: [mem 0xfd180000-0xfd1bffff 64bit]
[    0.091519] pci 0000:02:09.0: reg 20: [io  0x4400-0x443f]
[    0.091538] pci 0000:02:09.0: reg 30: [mem 0x00000000-0x0003ffff pref]
[    0.091582] pci 0000:02:09.0: PME# supported from D0 D3hot D3cold
[    0.091612] pci 0000:02:09.1: [8086:1079] type 00 class 0x020000
[    0.091636] pci 0000:02:09.1: reg 10: [mem 0xfd340000-0xfd35ffff 64bit]
[    0.091652] pci 0000:02:09.1: reg 18: [mem 0xfd300000-0xfd33ffff 64bit]
[    0.091663] pci 0000:02:09.1: reg 20: [io  0x4800-0x483f]
[    0.091681] pci 0000:02:09.1: reg 30: [mem 0x00000000-0x0003ffff pref]
[    0.091726] pci 0000:02:09.1: PME# supported from D0 D3hot D3cold
[    0.091775] pci 0000:01:00.0: PCI bridge to [bus 02-02]
[    0.091996] pci 0000:01:00.0:   bridge window [io  0x4000-0x4fff]
[    0.092001] pci 0000:01:00.0:   bridge window [mem 0xfd100000-0xfd3fffff]
[    0.092052] pci 0000:00:1c.0: PCI bridge to [bus 07-07]
[    0.092368] pci 0000:0d:00.0: [14e4:1659] type 00 class 0x020000
[    0.092393] pci 0000:0d:00.0: reg 10: [mem 0xfd400000-0xfd40ffff 64bit]
[    0.092519] pci 0000:0d:00.0: PME# supported from D3hot D3cold
[    0.092545] pci 0000:0d:00.0: disabling ASPM on pre-1.1 PCIe device.  Yo=
u can enable it with 'pcie_aspm=3Dforce'
[    0.093004] pci 0000:00:1c.4: PCI bridge to [bus 0d-0d]
[    0.093251] pci 0000:00:1c.4:   bridge window [mem 0xfd400000-0xfd4fffff]
[    0.093298] pci 0000:00:1c.5: PCI bridge to [bus 0e-0e]
[    0.093587] pci 0000:14:03.0: [102b:0522] type 00 class 0x030000
[    0.093606] pci 0000:14:03.0: reg 10: [mem 0xfc000000-0xfcffffff pref]
[    0.093618] pci 0000:14:03.0: reg 14: [mem 0xfd500000-0xfd503fff]
[    0.093629] pci 0000:14:03.0: reg 18: [mem 0xfd800000-0xfdffffff]
[    0.093733] pci 0000:00:1e.0: PCI bridge to [bus 14-14] (subtractive dec=
ode)
[    0.093998] pci 0000:00:1e.0:   bridge window [mem 0xfd500000-0xfdffffff]
[    0.094005] pci 0000:00:1e.0:   bridge window [mem 0xfc000000-0xfcffffff=
 64bit pref]
[    0.094009] pci 0000:00:1e.0:   bridge window [io  0x0000-0xffff] (subtr=
active decode)
[    0.094013] pci 0000:00:1e.0:   bridge window [mem 0x00000000-0xffffffff=
f] (subtractive decode)
[    0.094037] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.094188] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEXA._PRT]
[    0.094248] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEXA.PXH0._PRT]
[    0.094341] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEXB._PRT]
[    0.094396] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEXC._PRT]
[    0.094451] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEXD._PRT]
[    0.094506] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIH._PRT]
[    0.094607]  pci0000:00: Requesting ACPI _OSC control (0x1d)
[    0.094853]  pci0000:00: ACPI _OSC request failed (AE_NOT_FOUND), return=
ed control mask: 0x1d
[    0.094994] ACPI _OSC control for PCIe not granted, disabling ASPM
[    0.099544] ACPI: PCI Interrupt Link [LNKA] (IRQs *9 10 11)
[    0.100018] ACPI: PCI Interrupt Link [LNKB] (IRQs 9 10 *11)
[    0.100484] ACPI: PCI Interrupt Link [LNKC] (IRQs 9 10 *11)
[    0.100929] ACPI: PCI Interrupt Link [LNKD] (IRQs *9 10 11)
[    0.101361] ACPI: PCI Interrupt Link [LNKE] (IRQs *9 10 11)
[    0.101800] ACPI: PCI Interrupt Link [LNKF] (IRQs 9 10 11) *5
[    0.102264] ACPI: PCI Interrupt Link [LNKG] (IRQs 9 *10 11)
[    0.102728] ACPI: PCI Interrupt Link [LNKH] (IRQs 9 10 *11)
[    0.103072] vgaarb: device added: PCI:0000:14:03.0,decodes=3Dio+mem,owns=
=3Dio+mem,locks=3Dnone
[    0.103483] vgaarb: loaded
[    0.103993] vgaarb: bridge control possible 0000:14:03.0
[    0.104340] SCSI subsystem initialized
[    0.104591] libata version 3.00 loaded.
[    0.104591] usbcore: registered new interface driver usbfs
[    0.104591] usbcore: registered new interface driver hub
[    0.105011] usbcore: registered new device driver usb
[    0.105295] PCI: Using ACPI for IRQ routing
[    0.105607] PCI: pci_cache_line_size set to 64 bytes
[    0.106075] reserve RAM buffer: 000000000009e800 - 000000000009ffff=20
[    0.106079] reserve RAM buffer: 00000000efee0000 - 00000000efffffff=20
[    0.106226] NetLabel: Initializing
[    0.106466] NetLabel:  domain hash size =3D 128
[    0.106709] NetLabel:  protocols =3D UNLABELED CIPSOv4
[    0.106963] NetLabel:  unlabeled traffic allowed by default
[    0.107269] hpet clockevent registered
[    0.107273] HPET: 3 timers in total, 0 timers will be used for per-cpu t=
imer
[    0.107522] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.107993] hpet0: 3 comparators, 64-bit 14.318180 MHz counter
[    0.111014] Switching to clocksource hpet
[    0.123953] pnp: PnP ACPI init
[    0.124231] ACPI: bus type pnp registered
[    0.124621] pnp 00:00: [bus 00-ff]
[    0.124625] pnp 00:00: [io  0x0000-0x0cf7 window]
[    0.124628] pnp 00:00: [io  0x0d00-0xffff window]
[    0.124631] pnp 00:00: [mem 0x000a0000-0x000bffff window]
[    0.124634] pnp 00:00: [mem 0x000c8000-0x000dffff window]
[    0.124638] pnp 00:00: [mem 0xf0000000-0xefffffff window disabled]
[    0.124641] pnp 00:00: [mem 0xf4000000-0xfebfffff window]
[    0.124644] pnp 00:00: [mem 0xfed00000-0xfedfffff window]
[    0.124647] pnp 00:00: [mem 0xfef00000-0xffafffff window]
[    0.124650] pnp 00:00: [mem 0xffc00000-0xffefffff window]
[    0.124653] pnp 00:00: [io  0x0cf8-0x0cff]
[    0.124730] pnp 00:00: Plug and Play ACPI device, IDs PNP0a03 (active)
[    0.124955] pnp 00:01: [mem 0xffb00000-0xffbfffff]
[    0.125014] pnp 00:01: Plug and Play ACPI device, IDs INT0800 (active)
[    0.125173] pnp 00:02: [io  0x0010-0x001f]
[    0.125176] pnp 00:02: [io  0x0022-0x002d]
[    0.125179] pnp 00:02: [io  0x002e-0x002f]
[    0.125182] pnp 00:02: [io  0x0030-0x003f]
[    0.125184] pnp 00:02: [io  0x004e-0x004f]
[    0.125187] pnp 00:02: [io  0x0050-0x0053]
[    0.125194] pnp 00:02: [io  0x0062-0x0063]
[    0.125197] pnp 00:02: [io  0x0065-0x006f]
[    0.125200] pnp 00:02: [io  0x0072-0x0073]
[    0.125202] pnp 00:02: [io  0x0074-0x007f]
[    0.125205] pnp 00:02: [io  0x0090-0x009f]
[    0.125208] pnp 00:02: [io  0x00a2-0x00b1]
[    0.125210] pnp 00:02: [io  0x00b2-0x00b3]
[    0.125213] pnp 00:02: [io  0x00b4-0x00bf]
[    0.125215] pnp 00:02: [io  0x00ec-0x00ef]
[    0.125218] pnp 00:02: [io  0x0200-0x0207]
[    0.125221] pnp 00:02: [io  0x04d0-0x04d1]
[    0.125223] pnp 00:02: [io  0x0400-0x040f]
[    0.125226] pnp 00:02: [io  0x0800-0x087f]
[    0.125229] pnp 00:02: [io  0x0ca2-0x0ca3]
[    0.125231] pnp 00:02: [io  0x0ca4-0x0ca5]
[    0.125234] pnp 00:02: [io  0x0e00-0x0e7f]
[    0.125236] pnp 00:02: [io  0xf000-0xf07f]
[    0.125239] pnp 00:02: [io  0xf100-0xf10f]
[    0.125242] pnp 00:02: [io  0xf180-0xf1bf]
[    0.125244] pnp 00:02: [io  0xf820-0xf82f]
[    0.125247] pnp 00:02: [io  0xfe00]
[    0.125249] pnp 00:02: [mem 0xfec00000-0xfecfffff]
[    0.125252] pnp 00:02: [mem 0xfee00000-0xfeefffff]
[    0.125255] pnp 00:02: [mem 0xfed1c000-0xfed1ffff]
[    0.125258] pnp 00:02: [mem 0xfed13000-0xfed13fff]
[    0.125261] pnp 00:02: [mem 0xfed14000-0xfed17fff]
[    0.125264] pnp 00:02: [mem 0xfed18000-0xfed18fff]
[    0.125266] pnp 00:02: [mem 0xfed19000-0xfed19fff]
[    0.125269] pnp 00:02: [mem 0xf0000000-0xf3ffffff]
[    0.125413] system 00:02: [io  0x0200-0x0207] has been reserved
[    0.125660] system 00:02: [io  0x04d0-0x04d1] has been reserved
[    0.125905] system 00:02: [io  0x0400-0x040f] has been reserved
[    0.126160] system 00:02: [io  0x0800-0x087f] has been reserved
[    0.126405] system 00:02: [io  0x0ca2-0x0ca3] has been reserved
[    0.126651] system 00:02: [io  0x0ca4-0x0ca5] has been reserved
[    0.126897] system 00:02: [io  0x0e00-0x0e7f] has been reserved
[    0.127154] system 00:02: [io  0xf000-0xf07f] has been reserved
[    0.127399] system 00:02: [io  0xf100-0xf10f] has been reserved
[    0.127644] system 00:02: [io  0xf180-0xf1bf] has been reserved
[    0.127889] system 00:02: [io  0xf820-0xf82f] has been reserved
[    0.128143] system 00:02: [io  0xfe00] has been reserved
[    0.128390] system 00:02: [mem 0xfec00000-0xfecfffff] could not be reser=
ved
[    0.128623] system 00:02: [mem 0xfee00000-0xfeefffff] has been reserved
[    0.128846] system 00:02: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.129076] system 00:02: [mem 0xfed13000-0xfed13fff] has been reserved
[    0.129299] system 00:02: [mem 0xfed14000-0xfed17fff] has been reserved
[    0.129522] system 00:02: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.129745] system 00:02: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.129969] system 00:02: [mem 0xf0000000-0xf3ffffff] has been reserved
[    0.130220] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.130236] pnp 00:03: [io  0x0000-0x000f]
[    0.130239] pnp 00:03: [io  0x0080-0x008f]
[    0.130242] pnp 00:03: [io  0x00c0-0x00df]
[    0.130245] pnp 00:03: [dma 4]
[    0.130290] pnp 00:03: Plug and Play ACPI device, IDs PNP0200 (active)
[    0.130308] pnp 00:04: [io  0x0070-0x0071]
[    0.130324] pnp 00:04: [irq 8]
[    0.130373] pnp 00:04: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.130392] pnp 00:05: [io  0x00f0-0x00fe]
[    0.130398] pnp 00:05: [irq 13]
[    0.130444] pnp 00:05: Plug and Play ACPI device, IDs PNP0c04 (active)
[    0.130458] pnp 00:06: [io  0x0061]
[    0.130507] pnp 00:06: Plug and Play ACPI device, IDs PNP0800 (active)
[    0.130580] pnp 00:07: Plug and Play ACPI device, IDs PNP0103 (disabled)
[    0.130627] pnp 00:08: [io  0x0060]
[    0.130630] pnp 00:08: [io  0x0064]
[    0.130637] pnp 00:08: [irq 1]
[    0.130696] pnp 00:08: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.130776] pnp 00:09: [irq 12]
[    0.130835] pnp 00:09: Plug and Play ACPI device, IDs PNP0f13 (active)
[    0.130905] pnp 00:0a: [io  0x03f0-0x03f5]
[    0.130908] pnp 00:0a: [io  0x03f7]
[    0.130911] pnp 00:0a: [dma 2]
[    0.130917] pnp 00:0a: [irq 6]
[    0.130979] pnp 00:0a: Plug and Play ACPI device, IDs PNP0700 (active)
[    0.131148] pnp 00:0b: [io  0x0378-0x037b]
[    0.131155] pnp 00:0b: [irq 7]
[    0.131282] pnp 00:0b: Plug and Play ACPI device, IDs PNP0400 (active)
[    0.131521] pnp 00:0c: [io  0x03f8-0x03ff]
[    0.131528] pnp 00:0c: [irq 4]
[    0.131611] pnp 00:0c: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.131762] pnp 00:0d: [io  0x02f8-0x02ff]
[    0.131769] pnp 00:0d: [irq 3]
[    0.131855] pnp 00:0d: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.131863] pnp: PnP ACPI: found 14 devices
[    0.132114] ACPI: ACPI bus type pnp unregistered
[    0.140075] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus =
07-07] add_size 1000
[    0.140081] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff 6=
4bit pref] to [bus 07-07] add_size 200000
[    0.140086] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff] =
to [bus 07-07] add_size 200000
[    0.140096] pci 0000:00:1c.4: bridge window [io  0x1000-0x0fff] to [bus =
0d-0d] add_size 1000
[    0.140101] pci 0000:00:1c.4: bridge window [mem 0x00100000-0x000fffff 6=
4bit pref] to [bus 0d-0d] add_size 200000
[    0.140111] pci 0000:00:1c.5: bridge window [io  0x1000-0x0fff] to [bus =
0e-0e] add_size 1000
[    0.140115] pci 0000:00:1c.5: bridge window [mem 0x00100000-0x000fffff 6=
4bit pref] to [bus 0e-0e] add_size 200000
[    0.140120] pci 0000:00:1c.5: bridge window [mem 0x00100000-0x000fffff] =
to [bus 0e-0e] add_size 200000
[    0.140138] pci 0000:00:1c.0: res[14]=3D[mem 0x00100000-0x000fffff] get_=
res_add_size add_size 200000
[    0.140142] pci 0000:00:1c.0: res[15]=3D[mem 0x00100000-0x000fffff 64bit=
 pref] get_res_add_size add_size 200000
[    0.140147] pci 0000:00:1c.4: res[15]=3D[mem 0x00100000-0x000fffff 64bit=
 pref] get_res_add_size add_size 200000
[    0.140151] pci 0000:00:1c.5: res[14]=3D[mem 0x00100000-0x000fffff] get_=
res_add_size add_size 200000
[    0.140155] pci 0000:00:1c.5: res[15]=3D[mem 0x00100000-0x000fffff 64bit=
 pref] get_res_add_size add_size 200000
[    0.140159] pci 0000:00:1c.0: res[13]=3D[io  0x1000-0x0fff] get_res_add_=
size add_size 1000
[    0.140163] pci 0000:00:1c.4: res[13]=3D[io  0x1000-0x0fff] get_res_add_=
size add_size 1000
[    0.140166] pci 0000:00:1c.5: res[13]=3D[io  0x1000-0x0fff] get_res_add_=
size add_size 1000
[    0.140173] pci 0000:00:01.0: BAR 15: assigned [mem 0xf4000000-0xf41ffff=
f pref]
[    0.140623] pci 0000:00:1c.0: BAR 14: assigned [mem 0xf4200000-0xf43ffff=
f]
[    0.140871] pci 0000:00:1c.0: BAR 15: assigned [mem 0xf4400000-0xf45ffff=
f 64bit pref]
[    0.141328] pci 0000:00:1c.4: BAR 15: assigned [mem 0xf4600000-0xf47ffff=
f 64bit pref]
[    0.141778] pci 0000:00:1c.5: BAR 14: assigned [mem 0xf4800000-0xf49ffff=
f]
[    0.142034] pci 0000:00:1c.5: BAR 15: assigned [mem 0xf4a00000-0xf4bffff=
f 64bit pref]
[    0.142485] pci 0000:00:1c.0: BAR 13: assigned [io  0x1000-0x1fff]
[    0.142731] pci 0000:00:1c.4: BAR 13: assigned [io  0x5000-0x5fff]
[    0.142954] pci 0000:00:1c.5: BAR 13: assigned [io  0x6000-0x6fff]
[    0.143186] pci 0000:01:00.0: BAR 15: assigned [mem 0xf4000000-0xf41ffff=
f pref]
[    0.143589] pci 0000:02:05.0: BAR 6: assigned [mem 0xf4000000-0xf40fffff=
 pref]
[    0.143992] pci 0000:02:09.0: BAR 6: assigned [mem 0xf4100000-0xf413ffff=
 pref]
[    0.144417] pci 0000:02:09.1: BAR 6: assigned [mem 0xf4140000-0xf417ffff=
 pref]
[    0.144865] pci 0000:01:00.0: PCI bridge to [bus 02-02]
[    0.145116] pci 0000:01:00.0:   bridge window [io  0x4000-0x4fff]
[    0.145364] pci 0000:01:00.0:   bridge window [mem 0xfd100000-0xfd3fffff]
[    0.145612] pci 0000:01:00.0:   bridge window [mem 0xf4000000-0xf41fffff=
 pref]
[    0.146070] pci 0000:00:01.0: PCI bridge to [bus 01-02]
[    0.146314] pci 0000:00:01.0:   bridge window [io  0x4000-0x4fff]
[    0.146561] pci 0000:00:01.0:   bridge window [mem 0xfd100000-0xfd3fffff]
[    0.146809] pci 0000:00:01.0:   bridge window [mem 0xf4000000-0xf41fffff=
 pref]
[    0.147267] pci 0000:00:1c.0: PCI bridge to [bus 07-07]
[    0.147511] pci 0000:00:1c.0:   bridge window [io  0x1000-0x1fff]
[    0.147761] pci 0000:00:1c.0:   bridge window [mem 0xf4200000-0xf43fffff]
[    0.148017] pci 0000:00:1c.0:   bridge window [mem 0xf4400000-0xf45fffff=
 64bit pref]
[    0.148470] pci 0000:00:1c.4: PCI bridge to [bus 0d-0d]
[    0.148714] pci 0000:00:1c.4:   bridge window [io  0x5000-0x5fff]
[    0.148963] pci 0000:00:1c.4:   bridge window [mem 0xfd400000-0xfd4fffff]
[    0.149220] pci 0000:00:1c.4:   bridge window [mem 0xf4600000-0xf47fffff=
 64bit pref]
[    0.149673] pci 0000:00:1c.5: PCI bridge to [bus 0e-0e]
[    0.149916] pci 0000:00:1c.5:   bridge window [io  0x6000-0x6fff]
[    0.150172] pci 0000:00:1c.5:   bridge window [mem 0xf4800000-0xf49fffff]
[    0.150421] pci 0000:00:1c.5:   bridge window [mem 0xf4a00000-0xf4bfffff=
 64bit pref]
[    0.150873] pci 0000:00:1e.0: PCI bridge to [bus 14-14]
[    0.151126] pci 0000:00:1e.0:   bridge window [mem 0xfd500000-0xfdffffff]
[    0.151374] pci 0000:00:1e.0:   bridge window [mem 0xfc000000-0xfcffffff=
 64bit pref]
[    0.151849] pci 0000:00:1c.0: enabling device (0140 -> 0143)
[    0.152118] pci 0000:00:1c.5: enabling device (0140 -> 0143)
[    0.152369] pci 0000:00:1e.0: setting latency timer to 64
[    0.152374] pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
[    0.152377] pci_bus 0000:00: resource 5 [mem 0x00000000-0xfffffffff]
[    0.152380] pci_bus 0000:01: resource 0 [io  0x4000-0x4fff]
[    0.152384] pci_bus 0000:01: resource 1 [mem 0xfd100000-0xfd3fffff]
[    0.152387] pci_bus 0000:01: resource 2 [mem 0xf4000000-0xf41fffff pref]
[    0.152390] pci_bus 0000:02: resource 0 [io  0x4000-0x4fff]
[    0.152394] pci_bus 0000:02: resource 1 [mem 0xfd100000-0xfd3fffff]
[    0.152397] pci_bus 0000:02: resource 2 [mem 0xf4000000-0xf41fffff pref]
[    0.152400] pci_bus 0000:07: resource 0 [io  0x1000-0x1fff]
[    0.152404] pci_bus 0000:07: resource 1 [mem 0xf4200000-0xf43fffff]
[    0.152407] pci_bus 0000:07: resource 2 [mem 0xf4400000-0xf45fffff 64bit=
 pref]
[    0.152410] pci_bus 0000:0d: resource 0 [io  0x5000-0x5fff]
[    0.152414] pci_bus 0000:0d: resource 1 [mem 0xfd400000-0xfd4fffff]
[    0.152417] pci_bus 0000:0d: resource 2 [mem 0xf4600000-0xf47fffff 64bit=
 pref]
[    0.152420] pci_bus 0000:0e: resource 0 [io  0x6000-0x6fff]
[    0.152423] pci_bus 0000:0e: resource 1 [mem 0xf4800000-0xf49fffff]
[    0.152427] pci_bus 0000:0e: resource 2 [mem 0xf4a00000-0xf4bfffff 64bit=
 pref]
[    0.152430] pci_bus 0000:14: resource 1 [mem 0xfd500000-0xfdffffff]
[    0.152434] pci_bus 0000:14: resource 2 [mem 0xfc000000-0xfcffffff 64bit=
 pref]
[    0.152437] pci_bus 0000:14: resource 4 [io  0x0000-0xffff]
[    0.152441] pci_bus 0000:14: resource 5 [mem 0x00000000-0xfffffffff]
[    0.152501] NET: Registered protocol family 2
[    0.153103] IP route cache hash table entries: 262144 (order: 9, 2097152=
 bytes)
[    0.155492] TCP established hash table entries: 524288 (order: 11, 83886=
08 bytes)
[    0.162687] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.163770] TCP: Hash tables configured (established 524288 bind 65536)
[    0.164024] TCP: reno registered
[    0.164294] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    0.164659] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    0.165143] NET: Registered protocol family 1
[    0.165593] pci 0000:01:00.0: rerouting interrupts for [8086:032c]
[    0.165858] pci 0000:14:03.0: Boot video device
[    0.165863] PCI: CLS 32 bytes, default 64
[    0.165950] Trying to unpack rootfs image as initramfs...
[    0.363471] Freeing initrd memory: 7488k freed
[    0.367493] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.367750] Placing 64MB software IO TLB between ffff8800ebed8000 - ffff=
8800efed8000
[    0.368219] software IO TLB at phys 0xebed8000 - 0xefed8000
[    0.368632] Simple Boot Flag at 0x69 set to 0x1
[    0.369707] audit: initializing netlink socket (disabled)
[    0.369975] type=3D2000 audit(1337562612.368:1): initialized
[    0.395142] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.397730] VFS: Disk quotas dquot_6.5.2
[    0.398046] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.398905] msgmni has been set to 11935
[    0.399222] SELinux:  Registering netfilter hooks
[    0.399583] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 253)
[    0.399987] io scheduler noop registered
[    0.400241] io scheduler deadline registered
[    0.400555] io scheduler cfq registered (default)
[    0.400962] pcieport 0000:00:01.0: irq 64 for MSI/MSI-X
[    0.401068] pcieport 0000:00:1c.0: irq 65 for MSI/MSI-X
[    0.401172] pcieport 0000:00:1c.4: irq 66 for MSI/MSI-X
[    0.401284] pcieport 0000:00:1c.5: irq 67 for MSI/MSI-X
[    0.401389] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    0.401658] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    0.401904] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.402506] intel_idle: does not run on family 6 model 15
[    0.402604] input: Power Button as /devices/LNXSYSTM:00/device:00/PNP0C0=
C:00/input/input0
[    0.403066] ACPI: Power Button [PWRB]
[    0.403382] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input1
[    0.403831] ACPI: Power Button [PWRF]
[    0.404240] ACPI: Requesting acpi_cpufreq
[    0.407854] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.672155] serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
[    0.937154] serial8250: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
[    0.958379] 00:0c: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
[    0.979331] 00:0d: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
[    0.979974] Non-volatile memory driver v1.3
[    0.980231] Linux agpgart interface v0.103
[    0.982433] brd: module loaded
[    0.983640] loop: module loaded
[    0.983981] ata_piix 0000:00:1f.1: version 2.13
[    0.984049] ata_piix 0000:00:1f.1: setting latency timer to 64
[    0.984448] scsi0 : ata_piix
[    0.984798] scsi1 : ata_piix
[    0.985565] ata2: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0x3400 irq=
 14
[    0.985813] ata3: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x3408 irq=
 15
[    0.986116] ata_piix 0000:00:1f.2: enabling device (0045 -> 0047)
[    0.986409] ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
[    1.137042] ata_piix 0000:00:1f.2: setting latency timer to 64
[    1.137449] scsi2 : ata_piix
[    1.137752] scsi3 : ata_piix
[    1.138648] ata4: SATA max UDMA/133 cmd 0x3430 ctl 0x3424 bmdma 0x3410 i=
rq 19
[    1.138885] ata5: SATA max UDMA/133 cmd 0x3428 ctl 0x3420 bmdma 0x3418 i=
rq 19
[    1.139223] Fixed MDIO Bus: probed
[    1.139733] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.148159] ehci_hcd 0000:00:1d.7: setting latency timer to 64
[    1.148164] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[    1.148659] ata2.00: ATAPI: MATSHITADVD-RAM UJ-850S, 1.00, max UDMA/33
[    1.148727] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus =
number 1
[    1.148752] ehci_hcd 0000:00:1d.7: using broken periodic workaround
[    1.152657] ehci_hcd 0000:00:1d.7: cache line size of 32 is not supported
[    1.152679] ehci_hcd 0000:00:1d.7: irq 23, io mem 0xfd000000
[    1.155427] ata2.00: configured for UDMA/33
[    1.160352] scsi 0:0:0:0: CD-ROM            MATSHITA DVD-RAM UJ-850S  1.=
00 PQ: 0 ANSI: 5
[    1.163048] sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 =
cdda tray
[    1.163506] cdrom: Uniform CD-ROM driver Revision: 3.20
[    1.163886] sr 0:0:0:0: Attached scsi CD-ROM sr0
[    1.164016] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    1.164028] sr 0:0:0:0: Attached scsi generic sg0 type 5
[    1.164567] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    1.164820] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.165278] usb usb1: Product: EHCI Host Controller
[    1.165521] usb usb1: Manufacturer: Linux 3.4.0-rc4 ehci_hcd
[    1.165766] usb usb1: SerialNumber: 0000:00:1d.7
[    1.166145] hub 1-0:1.0: USB hub found
[    1.166366] hub 1-0:1.0: 8 ports detected
[    1.166696] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.166931] uhci_hcd: USB Universal Host Controller Interface driver
[    1.167188] uhci_hcd 0000:00:1d.0: setting latency timer to 64
[    1.167192] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    1.167475] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus =
number 2
[    1.167948] uhci_hcd 0000:00:1d.0: irq 23, io base 0x00002000
[    1.168237] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    1.168485] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.168933] usb usb2: Product: UHCI Host Controller
[    1.169183] usb usb2: Manufacturer: Linux 3.4.0-rc4 uhci_hcd
[    1.169427] usb usb2: SerialNumber: 0000:00:1d.0
[    1.169794] hub 2-0:1.0: USB hub found
[    1.170049] hub 2-0:1.0: 2 ports detected
[    1.170396] uhci_hcd 0000:00:1d.1: setting latency timer to 64
[    1.170400] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    1.170702] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus =
number 3
[    1.171193] uhci_hcd 0000:00:1d.1: irq 22, io base 0x00002400
[    1.171477] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    1.171725] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.172182] usb usb3: Product: UHCI Host Controller
[    1.172424] usb usb3: Manufacturer: Linux 3.4.0-rc4 uhci_hcd
[    1.172669] usb usb3: SerialNumber: 0000:00:1d.1
[    1.173047] hub 3-0:1.0: USB hub found
[    1.173290] hub 3-0:1.0: 2 ports detected
[    1.173622] uhci_hcd 0000:00:1d.2: setting latency timer to 64
[    1.173626] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    1.173928] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus =
number 4
[    1.174425] uhci_hcd 0000:00:1d.2: irq 21, io base 0x00002800
[    1.174706] usb usb4: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    1.174953] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.175410] usb usb4: Product: UHCI Host Controller
[    1.175652] usb usb4: Manufacturer: Linux 3.4.0-rc4 uhci_hcd
[    1.175898] usb usb4: SerialNumber: 0000:00:1d.2
[    1.176274] hub 4-0:1.0: USB hub found
[    1.176517] hub 4-0:1.0: 2 ports detected
[    1.176851] uhci_hcd 0000:00:1d.3: setting latency timer to 64
[    1.176856] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[    1.177171] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus =
number 5
[    1.177650] uhci_hcd 0000:00:1d.3: irq 20, io base 0x00002c00
[    1.177932] usb usb5: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    1.178190] usb usb5: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.178638] usb usb5: Product: UHCI Host Controller
[    1.178881] usb usb5: Manufacturer: Linux 3.4.0-rc4 uhci_hcd
[    1.179133] usb usb5: SerialNumber: 0000:00:1d.3
[    1.179496] hub 5-0:1.0: USB hub found
[    1.179739] hub 5-0:1.0: 2 ports detected
[    1.180154] i8042: PNP: PS/2 Controller [PNP0303:KEYB,PNP0f13:PS2M] at 0=
x60,0x64 irq 1,12
[    1.183205] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.183452] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.183826] mousedev: PS/2 mouse device common for all mice
[    1.184288] rtc_cmos 00:04: RTC can wake from S4
[    1.184667] rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
[    1.184936] rtc0: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    1.185294] device-mapper: uevent: version 1.0.3
[    1.185629] device-mapper: ioctl: 4.22.0-ioctl (2011-10-19) initialised:=
 dm-devel@redhat.com
[    1.186147] cpuidle: using governor ladder
[    1.186388] cpuidle: using governor menu
[    1.186629] EFI Variables Facility v0.08 2004-May-17
[    1.187052] usbcore: registered new interface driver usbhid
[    1.187295] usbhid: USB HID core driver
[    1.187565] nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
[    1.188151] ip_tables: (C) 2000-2006 Netfilter Core Team
[    1.188409] TCP: cubic registered
[    1.188650] Initializing XFRM netlink socket
[    1.188895] NET: Registered protocol family 17
[    1.189177] Registering the dns_resolver key type
[    1.189717] PM: Hibernation image not present or could not be loaded.
[    1.189739] registered taskstats version 1
[    1.189986] IMA: No TPM chip found, activating TPM-bypass!
[    1.190652]   Magic number: 12:290:155
[    1.190924] bdi 1:7: hash matches
[    1.191270] rtc_cmos 00:04: setting system clock to 2012-05-21 01:10:14 =
UTC (1337562614)
[    1.191791] Initializing network drop monitor service
[    1.202043] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input2
[    1.314474] Freeing unused kernel memory: 900k freed
[    1.315029] Write protecting the kernel read-only data: 10240k
[    1.322599] Freeing unused kernel memory: 1284k freed
[    1.332325] Freeing unused kernel memory: 1628k freed
[    1.348152] dracut: dracut-006-3.fc14
[    1.354104] dracut: rd_NO_LUKS: removing cryptoluks activation
[    1.359113] udev[70]: starting version 161
[    1.370027] Refined TSC clocksource calibration: 1862.048 MHz.
[    1.370283] Switching to clocksource tsc
[    1.445549] dracut: Starting plymouth daemon
[    1.556643] Floppy drive(s): fd0 is 1.44M
[    1.562910] Fusion MPT base driver 3.04.20
[    1.563181] Copyright (c) 1999-2008 LSI Corporation
[    1.566091] Fusion MPT SAS Host driver 3.04.20
[    1.566395] mptsas 0000:02:05.0: PCI IRQ 25 -> rerouted to legacy IRQ 17
[    1.566775] mptbase: ioc0: Initiating bringup
[    1.570655] FDC 0 is a post-1991 82077
[    1.845030] ioc0: LSISAS1068 B0: Capabilities=3D{Initiator}
[    1.928863] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/=
i8042/serio1/input/input3
[   10.904340] scsi4 : ioc0: LSISAS1068 B0, FwRev=3D010a0600h, Ports=3D1, M=
axQ=3D511, IRQ=3D17
[   10.942489] mptsas: ioc0: attaching ssp device: fw_channel 0, fw_id 0, p=
hy 0, sas_addr 0x500000e0177557e2
[   10.944012] scsi 4:0:0:0: Direct-Access     FUJITSU  MAX3147RC        52=
05 PQ: 0 ANSI: 3
[   10.947219] sd 4:0:0:0: Attached scsi generic sg1 type 0
[   10.948000] sd 4:0:0:0: [sda] 286749488 512-byte logical blocks: (146 GB=
/136 GiB)
[   10.949738] mptsas: ioc0: attaching ssp device: fw_channel 0, fw_id 2, p=
hy 2, sas_addr 0x500000e0177540f2
[   10.950221] sd 4:0:0:0: [sda] Write Protect is off
[   10.950469] sd 4:0:0:0: [sda] Mode Sense: dd 00 00 08
[   10.951426] scsi 4:0:1:0: Direct-Access     FUJITSU  MAX3147RC        52=
05 PQ: 0 ANSI: 3
[   10.951902] sd 4:0:0:0: [sda] Write cache: disabled, read cache: enabled=
, doesn't support DPO or FUA
[   10.954674] sd 4:0:1:0: Attached scsi generic sg2 type 0
[   10.955452] sd 4:0:1:0: [sdb] 286749488 512-byte logical blocks: (146 GB=
/136 GiB)
[   10.957596] sd 4:0:1:0: [sdb] Write Protect is off
[   10.957819] sd 4:0:1:0: [sdb] Mode Sense: dd 00 00 08
[   10.959010] sd 4:0:1:0: [sdb] Write cache: disabled, read cache: enabled=
, doesn't support DPO or FUA
[   10.981116]  sda: sda1 sda2 sda3
[   10.985044] sd 4:0:0:0: [sda] Attached SCSI disk
[   10.993790]  sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 sdb6 >
[   10.997914] sd 4:0:1:0: [sdb] Attached SCSI disk
[   11.417583] kjournald starting.  Commit interval 5 seconds
[   11.417655] EXT3-fs (sda3): mounted filesystem with ordered data mode
[   11.449023] dracut: Mounted root filesystem /dev/sda3
[   11.504118] dracut: Loading SELinux policy
[   11.686991] SELinux:  Disabled at runtime.
[   11.687292] SELinux:  Unregistering netfilter hooks
[   11.687464] type=3D1404 audit(1337562624.995:2): selinux=3D0 auid=3D4294=
967295 ses=3D4294967295
[   11.762470] dracut: /sbin/load_policy: Can't load policy file /etc/selin=
ux/targeted/policy/policy.15: =E3=9D=E3=AE=E3=82=E3=86=E3=AA=E3=83=95=E3=82=
=A1=E3=82=A4=E3=83=AB=E3=82=84=E3=83=87=E3=82=A3=E3=83=AC=E3=82=AF=E3=83=E3=
=83=AA=E3=AF=E3=82=E3=82=8A=E3=BE=E3=9B=E3=82=93
[   11.834217] dracut: Switching root
[   12.594793] readahead: starting
[   12.910173] udev[290]: starting version 161
[   13.703704] microcode: CPU0 sig=3D0x6f2, pf=3D0x1, revision=3D0x56
[   13.814073] input: PC Speaker as /devices/platform/pcspkr/input/input4
[   13.874883] intel_rng: FWH not detected
[   13.889674] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   13.939229] coretemp coretemp.0: Using relative temperature scale!
[   13.939498] coretemp coretemp.0: Using relative temperature scale!
[   13.945905] microcode: CPU1 sig=3D0x6f2, pf=3D0x1, revision=3D0x56
[   13.947698] microcode: Microcode Update Driver: v2.00 <tigran@aivazian.f=
snet.co.uk>, Peter Oruba
[   14.163515] iTCO_vendor_support: vendor-support=3D0
[   14.219283] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-=
NAPI
[   14.219548] e1000: Copyright (c) 1999-2006 Intel Corporation.
[   14.220241] e1000 0000:02:09.0: PCI IRQ 25 -> rerouted to legacy IRQ 17
[   14.305329] microcode: CPU0 updated to revision 0x5a, date =3D 2007-09-26
[   14.306001] microcode: CPU1 updated to revision 0x5a, date =3D 2007-09-26
[   14.336121] tg3.c:v3.123 (March 21, 2012)
[   14.364756] EDAC MC: Ver: 2.1.0
[   14.368336] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.07
[   14.368675] iTCO_wdt: Found a ICH7 or ICH7R TCO device (Version=3D2, TCO=
BASE=3D0xf060)
[   14.433431] iTCO_wdt: initialized. heartbeat=3D30 sec (nowayout=3D0)
[   14.476639] EDAC MC0: Giving out device to 'i3000_edac' 'i3000': DEV 000=
0:00:00.0
[   14.482158] EDAC PCI0: Giving out device to module 'i3000_edac' controll=
er 'EDAC PCI controller': DEV '0000:00:00.0' (POLLED)
[   14.493520] tg3 0000:0d:00.0: eth0: Tigon3 [partno(BCM95721) rev 4201] (=
PCI Express) MAC address 00:19:99:14:f1:c5
[   14.493980] tg3 0000:0d:00.0: eth0: attached PHY is 5750 (10/100/1000Bas=
e-T Ethernet) (WireSpeed[1], EEE[0])
[   14.494443] tg3 0000:0d:00.0: eth0: RXcsums[1] LinkChgREG[0] MIirq[0] AS=
F[1] TSOcap[1]
[   14.494895] tg3 0000:0d:00.0: eth0: dma_rwctrl[76180000] dma_mask[64-bit]
[   14.511720] e1000 0000:02:09.0: eth1: (PCI-X:66MHz:64-bit) 00:04:23:be:e=
8:0a
[   14.511977] e1000 0000:02:09.0: eth1: Intel(R) PRO/1000 Network Connecti=
on
[   14.512265] e1000 0000:02:09.1: PCI IRQ 26 -> rerouted to legacy IRQ 18
[   14.527518] leds_ss4200: no LED devices found
[   14.803332] e1000 0000:02:09.1: eth2: (PCI-X:66MHz:64-bit) 00:04:23:be:e=
8:0b
[   14.803593] e1000 0000:02:09.1: eth2: Intel(R) PRO/1000 Network Connecti=
on
[   14.876375] parport_pc 00:0b: reported by Plug and Play ACPI
[   14.876659] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE,EPP]
[   14.990915] ppdev: user-space parallel port driver
[   16.163860] EXT3-fs (sda3): using internal journal
[   16.340769] kjournald starting.  Commit interval 5 seconds
[   16.348777] EXT3-fs (sda1): using internal journal
[   16.349038] EXT3-fs (sda1): mounted filesystem with ordered data mode
[   16.838960] Adding 204796k swap on /dev/sda2.  Priority:-1 extents:1 acr=
oss:204796k=20
[   17.395066] Loading iSCSI transport class v2.0-870.
[   17.431980] iscsi: registered transport (tcp)
[   17.668733] NET: Registered protocol family 10
[   17.821132] iscsi: registered transport (iser)
[   17.964840] libcxgbi:libcxgbi_init_module: tag itt 0x1fff, 13 bits, age =
0xf, 4 bits.
[   17.965313] libcxgbi:ddp_setup_host_page_size: system PAGE 4096, ddp idx=
 0.
[   17.981459] Chelsio T3 iSCSI Driver cxgb3i v2.0.0 (Jun. 2010)
[   17.981750] iscsi: registered transport (cxgb3i)
[   18.036209] cnic: Broadcom NetXtreme II CNIC Driver cnic v2.5.10 (March =
21, 2012)
[   18.086792] Broadcom NetXtreme II iSCSI Driver bnx2i v2.7.0.3 (Jun 15, 2=
011)
[   18.087102] iscsi: registered transport (bnx2i)
[   18.153544] iscsi: registered transport (be2iscsi)
[   18.241000] iscsid (726): /proc/726/oom_adj is deprecated, please use /p=
roc/726/oom_score_adj instead.
[   18.778672] tg3 0000:0d:00.0: irq 68 for MSI/MSI-X
[   18.824864] ADDRCONF(NETDEV_UP): eth0: link is not ready
[   21.933228] tg3 0000:0d:00.0: eth0: Link is up at 1000 Mbps, full duplex
[   21.933423] tg3 0000:0d:00.0: eth0: Flow control is on for TX and on for=
 RX
[   21.935596] ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   32.250012] eth0: no IPv6 routers present
[  144.634197] RPC: Registered named UNIX socket transport module.
[  144.634648] RPC: Registered udp transport module.
[  144.634891] RPC: Registered tcp transport module.
[  144.635147] RPC: Registered tcp NFSv4.1 backchannel transport module.
[  145.317952] ipmi message handler version 39.2
[  145.334534] IPMI System Interface driver.
[  145.335410] ipmi_si: probing via SMBIOS
[  145.335666] ipmi_si: SMBIOS: io 0xca2 regsize 1 spacing 1 irq 0
[  145.335916] ipmi_si: Adding SMBIOS-specified kcs state machine
[  145.336214] ipmi_si: Trying SMBIOS-specified kcs state machine at i/o ad=
dress 0xca2, slave address 0x24, irq 0
[  145.393964] ipmi_si ipmi_si.0: Found new BMC (man_id: 0x002880, prod_id:=
 0x0206, dev_id: 0x01)
[  145.394450] ipmi_si ipmi_si.0: IPMI kcs interface initialized
[  147.818551] Bridge firewalling registered
[  147.916309] tun: Universal TUN/TAP device driver, 1.6
[  147.916360] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[  147.924361] device virbr0-nic entered promiscuous mode
[  147.999150] ADDRCONF(NETDEV_UP): virbr0: link is not ready
[  148.203259] Ebtables v2.0 registered
[  148.242002] ip6_tables: (C) 2000-2006 Netfilter Core Team

--Multipart=_Mon__21_May_2012_10_45_59_+0900_E9OWCe_pY1gi0z05--

