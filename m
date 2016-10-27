Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:33390 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934036AbcJ0BJx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Oct 2016 21:09:53 -0400
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g9t1613g.houston.hpe.com (Postfix) with ESMTPS id 0F57362274
        for <linux-pci@vger.kernel.org>; Thu, 27 Oct 2016 01:09:52 +0000 (UTC)
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id C93CF48
        for <linux-pci@vger.kernel.org>; Thu, 27 Oct 2016 01:09:12 +0000 (UTC)
Received: from [16.93.61.14] (unknown [16.93.61.14])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 957033D
        for <linux-pci@vger.kernel.org>; Thu, 27 Oct 2016 01:09:12 +0000 (UTC)
To: linux-pci@vger.kernel.org
From: divakar <divakar.chitturi@hpe.com>
Subject: pci bar 0 assignment issue when device hotplugged
Message-ID: <33336b4e-313e-beff-eec6-a63a155e1e75@hpe.com>
Date: Wed, 26 Oct 2016 18:08:11 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

HiAll,

Scenario 1:
I am seeing BAR 0 assignment issue for one of the devices (Device A) downstream to pcie switch when i insert (hotplug) the card (with the plx switch and devices on it) after linux boots and enter the command prompt. However BAR 0 is assigned successfully to a different device (Device B) on different port of the same pcie switch.

Scenario 2:
In contrast, when i plug the card in the system first and power on, all the devices downstream to the pcie switch are allocated BAR 0.

Questions:
1. How can i get pci/pciehp to assign memory/BAR 0 to Device A (45:00.x) in Scenario 1.
2. Can this be caused by wrong config space settings for Device A ? If yes which register/field i should be looking at ?
3. How is the memory address assigned for Device B ( 44:00.x) change between Scenario 1 and scenario 2.


It would be of great help if someone can point out what am i missing, or how i can solve this. Without solving Question 1, i am not able to successfully enable the device driver for Device A in the hotplug situation, where the error will be something like "can't enable device: BAR 0 [] not claimed "


Thanks
Divakar



Sorry for removing some of the company information from the device details as the product is still under development.Currently running 3.19 ( linux yocto ). Also tried on 4.4.16 ( linux yocto ). Below log is from running 4.4.16 kernel


Scenario 1: HOTPLUG ( Insert the card after power on + linux booted )

BEFORE card Inserted

 \-[0000:00]-+-00.0
             +-01.0-[01-26]----00.0-[02-26]--+-09.0-[03-0b]--
             |                               +-0a.0-[0c-14]--
             |                               +-0b.0-[15-1d]--
             |                               \-0c.0-[1e-26]--
             +-02.0-[27]--+-00.0
             |            +-00.1
             |            +-00.2
             |            \-00.3
             +-02.2-[28-2a]--+-00.0
             |               \-00.1
             +-03.0-[2b]--
             +-03.1-[2c]--+-00.0
             |            +-00.1
             |            +-00.2
             |            \-00.3
             +-03.2-[2d-52]--+-00.0-[2e-52]--+-01.0-[2f-37]--
             |               |               +-02.0-[38-40]--
             |               |               +-03.0-[41-49]--
             |               |               \-04.0-[4a-52]--
             |               +-00.1
             |               +-00.2
             |               +-00.3
             |               \-00.4
             +-05.0
             +-05.1
             +-05.2
             +-05.4
             +-14.0
             +-1a.0

Hot plug enabled for port of pcie switch where cards can be inserted.

