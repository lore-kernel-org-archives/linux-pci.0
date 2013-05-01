Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:34886 "EHLO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933945Ab3EAAUh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 30 Apr 2013 20:20:37 -0400
Message-ID: <51805FD1.4040004@fold.natur.cuni.cz>
Date: Wed, 01 May 2013 02:20:33 +0200
From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
MIME-Version: 1.0
To: Huang Ying <ying.huang@intel.com>
CC: Yijing Wang <wangyijing@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Yinghai Lu <yinghai@kernel.org>
Subject: Re: 3.9-rc1: pciehp and eSATA card SiI 3132, no XHCI
References: <513E7E1E.80508@fold.natur.cuni.cz>     <513FE7AD.2020408@huawei.com> <5141145E.4020300@fold.natur.cuni.cz>     <51417C28.40402@huawei.com> <5141C9D7.9040706@fold.natur.cuni.cz>     <51428A72.2060602@huawei.com> <51548E13.8030308@fold.natur.cuni.cz>    <1364545211.1817.228.camel@yhuang-dev>    <5155A101.2090705@fold.natur.cuni.cz>   <1364640886.5773.5.camel@yhuang-mobile.sh.intel.com>   <51581170.30708@fold.natur.cuni.cz>  <1364739160.5947.5.camel@yhuang-mobile.sh.intel.com>  <51585071.3090600@fold.natur.cuni.cz> <1364801587.6298.8.camel@yhuang-dev> <5159C293.4030009@fold.natur.cuni.cz> <518032F3.3040706@fold.natur.cuni.cz>
In-Reply-To: <518032F3.3040706@fold.natur.cuni.cz>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Martin Mokrejs wrote:
> Hi,
>   I went to test final 3.9 kernel and was almost ready to report no difference
> in pciehp and *no hotplug functionality of either of my 3 express cards*. But ...
> I also tested change from pcie_aspm=off to pcie_aspm=native and hot events started
> to work!
> So, I would like to ask you to review the code affected by both values aiming
> to find an explanation. You have the collected data available and email archives
> so I believe this should be easy now for you.
> 
>   If you want to compare with 3.9 kernel then I uploaded collected with pciehp
> under 3.9 kernel to http://195.113.57.32/~mmokrejs/tmp/20130430.tar.bz2 .
> The 3.8.8 data is acpiphp testing, so ignore it for this thread.

For those who have no time to look into the files themselves I will spot few
diff myself.

1. The pcie_aspm did *not* affect ASPM values reported by lspci -vvv of *all*
devices, just some. That might explain why such a mess.


2. The pciehp could not work under pcie_aspm=off because this breakage?:
--- off/eSATA_SiI3132/lspci_vvv_initial.txt     2013-04-30 21:23:42.000000000 +0200
+++ native/eSATA_SiI3132/lspci_vvv_initial.txt  2013-04-30 22:00:14.000000000 +0200

 00:1c.7 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family PCI Express Root Port 8 (rev b5) (prog-if 00 [Normal decode])
-       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
+       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=00, secondary=11, subordinate=16, sec-latency=0
        I/O behind bridge: 0000c000-0000dfff
        Memory behind bridge: f6c00000-f7cfffff
        Prefetchable memory behind bridge: 00000000f0000000-00000000f10fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
                        ExtTag- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
-               DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
+               DevSta: CorrErr- UncorrErr+ FatalErr+ UnsuppReq- AuxPwr+ TransPend-
                LnkCap: Port #8, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 <16us
                        ClockPM- Surprise- LLActRep+ BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
                        Slot #7, PowerLimit 10.000W; Interlock- NoCompl+
-               SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
+               SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq+ LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
                        Changed: MRL- PresDet- LinkState-
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
-       Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
-               Address: 00000000  Data: 0000
+       Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
+               Address: fee0300c  Data: 4191
        Capabilities: [90] Subsystem: Dell Device 04b3
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: pcieport


 11:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev 01)
        Subsystem: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller
+       Physical Slot: 7
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at f6c84000 (64-bit, non-prefetchable) [size=128]
        Region 2: Memory at f6c80000 (64-bit, non-prefetchable) [size=16K]
        Region 4: I/O ports at c000 [size=128]
        Expansion ROM at f6c00000 [disabled] [size=512K]
        Capabilities: [54] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [5c] MSI: Enable- Count=1/1 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [70] Express (v1) Legacy Endpoint, MSI 00
                DevCap: MaxPayload 1024 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 4096 bytes
                DevSta: CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0 unlimited, L1 unlimited
                        ClockPM- Surprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                AERCap: First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
        Kernel driver in use: sata_sil24


