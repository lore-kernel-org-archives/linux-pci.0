Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.4]:61218 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752486AbaJ0Til (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 27 Oct 2014 15:38:41 -0400
Message-ID: <544E9F1C.205@web.de>
Date: Mon, 27 Oct 2014 20:38:04 +0100
From: Heiner Kallweit <heiner.kallweit@web.de>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Lucas Stach <l.stach@pengutronix.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>
Subject: Re: Setting cpu affinity for MSI-X on i.mx6 possible?
References: <544D37F7.2060800@web.de> <1414399977.2421.1.camel@pengutronix.de> <544E99FD.5040306@web.de> <CAErSpo5Wsmjqm1rMi_46j_Y-6h+9eNv7Rc1OH0Wm7S1VmMNWWA@mail.gmail.com>
In-Reply-To: <CAErSpo5Wsmjqm1rMi_46j_Y-6h+9eNv7Rc1OH0Wm7S1VmMNWWA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am 27.10.2014 um 20:31 schrieb Bjorn Helgaas:
> On Mon, Oct 27, 2014 at 1:16 PM, Heiner Kallweit <heiner.kallweit@web.de> wrote:
>> Thanks, Lucas.
>>
>> It's interesting however that the igb driver claims it's using MSI-X.
>> Maybe the DW PCIE drivers offers MSI-X on the bus and just internally falls back to MSI?
>>
>> Rgds, Heiner
>>
>> [    4.165850] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.2.15-k
>> [    4.172930] igb: Copyright (c) 2007-2014 Intel Corporation.
>> [    4.178638] igb 0000:01:00.0: enabling device (0140 -> 0142)
>> [    4.235789] igb 0000:01:00.0: added PHC on eth0
>> [    4.235793] igb 0000:01:00.0: Intel(R) Gigabit Ethernet Network Connection
>> [    4.235799] igb 0000:01:00.0: eth0: (PCIe:2.5Gb/s:Width x1) 00:01:c0:14:b1:58
>> [    4.235804] igb 0000:01:00.0: eth0: PBA No: FFFFFF-0FF
>> [    4.235810] igb 0000:01:00.0: Using MSI-X interrupts. 2 rx queue(s), 2 tx queue(s)
> 
> What does "lspci -vvs01:00.0" say?  It *looks* like igb pays attention
> to whether enabling MSI-X worked, but that path in the driver is not
> completely trivial, and I got tired of tracing the code to verify it.
> 
> Bjorn
> 

Thanks, Bjorn. Here comes the full output of the lspci command.

[root@utilite ~]# lspci -vvs01:00.0
01:00.0 Ethernet controller: Intel Corporation I211 Gigabit Network Connection (rev 03)
        Subsystem: Intel Corporation Device 0000
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 155
        Region 0: Memory at 01100000 (32-bit, non-prefetchable) [size=128K]
        Region 2: I/O ports at 1000 [disabled] [size=32]
        Region 3: Memory at 01120000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
                Address: 0000000000000000  Data: 0000
                Masking: 00000000  Pending: 00000000
        Capabilities: [70] MSI-X: Enable+ Count=5 Masked-
                Vector table: BAR=3 offset=00000000
                PBA: BAR=3 offset=00002000
        Capabilities: [a0] Express (v2) Endpoint, MSI 00
                DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
                DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
                LnkCap: Port #4, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <2us, L1 <16us
                        ClockPM- Surprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
        Capabilities: [100 v2] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
        Capabilities: [140 v1] Device Serial Number 00-a0-c9-ff-ff-00-00-00
        Capabilities: [1a0 v1] Transaction Processing Hints
                Device specific mode supported
                Steering table in TPH capability structure
        Kernel driver in use: igb
        Kernel modules: igb