dmesg | grep pciehp
[    6.851607] pciehp 0000:02:09.0:pcie24: Slot #9 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- LLActRep-
[    6.863882] pciehp 0000:02:09.0:pcie24: service driver pciehp loaded
[    6.863888] pciehp 0000:02:0a.0:pcie24: Slot #10 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- LLActRep-
[    6.876262] pciehp 0000:02:0a.0:pcie24: service driver pciehp loaded
[    6.876267] pciehp 0000:02:0b.0:pcie24: Slot #11 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- LLActRep-
[    6.888639] pciehp 0000:02:0b.0:pcie24: service driver pciehp loaded
[    6.888644] pciehp 0000:02:0c.0:pcie24: Slot #12 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- LLActRep-
[    6.901016] pciehp 0000:02:0c.0:pcie24: service driver pciehp loaded
[    6.901022] pciehp 0000:2e:01.0:pcie24: Slot #1 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- LLActRep-
[    6.913298] pciehp 0000:2e:01.0:pcie24: service driver pciehp loaded
[    6.913304] pciehp 0000:2e:02.0:pcie24: Slot #2 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- LLActRep-
[    6.925581] pciehp 0000:2e:02.0:pcie24: service driver pciehp loaded
[    6.925587] pciehp 0000:2e:03.0:pcie24: Slot #3 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- LLActRep-
[    6.937862] pciehp 0000:2e:03.0:pcie24: service driver pciehp loaded
[    6.937868] pciehp 0000:2e:04.0:pcie24: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- LLActRep-
[    6.950142] pciehp 0000:2e:04.0:pcie24: service driver pciehp loaded
[    6.987039] pciehp: PCI Express Hot Plug Controller Driver version: 0.4

 

AFTER Card (with pcie switch and devices on it) Insertion

 \-[0000:00]-+-00.0
             +-01.0-[01-26]----00.0-[02-26]--+-09.0-[03-0b]--
             |                               +-0a.0-[0c-14]--
             |                               +-0b.0-[15-1d]--
             |                               \-0c.0-[1e-26]--
             +-02.0-[27]--+-00.0
             |            +-00.1
             |            +-00.2
             |            \-00.3
             +-02.2-[28-2a]--+-00.0
             |               \-00.1
             +-03.0-[2b]--
             +-03.1-[2c]--+-00.0
             |            +-00.1
             |            +-00.2
             |            \-00.3
             +-03.2-[2d-52]--+-00.0-[2e-52]--+-01.0-[2f-37]--
             |               |               +-02.0-[38-40]--
             |               |               +-03.0-[41-49]--+-00.0-[42-46]--+-01.0-[43]----00.0
             |               |               |               |               +-02.0-[44]--+-00.0
             |               |               |               |               |            \-00.1
             |               |               |               |               +-04.0-[45]--+-00.0
             |               |               |               |               |            +-00.1
             |               |               |               |               |            +-00.2
             |               |               |               |               |            \-00.3
             |               |               |               |               \-0a.0-[46]--+-00.0
             |               |               |               |                            +-00.1
             |               |               |               |                            +-00.2
             |               |               |               |                            \-00.3
             |               |               |               +-00.1
             |               |               |               +-00.2
             |               |               |               +-00.3
             |               |               |               \-00.4
             |               |               \-04.0-[4a-52]--
             |               +-00.1
             |               +-00.2
             |               +-00.3
             |               \-00.4
             +-05.0
             +-05.1
             +-05.2
             +-05.4
             +-14.0

When card inserted ( hotplugged ) messages i see

