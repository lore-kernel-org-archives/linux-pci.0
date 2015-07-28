Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:35739 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722AbbG1V3t (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jul 2015 17:29:49 -0400
Received: by iodd187 with SMTP id d187so1411779iod.2
        for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2015 14:29:48 -0700 (PDT)
Date: Tue, 28 Jul 2015 16:29:44 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Duc Dang <dhdang@apm.com>
Cc: Tanmay Inamdar <tinamdar@apm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: X-Gene: Unhandled fault: synchronous external abort in
 pci_generic_config_read32
Message-ID: <20150728212944.GA12958@google.com>
References: <20150724224258.GA23990@google.com>
 <CADaLNDmYZ=8XQt82W_H74QaOiX3UwkVxkE1_EWRgzhkG1boebw@mail.gmail.com>
 <CAErSpo549xfAnx62quCqGHh3DNay5Lfb6EhEG+4EXooEuueQFQ@mail.gmail.com>
 <CADaLNDn95H=g73DKWRsrB4SuWcf+-8mkepbwb_DC-sFsVkrk6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CADaLNDn95H=g73DKWRsrB4SuWcf+-8mkepbwb_DC-sFsVkrk6g@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 28, 2015 at 10:45:26AM -0700, Duc Dang wrote:
> On Tue, Jul 28, 2015 at 9:43 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> > On Fri, Jul 24, 2015 at 7:05 PM, Duc Dang <dhdang@apm.com> wrote:
> >> Hi Bjorn,
> >>
> >> On Fri, Jul 24, 2015 at 3:42 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> >>>
> >>> I regularly see faults like this on an APM X-Gene:
> >>>
> >>>   U-Boot 2013.04-mustang_sw_1.14.14 (Dec 16 2014 - 15:59:33)
> >>>   CPU0: APM ARM 64-bit Potenza Rev B0 2400MHz PCP 2400MHz
> >>>        32 KB ICACHE, 32 KB DCACHE
> >>>        SOC 2000MHz IOBAXI 400MHz AXI 250MHz AHB 200MHz GFC 125MHz
> >>>   ...
> >>>   Unhandled fault: synchronous external abort (0x96000010) at 0xffffff8000110034
> >>>   Internal error: : 96000010 [#1] SMP
> >>>   Modules linked in:
> >>>   CPU: 0 PID: 3723 Comm: ... 4.1.0-smp-DEV #3
> >>>   Hardware name: APM X-Gene Mustang board (DT)
> >>>   task: ffffffc7dc1a4140 ti: ffffffc7dc118000 task.ti: ffffffc7dc118000
> >>>   PC is at pci_generic_config_read32+0x4c/0xb8
> >>>   LR is at pci_generic_config_read32+0x40/0xb8
> >>>   pc : [<ffffffc00033b90c>] lr : [<ffffffc00033b900>] pstate: 600001c5
> >>>   ...
> >>>   Call trace:
> >>>   [<ffffffc00033b90c>] pci_generic_config_read32+0x4c/0xb8
> >>>   [<ffffffc00033bf58>] pci_user_read_config_byte+0x60/0xc4
> >>>   [<ffffffc0003496a8>] pci_read_config+0x15c/0x238
> >>>   [<ffffffc0002393b4>] sysfs_kf_bin_read+0x68/0xa0
> >>>   [<ffffffc00023896c>] kernfs_fop_read+0x9c/0x1ac
> >>>   [<ffffffc0001c361c>] __vfs_read+0x44/0x128
> >>>   [<ffffffc0001c3e28>] vfs_read+0x84/0x144
> >>>   [<ffffffc0001c4764>] SyS_read+0x50/0xb0
> >>
> >> The log shows kernel gets an exception when trying to access Mellanox
> >> card configuration space. This is usually due to suboptimal PCIe
> >> SerDes parameters are using in your board, which will cause bad link
> >> quality.
> >> The PCIe SerDes programming is done in U-Boot, so I suggest you do a
> >> U-Boot upgrade to our latest X-Gene U-Boot release.
> >
> > I installed U-Boot 1.15.12, which I thought was the latest.  I'm still
> > seeing this issue regularly, approx once/hour.
> 
> Our latest U-Boot is 1.15.15, but U-Boot 1.15.12 is already a good
> version to use. Are you running any PCIe traffic test when the error
> happens? 

Nope, the machine was either idle or running a reboot test; no PCIe stress
test or anything.

> And it will be useful if you can share your "lspci -vvv" output when
> the board is running, we can check to see if there is any error status
> reported.

Here's some lspci output and info about the firmware I'm running.
Obviously this lspci output was collected before a crash.  I have also
seen lspci output where "CESta: RxErr+" was set on the 00:00.0 Root Port.

U-Boot 2013.04-mustang_sw_1.15.12 (May 20 2015 - 10:03:33)

CPU0: APM ARM 64-bit Potenza Rev B0 2400MHz PCP 2400MHz
     32 KB ICACHE, 32 KB DCACHE
     SOC 2000MHz IOBAXI 400MHz AXI 250MHz AHB 200MHz GFC 125MHz
Boot from SPI-NOR
Slimpro FW:
        Ver: 2.4 (build 01.15.12.00 2015/05/20)
        PMD: 970 mV
        SOC: 950 mV
Board: Mustang - AppliedMicro APM883208-xNA24SPT Reference Board
I2C:   ready
DRAM:  ECC 32 GiB @ 1600MHz
SF: Detected N25Q256 with page size 256 Bytes, total 32 MiB
MMC:   X-Gene SD/SDIO/eMMC: 0
PCIE0: (RC) X8 GEN-3 link up
  00:00.0     - 10e8:e004 - Bridge device
   01:00.0    - 15b3:1007 - Network controller

# lspci -vvv
00:00.0 PCI bridge: Applied Micro Circuits Corp. Device e004 (rev 04) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: 80000000-82ffffff
	Prefetchable memory behind bridge: 0000000083000000-00000000830fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <1us, L1 unlimited
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr+ UnsuppReq- AuxPwr- TransPend+
		LnkCap:	Port #0, Speed unknown, Width x8, ASPM L0s L1, Latency L0 unlimited, L1 unlimited
			ClockPM- Surprise+ LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x8, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #1, PowerLimit 10.000W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Off, PwrInd Off, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
			Changed: MRL- PresDet- LinkState+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+ ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
		LnkCtl2: Target Link Speed: Unknown, EnterCompliance- SpeedDis-, Selectable De-emphasis: -3.5dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr+ BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr+ BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [180 v1] #19
	Capabilities: [150 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
	Kernel driver in use: pcieport

01:00.0 Ethernet controller: Mellanox Technologies MT27520 Family
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 226
	Region 0: [virtual] Memory at e182000000 (32-bit, non-prefetchable) [size=1M]
	Region 2: [virtual] Memory at e180000000 (32-bit, non-prefetchable) [size=32M]
	[virtual] Expansion ROM at e183000000 [disabled] [size=1M]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [9c] MSI-X: Enable- Count=64 Masked-
		Vector table: BAR=0 offset=0007c000
		PBA: BAR=0 offset=0007d000
	Capabilities: [60] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 unlimited
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #8, Speed unknown, Width x8, ASPM L0s, Latency L0 unlimited, L1 unlimited
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: Unknown, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB
	Capabilities: [100 v1] Alternative Routing-ID Interpretation (ARI)
		ARICap:	MFVC- ACS-, Next Function: 0
		ARICtl:	MFVC- ACS-, Function Group: 0
	Capabilities: [148 v1] Device Serial Number xx-xx-xx-xx-xx-xx-xx-xx
	Capabilities: [154 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [18c v1] #19
	Kernel modules: mlx4_core
