Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:59983 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751590Ab2FHNnK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 8 Jun 2012 09:43:10 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glp-linux-pci@m.gmane.org>)
	id 1SczT0-0004Fn-J5
	for linux-pci@vger.kernel.org; Fri, 08 Jun 2012 15:43:06 +0200
Received: from c-24-62-77-150.hsd1.nh.comcast.net ([24.62.77.150])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Fri, 08 Jun 2012 15:43:06 +0200
Received: from tkcarr03873 by c-24-62-77-150.hsd1.nh.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Fri, 08 Jun 2012 15:43:06 +0200
To: linux-pci@vger.kernel.org
From: Tom Carr <tkcarr03873@gmail.com>
Subject: Re: PCIe rescan not working
Date: Fri, 8 Jun 2012 13:42:53 +0000 (UTC)
Message-ID: <loom.20120608T141401-887@post.gmane.org>
References: <loom.20120607T194858-986@post.gmane.org> <CAE9FiQWau+ko4JiEEjM=2xSH_7FPBr_ZYOm8YGpin2p97=12PQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Yinghai Lu <yinghai <at> kernel.org> writes:

> 
> On Thu, Jun 7, 2012 at 12:16 PM, Tom Carr <tkcarr03873 <at> gmail.com> wrote:
> >  I wanted to follow up on comment 12836 which was answered by Yinghai Lu 
> >with a
> > patch that appears to deal with a PCIe rescan issue when there is a switch
> > behind a bridge. I am seeing the same failure on the 2 version mentioned in
> > the
> > subject. The 3.2 version also has the patch referenced by Yinghai Lu in 
> >comment
> > 12836. Our setup is as follows
> >
> >   -----------------    -------------------     -------------------
> >   |Intel processor| -> | IDT 6 port switch| -> | unpopulated FPGA |
> >   | PCIe root     |    |                  |    |                  |
> >   -----------------    -------------------     -------------------
> >
> >  The processor is an i7-2600. I am not 100% certain of the model of the 
> >switch
> > but I believe it is an IDT PES32NT8BG2 switch being used in P2P mode. The
> > design
> > of the project requires that after the system is booted a bitstream with a 
> >PCIe
> > endpoint will be loaded into the FPGA and rescan will be run to bring the
> > endpoint on line. In the drawing above, the switch and FPGA are on a board 
> >that
> > is plugged into a 4x PCIe connector on the motherboard. The driver being 
> >used
> > for the switch is the pcieport in conjunction with the shpchp module. I am
> > forcing the rescan by using "echo 1 > /sys/bus/pci/rescan".
> >
> >  From the debug message and kernel messages it appears that the rescan takes
> > place with the endpoint being found and added. The probe function for both 
> >the
> > pcieport driver and customer driver are called. You can see the endpoint 
> >using
> > lspci but there was no memory assigned to the bars of the new endpoint. The
> > kernel messages show that both the switch port and the endpoint failed to 
> >have
> > memory assigned. As the messages below show
> >
> > Jun  4 14:04:02 bdsazi1 kernel: [  177.562151] i915 0000:00:02.0: BAR 6: 
> >[???
> > 0x00000000 flags 0x2] has bogus alignment
> > Jun  4 14:04:02 bdsazi1 kernel: [  177.562161] pcieport 0000:04:08.0: BAR 14
> > can't assign mem (size 0x100000)
> > Jun  4 14:04:02 bdsazi1 kernel: [  177.562166] pci 0000:08:00.0: BAR 0: 
> >can't
> > assign mem (size 0x10000)
> > Jun  4 14:04:02 bdsazi1 kernel: [  177.562168] pci 0000:08:00.0: BAR 2: 
> >can't
> > assign mem (size 0x4000)
> > Jun  4 14:04:02 bdsazi1 kernel: [  177.562171] pci 0000:08:00.0: BAR 1: 
> >can't
> > assign mem (size 0x2000)
> > Jun  4 14:04:02 bdsazi1 kernel: [  177.562240] BDS_FPGA_PROBE pdev =
> > 0xffff880214963000 bus=0x8 devfn=0x0 vend = 0x19aa parent = 0x4
> > Jun  4 14:04:02 bdsazi1 kernel: [  177.562260] bds_pcie 0000:08:00.0: PCI 
> >INT A
> > -> GSI 18 (level, low) -> IRQ 18
> > Jun  4 14:04:02 bdsazi1 kernel: [  177.562279] BDS_FPGA Dev 1 0x00000000
> > 0x00000000 0x00000000 2 0x00000000 0x00000000 0x00000000 3 0x00000000 
> >0x00000000
> > 0x00000000
> > Jun  4 14:04:02 bdsazi1 kernel: [  177.562282] BDS_FPGA enable MSI pin irq
> > 18
> > Jun  4 14:04:02 bdsazi1 kernel: [  177.562357] BDS_FPGA enable MSI msi irq
> > 59
> >
> >
> >  The FPGA is attached to the port at bfn 4.8.0 which has a secondary bus of
> > 8.
> > If we remove the board and replace it with a board with just and FPGA and no
> > switch, the rescan works fine and the endpoint is operational. If we load 
> > the
> > FPGA and then boot the board everything if fine. The problem is definitely
> > with
> > the switch being present with nothing behind it at boot time. There is
> > nothing I
> > can find in docs or the code to give a hint as to why memory is not being
> > assigned to the switch port which is why the endpoint is not getting 
> > memory. I
> > have added lots of debug to try to figure out the exact reason why the 
> > failure
> > is occuring but I have not found it yet. The failure appears to be coming 
> >from a
> > call to allocate_resource in kernel/resource.c but I am still working on 
> >proving
> > that. The discussion in 12836 sounded very similar to this problem and I 
> >thought
> > the patch to 3.2 would solve the problem but it did not.
> >
> >  The lspci output for the port follows
> >
> > 04:08.0 PCI bridge: Integrated Device Technology, Inc. Device 8091 (rev 02)
> > (prog-if 00 [Normal decode])
> >        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> >                ParErr- Stepping- SERR- FastB2B- DisINTx+
> >        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
> ><TAbort-
> >                <MAbort- >SERR- <PERR- INTx-
> >        Latency: 0, Cache Line Size: 64 bytes
> >        Bus: primary=04, secondary=08, subordinate=08, sec-latency=0
> >        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
>> <TAbort-
> >                <MAbort- <SERR- <PERR-
> >        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
> >                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> >        Capabilities: [40] Express (v2) Downstream Port (Slot-), MSI 00
> >                DevCap: MaxPayload 2048 bytes, PhantFunc 0, Latency L0s 
> ><64ns,
> >                        L1 <1us
> >                        ExtTag+ RBE+ FLReset-
> >                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
> >                        Unsupported-
> >                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> >                        MaxPayload 128 bytes, MaxReadReq 128 bytes
> >                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr-
> >                        TransPend-
> >                LnkCap: Port #0, Speed 5GT/s, Width x4, ASPM L0s L1, Latency
> > L0
> >                        <4us, L1 <4us
> >                        ClockPM- Surprise+ LLActRep+ BwNot+
> >                LnkCtl: ASPM Disabled; Disabled- Retrain- CommClk-
> >                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> >                LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+
> >                        DLActive- BWMgmt- ABWMgmt-
> >                DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
> >ARIFwd+
> >                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- 
> >ARIFwd-
> >                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- 
> >SpeedDis-,
> >                         Selectable
> >                         De-emphasis: -6dB
> >                         Transmit Margin: Normal Operating Range,
> >                         EnterModifiedCompliance- ComplianceSOS-
> >                         Compliance De-emphasis: -6dB
> >                LnkSta2: Current De-emphasis Level: -6dB
> >        Capabilities: [c0] Power Management version 3
> >                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> >                       PME(D0+,D1-,D2-,D3hot+,D3cold+)
> >                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> >        Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
> >                Address: 00000000feeff00c  Data: 4199
> >        Capabilities: [100 v2] Advanced Error Reporting
> >                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> >                        RxOF- MalfTLP- ECRC-
> >                        UnsupReq- ACSViol-
> >                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> >                        RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> >                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
> >                        RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
> >                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
> >NonFatalErr+
> >                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
> >NonFatalErr+
> >                AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ 
> >ChkEn-
> >        Capabilities: [200 v1] Virtual Channel
> >                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
> >                Arb:    Fixed- WRR32- WRR64- WRR128-
> >                Ctrl:   ArbSelect=Fixed
> >                Status: InProgress-
> >                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
> >                        Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
> >                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
> >                        Status: NegoPending- InProgress-
> >        Capabilities: [320 v1] Access Control Services
> >                ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ 
> >UpstreamFwd+
> >                        EgressCtrl+ DirectTrans+
> >                ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- 
> >UpstreamFwd-
> >                        EgressCtrl- DirectTrans-
> >        Capabilities: [330 v1] #12
> >        Kernel driver in use: pcieport
> >        Kernel modules: shpchp
> >
> >
> >  I am sure I am not supply some piece of information that is important so
> > let me
> > know what else you need and I will provide it.
> 
> should be bridge that 04:08.0 is on, does not have big enough range
> after it is booted up.
> 
> current pciehp will resize bridge if the bridge resource is not big enough.
> 
> please post whole boot log with "debug" and compile the kernel with
> pci debug enabled.
> CONFIG_PCI_DEBUG=y
> 
> also please post
> lspci -vvxxx
> lspci -tv
> 
> Thanks
> 
> Yinghai
> 