# cut -c 15- off/eSATA_SiI3132/dmesg_initial.txt > /tmp/dmesg_eSATA_SiI3132_pcie_aspm-off.txt
# cut -c 15- native/eSATA_SiI3132/dmesg_initial.txt > /tmp/dmesg_eSATA_SiI3132_pcie_aspm-native.txt
# diff -u -w /tmp/dmesg_eSATA_SiI3132_pcie_aspm-off.txt /tmp/dmesg_eSATA_SiI3132_pcie_aspm-native.txt
--- /tmp/dmesg_eSATA_SiI3132_pcie_aspm-off.txt  2013-05-01 02:01:02.000000000 +0200
+++ /tmp/dmesg_eSATA_SiI3132_pcie_aspm-native.txt       2013-05-01 02:01:13.000000000 +0200
@@ -1,5 +1,5 @@
  Linux version 3.9.0-default (root@vostro) (gcc version 4.5.4 (Gentoo 4.5.4 p1.1, pie-0.4.7) ) #1 SMP Tue Apr 30 17:33:54 MEST 2013
- Command line: root=/dev/sda5 pciehp.pciehp_debug=1 pciehp_debug=1 slub_debug=AFPZ pcie_aspm=off
+ Command line: root=/dev/sda5 pciehp.pciehp_debug=1 pciehp_debug=1 slub_debug=AFPZ pcie_aspm=native
  e820: BIOS-provided physical RAM map:
  BIOS-e820: [mem 0x0000000000000000-0x000000000009d3ff] usable
  BIOS-e820: [mem 0x000000000009d400-0x000000000009ffff] reserved
@@ -175,8 +175,7 @@
  pcpu-alloc: [0] 0 1 
  Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 4104936
  Policy zone: Normal
- Kernel command line: root=/dev/sda5 pciehp.pciehp_debug=1 pciehp_debug=1 slub_debug=AFPZ pcie_aspm=off
- PCIe ASPM is disabled
+ Kernel command line: root=/dev/sda5 pciehp.pciehp_debug=1 pciehp_debug=1 slub_debug=AFPZ pcie_aspm=native
  PID hash table entries: 4096 (order: 3, 32768 bytes)
  __ex_table already sorted, skipping sort
  xsave: enabled xstate_bv 0x7, cntxt size 0x340
[cut]
@@ -406,6 +405,7 @@
  pci 0000:11:00.0: reg 20: [io  0xc000-0xc07f]
  pci 0000:11:00.0: reg 30: [mem 0xf6c00000-0xf6c7ffff pref]
  pci 0000:11:00.0: supports D1 D2
+ pci 0000:11:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
  pci_bus 0000:11: fixups for bus
  pci 0000:00:1c.7: PCI bridge to [bus 11-16]
  pci 0000:00:1c.7:   bridge window [io  0xc000-0xdfff]
@@ -418,7 +418,8 @@
  pci 0000:00:1c.4: scanning [bus 0b-0c] behind bridge, pass 1
  pci 0000:00:1c.7: scanning [bus 11-16] behind bridge, pass 1
  pci_bus 0000:00: bus scan returning with max=16
- acpi PNP0A08:00: Unable to request _OSC control (_OSC support mask: 0x19)
+ acpi PNP0A08:00: Requesting ACPI _OSC control (0x1d)
+ acpi PNP0A08:00: ACPI _OSC control (0x19) granted
  ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12 14 15)
  ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 10 11 12 14 15)
  ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 6 10 11 12 14 15)
@@ -598,7 +599,36 @@
  io scheduler noop registered
  io scheduler deadline registered (default)
  io scheduler cfq registered
+ pcieport 0000:00:1c.7: irq 40 for MSI/MSI-X
  pci_hotplug: PCI Hot Plug PCI Core version: 0.5
