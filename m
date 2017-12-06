Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp-out4.electric.net ([192.162.216.185]:57141 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751598AbdLFODh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Dec 2017 09:03:37 -0500
Received: from 1eMaIP-0003I2-Vw by out4d.electric.net with emc1-ok (Exim 4.87)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1eMaIQ-0003Jt-UH
        for linux-pci@vger.kernel.org; Wed, 06 Dec 2017 06:03:34 -0800
Received: from [156.67.243.126] (helo=AcuMS.aculab.com)
        by out4d.electric.net with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        (Exim 4.87)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1eMaIP-0003I2-Vw
        for linux-pci@vger.kernel.org; Wed, 06 Dec 2017 06:03:33 -0800
From: David Laight <David.Laight@ACULAB.COM>
To: "'linux-pci@vger.kernel.org'" <linux-pci@vger.kernel.org>
Subject: PCIe link not recovering
Date: Wed, 6 Dec 2017 14:03:55 +0000
Message-ID: <3d3c69b6dcc44963b1ad80120c69767b@AcuMS.aculab.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If I perform the following:
1) echo 1 >/sys/devices/pcixxxx/xxx/remove
2) completely reset the PCIe endpoint
3) echo 1 >/sys/devices/pcixxxx/rescan
I expect the endpoint to be reprobed (provided the BARs are compatible).

However on a new motherboard (SkyLake) it looks as though the root bridge isn't
trying to bring the PCIe link back up.
(The same system disk works fine in a slighty older system.)

There are 2 bits different in the lspci output for the root port between
the 'link up' and 'link down states':

--- link_up     2017-12-06 13:37:37.523661300 +0000
+++ link_down   2017-12-06 13:37:37.509614300 +0000
@@ -21,7 +21,7 @@
                DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
-               DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
+               DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
                LnkCap: Port #2, Speed 8GT/s, Width x8, ASPM L0s L1, Exit Latency L0s <256ns, L1 <8us
                        ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp+
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
@@ -51,7 +51,7 @@
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
-                       Status: NegoPending- InProgress-
+                       Status: NegoPending+ InProgress-
        Capabilities: [140 v1] Root Complex Link
                Desc:   PortNumber=02 ComponentID=01 EltType=Config
                Link0:  Desc:   TargetPort=00 TargetComponent=01 AssocRCRB- LinkType=MemMapped LinkValid+

The first just looks like a notification that there has been an error.
The last one might imply that it knows it needs to do something - but
needs to be 'kicked'.

I believe that the endpoint is flipping between the 'Detect Active' and 'Detect Quiet'
states. Which would imply that the root port isn't trying to establish the link.

Does the kernel have to prod the root complex somehow?

	David

The full output (link_down) is:

00:01.0 PCI bridge: Intel Corporation Skylake PCIe Controller (x16) (rev 05) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 122
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: df000000-df2fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [88] Subsystem: Super Micro Computer Inc Skylake PCIe Controller (x16)
        Capabilities: [80] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
                Address: fee00218  Data: 0000
        Capabilities: [a0] Express (v2) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 256 bytes, PhantFunc 0
                        ExtTag- RBE+
                DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
                LnkCap: Port #2, Speed 8GT/s, Width x8, ASPM L0s L1, Exit Latency L0s <256ns, L1 <8us
                        ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp+
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
                        Slot #1, PowerLimit 75.000W; Interlock- NoCompl+
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
                        Changed: MRL- PresDet+ LinkState-
                RootCtl: ErrCorrectable+ ErrNon-Fatal+ ErrFatal+ PMEIntEna+ CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR+, OBFF Via WAKE# ARIFwd-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Via WAKE# ARIFwd-
                LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
        Capabilities: [100 v1] Virtual Channel
                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=Fixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
                        Status: NegoPending+ InProgress-
        Capabilities: [140 v1] Root Complex Link
                Desc:   PortNumber=02 ComponentID=01 EltType=Config
                Link0:  Desc:   TargetPort=00 TargetComponent=01 AssocRCRB- LinkType=MemMapped LinkValid+
                        Addr:   00000000fed19000
        Capabilities: [d94 v1] #19
        Kernel driver in use: pcieport
        Kernel modules: shpchp