-[0000:00]-+-00.0  Intel Corporation Sandy Bridge DRAM Controller
           +-01.0-[01]--
           +-01.1-[02]--
           +-01.2-[03-09]----00.0-[04-09]--+-02.0-[05]--
           |                               +-04.0-[06]----00.0  Xilinx
Corporation Device e004
           |                               +-06.0-[07]--
           |                               +-08.0-[08]--
           |                               \-0c.0-[09]----00.0  Device 19aa:e004
           +-02.0  Intel Corporation Sandy Bridge Integrated Graphics Controller
           +-06.0-[0a]--
           +-16.0  Intel Corporation Cougar Point HECI Controller #1
           +-16.2  Intel Corporation Cougar Point IDE-r Controller
           +-16.3  Intel Corporation Cougar Point KT Controller
           +-19.0  Intel Corporation 82579LM Gigabit Network Connection
           +-1a.0  Intel Corporation Cougar Point USB Enhanced Host Controller
 #2
           +-1b.0  Intel Corporation Cougar Point High Definition Audio 
Controller
           +-1c.0-[0b]--
           +-1c.4-[0c]----00.0  Intel Corporation 82574L Gigabit Network 
Connection
           +-1d.0  Intel Corporation Cougar Point USB Enhanced Host Controller
 #1
           +-1e.0-[0d]--
           +-1f.0  Intel Corporation Cougar Point LPC Controller
           +-1f.2  Intel Corporation Cougar Point 4 port SATA IDE Controller
           +-1f.3  Intel Corporation Cougar Point SMBus Controller
           \-1f.5  Intel Corporation Cougar Point 2 port SATA IDE Controller


00:00.0 Host bridge: Intel Corporation Sandy Bridge DRAM Controller (rev 09)
	Subsystem: Intel Corporation Sandy Bridge DRAM Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
        Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
         <MAbort+ >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information: Len=0c <?>
	Kernel driver in use: agpgart-intel
	Kernel modules: intel-agp
00: 86 80 00 01 06 00 90 20 09 00 00 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 00 01
30: 00 00 00 00 e0 00 00 00 00 00 00 00 00 00 00 00
40: 01 90 d1 fe 00 00 00 00 01 00 d1 fe 00 00 00 00
50: 11 02 00 00 1f 20 00 00 00 00 00 00 01 00 00 cb
60: 01 00 00 e0 00 00 00 00 01 80 d1 fe 00 00 00 00
70: 00 00 00 fe 01 00 00 00 00 0c 00 fe 7f 00 00 00
80: 10 11 11 00 00 00 11 00 1a 00 00 00 00 00 00 00
90: 01 00 00 fe 01 00 00 00 01 00 50 2e 02 00 00 00
a0: 01 00 00 00 02 00 00 00 01 00 60 2e 02 00 00 00
b0: 01 00 a0 cb 01 00 80 cb 01 00 00 cb 01 00 a0 cf
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 09 00 0c 01 96 a0 00 02 90 00 00 16 00 00 00 00
f0: 00 00 00 00 00 00 00 00 b8 0f 06 00 00 00 00 00