+ pciehp 0000:00:1c.7:pcie04: Hotplug Controller:
+ pciehp 0000:00:1c.7:pcie04:   Seg/Bus/Dev/Func/IRQ : 0000:00:1c.7 IRQ 40
+ pciehp 0000:00:1c.7:pcie04:   Vendor ID            : 0x8086
+ pciehp 0000:00:1c.7:pcie04:   Device ID            : 0x1c1e
+ pciehp 0000:00:1c.7:pcie04:   Subsystem ID         : 0x04b3
+ pciehp 0000:00:1c.7:pcie04:   Subsystem Vendor ID  : 0x1028
+ pciehp 0000:00:1c.7:pcie04:   PCIe Cap offset      : 0x40
+ pciehp 0000:00:1c.7:pcie04:   PCI resource [13]     : [io  0xc000-0xdfff]
+ pciehp 0000:00:1c.7:pcie04:   PCI resource [14]     : [mem 0xf6c00000-0xf7cfffff]
+ pciehp 0000:00:1c.7:pcie04:   PCI resource [15]     : [mem 0xf0000000-0xf10fffff 64bit pref]
+ pciehp 0000:00:1c.7:pcie04: Slot Capabilities      : 0x003cb260
+ pciehp 0000:00:1c.7:pcie04:   Physical Slot Number : 7
+ pciehp 0000:00:1c.7:pcie04:   Attention Button     :  no
+ pciehp 0000:00:1c.7:pcie04:   Power Controller     :  no
+ pciehp 0000:00:1c.7:pcie04:   MRL Sensor           :  no
+ pciehp 0000:00:1c.7:pcie04:   Attention Indicator  :  no
+ pciehp 0000:00:1c.7:pcie04:   Power Indicator      :  no
+ pciehp 0000:00:1c.7:pcie04:   Hot-Plug Surprise    : yes
+ pciehp 0000:00:1c.7:pcie04:   EMI Present          :  no
+ pciehp 0000:00:1c.7:pcie04:   Command Completed    :  no
+ pciehp 0000:00:1c.7:pcie04: Slot Status            : 0x0040
+ pciehp 0000:00:1c.7:pcie04: Slot Control           : 0x0000
+ pciehp 0000:00:1c.7:pcie04: Link Active Reporting supported
+ pciehp 0000:00:1c.7:pcie04: HPC vendor_id 8086 device_id 1c1e ss_vid 1028 ss_did 4b3
+ pciehp 0000:00:1c.7:pcie04: Registering domain:bus:dev=0000:11:00 sun=7
+ pci_bus 0000:11: dev 00, created physical slot 7
+ pciehp 0000:00:1c.7:pcie04: pciehp_get_power_status: SLOTCTRL 58 value read 28
+ pciehp 0000:00:1c.7:pcie04: service driver pciehp loaded
  pciehp: pcie_port_service_register = 0
  pciehp: PCI Express Hot Plug Controller Driver version: 0.4
  intel_idle: MWAIT substates: 0x21120
@@ -1353,19 +1381,9 @@
  ata8: SATA max UDMA/100 host m128@0xf6c84000 port 0xf6c82000 irq 19
  Intel(R) Wireless WiFi driver for Linux, in-tree:d
  Copyright(c) 2003-2013 Intel Corporation
- iwlwifi 0000:09:00.0: irq 46 for MSI/MSI-X
+ iwlwifi 0000:09:00.0: irq 47 for MSI/MSI-X
  iwlwifi 0000:09:00.0: loaded firmware version 18.168.6.1
  [drm] Initialized drm 1.1.0 20060810
- iwlwifi 0000:09:00.0: CONFIG_IWLWIFI_DEBUG enabled
- iwlwifi 0000:09:00.0: CONFIG_IWLWIFI_DEBUGFS disabled
- iwlwifi 0000:09:00.0: CONFIG_IWLWIFI_DEVICE_TRACING disabled
- iwlwifi 0000:09:00.0: CONFIG_IWLWIFI_DEVICE_TESTMODE disabled
- iwlwifi 0000:09:00.0: CONFIG_IWLWIFI_P2P disabled
- iwlwifi 0000:09:00.0: Detected Intel(R) Centrino(R) Wireless-N 1030 BGN, REV=0xB0
- iwlwifi 0000:09:00.0: L1 Enabled; Disabling L0S
- iwlwifi 0000:09:00.0: RF_KILL bit toggled to disable radio.
- ieee80211 phy0: Selected rate control algorithm 'iwl-agn-rs'
- systemd-udevd[1961]: renamed network interface wlan0 to wlp9s0
  ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
  ata7.00: ATA-8: ST3000VX000-9YW166, CV12, max UDMA/133
  ata7.00: 5860533168 sectors, multi 0: LBA48 NCQ (depth 31/32)
