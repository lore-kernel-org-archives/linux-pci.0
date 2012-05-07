Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:34838 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756467Ab2EGOqj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 7 May 2012 10:46:39 -0400
Message-ID: <4FA7D47C.2070708@fold.natur.cuni.cz>
Date: Mon, 07 May 2012 15:56:12 +0200
From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
MIME-Version: 1.0
To: linux-pci@vger.kernel.org,
	IDE/ATA development list <linux-ide@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>, Jiang Liu <liuj97@gmail.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jeff Garzik <jgarzik@pobox.com>
Subject: linux-3.4-rc5: eSATA Sil3132 ExpressCard removal results in warn_slowpath_common
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,
  my motherboard and express card slot was replaced in my Dell Vostro 3550. It still does not report
when a card is unplugged (on re-insertion it does realize the change and complains about Surprise removal.
I haven't studied the current bit in detail again with new hardwarte but I believe this is still about
the "Changed:" line in 'lspci -vvvxxx' output which does not change.
I reported the details with the previous hardware and my impression was that for my FireWire and
eSATA card the "SltSta:" *does* change and *does* reflect state of teh slot (with card inserted or out).
Could linux kernel keep its own variablwe to to track changes of the states and ignore the
"Changed: MRL- PresDet- LinkState-" line? This is some kind of introduction to my hardware. ;)


--- /tmp/inserted-firewire      2012-05-07 15:43:24.000000000 +0200
+++ /tmp/removed-firewire       2012-05-07 15:43:32.000000000 +0200
@@ -441,7 +441,7 @@
        I/O behind bridge: 0000c000-0000dfff
        Memory behind bridge: f6c00000-f7cfffff
        Prefetchable memory behind bridge: 00000000f0000000-00000000f10fffff
-       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
+       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
@@ -450,18 +450,18 @@
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
-               DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
+               DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
                LnkCap: Port #8, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <1us, L1 <16us
                        ClockPM- Surprise- LLActRep+ BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
-               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
+               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
                        Slot #7, PowerLimit 10.000W; Interlock- NoCompl+
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq+ LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
-               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
-                       Changed: MRL- PresDet- LinkState-
+               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
+                       Changed: MRL- PresDet- LinkState+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
@@ -480,11 +480,11 @@
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: pcieport
 00: 86 80 1e 1c 07 04 10 00 b5 00 04 06 10 00 81 00
-10: 00 00 00 00 00 00 00 00 00 11 16 00 c0 d0 00 00
+10: 00 00 00 00 00 00 00 00 00 11 16 00 c0 d0 00 20
 20: c0 f6 c0 f7 01 f0 01 f1 00 00 00 00 00 00 00 00
 30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 04 10 00
-40: 10 80 42 01 00 80 00 00 00 00 10 00 12 4c 12 08
-50: 00 00 11 70 60 b2 3c 00 28 00 40 00 00 00 00 00
+40: 10 80 42 01 00 80 00 00 00 00 11 00 12 4c 12 08
+50: 00 00 11 50 60 b2 3c 00 28 00 00 01 00 00 00 00
 60: 00 00 00 00 16 00 00 00 00 00 00 00 00 00 00 00
 70: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
 80: 05 90 01 00 18 03 e0 fe 00 00 00 00 00 00 00 00
@@ -802,57 +802,3 @@
 e0: 00 00 40 63 00 00 00 00 00 00 00 00 00 00 00 00
 f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 

The above "surprise removal" upsets sata_sil24 driver, it does not crash bad complains
badly. I am not sure if there is anything to be changed here, the slowpath warning is
probably valid and desired (SATA port cannot be removed from the system too quickly).
Unfortunately, because the ExpressCard hardware is physically not very advanced, it happens
to me with this express card that it does not hold during insertion into teh slot
and slips out immediately. Hence, the sata_sil24 Oops below.