00:01.0 PCI bridge: Intel Corporation Sandy Bridge PCI Express Root Port (rev
09) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
        Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
         <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
        <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [88] Subsystem: Intel Corporation Sandy Bridge PCI 
 Express Root Port
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
                       PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: feeff00c  Data: 4151
	Capabilities: [a0] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, 
                        L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- 
                        Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- 
                        TransPend-
		LnkCap:	Port #2, Speed 5GT/s, Width x8, ASPM L0s L1, Latency 
                        L0 <1us, L1 <4us
			ClockPM- Surprise- LLActRep- BwNot+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ 
                        DLActive- BWMgmt- ABWMgmt-  
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- 
                        Surprise-
			Slot #0, PowerLimit 0.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
                        LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- 
                        Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- 
                        Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
                         CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, 
                         Selectable
                         De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, 
                         EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Capabilities: [140 v1] Root Complex Link
		Desc:	PortNumber=02 ComponentID=01 EltType=Config
		Link0:	Desc:	TargetPort=00 TargetComponent=01 AssocRCRB- 
                        LinkType=MemMapped LinkValid+
			Addr:	00000000fed19000
	Kernel driver in use: pcieport
	Kernel modules: shpchp
00: 86 80 01 01 07 04 10 00 09 00 04 06 10 00 81 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 f0 00 00 00
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 88 00 00 00 00 00 00 00 0b 01 10 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0a
80: 01 90 03 c8 08 00 00 00 0d 80 00 00 86 80 01 01
90: 05 a0 01 00 0c f0 ef fe 51 41 00 00 00 00 00 00
a0: 10 00 42 01 00 80 00 00 00 00 00 00 82 4c 21 02
b0: 00 00 01 10 00 00 04 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 08 00 00 00 00 00 00 00 00 00 00
d0: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 01 00 00 00 00 00 00 00 10 00

00:01.1 PCI bridge: Intel Corporation Sandy Bridge PCI Express Root Port (rev
09) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
                 Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
                <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
                <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [88] Subsystem: Intel Corporation Sandy Bridge PCI 
                       Express Root Port
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
                       PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: feeff00c  Data: 4159
	Capabilities: [a0] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, 
                        L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- 
                        Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- 
                        TransPend-
		LnkCap:	Port #3, Speed 5GT/s, Width x4, ASPM L0s L1, Latency L0
                        <1us, L1 <4us
			ClockPM- Surprise- LLActRep- BwNot+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ 
                        DLActive- BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- 
                        Surprise-
			Slot #0, PowerLimit 0.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
                        LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- 
                        Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- 
                        Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
                         CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, 
                         Selectable
                         De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, 
                         EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Capabilities: [140 v1] Root Complex Link
		Desc:	PortNumber=03 ComponentID=01 EltType=Config
		Link0:	Desc:	TargetPort=00 TargetComponent=01 AssocRCRB- 
                        LinkType=MemMapped
                        LinkValid+
			Addr:	00000000fed19000
	Kernel driver in use: pcieport
	Kernel modules: shpchp
00: 86 80 05 01 07 04 10 00 09 00 04 06 10 00 81 00
10: 00 00 00 00 00 00 00 00 00 02 02 00 f0 00 00 00
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 88 00 00 00 00 00 00 00 0b 01 10 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0a
80: 01 90 03 c8 08 00 00 00 0d 80 00 00 86 80 05 01
90: 05 a0 01 00 0c f0 ef fe 59 41 00 00 00 00 00 00
a0: 10 00 42 01 00 80 00 00 00 00 00 00 42 4c 21 03
b0: 00 00 01 10 00 00 04 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 08 00 00 00 00 00 00 00 00 00 00
d0: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 01 00 00 00 00 00 00 00 10 00

00:01.2 PCI bridge: Intel Corporation Sandy Bridge PCI Express Root Port (rev
09) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
                 Stepping-
                 SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
                <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=03, subordinate=09, sec-latency=0
	Memory behind bridge: fe400000-fe5fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
                          <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [88] Subsystem: Intel Corporation Sandy Bridge PCI 
Express Root Port
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
                       PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: feeff00c  Data: 4161
	Capabilities: [a0] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, 
                        L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- 
                        Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- 
                        TransPend-
		LnkCap:	Port #4, Speed 5GT/s, Width x4, ASPM L0s L1, 
                        Latency L0 <256ns, L1 <4us
			ClockPM- Surprise- LLActRep- BwNot+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive- 
                        BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- 
                        Surprise-
			Slot #0, PowerLimit 0.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
                        LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- 
                        Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
                        Interlock-
			Changed: MRL- PresDet+ LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
                         CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,
                         Selectable
                         De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, 
                         EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Capabilities: [140 v1] Root Complex Link
		Desc:	PortNumber=04 ComponentID=01 EltType=Config
		Link0:	Desc:	TargetPort=00 TargetComponent=01 AssocRCRB- 
                                LinkType=MemMapped
                                LinkValid+
			Addr:	00000000fed19000
	Kernel driver in use: pcieport
	Kernel modules: shpchp
00: 86 80 09 01 07 04 10 00 09 00 04 06 10 00 81 00
10: 00 00 00 00 00 00 00 00 00 03 09 00 f0 00 00 20
20: 40 fe 50 fe f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 88 00 00 00 00 00 00 00 0b 01 10 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0a
80: 01 90 03 c8 08 00 00 00 0d 80 00 00 86 80 09 01
90: 05 a0 01 00 0c f0 ef fe 61 41 00 00 00 00 00 00
a0: 10 00 42 01 00 80 00 00 00 00 00 00 42 2c 21 04
b0: 40 00 42 50 00 00 04 00 00 00 48 00 00 00 00 00
c0: 00 00 00 00 00 08 00 00 00 00 00 00 00 00 00 00
d0: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 01 00 00 00 00 00 00 00 10 00

00:02.0 VGA compatible controller: Intel Corporation Sandy Bridge Integrated
Graphics Controller (rev 09) (prog-if 00 [VGA controller])
	Subsystem: Intel Corporation Sandy Bridge Integrated Graphics Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
                 Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
                <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 56
	Region 0: Memory at fe000000 (64-bit, non-prefetchable) [size=4M]
	Region 2: Memory at d0000000 (64-bit, prefetchable) [size=256M]
	Region 4: I/O ports at f000 [size=64]
	Expansion ROM at <unassigned> [disabled]
	Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: feeff00c  Data: 4122
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
                       PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [a4] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: i915
	Kernel modules: i915
00: 86 80 02 01 07 04 90 00 09 00 00 03 00 00 00 00
10: 04 00 00 fe 00 00 00 00 0c 00 00 d0 00 00 00 00
20: 01 f0 00 00 00 00 00 00 00 00 00 00 86 80 02 01
30: 00 00 00 00 90 00 00 00 00 00 00 00 0b 01 00 00
40: 09 00 0c 01 96 a0 00 02 90 00 00 16 00 00 00 00
50: 11 02 00 00 1f 20 00 00 00 00 00 00 01 00 a0 cb
60: 00 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 05 d0 01 00 0c f0 ef fe 22 41 00 00 00 00 00 00
a0: 00 00 00 00 13 00 06 03 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 01 a4 22 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 80 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 06 00 18 80 e0 ca