@@ -1379,10 +1397,20 @@
  sd 6:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
   sdb: sdb1
  sd 6:0:0:0: [sdb] Attached SCSI disk
+ iwlwifi 0000:09:00.0: CONFIG_IWLWIFI_DEBUG enabled
+ iwlwifi 0000:09:00.0: CONFIG_IWLWIFI_DEBUGFS disabled
+ iwlwifi 0000:09:00.0: CONFIG_IWLWIFI_DEVICE_TRACING disabled
+ iwlwifi 0000:09:00.0: CONFIG_IWLWIFI_DEVICE_TESTMODE disabled
+ iwlwifi 0000:09:00.0: CONFIG_IWLWIFI_P2P disabled
+ iwlwifi 0000:09:00.0: Detected Intel(R) Centrino(R) Wireless-N 1030 BGN, REV=0xB0
+ iwlwifi 0000:09:00.0: L1 Disabled; Enabling L0S
+ iwlwifi 0000:09:00.0: RF_KILL bit toggled to disable radio.
+ ieee80211 phy0: Selected rate control algorithm 'iwl-agn-rs'
+ systemd-udevd[1960]: renamed network interface wlan0 to wlp9s0
  ata8: SATA link down (SStatus 0 SControl 0)
[cut]

Hmm, but 11:00 had in both scenarios enabled ASPM (see the above lspci diff).


Looks close to these?
https://bugzilla.kernel.org/show_bug.cgi?id=55211 
https://bugzilla.kernel.org/show_bug.cgi?id=57331



Now, in brief, a survey of PME-related differences between the three express cards I used
in all my tests:

20130430 # grep PME off/*/dmesg_initial.txt |  grep "1c.7"
off/FireWire/dmesg_initial.txt:[    1.681031] pci 0000:00:1c.7: PME# supported from D0 D3hot D3cold
off/FireWire/dmesg_initial.txt:[    1.681036] pci 0000:00:1c.7: PME# disabled
off/NEC_usb30/dmesg_initial.txt:[    1.680882] pci 0000:00:1c.7: PME# supported from D0 D3hot D3cold
off/NEC_usb30/dmesg_initial.txt:[    1.680888] pci 0000:00:1c.7: PME# disabled
off/eSATA_SiI3132/dmesg_initial.txt:[    1.683314] pci 0000:00:1c.7: PME# supported from D0 D3hot D3cold
off/eSATA_SiI3132/dmesg_initial.txt:[    1.683319] pci 0000:00:1c.7: PME# disabled
20130430 # grep PME off/*/dmesg_initial.txt |  grep "11:00"
off/FireWire/dmesg_initial.txt:[    1.723336] pci 0000:11:00.0: PME# supported from D2 D3hot D3cold
off/FireWire/dmesg_initial.txt:[    1.723344] pci 0000:11:00.0: PME# disabled
off/NEC_usb30/dmesg_initial.txt:[    1.724471] pci 0000:11:00.0: PME# supported from D0 D3hot
off/NEC_usb30/dmesg_initial.txt:[    1.724481] pci 0000:11:00.0: PME# disabled
20130430 # grep "pre-1.1" off/*/dmesg_initial.txt 
20130430 #



20130430 # grep PME native/*/dmesg_initial.txt |  grep "1c.7"
native/FireWire/dmesg_initial.txt:[    1.671345] pci 0000:00:1c.7: PME# supported from D0 D3hot D3cold
native/FireWire/dmesg_initial.txt:[    1.671351] pci 0000:00:1c.7: PME# disabled
native/NEC_usb30/dmesg_initial.txt:[    1.681021] pci 0000:00:1c.7: PME# supported from D0 D3hot D3cold
native/NEC_usb30/dmesg_initial.txt:[    1.681027] pci 0000:00:1c.7: PME# disabled
native/eSATA_SiI3132/dmesg_initial.txt:[    1.680976] pci 0000:00:1c.7: PME# supported from D0 D3hot D3cold
native/eSATA_SiI3132/dmesg_initial.txt:[    1.680982] pci 0000:00:1c.7: PME# disabled
20130430 # grep PME native/*/dmesg_initial.txt |  grep "11:00"
native/FireWire/dmesg_initial.txt:[    1.742989] pci 0000:11:00.0: PME# supported from D2 D3hot D3cold
native/FireWire/dmesg_initial.txt:[    1.742996] pci 0000:11:00.0: PME# disabled
native/NEC_usb30/dmesg_initial.txt:[    1.753353] pci 0000:11:00.0: PME# supported from D0 D3hot
native/NEC_usb30/dmesg_initial.txt:[    1.753363] pci 0000:11:00.0: PME# disabled
20130430 # grep "pre-1.1" native/*/dmesg_initial.txt 
native/eSATA_SiI3132/dmesg_initial.txt:[    1.753674] pci 0000:11:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
20130430 #