[    1.936017] pcieport 0000:00:1c.7: irq 42 for MSI/MSI-X
[    1.936240] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    1.936427] pciehp 0000:00:1c.7:pcie04: Hotplug Controller:
[    1.936522] pciehp 0000:00:1c.7:pcie04:   Seg/Bus/Dev/Func/IRQ : 0000:00:1c.7 IRQ 42
[    1.936666] pciehp 0000:00:1c.7:pcie04:   Vendor ID            : 0x8086
[    1.936763] pciehp 0000:00:1c.7:pcie04:   Device ID            : 0x1c1e
[    1.936860] pciehp 0000:00:1c.7:pcie04:   Subsystem ID         : 0x04b3
[    1.936956] pciehp 0000:00:1c.7:pcie04:   Subsystem Vendor ID  : 0x1028
[    1.937053] pciehp 0000:00:1c.7:pcie04:   PCIe Cap offset      : 0x40
[    1.937150] pciehp 0000:00:1c.7:pcie04:   PCI resource [13]     : [io  0xc000-0xdfff]
[    1.937297] pciehp 0000:00:1c.7:pcie04:   PCI resource [14]     : [mem 0xf6c00000-0xf7cfffff]
[    1.937443] pciehp 0000:00:1c.7:pcie04:   PCI resource [15]     : [mem 0xf0000000-0xf10fffff 64bit pref]
[    1.937592] pciehp 0000:00:1c.7:pcie04: Slot Capabilities      : 0x003cb260
[    1.937689] pciehp 0000:00:1c.7:pcie04:   Physical Slot Number : 7
[    1.937785] pciehp 0000:00:1c.7:pcie04:   Attention Button     :  no
[    1.937881] pciehp 0000:00:1c.7:pcie04:   Power Controller     :  no
[    1.937977] pciehp 0000:00:1c.7:pcie04:   MRL Sensor           :  no
[    1.938072] pciehp 0000:00:1c.7:pcie04:   Attention Indicator  :  no
[    1.938168] pciehp 0000:00:1c.7:pcie04:   Power Indicator      :  no
[    1.938264] pciehp 0000:00:1c.7:pcie04:   Hot-Plug Surprise    : yes
[    1.938360] pciehp 0000:00:1c.7:pcie04:   EMI Present          :  no
[    1.938455] pciehp 0000:00:1c.7:pcie04:   Command Completed    :  no
[    1.938552] pciehp 0000:00:1c.7:pcie04: Slot Status            : 0x0000
[    1.938651] pciehp 0000:00:1c.7:pcie04: Slot Control           : 0x0000
[    1.938749] pciehp 0000:00:1c.7:pcie04: Link Active Reporting supported
[    1.938758] pciehp 0000:00:1c.7:pcie04: HPC vendor_id 8086 device_id 1c1e ss_vid 1028 ss_did 4b3
[    1.940227] pciehp 0000:00:1c.7:pcie04: Registering domain:bus:dev=0000:11:00 sun=7
[    1.940232] pci_bus 0000:11: dev 00, created physical slot 7
[    1.940280] pciehp 0000:00:1c.7:pcie04: pciehp_get_power_status: SLOTCTRL 58 value read 28
[    1.940282] pciehp 0000:00:1c.7:pcie04: service driver pciehp loaded
[    1.940311] pciehp: pcie_port_service_register = 0
[    1.940312] pciehp: PCI Express Hot Plug Controller Driver version: 0.4

