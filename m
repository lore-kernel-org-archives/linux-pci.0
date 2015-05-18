Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0133.outbound.protection.outlook.com ([65.55.169.133]:35863
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932501AbbERTpS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 18 May 2015 15:45:18 -0400
Message-ID: <555A4137.7040000@amd.com>
Date: Mon, 18 May 2015 14:44:55 -0500
From: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Arnd Bergmann" <arnd@arndb.de>, Will Deacon <Will.Deacon@arm.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Krzysztof Halasa <khalasa@piap.pl>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Jingoo Han <jg1.han@samsung.com>,
	"Russell King" <linux@arm.linux.org.uk>,
	Lucas Stach <l.stach@pengutronix.de>,
	"Simon Horman" <horms@verge.net.au>,
	Minghuan Lian <minghuan.Lian@freescale.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jayachandran C <jchandra@broadcom.com>
Subject: Re: [RFC/RFT PATCH 2/2] ARM64: kernel: pci: implement PCI device
 resources claiming
References: <1431614537-16136-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1431614537-16136-2-git-send-email-lorenzo.pieralisi@arm.com>
 <5555553F.9070608@amd.com> <20150518173818.GA20028@red-moon>
In-Reply-To: <20150518173818.GA20028@red-moon>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 5/18/2015 12:38 PM, Lorenzo Pieralisi wrote:
>> Lorenzo/Bjorn,
>> >
>> >I have tested this patch on top of Jayachandran's V2 patch series
>> >(http://www.spinics.net/lists/linux-pci/msg40811.html) on AMD Seattle
>> >(w/ PROBE_ONLY and non-PROBE_ONLY mode), and your changes here works
>> >with additional changes below.
>> >
>> >It seems that when booting w/ PROBE_ONLY case, we need to call
>> >pci_read_bridge_bases() at some point before claiming the resources of
>> >devices underneath the bridge. This is needed to determine the bridge
>> >bases (i.e. bridge io, mmio and mmio_pref bases), and update bridge
>> >resources accordingly.
> Thanks for testing, I will give it a go on Seattle, if you can drop
> the log you get on PROBE_ONLY (without your patch below) that would be
> great so that I can have a look at the issue.
>
> Thanks,
> Lorenzo
>

Lorenzo,

Here is the log w/ PROBE_ONLY and w/o the changes I proposed:

# dmesg
.....
PCI host bridge /smb/pcie@f0000000 ranges:
    IO 0xefff0000..0xefffffff -> 0x00000000
   MEM 0x40000000..0xbfffffff -> 0x40000000
   MEM 0x100000000..0x7fffffffff -> 0x100000000
pci-host-generic f0000000.pcie: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [bus 00-7f]
pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
pci_bus 0000:00: root bus resource [mem 0x40000000-0xbfffffff]
pci_bus 0000:00: root bus resource [mem 0x100000000-0x7fffffffff]
pci 0000:00:00.0: of_irq_parse_pci() failed with rc=-19
pci 0000:00:02.0: of_irq_parse_pci() failed with rc=-19
pci 0000:01:00.0: can't claim BAR 0 [mem 0xbfe80000-0xbfefffff 64bit 
pref]: no compatible bridge window
pci 0000:01:00.0: can't claim BAR 2 [io  0x0020-0x003f]: no compatible 
bridge window
pci 0000:01:00.0: can't claim BAR 4 [mem 0xbff04000-0xbff07fff 64bit 
pref]: no compatible bridge window
pci 0000:01:00.1: can't claim BAR 0 [mem 0xbfe00000-0xbfe7ffff 64bit 
pref]: no compatible bridge window
pci 0000:01:00.1: can't claim BAR 2 [io  0x0000-0x001f]: no compatible 
bridge window
pci 0000:01:00.1: can't claim BAR 4 [mem 0xbff00000-0xbff03fff 64bit 
pref]: no compatible bridge window
.....

# dmesg | grep ixgbe
[    7.189232] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver - 
version 4.0.1-k
[    7.195580] ixgbe: Copyright (c) 1999-2014 Intel Corporation.
[    7.195638] ixgbe 0000:01:00.0: can't enable device: BAR 0 [mem size 
0x00080000 64bit pref] not assigned
[    7.195645] ixgbe: probe of 0000:01:00.0 failed with error -22
[    7.195660] ixgbe 0000:01:00.1: can't enable device: BAR 0 [mem size 
0x00080000 64bit pref] not assigned
[    7.195664] ixgbe: probe of 0000:01:00.1 failed with error -22

Also, here is the bridge configuration. Please note that the change I 
added tries to setup the bridge resource with information in 
_Prefetchable memory behind_ region.

# lspci -vvv -s 0:2.1
00:02.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 1a02 
(prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
         I/O behind bridge: 00fff000-00000fff
         Memory behind bridge: fff00000-000fffff
         Prefetchable memory behind bridge: 
00000000bfe00000-00000000bfffffff
         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
         BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
         Capabilities: [50] Power Management version 3
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [58] Express (v2) Root Port (Slot+), MSI 00
                 DevCap: MaxPayload 512 bytes, PhantFunc 0
                         ExtTag+ RBE+
                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
                         MaxPayload 512 bytes, MaxReadReq 512 bytes
                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- 
AuxPwr- TransPend-
                 LnkCap: Port #0, Speed 5GT/s, Width x8, ASPM L0s L1, 
Exit Latency L0s <512ns, L1 <64us
                         ClockPM- Surprise- LLActRep+ BwNot-
                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 5GT/s, Width x4, TrErr- Train- SlotClk+ 
DLActive+ BWMgmt- ABWMgmt-
                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- 
HotPlug- Surprise-
                         Slot #0, PowerLimit 0.000W; Interlock- NoCompl+
                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- 
HPIrq- LinkChg-
                         Control: AttnInd Unknown, PwrInd Unknown, 
Power- Interlock-
                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- 
PresDet+ Interlock-
                         Changed: MRL- PresDet- LinkState-
                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- 
PMEIntEna- CRSVisible+
                 RootCap: CRSVisible-
                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, 
LTR-, OBFF Not Supported ARIFwd+
                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, 
LTR-, OBFF Disabled ARIFwd+
                 LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- 
SpeedDis-
                          Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
                          Compliance De-emphasis: -6dB
                 LnkSta2: Current De-emphasis Level: -6dB, 
EqualizationComplete-, EqualizationPhase1-
                          EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest-
         Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit+
                 Address: 0000000000000000  Data: 0000
         Capabilities: [c0] Subsystem: Advanced Micro Devices, Inc. 
[AMD] Device 1234
         Capabilities: [c8] HyperTransport: MSI Mapping Enable+ Fixed+
         Capabilities: [100 v1] Vendor Specific Information: ID=0001 
Rev=1 Len=010 <?>
         Capabilities: [270 v1] #19

Thanks,

Suravee