So, ASPM also wasn't disabled on my pre-1.1 device, right?


Martin



> 
> Thank you,
> Martin
> 
> Martin Mokrejs wrote:
>> Huang Ying wrote:
>>> On Sun, 2013-03-31 at 17:04 +0200, Martin Mokrejs wrote:
>>>> Hi Ying,
>>>>   
>>>> Huang Ying wrote:
>>>>> Hi, Martin,
>>>>>
>>>>> Thanks for your testing!
>>>>>
>>>>> On Sun, 2013-03-31 at 12:35 +0200, Martin Mokrejs wrote:
>>>>>> Hi Ying,
>>>>>>   I have tested 4x your last patch. Somehow nothing gets logged to "dmesg"
>>>>>> when I hotremove or hotinsert the coldbooted eSATA card. Logging works so
>>>>>> enabling wifi via Fn+F2 is being logged. Also, eventual stacktraces
>>>>>> and kmemleaks.
>>>>>>   I removed the coldbooted card, inserted it and ejected it.
>>>>>>
>>>>>>
>>>>>>   In brief, lspci reports changes but there are no changes in /proc/interrupts
>>>>>> related to
>>>>>>
>>>>>>   19:          0          0   IO-APIC-fasteoi   sata_sil24
>>>>>>
>>>>>>
>>>>>> and no changes at all in /proc/iomem which I expected to happen during
>>>>>> hotremoval and hotinsert (something broken in 3.9-rc1 with your patch).
>>>>>>
>>>>>> All the runtime_status data were same after every tested step, so again,
>>>>>> no diffs to show but here are the values confirming laptop-mode-tools
>>>>>> enabled powersaving:
>>>>>>
>>>>>> /sys/bus/pci/devices/0000:00:00.0/power/runtime_status:suspended
>>>>>> /sys/bus/pci/devices/0000:00:02.0/power/runtime_status:active
>>>>>> /sys/bus/pci/devices/0000:00:16.0/power/runtime_status:suspended
>>>>>> /sys/bus/pci/devices/0000:00:1a.0/power/runtime_status:suspended
>>>>>> /sys/bus/pci/devices/0000:00:1b.0/power/runtime_status:active
>>>>>> /sys/bus/pci/devices/0000:00:1c.0/power/runtime_status:suspended
>>>>>> /sys/bus/pci/devices/0000:00:1c.1/power/runtime_status:active
>>>>>> /sys/bus/pci/devices/0000:00:1c.3/power/runtime_status:active
>>>>>> /sys/bus/pci/devices/0000:00:1c.4/power/runtime_status:active
>>>>>> /sys/bus/pci/devices/0000:00:1c.7/power/runtime_status:active
>>>>>
>>>>> It appears that 1c.7 is identified successfully as an hotplug-able PCIe
>>>>> port, and never put into suspended state.
>>>>
>>>> Yes. Truly said, after I now went to test your previous two patches
>>>> on the 3.9-rc1 I confirm that the syslog logging is broken with all your
>>>> three patches. I fear we are hitting here, with the pciehp problems
>>>> not a powersaving issue but an upstream /proc or /sys files being outdated.
>>>> Otherwise I can't figure out why disabling in runtime laptop-mode-tools
>>>> and doing the "find /sys .... | while ... echo "on" > $f" trickery
>>>> does not help to get pciehp working. This would have fixed the acpiphp
>>>> at least on 3.8 kernel. I see that sata_sil24 is not loaded by itself
>>>> during hotinsert. It seems lspci reports at such times 0xff for the 11:00
>>>> eSATA card, /etc/iomem reports stale memory regions used by 11:00 while
>>>> /proc/interrupts says no IRQ is assigned to sata_sil24 (well, sata_sil24
>>>> is not loaded per lsmod, lspci would should report sata_sil24 also but
>>>> provided the 11:00 entry is broken and shows the 0xff it maybe cannot
>>>> report is sata_sil24 is loaded).
>>>>
>>>> I will post a little more details as a proper answer to your other patch
>>>> where I managed to get yet another stacktrace, about the eSATA thought to
>>>> be D3 state. Physically the card was ejected and just a modprobe sata_sil24
>>>> caused the sata_sil24 to use some outdated data. I will dive now into
>>>> that. 
>>>>
>>>>
>>>>
>>>>>
>>>>> And from your description below, it appears that hot-add and hot-remove
>>>>> of the eSATA card works for you, doesn't it?
>>>>
>>>> The PresDet works fine I think, yes. Sometimes I see in the lspci -vvv diffs:
>>>>
>>>> -Control: I/O+ ... BusMaster+
>>>> +Control: I/O- ... BusMaster-
>>>
>>> But after hot-insert, can you use your eSATA card?  It appears that it
>>> is detected properly.
>>
>> Can't say about the above two. But under pciehp what is broken is the hotremoval.
>> I think the rest is just a downstream consequence.
>>
>>>
>>>> and sometimes 
>>>>
>>>> -        Latency: 0, Cache Line Size: 64 bytes
>>>> +        Latency: 0
>>
>> It seems to me that bridges in lspci output have 'Latency: 0' while end devices have
>> the Cache Line Size as well.
>>
>> When the card is hot inserted after a previous hot removal and seems "dead" then
>> lspci says:
>> Control: I/O- Mem- BusMaster-
>> Interrupt: pin A routed to IRQ 19
>> and no 'Latency:' and no 'Cache Line Size:' are the output of the 11:00  device.
>>
>> But please realize this is likely screwed because a previous eject of the card did not
>> fully release resources. When the slot was empty lspci reported 0xff and when it is
>> loaded it likely reports some crap. Unless the bug causing 'stale' data to be reported
>> (the 'Re: 3.8.2: stale pci device info for a previously inserted express card' thread)
>> I wonder what can we trust in this output.
>>
>>>>
>>>> or even the Latency: line being gone completely from lspci -vvv output. Why is that?
>>>> I think debug checks and prints in kernel are necessary.
>>>>
>>>>
>>>> How do these related to /proc/interrupts not showing an IRQ for the 11:00 device?
>>>> Does that prevent automated sata_sil24 loading once the card is inserted? Would
>>>> you please add some extra debug prints and checks into the kernel?
>>>>
>>>> Take also into consideration the "3.8.2: stale pci device info for a previously inserted express card"
>>>> for a list of chimeric entries reported by lspci. That could tell you which values
>>>> are being cached and invalid. Hopefully some checks could be done between values
>>>> read by lspci and those in /proc and /sys.
>>>>
>>>>
>>>>
>>>> Do you already know why almost nothing is logged by kernel wen either of your
>>>> three patches (v1 sent on 03/29/13 08:41, v2 sent on 03/29/13 09:20, v3 sent on
>>>> 03/30/13 11:54)?
>>>
>>> No.  Don't know why.  unpatched upstream kernel can produce kernel log?
>>
>> OK, vanilla 3.9-rc1 also prints nothing to syslog relevant to hotplug (only pciehp
>> tested). Logging itself works, as I said, rmmod sata_sil24 is logged. So, sorry,
>> your patches did NOT break logging.
>>
>> Martin
>>
>>
>>>
>>> Best Regards,
>>> Huang Ying
>>>
>>>> I did not test the xHCI port behavior with any of your three patches because I have
>>>> disabled USB support in this kernel altogether for 3.9-rc1 tests. And I would like to stick
>>>> with that until we fix the pciehp issue. I stepped rather late into the big testing game,
>>>> I believe the pciehp bug we are facing was not working since 3.5/3.6, I don't think
>>>> the 3.9-rc1-based tests be much different from earlier kernels.
>>>>
>>>> For a broader view, on the 3.8 series we will meanwhile hopefully get to a fix of the
>>>> PME# stuff. I think I reported quite a good number of potential problems yesterday.
>>>> After that, I will check how xHCI behaves on 3.9 but I believe the PME#-related fix from
>>>> 3.8 will be also applicable to fixing 3.9 so the xHCI won't have problems there anymore.
>>>>
>>>>
>>>> Martin
>>>
>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
