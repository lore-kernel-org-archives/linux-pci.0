Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:56737 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752479AbdLNNNB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Dec 2017 08:13:01 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 5500C20994
        for <linux-pci@vger.kernel.org>; Thu, 14 Dec 2017 08:13:00 -0500 (EST)
Received: from [10.0.16.1] (c-73-19-34-176.hsd1.wa.comcast.net [73.19.34.176])
        by mail.messagingengine.com (Postfix) with ESMTPA id D5A632450C
        for <linux-pci@vger.kernel.org>; Thu, 14 Dec 2017 08:12:59 -0500 (EST)
To: linux-pci@vger.kernel.org
From: John Strader <strader.john@code.jackst.com>
Subject: Quirk - broken_intx_masking - Ceton InfiniTV4
Message-ID: <92a65068-60b2-c1a8-9e17-ac41fe3c5c93@code.jackst.com>
Date: Thu, 14 Dec 2017 05:12:59 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Submitting a device for quirk_broken_intx_masking, as requested by
modinfo for vfio-pci "nointxmask" parameter.

The device is a Ceton InfiniTV4 [1b7c:0004].  I can confirm that this
device operates correctly with vfio when passed the nointxmask
parameter.  I can also confirm that applying quirk_broken_intx_masking
via drivers/pci/quirks.c in a custom compiled kernel also works.  I no
longer compile the custom kernel and seem to have misplaced the patch,
so I won't bother remaking a one-liner, but it was of the standard form:

DECLARE_PCI_FIXUP_FINAL(0x1b7c, 0x0004,
                         quirk_broken_intx_masking);

The driver for this device also specifies that 0x1b7c is a Ceton PCI
vendor ID, but I have not done any digging to confirm this beyond
looking at the driver source:

https://github.com/ceton/infinitv_pcie/blob/eb7fbf983f47bfaf236e49555e5a846e6f35e505/ctn91xx_registers.h#L13


lspci -vvvxxx as per instructions:

03:08.0 Non-VGA unclassified device: Device 1b7c:0004 (rev 01)
     Subsystem: Device 1b7c:0004
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 32 (2000ns min), Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 17
     Region 0: Memory at f8100000 (32-bit, non-prefetchable) [size=128K]
     Region 1: Memory at f8120000 (32-bit, non-prefetchable) [size=64K]
     Kernel driver in use: vfio-pci
00: 7c 1b 04 00 06 00 00 04 01 00 00 00 10 20 00 00
10: 00 00 10 f8 00 00 12 f8 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 7c 1b 04 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 01 08 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


The PCIe device also includes an integrated PCI bridge, lspci is
included for completeness:

02:00.0 PCI bridge: Tundra Semiconductor Corp. Device 8111 (rev 02) 
(prog-if 00 [Normal decode])
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Region 0: Memory at f8200000 (32-bit, non-prefetchable) [size=4K]
     Bus: primary=02, secondary=03, subordinate=03, sec-latency=32
     I/O behind bridge: 0000f000-00000fff
     Memory behind bridge: f8100000-f81fffff
     Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
     Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
     BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [80] MSI: Enable- Count=1/8 Maskable+ 64bit+
         Address: 0000000000000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [a0] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [c0] Express (v1) PCI-Express to PCI/PCI-X Bridge, MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+
         DevCtl:    Report errors: Correctable+ Non-Fatal+ Fatal+ 
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- BrConfRtry-
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr+ UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Exit 
Latency L0s <512ns, L1 <1us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk- 
DLActive- BWMgmt- ABWMgmt-
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
         AERCap:    First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
     Kernel modules: shpchp
00: e3 10 11 81 07 00 10 00 02 00 04 06 00 00 01 00
10: 00 00 20 f8 00 00 00 00 02 03 03 20 f1 01 a0 22
20: 10 f8 10 f8 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 ff 00 10 00
40: 00 00 00 00 00 19 10 7d 00 01 00 00 07 03 00 00
50: 68 89 09 80 00 1f 00 00 00 01 00 00 01 00 01 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 05 a0 86 01 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 c0 03 78 08 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 40 00 00 00 00 00 00 00 41 00 00 03
c0: 10 00 71 00 00 80 00 00 07 20 0b 00 11 34 00 00
d0: 00 00 11 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