00:06.0 PCI bridge: Intel Corporation Sandy Bridge PCI Express Root Port (rev
09) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
                 Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
                <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=0a, subordinate=0a, sec-latency=0
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
                 <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [88] Subsystem: Intel Corporation Sandy Bridge PCI 
 Express Root Port
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
                       PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: feeff00c  Data: 4169
	Capabilities: [a0] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns,
                        L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- 
                        Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- 
                        TransPend-
		LnkCap:	Port #5, Speed 5GT/s, Width x4, ASPM L0s L1, Latency L0
                        <1us, L1 <4us
			ClockPM- Surprise- LLActRep- BwNot+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ 
                        DLActive- BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- 
                        Surprise-
			Slot #0, PowerLimit 0.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
                        LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- 
                        Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- 
                        Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
                         CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, 
                         Selectable 
                         De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, 
                         EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Capabilities: [140 v1] Root Complex Link
		Desc:	PortNumber=05 ComponentID=01 EltType=Config
		Link0:	Desc:	TargetPort=00 TargetComponent=01 AssocRCRB- 
                                LinkType=MemMapped LinkValid+
			Addr:	00000000fed19000
	Kernel driver in use: pcieport
	Kernel modules: shpchp
00: 86 80 0d 01 07 04 10 00 09 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 00 0a 0a 00 f0 00 00 00
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 88 00 00 00 00 00 00 00 0b 01 10 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0a
80: 01 90 03 c8 08 00 00 00 0d 80 00 00 86 80 0d 01
90: 05 a0 01 00 0c f0 ef fe 69 41 00 00 00 00 00 00
a0: 10 00 42 01 00 80 00 00 00 00 00 00 42 4c 21 05
b0: 00 00 01 10 00 00 04 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 08 00 00 00 00 00 00 00 00 00 00
d0: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 01 00 00 00 00 00 00 00 10 00

00:16.0 Communication controller: Intel Corporation Cougar Point HECI 
Controller #1 (rev 04)
	Subsystem: Intel Corporation Cougar Point HECI Controller #1
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
                 ParErr- Stepping SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
                <MAbort- >SERR- <PERR- INTx+
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at fe729000 (64-bit, non-prefetchable) [size=16]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
                       PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [8c] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
00: 86 80 3a 1c 06 00 18 00 04 00 80 07 00 00 80 00
10: 04 90 72 fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 3a 1c
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 00 00
40: 55 02 00 1e 20 00 01 80 06 00 00 69 e0 1f 00 10
50: 01 8c 03 c8 08 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 05 00 80 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 02 00 00 c0
c0: 87 ed ad 08 31 83 1a d5 a1 53 a9 26 37 f4 d1 71
d0: e6 52 f2 a0 90 2d f1 01 b5 95 8b 37 a0 8b 2c cd
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:16.2 IDE interface: Intel Corporation Cougar Point IDE-r Controller (rev 04)
(prog-if 85 [Master SecO PriO])
	Subsystem: Intel Corporation Cougar Point IDE-r Controller
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
                 Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
                     <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin C routed to IRQ 18
	Region 0: I/O ports at f190 [size=8]
	Region 1: I/O ports at f180 [size=4]
	Region 2: I/O ports at f170 [size=8]
	Region 3: I/O ports at f160 [size=4]
	Region 4: I/O ports at f150 [size=16]
	Capabilities: [c8] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
                       PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
00: 86 80 3c 1c 01 00 b0 00 04 85 01 01 00 00 00 00
10: 91 f1 00 00 81 f1 00 00 71 f1 00 00 61 f1 00 00
20: 51 f1 00 00 00 00 00 00 00 00 00 00 86 80 3c 1c
30: 00 00 00 00 c8 00 00 00 00 00 00 00 0a 03 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 01 d0 23 00 08 00 00 00
d0: 05 00 80 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:16.3 Serial controller: Intel Corporation Cougar Point KT Controller (rev 04)
(prog-if 02 [16550])
	Subsystem: Intel Corporation Cougar Point KT Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
                 Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbo
                <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 17
	Region 0: I/O ports at f140 [size=8]
	Region 1: Memory at fe728000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [c8] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
                       PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Kernel driver in use: serial
