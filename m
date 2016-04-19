Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:37813 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754235AbcDSUjM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Apr 2016 16:39:12 -0400
Received: by mail-ig0-f176.google.com with SMTP id g8so29243178igr.0
        for <linux-pci@vger.kernel.org>; Tue, 19 Apr 2016 13:39:12 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 19 Apr 2016 13:39:11 -0700
Message-ID: <CAH=XD58Rqd-pcN+OAChKAds57sQ0OeszT1H40DUwyDZPMOQQkQ@mail.gmail.com>
Subject: PCI Hot Plug: OS can not program BARs for new devices
From: Kallol Biswas <kallol@nucleodyne.com>
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I have a been testing PCIe Hot Plug feature on a Supericro X10DRL
motherboard running 2.6.38.1 kernel.

If an endpoint is already present at boot time on a hot plug capable
PCIe slot then I can remove and add the endpoint with the help of a
Quarch device. OS allocates resources properly and after hot unplug
and plug, the device is functional.

If the endpoint is not present at boot time (turned off with the
Quarch) then put back (turn on with Quarch) the OS can not program BAR
registers.

Here is the dmesg output:

pci 0000:0c:00.0: [10ec:8168] type 0 class 0x000200
pci 0000:0c:00.0: reg 10: [io  0x0000-0x00ff]
pci 0000:0c:00.0: reg 18: [mem 0x00000000-0x00000fff 64bit]
pci 0000:0c:00.0: reg 20: [mem 0x00000000-0x00003fff 64bit pref]
pci 0000:0c:00.0: supports D1 D2
pci 0000:0c:00.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:0c:00.0: PME# disabled
pcieport 0000:09:09.0: BAR 14: can't assign mem (size 0x400000)
pci 0000:0c:00.0: BAR 4: assigned [mem 0x90200000-0x90203fff 64bit pref]
pci 0000:0c:00.0: BAR 4: set to [mem 0x90200000-0x90203fff 64bit pref]
(PCI address [0x90200000-0x90203fff])
pci 0000:0c:00.0: BAR 2: can't assign mem (size 0x1000)
pci 0000:0c:00.0: BAR 0: assigned [io  0x2000-0x20ff]
pci 0000:0c:00.0: BAR 0: set to [io  0x2000-0x20ff] (PCI address
[0x2000-0x20ff])
pcieport 0000:09:09.0: PCI bridge to [bus 0c-0c]
pcieport 0000:09:09.0:   bridge window [io  0x2000-0x2fff]
pcieport 0000:09:09.0:   bridge window [mem disabled]
pcieport 0000:09:09.0:   bridge window [mem 0x90200000-0x903fffff 64bit pref]
PCI: No. 2 try to assign unassigned res
release child resource [mem 0xfa800000-0xfaffffff]
pcieport 0000:09:19.0: resource 14 [mem 0xfa800000-0xfaffffff] released
pcieport 0000:09:19.0: PCI bridge to [bus 14-15]
pcieport 0000:09:19.0:   bridge window [mem disabled]
pcieport 0000:08:00.0: resource 14 [mem 0xfa800000-0xfaffffff] released
pcieport 0000:08:00.0: PCI bridge to [bus 09-15]
pcieport 0000:08:00.0:   bridge window [mem disabled]
pcieport 0000:09:09.0: BAR 14: can't assign mem (size 0x400000)
pci 0000:0c:00.0: BAR 2: can't assign mem (size 0x1000)
pcieport 0000:09:09.0: PCI bridge to [bus 0c-0c]
pcieport 0000:09:09.0:   bridge window [io  0x2000-0x2fff]
pcieport 0000:09:09.0:   bridge window [mem disabled]
pcieport 0000:09:09.0:   bridge window [mem 0x90200000-0x903fffff 64bit pref]
pcieport 0000:09:09.0: setting latency timer to 64
pciehp_readw : reg 0x1a value 0x140 ret 0x0
pciehp_readw : reg 0x18 value 0x27d ret 0x0
pciehp 0000:09:09.0:pcie24: pcie_write_cmd: written at SLOTCTRL 0x18 value 0x17d
pciehp_writew : reg 0x18 value 0x17d ret 0x0
pciehp_readw : reg 0x1a value 0x150 ret 0x0
pciehp_writew : reg 0x1a value 0x10 ret 0x0
pciehp_readw : reg 0x1a value 0x140 ret 0x0


Here is lspci -vvv -s <end point> output:

lspci -vvv -s 0c:00.0
0c:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 06)
Subsystem: TP-LINK Technologies Co., Ltd. TG-3468 Gigabit PCI Express
Network Adapter
Physical Slot: 9
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Interrupt: pin A routed to IRQ 255
Region 0: I/O ports at 2000 [disabled] [size=256]
Region 2: Memory at <unassigned> (64-bit, non-prefetchable) [disabled]
Region 4: Memory at 90200000 (64-bit, prefetchable) [disabled] [size=16K]
Capabilities: [40] Power Management version 3
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
Address: 0000000000000000  Data: 0000
Capabilities: [70] Express (v2) Endpoint, MSI 01
DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 512 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0
<512ns, L1 <64us
ClockPM+ Surprise- LLActRep- BwNot-
LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR-, OBFF
Not Supported
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [b0] MSI-X: Enable- Count=4 Masked-
Vector table: BAR=4 offset=00000000
PBA: BAR=4 offset=00000800
Capabilities: [d0] Vital Product Data
Unknown small resource type 05, will not decode more.
Capabilities: [100 v1] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
Capabilities: [140 v1] Virtual Channel
Caps: LPEVC=0 RefClk=100ns PATEntryBits=1
Arb: Fixed- WRR32- WRR64- WRR128-
Ctrl: ArbSelect=Fixed
Status: InProgress-
VC0: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl: Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
Status: NegoPending- InProgress-
Capabilities: [160 v1] Device Serial Number 0a-40-00-00-68-4c-e0-00
Kernel modules: r8169

The kernel options:
ro root=/dev/mapper/VolGroup-lv_root nomodeset rd_NO_LUKS rd_NO_MD
pci=assign-busses pcie_ports=native rd_LVM_LV=VolGroup/lv_swap
crashkernel=128M rd_LVM_LV=VolGroup/lv_root rd_NO_DM rhgb quiet
SYSFONT=latarcyrheb-sun16 LANG=en_US.UTF-8 KEYTABLE=us

Is there a workaround for this? Note, there are other devices on
downstream PCIe ports, so remove and rescan is not an option.
