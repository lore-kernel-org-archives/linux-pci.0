Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:51500 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756551Ab2FGUb5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jun 2012 16:31:57 -0400
Received: by dady13 with SMTP id y13so1366234dad.19
        for <linux-pci@vger.kernel.org>; Thu, 07 Jun 2012 13:31:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <loom.20120607T194858-986@post.gmane.org>
References: <loom.20120607T194858-986@post.gmane.org>
Date: Thu, 7 Jun 2012 13:31:56 -0700
Message-ID: <CAE9FiQWau+ko4JiEEjM=2xSH_7FPBr_ZYOm8YGpin2p97=12PQ@mail.gmail.com>
Subject: Re: PCIe rescan not working
From: Yinghai Lu <yinghai@kernel.org>
To: Tom Carr <tkcarr03873@gmail.com>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 7, 2012 at 12:16 PM, Tom Carr <tkcarr03873@gmail.com> wrote:
>  I wanted to follow up on comment 12836 which was answered by Yinghai Lu with a
> patch that appears to deal with a PCIe rescan issue when there is a switch
> behind a bridge. I am seeing the same failure on the 2 version mentioned in the
> subject. The 3.2 version also has the patch referenced by Yinghai Lu in comment
> 12836. Our setup is as follows
>
>   -----------------    -------------------     -------------------
>   |Intel processor| -> | IDT 6 port switch| -> | unpopulated FPGA |
>   | PCIe root     |    |                  |    |                  |
>   -----------------    -------------------     -------------------
>
>  The processor is an i7-2600. I am not 100% certain of the model of the switch
> but I believe it is an IDT PES32NT8BG2 switch being used in P2P mode. The design
> of the project requires that after the system is booted a bitstream with a PCIe
> endpoint will be loaded into the FPGA and rescan will be run to bring the
> endpoint on line. In the drawing above, the switch and FPGA are on a board that
> is plugged into a 4x PCIe connector on the motherboard. The driver being used
> for the switch is the pcieport in conjunction with the shpchp module. I am
> forcing the rescan by using "echo 1 > /sys/bus/pci/rescan".
>
>  From the debug message and kernel messages it appears that the rescan takes
> place with the endpoint being found and added. The probe function for both the
> pcieport driver and customer driver are called. You can see the endpoint using
> lspci but there was no memory assigned to the bars of the new endpoint. The
> kernel messages show that both the switch port and the endpoint failed to have
> memory assigned. As the messages below show
>
> Jun  4 14:04:02 bdsazi1 kernel: [  177.562151] i915 0000:00:02.0: BAR 6: [???
> 0x00000000 flags 0x2] has bogus alignment
> Jun  4 14:04:02 bdsazi1 kernel: [  177.562161] pcieport 0000:04:08.0: BAR 14
> can't assign mem (size 0x100000)
> Jun  4 14:04:02 bdsazi1 kernel: [  177.562166] pci 0000:08:00.0: BAR 0: can't
> assign mem (size 0x10000)
> Jun  4 14:04:02 bdsazi1 kernel: [  177.562168] pci 0000:08:00.0: BAR 2: can't
> assign mem (size 0x4000)
> Jun  4 14:04:02 bdsazi1 kernel: [  177.562171] pci 0000:08:00.0: BAR 1: can't
> assign mem (size 0x2000)
> Jun  4 14:04:02 bdsazi1 kernel: [  177.562240] BDS_FPGA_PROBE pdev =
> 0xffff880214963000 bus=0x8 devfn=0x0 vend = 0x19aa parent = 0x4
> Jun  4 14:04:02 bdsazi1 kernel: [  177.562260] bds_pcie 0000:08:00.0: PCI INT A
> -> GSI 18 (level, low) -> IRQ 18
> Jun  4 14:04:02 bdsazi1 kernel: [  177.562279] BDS_FPGA Dev 1 0x00000000
> 0x00000000 0x00000000 2 0x00000000 0x00000000 0x00000000 3 0x00000000 0x00000000
> 0x00000000
> Jun  4 14:04:02 bdsazi1 kernel: [  177.562282] BDS_FPGA enable MSI pin irq 18
> Jun  4 14:04:02 bdsazi1 kernel: [  177.562357] BDS_FPGA enable MSI msi irq 59
>
>
>  The FPGA is attached to the port at bfn 4.8.0 which has a secondary bus of 8.
> If we remove the board and replace it with a board with just and FPGA and no
> switch, the rescan works fine and the endpoint is operational. If we load the
> FPGA and then boot the board everything if fine. The problem is definitely with
> the switch being present with nothing behind it at boot time. There is nothing I
> can find in docs or the code to give a hint as to why memory is not being
> assigned to the switch port which is why the endpoint is not getting memory. I
> have added lots of debug to try to figure out the exact reason why the failure
> is occuring but I have not found it yet. The failure appears to be coming from a
> call to allocate_resource in kernel/resource.c but I am still working on proving
> that. The discussion in 12836 sounded very similar to this problem and I thought
> the patch to 3.2 would solve the problem but it did not.
>
>  The lspci output for the port follows
>
> 04:08.0 PCI bridge: Integrated Device Technology, Inc. Device 8091 (rev 02)
> (prog-if 00 [Normal decode])
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
>                ParErr- Stepping- SERR- FastB2B- DisINTx+
>        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
>                <MAbort- >SERR- <PERR- INTx-
>        Latency: 0, Cache Line Size: 64 bytes
>        Bus: primary=04, secondary=08, subordinate=08, sec-latency=0
>        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
>                <MAbort- <SERR- <PERR-
>        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>        Capabilities: [40] Express (v2) Downstream Port (Slot-), MSI 00
>                DevCap: MaxPayload 2048 bytes, PhantFunc 0, Latency L0s <64ns,
>                        L1 <1us
>                        ExtTag+ RBE+ FLReset-
>                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
>                        Unsupported-
>                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                        MaxPayload 128 bytes, MaxReadReq 128 bytes
>                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr-
>                        TransPend-
>                LnkCap: Port #0, Speed 5GT/s, Width x4, ASPM L0s L1, Latency L0
>                        <4us, L1 <4us
>                        ClockPM- Surprise+ LLActRep+ BwNot+
>                LnkCtl: ASPM Disabled; Disabled- Retrain- CommClk-
>                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+
>                        DLActive- BWMgmt- ABWMgmt-
>                DevCap2: Completion Timeout: Not Supported, TimeoutDis- ARIFwd+
>                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
>                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,
>                         Selectable
>                         De-emphasis: -6dB
>                         Transmit Margin: Normal Operating Range,
>                         EnterModifiedCompliance- ComplianceSOS-
>                         Compliance De-emphasis: -6dB
>                LnkSta2: Current De-emphasis Level: -6dB
>        Capabilities: [c0] Power Management version 3
>                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
>                       PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>        Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
>                Address: 00000000feeff00c  Data: 4199
>        Capabilities: [100 v2] Advanced Error Reporting
>                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
>                        RxOF- MalfTLP- ECRC-
>                        UnsupReq- ACSViol-
>                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
>                        RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
>                        RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>                AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
>        Capabilities: [200 v1] Virtual Channel
>                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
>                Arb:    Fixed- WRR32- WRR64- WRR128-
>                Ctrl:   ArbSelect=Fixed
>                Status: InProgress-
>                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>                        Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
>                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
>                        Status: NegoPending- InProgress-
>        Capabilities: [320 v1] Access Control Services
>                ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+
>                        EgressCtrl+ DirectTrans+
>                ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd-
>                        EgressCtrl- DirectTrans-
>        Capabilities: [330 v1] #12
>        Kernel driver in use: pcieport
>        Kernel modules: shpchp
>
>
>  I am sure I am not supply some piece of information that is important so let me
> know what else you need and I will provide it.

should be bridge that 04:08.0 is on, does not have big enough range
after it is booted up.

current pciehp will resize bridge if the bridge resource is not big enough.

please post whole boot log with "debug" and compile the kernel with
pci debug enabled.
CONFIG_PCI_DEBUG=y

also please post
lspci -vvxxx
lspci -tv

Thanks

Yinghai