pciehp 0000:2e:03.0:pcie24: Card present on Slot(3)
pci 0000:41:00.0: Max Payload Size set to 256 (was 128, max 256)
pci 0000:41:00.1: Max Payload Size set to 256 (was 128, max 256)
pci 0000:41:00.2: Max Payload Size set to 256 (was 128, max 256)
pci 0000:41:00.3: Max Payload Size set to 256 (was 128, max 256)
pci 0000:41:00.4: Max Payload Size set to 256 (was 128, max 256)
pci 0000:41:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:42:01.0: Max Payload Size set to 256 (was 128, max 256)
pci 0000:42:02.0: Max Payload Size set to 256 (was 128, max 256)
pci 0000:42:04.0: Max Payload Size set to 256 (was 128, max 256)
pci 0000:42:0a.0: Max Payload Size set to 256 (was 128, max 256)
pci 0000:41:00.0: PCI bridge to [bus 42-ff]
pci 0000:42:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:42:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:42:04.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:42:0a.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:43:00.0: Max Payload Size set to 256 (was 128, max 256)
pci 0000:42:01.0: PCI bridge to [bus 43-ff]
pci 0000:44:00.0: can't set Max Payload Size to 256; if necessary, use "pci=pcie_bus_safe" and report a bug
pci 0000:44:00.1: can't set Max Payload Size to 256; if necessary, use "pci=pcie_bus_safe" and report a bug
pci 0000:42:02.0: PCI bridge to [bus 44-ff]
pci 0000:45:00.0: can't set Max Payload Size to 256; if necessary, use "pci=pcie_bus_safe" and report a bug
pci 0000:45:00.1: can't set Max Payload Size to 256; if necessary, use "pci=pcie_bus_safe" and report a bug
pci 0000:45:00.2: can't set Max Payload Size to 256; if necessary, use "pci=pcie_bus_safe" and report a bug
pci 0000:45:00.3: can't set Max Payload Size to 256; if necessary, use "pci=pcie_bus_safe" and report a bug
pci 0000:42:04.0: PCI bridge to [bus 45-ff]
pci 0000:46:00.0: can't set Max Payload Size to 256; if necessary, use "pci=pcie_bus_safe" and report a bug
pci 0000:46:00.1: can't set Max Payload Size to 256; if necessary, use "pci=pcie_bus_safe" and report a bug
pci 0000:46:00.2: can't set Max Payload Size to 256; if necessary, use "pci=pcie_bus_safe" and report a bug
pci 0000:46:00.3: can't set Max Payload Size to 256; if necessary, use "pci=pcie_bus_safe" and report a bug
pci 0000:42:0a.0: PCI bridge to [bus 46-ff]
pci 0000:41:00.0: BAR 9: assigned [mem 0xd5000000-0xd6ffffff 64bit pref]
pci 0000:41:00.0: BAR 8: assigned [mem 0x91000000-0x914fffff]
pci 0000:41:00.0: BAR 0: assigned [mem 0x91500000-0x9153ffff]
pci 0000:41:00.1: BAR 0: assigned [mem 0x91540000-0x91541fff]
pci 0000:41:00.2: BAR 0: assigned [mem 0x91542000-0x91543fff]
pci 0000:41:00.3: BAR 0: assigned [mem 0x91544000-0x91545fff]
pci 0000:41:00.4: BAR 0: assigned [mem 0x91546000-0x91547fff]
pci 0000:41:00.0: BAR 7: no space for [io  size 0x2000]
pci 0000:41:00.0: BAR 7: failed to assign [io  size 0x2000]
pci 0000:41:00.0: BAR 7: no space for [io  size 0x2000]
pci 0000:41:00.0: BAR 7: failed to assign [io  size 0x2000]
pci 0000:42:02.0: BAR 9: assigned [mem 0xd5000000-0xd63fffff 64bit pref]
pci 0000:42:01.0: BAR 8: assigned [mem 0x91000000-0x910fffff]
pci 0000:42:02.0: BAR 8: assigned [mem 0x91100000-0x912fffff]
pci 0000:42:04.0: BAR 9: assigned [mem 0xd6400000-0xd67fffff 64bit pref]
pci 0000:42:0a.0: BAR 8: assigned [mem 0x91300000-0x914fffff]
pci 0000:42:0a.0: BAR 9: assigned [mem 0xd6800000-0xd6dfffff 64bit pref]
pci 0000:42:02.0: BAR 7: no space for [io  size 0x1000]
pci 0000:42:02.0: BAR 7: failed to assign [io  size 0x1000]
pci 0000:42:0a.0: BAR 7: no space for [io  size 0x1000]
pci 0000:42:0a.0: BAR 7: failed to assign [io  size 0x1000]
pci 0000:42:0a.0: BAR 7: no space for [io  size 0x1000]
pci 0000:42:0a.0: BAR 7: failed to assign [io  size 0x1000]
pci 0000:42:02.0: BAR 7: no space for [io  size 0x1000]
pci 0000:42:02.0: BAR 7: failed to assign [io  size 0x1000]
pci 0000:43:00.0: BAR 0: assigned [mem 0x91000000-0x9103ffff]
pci 0000:42:01.0: PCI bridge to [bus 43]
pci 0000:42:01.0:   bridge window [mem 0x91000000-0x910fffff]
pci 0000:44:00.0: BAR 2: assigned [mem 0xd5000000-0xd57fffff 64bit pref]
pci 0000:44:00.1: BAR 2: assigned [mem 0xd5800000-0xd5ffffff 64bit pref]
pci 0000:44:00.0: BAR 0: assigned [mem 0xd6000000-0xd6007fff 64bit pref]
pci 0000:44:00.1: BAR 0: assigned [mem 0xd6008000-0xd600ffff 64bit pref]
pci 0000:42:02.0: PCI bridge to [bus 44]
pci 0000:42:02.0:   bridge window [mem 0x91100000-0x912fffff]
pci 0000:42:02.0:   bridge window [mem 0xd5000000-0xd63fffff 64bit pref]
pci 0000:42:04.0: PCI bridge to [bus 45]
pci 0000:42:04.0:   bridge window [mem 0xd6400000-0xd67fffff 64bit pref]
pci 0000:42:0a.0: PCI bridge to [bus 46]
pci 0000:42:0a.0:   bridge window [mem 0x91300000-0x914fffff]
pci 0000:42:0a.0:   bridge window [mem 0xd6800000-0xd6dfffff 64bit pref]
pci 0000:41:00.0: PCI bridge to [bus 42-46]
pci 0000:41:00.0:   bridge window [mem 0x91000000-0x914fffff]
pci 0000:41:00.0:   bridge window [mem 0xd5000000-0xd6ffffff 64bit pref]
pcieport 0000:2e:03.0: PCI bridge to [bus 41-49]
pcieport 0000:2e:03.0:   bridge window [io  0xa000-0xafff]
pcieport 0000:2e:03.0:   bridge window [mem 0x91000000-0x917fffff]
pcieport 0000:2e:03.0:   bridge window [mem 0xd5000000-0xdc7fffff 64bit pref]
pcieport 0000:41:00.0: enabling device (0000 -> 0002)
pcieport 0000:42:01.0: enabling device (0000 -> 0002)
pcieport 0000:42:02.0: enabling device (0000 -> 0002)
pciehp 0000:42:02.0:pcie24: Slot #2 AttnBtn+ PwrCtrl+ MRL+ AttnInd+ PwrInd+ HotPlug+ Surprise- Interlock- NoCompl- LLActRep-
pcieport 0000:42:04.0: enabling device (0000 -> 0002)
pcieport 0000:42:0a.0: enabling device (0000 -> 0002)
pciehp 0000:42:0a.0:pcie24: Slot #10 AttnBtn+ PwrCtrl+ MRL+ AttnInd+ PwrInd+ HotPlug+ Surprise- Interlock- NoCompl- LLActRep-