[  113.548456] pciehp 0000:00:1c.7:pcie04: pcie_isr: intr_loc 8
[  113.548466] pciehp 0000:00:1c.7:pcie04: Presence/Notify input change
[  113.548470] pciehp 0000:00:1c.7:pcie04: Card present on Slot(7)
[  113.548497] pciehp 0000:00:1c.7:pcie04: Surprise Removal
[  113.548724] pciehp 0000:00:1c.7:pcie04: check_link_active: lnk_status = 7011
[  113.657351] pciehp 0000:00:1c.7:pcie04: pciehp_check_link_status: lnk_status = 7011
[  113.657426] pci 0000:11:00.0: [1095:3132] type 00 class 0x018000
[  113.657478] pci 0000:11:00.0: reg 10: [mem 0x00000000-0x0000007f 64bit]
[  113.657507] pci 0000:11:00.0: reg 18: [mem 0x00000000-0x00003fff 64bit]
[  113.657525] pci 0000:11:00.0: reg 20: [io  0x0000-0x007f]
[  113.657561] pci 0000:11:00.0: reg 30: [mem 0x00000000-0x0007ffff pref]
[  113.657653] pci 0000:11:00.0: supports D1 D2
[  113.657685] pci 0000:11:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[  113.657710] pci 0000:11:00.0: BAR 6: assigned [mem 0xf0000000-0xf007ffff pref]
[  113.657712] pci 0000:11:00.0: BAR 2: assigned [mem 0xf6c00000-0xf6c03fff 64bit]
[  113.657723] pci 0000:11:00.0: BAR 2: set to [mem 0xf6c00000-0xf6c03fff 64bit] (PCI address [0xf6c00000-0xf6c03fff])
[  113.657725] pci 0000:11:00.0: BAR 0: assigned [mem 0xf6c04000-0xf6c0407f 64bit]
[  113.657736] pci 0000:11:00.0: BAR 0: set to [mem 0xf6c04000-0xf6c0407f 64bit] (PCI address [0xf6c04000-0xf6c0407f])
[  113.657738] pci 0000:11:00.0: BAR 4: assigned [io  0xc000-0xc07f]
[  113.657744] pci 0000:11:00.0: BAR 4: set to [io  0xc000-0xc07f] (PCI address [0xc000-0xc07f])
[  113.657746] pcieport 0000:00:1c.7: PCI bridge to [bus 11-16]
[  113.657749] pcieport 0000:00:1c.7:   bridge window [io  0xc000-0xdfff]
[  113.657754] pcieport 0000:00:1c.7:   bridge window [mem 0xf6c00000-0xf7cfffff]
[  113.657758] pcieport 0000:00:1c.7:   bridge window [mem 0xf0000000-0xf10fffff 64bit pref]
[  113.730997] sata_sil24 0000:11:00.0: version 1.1
[  113.731011] sata_sil24 0000:11:00.0: enabling device (0100 -> 0103)
[  113.731118] sata_sil24 0000:11:00.0: enabling bus mastering
[  113.731438] scsi7 : sata_sil24
[  113.731526] scsi8 : sata_sil24
[  113.731561] ata8: SATA max UDMA/100 host m128@0xf6c04000 port 0xf6c00000 irq 19
[  113.731565] ata9: SATA max UDMA/100 host m128@0xf6c04000 port 0xf6c02000 irq 19
[  115.814158] ata8: SATA link down (SStatus 0 SControl 0)
[  116.799827] pciehp 0000:00:1c.7:pcie04: pcie_isr: intr_loc 8
[  116.799846] pciehp 0000:00:1c.7:pcie04: Presence/Notify input change
[  116.799850] pciehp 0000:00:1c.7:pcie04: Card not present on Slot(7)
[  116.799879] pciehp 0000:00:1c.7:pcie04: Surprise Removal
[  116.800041] pciehp 0000:00:1c.7:pcie04: Disabling domain:bus:device=0000:11:00
[  116.800043] pciehp 0000:00:1c.7:pcie04: pciehp_unconfigure_device: domain:bus:dev = 0000:11:00
[  118.889684] ata9: SATA link down (SStatus FFFFFFFF SControl FFFFFFFF)
[  118.889699] ------------[ cut here ]------------
[  118.889705] WARNING: at drivers/ata/libata-core.c:6177 ata_host_detach+0x72/0xd8()
[  118.889707] Hardware name: Vostro 3550
[  118.889715] Modules linked in: sata_sil24 usb_storage iwlwifi i2c_i801
[  118.889721] Pid: 1578, comm: kworker/0:2 Not tainted 3.4.0-rc5-default #20
[  118.889723] Call Trace:
[  118.889728]  [<ffffffff8107af23>] warn_slowpath_common+0x80/0x98
[  118.889731]  [<ffffffff81090a8e>] ? wake_up_bit+0x25/0x25
[  118.889733]  [<ffffffff8107af50>] warn_slowpath_null+0x15/0x17
[  118.889735]  [<ffffffff8134f188>] ata_host_detach+0x72/0xd8
[  118.889738]  [<ffffffff8134f206>] ata_pci_remove_one+0x18/0x1a
[  118.889741]  [<ffffffff81247077>] pci_device_remove+0x3a/0x8c
[  118.889744]  [<ffffffff81329036>] __device_release_driver+0x81/0xca
[  118.889746]  [<ffffffff8132909d>] device_release_driver+0x1e/0x2b
[  118.889748]  [<ffffffff81328af1>] bus_remove_device+0xdb/0xf0
[  118.889750]  [<ffffffff81326985>] device_del+0x122/0x17d
[  118.889753]  [<ffffffff813269f1>] device_unregister+0x11/0x1e
[  118.889756]  [<ffffffff812427a2>] pci_stop_bus_device+0x5e/0x80
[  118.889758]  [<ffffffff8124292f>] pci_stop_and_remove_bus_device+0x11/0x1e
[  118.889761]  [<ffffffff812524f4>] pciehp_unconfigure_device+0x105/0x171
[  118.889763]  [<ffffffff81251fbd>] pciehp_disable_slot+0x107/0x168
[  118.889765]  [<ffffffff8125201e>] ? pciehp_disable_slot+0x168/0x168
[  118.889767]  [<ffffffff812520a3>] pciehp_power_thread+0x85/0xd1
[  118.889770]  [<ffffffff8108c6d5>] process_one_work+0x161/0x22b
[  118.889773]  [<ffffffff8108d23f>] worker_thread+0xfe/0x182
[  118.889775]  [<ffffffff8108d141>] ? manage_workers.clone.18+0x16d/0x16d
[  118.889777]  [<ffffffff8108d141>] ? manage_workers.clone.18+0x16d/0x16d
[  118.889779]  [<ffffffff81090669>] kthread+0x84/0x8c
[  118.889783]  [<ffffffff815e2ad4>] kernel_thread_helper+0x4/0x10
[  118.889786]  [<ffffffff810905e5>] ? kthread_freezable_should_stop+0x41/0x41
[  118.889788]  [<ffffffff815e2ad0>] ? gs_change+0xb/0xb
[  118.889789] ---[ end trace d74a5064a189840f ]---
[  118.889926] sata_sil24: IRQ status == 0xffffffff, PCI fault or device removal?

SATA/IDE, probably take this just as a note. For the pciehp stuff I will eventually provide
more info upon request, in a new thread.
Thanks,
Martin