00: 86 80 3d 1c 07 00 b0 00 04 02 00 07 00 00 00 00
10: 41 f1 00 00 00 80 72 fe 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 3d 1c
30: 00 00 00 00 c8 00 00 00 00 00 00 00 07 02 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 01 d0 23 00 08 00 00 00
d0: 05 00 80 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:19.0 Ethernet controller: Intel Corporation 82579LM Gigabit Network
Connection (rev 05)
	Subsystem: Intel Corporation Device 0000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
                 Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
                <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 51
	Region 0: Memory at fe700000 (32-bit, non-prefetchable) [size=128K]
	Region 1: Memory at fe727000 (32-bit, non-prefetchable) [size=4K]
	Region 2: I/O ports at f060 [size=32]
	Capabilities: [c8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
                       PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee1000c  Data: 4142
	Capabilities: [e0] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: e1000e
	Kernel modules: e1000e
00: 86 80 02 15 07 04 10 00 05 00 00 02 00 00 00 00
10: 00 00 70 fe 00 70 72 fe 61 f0 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 00 00
30: 00 00 00 00 c8 00 00 00 00 00 00 00 0a 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 01 d0 22 c8 00 20 00 07
d0: 05 e0 81 00 0c 00 e1 fe 00 00 00 00 42 41 00 00
e0: 13 00 06 03 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:1a.0 USB Controller: Intel Corporation Cougar Point USB Enhanced Host
Controller #2 (rev 05) (prog-if 20 [EHCI])
	Subsystem: Intel Corporation Cougar Point USB Enhanced Host Controller
#2
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
                 Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
                <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at fe726000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
                       PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port: BAR=1 offset=00a0
	Capabilities: [98] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: ehci_hcd
00: 86 80 2d 1c 06 00 90 02 05 20 03 0c 00 00 00 00
10: 00 60 72 fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 2d 1c
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 58 c2 c9 00 00 00 00 0a 98 a0 20 00 00 00 00
60: 20 20 ff 07 00 00 00 00 01 00 00 01 00 00 08 00
70: 00 00 df 3f 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 80 00 11 88 0c 93 30 0d 00 24 00 00 00 00
90: 00 00 00 00 00 00 00 00 13 00 06 03 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 aa ff 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 04 40 80 17
f0: 00 00 00 00 88 85 80 00 87 0f 06 08 e8 17 5b 20

00:1b.0 Audio device: Intel Corporation Cougar Point High Definition Audio
Controller (rev 05)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
                 Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
                <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 55
	Region 0: Memory at fe720000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA 
                       PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee4400c  Data: 41e9
	Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns,
                        L1 <1us
			ExtTag- RBE- FLReset+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- 
                        Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
 		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
                        TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency
                        L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- 
                        DLActive- BWMgmt- ABWMgmt-
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
			Status:	NegoPending- InProgress-
		VC1:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=2 ArbSelect=Fixed TC/VC=44
			Status:	NegoPending- InProgress-
	Capabilities: [130 v1] Root Complex Link
		Desc:	PortNumber=0f ComponentID=00 EltType=Config
		Link0:	Desc:	TargetPort=00 TargetComponent=00 AssocRCRB- 
                        LinkType=MemMapped LinkValid+
			Addr:	00000000fed1c000
	Kernel driver in use: HDA Intel
	Kernel modules: snd-hda-intel
00: 86 80 20 1c 06 04 10 00 05 00 03 04 10 00 00 00
10: 04 00 72 fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 07 01 00 00
40: 01 00 00 05 00 00 00 00 00 00 00 00 00 80 00 00
50: 01 60 42 c8 00 00 00 00 00 00 00 00 00 00 00 00
60: 05 70 81 00 0c 40 e4 fe 00 00 00 00 e9 41 00 00
70: 10 00 91 00 00 00 00 10 00 00 10 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 04 00 01 00 24 00 40 00 0c a3 82 10 00 33 02
d0: 00 0c a3 02 10 00 33 02 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 87 0f 06 08 00 00 00 00

00:1c.0 PCI bridge: Intel Corporation Cougar Point PCI Express Root Port 1 (rev
b5) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
                 Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
                <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=0b, subordinate=0b, sec-latency=0
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
                          <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, 
                        L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- 
                        Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
                        TransPend-
		LnkCap:	Port #1, Speed 5GT/s, Width x4, ASPM L0s L1, Latency L0
                        <1us, L1 <4us
			ClockPM- Surprise- LLActRep+ BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ 
                        DLActive- BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- 
                        Surprise-
			Slot #0, PowerLimit 25.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- 
                        LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- 
                        Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- 
                        Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
                        CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- 
                         SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range,
                         EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: feeff00c  Data: 4171
	Capabilities: [90] Subsystem: Intel Corporation Cougar Point PCI 
                      Express Root Port 1
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
                       PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: pcieport
	Kernel modules: shpchp
00: 86 80 10 1c 07 04 10 00 b5 00 04 06 10 00 81 00
10: 00 00 00 00 00 00 00 00 00 0b 0b 00 f0 00 00 20
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 07 01 10 00
40: 10 80 42 01 00 80 00 00 00 00 10 00 42 4c 11 01
50: 00 00 01 10 00 fd 04 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 16 00 00 00 00 00 00 00 00 00 00 00
70: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 05 90 01 00 0c f0 ef fe 71 41 00 00 00 00 00 00
90: 0d a0 00 00 86 80 10 1c 00 00 00 00 00 00 00 00
a0: 01 00 02 c8 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 01 00 0b 00 00 00 80 11 01 00 00 00 00
e0: 00 3f 00 00 00 00 00 00 03 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 87 0f 06 08 00 00 00 00

00:1c.4 PCI bridge: Intel Corporation Cougar Point PCI Express Root Port 5 
(revb5) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
                 Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort
                <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=0c, subordinate=0c, sec-latency=0
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: fe600000-fe6fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
                 <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, 
                        L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable+ Non-Fatal+ Fatal+ 
                        Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
                        TransPend-
		LnkCap:	Port #5, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0
                        <512ns, L1 <4us
			ClockPM- Surprise- LLActRep+ BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
                        DLActive+ BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- 
                        Surprise-
			Slot #4, PowerLimit 10.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
                        LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- 
                        Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
                        Interlock-
			Changed: MRL- PresDet- LinkState+
		RootCtl: ErrCorrectable+ ErrNon-Fatal+ ErrFatal+ PMEIntEna- 
                        CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- 
                         SpeedDis-, Selectable
                         De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, 
                         EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: feeff00c  Data: 4179
	Capabilities: [90] Subsystem: Intel Corporation Cougar Point PCI 
Express Root Port 5
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
                       PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: pcieport
	Kernel modules: shpchp
00: 86 80 18 1c 07 04 10 00 b5 00 04 06 10 00 81 00
10: 00 00 00 00 00 00 00 00 00 0c 0c 00 e0 e0 00 00
20: 60 fe 60 fe f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 07 01 10 00
40: 10 80 42 01 00 80 00 00 07 00 10 00 12 3c 11 05
50: 40 00 11 70 00 b2 24 00 00 00 40 01 07 00 00 00
60: 00 00 00 00 16 00 00 00 00 00 00 00 00 00 00 00
70: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 05 90 01 00 0c f0 ef fe 79 41 00 00 00 00 00 00
90: 0d a0 00 00 86 80 18 1c 00 00 00 00 00 00 00 00
a0: 01 00 02 c8 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 01 00 0b 00 00 00 80 11 01 00 00 00 00
e0: 00 3f 00 00 00 00 00 00 03 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 87 0f 06 08 00 00 00 00

00:1d.0 USB Controller: Intel Corporation Cougar Point USB Enhanced Host
Controller #1 (rev 05) (prog-if 20 [EHCI])
	Subsystem: Intel Corporation Cougar Point USB Enhanced Host Controller 
#1
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
                 Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
                <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 23
	Region 0: Memory at fe725000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
                       PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port: BAR=1 offset=00a0
	Capabilities: [98] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: ehci_hcd
00: 86 80 26 1c 06 00 90 02 05 20 03 0c 00 00 00 00
10: 00 50 72 fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 26 1c
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 58 c2 c9 00 00 00 00 0a 98 a0 20 00 00 00 00
60: 20 20 ff 07 00 00 00 00 01 00 00 01 00 00 08 00
70: 00 00 df 3f 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 80 00 11 88 0c 93 30 0d 00 24 00 00 00 00
90: 00 00 00 00 00 00 00 00 13 00 06 03 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 aa ff 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 04 70 80 17
f0: 00 00 00 00 88 85 80 00 87 0f 06 08 e8 17 5b 20

00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev a5) (prog-if 01
[Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
                 Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
                <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Bus: primary=00, secondary=0d, subordinate=0d, sec-latency=32
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
                          <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [50] Subsystem: Intel Corporation 82801 PCI Bridge
00: 86 80 4e 24 07 00 10 00 a5 01 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 0d 0d 20 f0 00 80 22
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 00 10 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 12 00 10
50: 0d 00 00 00 86 80 4e 24 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 87 0f 06 08 00 00 00 00

00:1f.0 ISA bridge: Intel Corporation Cougar Point LPC Controller (rev 05)
	Subsystem: Intel Corporation Cougar Point LPC Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
                 Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
                <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information: Len=0c <?>
	Kernel modules: iTCO_wdt
00: 86 80 56 1c 07 00 10 02 05 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 56 1c
30: 00 00 00 00 e0 00 00 00 00 00 00 00 00 00 00 00
40: 01 04 00 00 80 00 00 00 81 04 00 00 10 00 00 00
50: f8 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 8b 87 8a 8b d0 00 00 00 8a 80 87 8b f8 f0 00 00
70: 78 f0 79 f0 7a f0 7b f0 7c f0 7d f0 7e f0 7f f0
80: 10 00 0f 3f 01 0a 3c 00 91 02 0c 00 00 00 00 00
90: 00 00 00 00 00 0f 00 00 00 00 00 00 00 00 00 00
a0: 08 0a a0 00 48 19 06 00 00 47 00 00 00 03 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 33 22 11 00 67 45 00 00 c0 f8 00 00 00 00 00 00
e0: 09 00 0c 10 00 00 00 00 91 02 64 0c 00 00 00 00
f0: 01 c0 d1 fe 00 00 00 00 87 0f 06 08 00 00 00 00

00:1f.2 IDE interface: Intel Corporation Cougar Point 4 port SATA IDE 
Controller(rev 05) (prog-if 8a [Master SecP PriP])
	Subsystem: Intel Corporation Cougar Point 4 port SATA IDE Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
                 Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
                <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 19
	Region 0: I/O ports at 01f0 [size=8]
	Region 1: I/O ports at 03f4 [size=1]
	Region 2: I/O ports at 0170 [size=8]
	Region 3: I/O ports at 0374 [size=1]
	Region 4: I/O ports at f0f0 [size=16]
	Region 5: I/O ports at f0e0 [size=16]
	Capabilities: [70] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
                       PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [b0] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: ata_piix
00: 86 80 00 1c 07 00 b0 02 05 8a 01 01 00 00 00 00
10: 31 f1 00 00 21 f1 00 00 11 f1 00 00 01 f1 00 00
20: f1 f0 00 00 e1 f0 00 00 00 00 00 00 86 80 00 1c
30: 00 00 00 00 70 00 00 00 00 00 00 00 0b 02 00 00
40: 07 a3 00 80 00 00 00 00 01 00 01 00 00 00 00 00
50: 00 00 00 00 00 10 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 01 b0 03 00 08 00 00 00 00 00 00 00 00 00 00 00
80: 05 70 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 3e 01 81 83 01 00 3e 08 42 1c 01 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 13 00 06 03 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 05 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 87 0f 06 08 00 00 00 00

00:1f.3 SMBus: Intel Corporation Cougar Point SMBus Controller (rev 05)
	Subsystem: Intel Corporation Cougar Point SMBus Controller
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
                 Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
                <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin C routed to IRQ 10
	Region 0: Memory at fe724000 (64-bit, non-prefetchable) [size=256]
	Region 4: I/O ports at f040 [size=32]
	Kernel modules: i2c-i801
00: 86 80 22 1c 03 00 80 02 05 00 05 0c 00 00 00 00
10: 04 40 72 fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 41 f0 00 00 00 00 00 00 00 00 00 00 86 80 22 1c
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 03 00 00
40: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 03 04 04 00 00 00 08 08 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 87 0f 06 08 00 00 00 00

00:1f.5 IDE interface: Intel Corporation Cougar Point 2 port SATA IDE 
Controller (rev 05) (prog-if 85 [Master SecO PriO])
	Subsystem: Intel Corporation Cougar Point 2 port SATA IDE Controller
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
                 Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
                <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 19
	Region 0: I/O ports at f0d0 [size=8]
	Region 1: I/O ports at f0c0 [size=4]
	Region 2: I/O ports at f0b0 [size=8]
	Region 3: I/O ports at f0a0 [size=4]
	Region 4: I/O ports at f090 [size=16]
	Region 5: I/O ports at f080 [size=16]
	Capabilities: [70] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
                       PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [b0] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: ata_piix
00: 86 80 08 1c 05 00 b0 02 05 85 01 01 00 00 00 00
10: d1 f0 00 00 c1 f0 00 00 b1 f0 00 00 a1 f0 00 00
20: 91 f0 00 00 81 f0 00 00 00 00 00 00 86 80 08 1c
30: 00 00 00 00 70 00 00 00 00 00 00 00 0b 02 00 00
40: 00 80 00 80 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 01 b0 03 00 08 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 13 00 06 03 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 87 0f 06 08 00 00 00 00

03:00.0 PCI bridge: Integrated Device Technology, Inc. Device 8091 (rev 02)
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
                 Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
                <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=03, secondary=04, subordinate=09, sec-latency=0
	Memory behind bridge: fe400000-fe5fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
                          <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Upstream Port, MSI 00
		DevCap:	MaxPayload 2048 bytes, PhantFunc 0, Latency L0s <64ns,
                        L1 <1us
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                        SlotPowerLimit 0.000W
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- 
                        Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- 
                        TransPend-
		LnkCap:	Port #8, Speed 5GT/s, Width x4, ASPM L0s L1, Latency L0
                        <4us, L1 <4us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x4, TrErr- Train- SlotClk+ 
                        DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,
                         Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, 
                         EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB
	Capabilities: [c0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
                       PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
                        RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
                        RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
                        RxOF+ MalfTLP+
                        ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [200 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
			Status:	NegoPending- InProgress-
	Capabilities: [330 v1] #12
	Kernel driver in use: pcieport
	Kernel modules: shpchp
00: 1d 11 91 80 07 00 10 00 02 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 03 04 09 00 f1 01 00 00
20: 40 fe 50 fe f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 00 10 00
40: 10 c0 52 00 24 80 00 00 00 00 09 00 42 6c 01 08
50: 40 00 42 10 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 04 00 00 00 00 00 00 00 00 00 00
70: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 03 c8 08 00 00 00 00 00 00 00 00 00 00 00
d0: 05 00 80 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 0d 00 00 00 00 00 00 00 00 00 00 00 1d 11 91 80

04:02.0 PCI bridge: Integrated Device Technology, Inc. Device 8091 (rev 02)
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
                 Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
                <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=04, secondary=05, subordinate=05, sec-latency=0
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
                          <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Downstream Port (Slot-), MSI 00
		DevCap:	MaxPayload 2048 bytes, PhantFunc 0, Latency L0s <64ns,
                        L1 <1us
			ExtTag+ RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- 
                        Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- 
                        TransPend-
		LnkCap:	Port #2, Speed 5GT/s, Width x4, ASPM L0s L1, Latency 
                        L0 <4us, L1 <4us
			ClockPM- Surprise+ LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ 
                        DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, 
                         Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, 
                         EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB
	Capabilities: [c0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
                       PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000feeff00c  Data: 4181
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
                       RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
                       RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
                       RxOF+ MalfTLP+
                       ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [200 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Capabilities: [320 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+
                        EgressCtrl+ DirectTrans+
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd-
                        EgressCtrl- DirectTrans-
	Capabilities: [330 v1] #12
	Kernel driver in use: pcieport
	Kernel modules: shpchp
00: 1d 11 91 80 07 04 10 00 02 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 04 05 05 00 f1 01 00 00
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 00 10 00
40: 10 c0 62 00 24 80 00 00 00 00 09 00 42 6c 39 02
50: 00 00 01 10 00 00 00 00 00 00 40 00 00 00 00 00
60: 00 00 00 00 20 04 00 00 00 00 00 00 00 00 00 00
70: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 d0 03 c8 08 00 00 00 00 00 00 00 00 00 00 00
d0: 05 00 81 00 0c f0 ef fe 00 00 00 00 81 41 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 0d 00 00 00 00 00 00 00 00 00 00 00 1d 11 91 80

04:04.0 PCI bridge: Integrated Device Technology, Inc. Device 8091 (rev 02)
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
                 Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
                <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=04, secondary=06, subordinate=06, sec-latency=0
	Memory behind bridge: fe500000-fe5fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
                          <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Downstream Port (Slot-), MSI 00
		DevCap:	MaxPayload 2048 bytes, PhantFunc 0, Latency L0s <64ns,
                        L1 <1us
			ExtTag+ RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- 
                        Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- 
                        TransPend-
		LnkCap:	Port #4, Speed 5GT/s, Width x4, ASPM L0s L1, Latency 
                        L0 <4us, L1 <4us
			ClockPM- Surprise+ LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
                        DLActive+ BWMgmt+ ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,
                         Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, 
                         EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB
	Capabilities: [c0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
                       PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000feeff00c  Data: 4189
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
                       RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
                       RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
                       RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [200 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
			Status:	NegoPending- InProgress-
	Capabilities: [320 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ 
                        EgressCtrl+ DirectTrans+
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- 
                        EgressCtrl- DirectTrans-
	Capabilities: [330 v1] #12
	Kernel driver in use: pcieport
	Kernel modules: shpchp
00: 1d 11 91 80 07 04 10 00 02 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 04 06 06 00 f1 01 00 00
20: 50 fe 50 fe f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 00 10 00
40: 10 c0 62 00 24 80 00 00 00 00 09 00 42 6c 39 04
50: 40 00 11 70 00 00 00 00 00 00 40 00 00 00 00 00
60: 00 00 00 00 20 04 00 00 00 00 00 00 00 00 00 00
70: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 d0 03 c8 08 00 00 00 00 00 00 00 00 00 00 00
d0: 05 00 81 00 0c f0 ef fe 00 00 00 00 89 41 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 0d 00 00 00 00 00 00 00 00 00 00 00 1d 11 91 80

04:06.0 PCI bridge: Integrated Device Technology, Inc. Device 8091 (rev 02)
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
                 Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
                <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=04, secondary=07, subordinate=07, sec-latency=0
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
                          <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Downstream Port (Slot-), MSI 00
		DevCap:	MaxPayload 2048 bytes, PhantFunc 0, Latency L0s 
                        <64ns, L1 <1us
			ExtTag+ RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- 
                        Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- 
                        TransPend-
		LnkCap:	Port #6, Speed 5GT/s, Width x4, ASPM L0s L1, 
                        Latency L0 <4us, L1 <4us
			ClockPM- Surprise+ LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ 
                        DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, 
                         Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, 
                         EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB
	Capabilities: [c0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
                       PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000feeff00c  Data: 4191
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
                        RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
                        RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
                        RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [200 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Capabilities: [320 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ 
                        EgressCtrl+ DirectTrans+
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- 
                        EgressCtrl- DirectTrans-
	Capabilities: [330 v1] #12
	Kernel driver in use: pcieport
	Kernel modules: shpchp
00: 1d 11 91 80 07 04 10 00 02 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 04 07 07 00 f1 01 00 00
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 00 10 00
40: 10 c0 62 00 24 80 00 00 00 00 09 00 42 6c 39 06
50: 00 00 01 10 00 00 00 00 00 00 40 00 00 00 00 00
60: 00 00 00 00 20 04 00 00 00 00 00 00 00 00 00 00
70: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 d0 03 c8 08 00 00 00 00 00 00 00 00 00 00 00
d0: 05 00 81 00 0c f0 ef fe 00 00 00 00 91 41 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 0d 00 00 00 00 00 00 00 00 00 00 00 1d 11 91 80

04:08.0 PCI bridge: Integrated Device Technology, Inc. Device 8091 (rev 02)
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
                 Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
                <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=04, secondary=08, subordinate=08, sec-latency=0
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
                         <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Downstream Port (Slot-), MSI 00
		DevCap:	MaxPayload 2048 bytes, PhantFunc 0, Latency L0s <64ns,
                        L1 <1us
			ExtTag+ RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- 
                        Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- 
                        TransPend-
		LnkCap:	Port #0, Speed 5GT/s, Width x4, ASPM L0s L1, 
                        Latency L0 <4us, L1 <4us
			ClockPM- Surprise+ LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ 
                        DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, 
                         Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, 
                         EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB
	Capabilities: [c0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
                       PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000feeff00c  Data: 4199
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
                        RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
                        RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
                        RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [200 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Capabilities: [320 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+
                        EgressCtrl+ DirectTrans+
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd-
                        EgressCtrl- DirectTrans-
	Capabilities: [330 v1] #12
	Kernel driver in use: pcieport
	Kernel modules: shpchp
00: 1d 11 91 80 07 04 10 00 02 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 04 08 08 00 f1 01 00 00
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 00 10 00
40: 10 c0 62 00 24 80 00 00 00 00 09 00 42 6c 39 00
50: 00 00 01 10 00 00 00 00 00 00 40 00 00 00 00 00
60: 00 00 00 00 20 04 00 00 00 00 00 00 00 00 00 00
70: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 d0 03 c8 08 00 00 00 00 00 00 00 00 00 00 00
d0: 05 00 81 00 0c f0 ef fe 00 00 00 00 99 41 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 0d 00 00 00 00 00 00 00 00 00 00 00 1d 11 91 80

04:0c.0 PCI bridge: Integrated Device Technology, Inc. Device 8091 (rev 02)
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
                 Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
                <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=04, secondary=09, subordinate=09, sec-latency=0
	Memory behind bridge: fe400000-fe4fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
                          <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Downstream Port (Slot-), MSI 00
		DevCap:	MaxPayload 2048 bytes, PhantFunc 0, Latency L0s 
                        <64ns, L1 <1us
			ExtTag+ RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- 
                        Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- 
                        TransPend-
		LnkCap:	Port #12, Speed 5GT/s, Width x4, ASPM L0s L1, Latency 
                        L0 <4us, L1 <4us
			ClockPM- Surprise+ LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+ 
                        DLActive+ BWMgmt+ ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,
                         Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, 
                         EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB
	Capabilities: [c0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
                       PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000feeff00c  Data: 41a1
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
                        RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
                        RxOF- MalfTLP- ECRC-UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
                        RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [200 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
			Status:	NegoPending- InProgress-
	Capabilities: [320 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ 
                        EgressCtrl+ DirectTrans+
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd-
                        EgressCtrl- DirectTrans-
	Capabilities: [330 v1] #12
	Kernel driver in use: pcieport
	Kernel modules: shpchp
00: 1d 11 91 80 07 04 10 00 02 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 04 09 09 00 f1 01 00 00
20: 40 fe 40 fe f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 00 10 00
40: 10 c0 62 00 24 80 00 00 00 00 09 00 42 6c 39 0c
50: 00 00 41 70 00 00 00 00 00 00 40 00 00 00 00 00
60: 00 00 00 00 20 04 00 00 00 00 00 00 00 00 00 00
70: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 d0 03 c8 08 00 00 00 00 00 00 00 00 00 00 00
d0: 05 00 81 00 0c f0 ef fe 00 00 00 00 a1 41 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 0d 00 00 00 00 00 00 00 00 00 00 00 1d 11 91 80

06:00.0 Signal processing controller: Xilinx Corporation Device e004 (rev 32)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
                 Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
                <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Region 0: Memory at fe540000 (32-bit, non-prefetchable) [size=64K]
	Region 1: Memory at fe550000 (32-bit, non-prefetchable) [size=8K]
	Region 2: Memory at fe500000 (32-bit, non-prefetchable) [size=256K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
                       PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [58] Express (v1) Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 1, Latency L0s <64ns,
                        L1 <1us
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- 
                        Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- 
                        TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency 
                        L0 unlimited, L1 unlimited
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
                        DLActive- BWMgmt- ABWMgmt-
00: ee 10 04 e0 07 00 10 00 32 00 80 11 10 00 00 00
10: 00 00 54 fe 00 00 55 fe 00 00 50 fe 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 00 00 00
40: 01 48 23 00 08 00 00 00 05 58 80 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 10 00 01 00 2a 80 00 00
60: 10 00 00 00 11 f4 03 00 40 00 11 10 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

09:00.0 Signal processing controller: Device 19aa:e004 (rev 33)
	Subsystem: Device 19aa:0002
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
                 Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
                <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at fe400000 (32-bit, non-prefetchable) [size=64K]
	Region 1: Memory at fe414000 (32-bit, non-prefetchable) [size=8K]
	Region 2: Memory at fe410000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
                       PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] MSI: Enable- Count=1/32 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [60] Express (v2) Endpoint, MSI 01
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <64ns,
                        L1 unlimited
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- 
                        Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- 
                        TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x4, ASPM L0s, Latency 
                        L0 unlimited, L1 unlimited
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk- 
                        DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range B, TimeoutDis-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- 
                         SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, 
                         EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB
	Capabilities: [9c] MSI-X: Enable- Count=32 Masked-
		Vector table: BAR=0 offset=00006000
		PBA: BAR=0 offset=00007000
00: aa 19 04 e0 07 00 10 00 33 00 80 11 10 00 00 00
10: 00 00 40 fe 00 40 41 fe 00 00 41 fe 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 aa 19 02 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 01 00 00
40: 01 48 03 78 08 00 00 00 05 60 8a 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 9c 02 02 02 8e 00 00 10 00 00 00 41 f4 03 00
70: 00 00 41 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 01 00 00 00 00 00 00 00 00 00 11 00 1f 00
a0: 00 60 00 00 00 70 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0c:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network 
Connection Subsystem: Intel Corporation Device 0000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
                 Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
                 <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at fe600000 (32-bit, non-prefetchable) [size=128K]
	Region 2: I/O ports at e000 [size=32]
	Region 3: Memory at fe620000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [c8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
                       PME(D0+,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [e0] Express (v1) Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s 
                        <512ns, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable+ Non-Fatal+ Fatal+ 
                        Unsupported+
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr-
                        TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, 
                        Latency L0 <128ns, L1 <64us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
                        DLActive- BWMgmt- ABWMgmt-
	Capabilities: [a0] MSI-X: Enable+ Count=3 Masked-
		Vector table: BAR=3 offset=00000000
		PBA: BAR=3 offset=00002000
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
                        RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
                        RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
                        RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [140 v1] Device Serial Number 00-90-fb-ff-ff-3d-ca-b7
	Kernel driver in use: e1000e
	Kernel modules: e1000e
00: 86 80 d3 10 07 04 10 00 00 00 00 02 10 00 00 00
10: 00 00 60 fe 00 00 00 00 01 e0 00 00 00 00 62 fe
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 00 00
30: 00 00 00 00 c8 00 00 00 00 00 00 00 0b 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 11 00 02 80 03 00 00 00 03 20 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 01 d0 22 48 00 20 00 0f
d0: 05 e0 80 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 10 a0 01 00 c1 8c 00 00 0f 00 09 00 11 1c 03 00
f0: 40 00 11 10 00 00 00 00 00 00 00 00 00 00 00 00



 I rebuilt the image last night with debug enabled and should have the full
boot log for you later this morning