Device A : Memory not assigned
lspci -vvv -s 45:*
45:00.0 
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Region 0: Memory at <unassigned> (64-bit, prefetchable) [disabled] [size=1M]
	Capabilities: [50] MSI: Enable- Count=1/32 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [78] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 25.000W
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #1, Speed 2.5GT/s, Width x1, ASPM not supported, Exit Latency L0s <4us, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v1] Multi-Function Virtual Channel <?>
	Capabilities: [200 v1] Vendor Specific Information:


Device B : Region 0 assigned
lspci -vvv -s 44:*
44:00.0 
	Subsystem: 
	Physical Slot: 2-2
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at d6000000 (64-bit, prefetchable) [disabled] [size=32K]
	Region 2: Memory at d5000000 (64-bit, prefetchable) [disabled] [size=8M]
	Capabilities: [48] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
pcilib: sysfs_read_vpd: read failed: Connection timed out
		Not readable
	Capabilities: [58] MSI: Enable- Count=1/8 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [a0] MSI-X: Enable- Count=1 Masked-
		Vector table: BAR=0 offset=00000000
		PBA: BAR=0 offset=00000000
	Capabilities: [ac] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 25.000W
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 5GT/s, Width x2, ASPM L0s L1, Exit Latency L0s <2us, L1 <4us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x2, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+, OBFF Via WAKE#
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [13c v1] Device Serial Number 00-00-00-00-00-00-00-00
	Capabilities: [150 v1] Power Budgeting <?>
	Capabilities: [160 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Capabilities: [180 v1] Vendor Specific Information: ID=0000 Rev=0 Len=028 <?>
	Capabilities: [1b0 v1] Latency Tolerance Reporting
		Max snoop latency: 0ns
		Max no snoop latency: 0ns
	Capabilities: [250 v1] #12


 

Scenario 2: COLD boot ( when card is inserted in the slot before power on )

\-[0000:00]-+-00.0
             +-01.0-[01-26]----00.0-[02-26]--+-09.0-[03-0b]--
             |                               +-0a.0-[0c-14]--
             |                               +-0b.0-[15-1d]--
             |                               \-0c.0-[1e-26]--
             +-02.0-[27]--+-00.0
             |            +-00.1
             |            +-00.2
             |            \-00.3
             +-02.2-[28-2a]--+-00.0
             |               \-00.1
             +-03.0-[2b]--
             +-03.1-[2c]--+-00.0
             |            +-00.1
             |            +-00.2
             |            \-00.3
             +-03.2-[2d-57]--+-00.0-[2e-57]--+-01.0-[2f-37]--
             |               |               +-02.0-[38-40]--
             |               |               +-03.0-[41-4e]--+-00.0-[42-46]--+-01.0-[43]----00.0
             |               |               |               |               +-02.0-[44]--+-00.0
             |               |               |               |               |            \-00.1
             |               |               |               |               +-04.0-[45]--+-00.0
             |               |               |               |               |            +-00.1
             |               |               |               |               |            +-00.2
             |               |               |               |               |            \-00.3
             |               |               |               |               \-0a.0-[46]--+-00.0
             |               |               |               |                            +-00.1
             |               |               |               |                            +-00.2
             |               |               |               |                            \-00.3
             |               |               |               +-00.1
             |               |               |               +-00.2
             |               |               |               +-00.3
             |               |               |               \-00.4
             |               |               \-04.0-[4f-57]--
             |               +-00.1
             |               +-00.2
             |               +-00.3
             |               \-00.4
Device A
lspci -vvv -s 45:00.0
45:00.0 
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Region 0: Memory at 183fff000000 (64-bit, prefetchable) [size=1M]
	Capabilities: [50] MSI: Enable- Count=1/32 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [78] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 25.000W
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #1, Speed 2.5GT/s, Width x1, ASPM not supported, Exit Latency L0s <4us, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v1] Multi-Function Virtual Channel <?>
	Capabilities: [200 v1] Vendor Specific Information: 

Device B
lspci -vvv -s 44:00.0
44:00.0 
	Subsystem: 
	Physical Slot: 2-2
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at 183ffe808000 (64-bit, prefetchable) [size=32K]
	Region 2: Memory at 183ffe000000 (64-bit, prefetchable) [size=8M]
	Capabilities: [48] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
pcilib: sysfs_read_vpd: read failed: Connection timed out
		Not readable
	Capabilities: [58] MSI: Enable- Count=1/8 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [a0] MSI-X: Enable- Count=1 Masked-
		Vector table: BAR=0 offset=00000000
		PBA: BAR=0 offset=00000000
	Capabilities: [ac] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 25.000W
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 5GT/s, Width x2, ASPM L0s L1, Exit Latency L0s <2us, L1 <4us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x2, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+, OBFF Via WAKE#
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [13c v1] Device Serial Number 00-00-00-00-00-00-00-00
	Capabilities: [150 v1] Power Budgeting <?>
	Capabilities: [160 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Capabilities: [180 v1] Vendor Specific Information: ID=0000 Rev=0 Len=028 <?>
	Capabilities: [1b0 v1] Latency Tolerance Reporting
		Max snoop latency: 0ns
		Max no snoop latency: 0ns
	Capabilities: [250 v1] #12 

















