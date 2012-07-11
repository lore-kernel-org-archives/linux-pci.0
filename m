Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gw1.transmode.se ([195.58.98.146]:62914 "EHLO gw1.transmode.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753199Ab2GKBHT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 10 Jul 2012 21:07:19 -0400
In-Reply-To: <CAE9FiQXMaPBc7o0KhSBAoAHRP=+1aqemvUBZjJd3bANXoFtqyA@mail.gmail.com>
References: <OF15EE971A.73D0AED3-ONC1257A37.005D93BD-C1257A37.00601BF9@transmode.se>	<CAE9FiQV3-x64CbkPGVDNLzDkiuteQyvxpU56U_paVbyXavifmQ@mail.gmail.com>
	<OF9D2FB397.4951E6E4-ONC1257A37.0076FA3B-C1257A37.0077405A@transmode.se> <CAE9FiQXMaPBc7o0KhSBAoAHRP=+1aqemvUBZjJd3bANXoFtqyA@mail.gmail.com>
Subject: Re: PICe hotplug problems
To: Yinghai Lu <yinghai@kernel.org>
Cc: linux-pci@vger.kernel.org, yhlu.kernel@gmail.com
Message-ID: <OF9DA7C6E4.12BE1316-ONC1257A38.000618C1-C1257A38.00062838@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Wed, 11 Jul 2012 03:07:15 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

yhlu.kernel@gmail.com wrote on 2012/07/11 00:09:00:
>
> On Tue, Jul 10, 2012 at 2:42 PM, Joakim Tjernlund
> <joakim.tjernlund@transmode.se> wrote:
> > yhlu.kernel@gmail.com wrote on 2012/07/10 20:22:09:
> >
> >>
> >> On Tue, Jul 10, 2012 at 10:29 AM, Joakim Tjernlund
> >> <joakim.tjernlund@transmode.se> wrote:
> >> >
> >> > I got an PCIe device that is woken up by user space, clocks needs to configured in various ways before the
> >> > device enables its PCIe interface.
> >> >
> >> > The device is connected to a built in root bridge on a P2010(mpc85xx) CPU.
> >> > To enable HP in Linux we need to apply some minor hacks.
> >>
> >> can you post lspci -vvxxx -s BB:DD:F of the two devices?
> >
> > Not really, this is an embedded device with limited SW. I got
> > busybox and its lspci but that is very limited:
> > # > ./busybox lspci -mk
> > 00:00.0 "Class 0604" "1957" "0079" "0000" "0000" "pcieport"
> > 01:00.0 "Class 0200" "14e4" "b540" "14e4" "b540"
> >
> > Does that tell you anything?
>
> No. Can you compile lspci util as static and run it ?

That wasn't so hard so here:

root@P2020RDB ~ # ./lspci  -vvxxx
00:00.0 Class 0604: Device 1957:0079 (rev 21)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Region 0: Memory at <ignored> (32-bit, non-prefetchable)
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00000000-00000fff
	Memory behind bridge: 80000000-9fffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [4c] Express (v1) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x4, ASPM L0s, Latency L0 <2us, L1 unlimited
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 128 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x2, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Kernel driver in use: pcieport
00: 57 19 79 00 06 01 10 00 21 00 20 0b 08 00 01 00
10: 00 00 f0 ff 00 00 00 00 00 01 01 00 00 00 00 00
20: 00 80 f0 9f f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 44 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 01 4c 02 fe 00 00 00 00 10 00 41 00
50: 01 00 00 00 1f 28 00 00 41 d4 03 00 08 00 21 00
60: c0 07 00 00 c8 03 40 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:00.0 Class 0200: Device 14e4:b540 (rev 02)
	Subsystem: Device 14e4:b540
	Physical Slot: 0
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at 80000000 (64-bit, non-prefetchable) [size=256K]
	Capabilities: [48] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
pcilib: sysfs_read_vpd: read failed: Connection timed out
		Not readable
	Capabilities: [58] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [ac] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 5GT/s, Width x2, ASPM L0s L1, Latency L0 <4us, L1 <4us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x2, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v1] Device Serial Number 00-00-00-00-00-00-00-00
	Capabilities: [110 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
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
00: e4 14 40 b5 06 00 10 00 02 00 00 02 08 00 00 00
10: 04 00 00 80 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 e4 14 40 b5
30: 00 00 00 00 48 00 00 00 00 00 00 00 00 01 00 00
40: 00 00 00 00 00 00 00 00 01 50 03 c8 08 20 00 00
50: 03 58 00 00 00 00 00 00 05 ac 80 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 11 00 00 00 00 00 00 00 00 00 00 00 10 00 02 00
b0: 02 80 3c 00 10 2c 10 00 22 6c 01 00 00 00 21 10
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 1f 00 00 00 00 00 00 00 00 00 00 00 01 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

