Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout1.freenet.de ([195.4.92.91]:59806 "EHLO mout1.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751137AbaJJJpl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 10 Oct 2014 05:45:41 -0400
Message-ID: <5437A958.3000201@maya.org>
Date: Fri, 10 Oct 2014 11:39:36 +0200
From: Andreas Hartmann <andihartmann@freenet.de>
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@redhat.com>
CC: linux-pci <linux-pci@vger.kernel.org>
Subject: Re: Hard and silent lock up since linux 3.14 with PCIe pass
 through (vfio)
References: <20140923210318.498dacbd@dualc.maya.org> <1411502866.24563.8.camel@ul30vt.home>
In-Reply-To: <1411502866.24563.8.camel@ul30vt.home>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

shortly: I retested w/ qemu 2.1.0 and Linux 3.17.0 - no change in behaviour.

Alex Williamson wrote:
> On Tue, 2014-09-23 at 21:03 +0200, Andreas Hartmann wrote:
>> Hello!
>>
>> Since long time now, I'm using w/o any problem PCIe pass through with a
>> Gigabyte GA-990XA-UD3/GA-990XA-UD3 mainboard (AMD 990X chipset) and
>> enabled IOMMU with vfio-pci.
>>
>> The last kernel working w/o any problem is kernel 3.13.7 (I didn't use
>> .8 and .9, but I do not think they would have been problematic).
>>
>> Since 3.14.19 (I didn't test any 3.14 kernel before) I'm encountering a
>> hard and silent lock up of the complete machine when starting the VM
>> with the PCIe card passed through.
>>
>> That's the relevant PCIe card, which locks up the machine (here
>> running w/ 3.12.28) when passed to the VM:
>>
>> 03:00.0 Network controller: Qualcomm Atheros AR93xx Wireless Network Adapter (rev 01)
>>         Subsystem: Qualcomm Atheros Device 3112
>>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
>>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>         Latency: 0, Cache Line Size: 64 bytes
>>         Interrupt: pin A routed to IRQ 17
>>         Region 0: Memory at fdbc0000 (64-bit, non-prefetchable) [size=128K]
>>         Expansion ROM at fda00000 [size=64K]
>>         Capabilities: [40] Power Management version 3
>>                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=375mA PME(D0+,D1+,D2-,D3hot+,D3cold-)
>>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>>         Capabilities: [50] MSI: Enable- Count=1/4 Maskable+ 64bit+
>>                 Address: 0000000000000000  Data: 0000
>>                 Masking: 00000000  Pending: 00000000
>>         Capabilities: [70] Express (v2) Endpoint, MSI 00
>>                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <1us, L1 <8us
>>                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
>>                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>>                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
>>                         MaxPayload 128 bytes, MaxReadReq 512 bytes
>>                 DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
>>                 LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <2us, L1 <64us
>>                         ClockPM- Surprise- LLActRep- BwNot-
>>                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
>>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>>                 DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR-, OBFF Not Supported
>>                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
>>                 LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
>>                          Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
>>                          Compliance De-emphasis: -6dB
>>                 LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
>>                          EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
>>         Capabilities: [100 v1] Advanced Error Reporting
>>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>>                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout+ NonFatalErr+
>>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>>                 AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
>>         Capabilities: [140 v1] Virtual Channel
>>                 Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
>>                 Arb:    Fixed- WRR32- WRR64- WRR128-
>>                 Ctrl:   ArbSelect=Fixed
>>                 Status: InProgress-
>>                 VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>>                         Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
>>                         Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
>>                         Status: NegoPending- InProgress-
>>         Capabilities: [300 v1] Device Serial Number 00-00-00-00-00-00-00-00
>>         Kernel driver in use: vfio-pci
>>         Kernel modules: ath9k
>>
>>
>> Unbinding it works w/o any problem. The lock up encounters about 4 s
>> after the start of the VM.
>>
>> On 3.12.x, I can see the following message on the error terminal when
>> starting the VM: 
>> vfio-pci: 03:00.0: invalid ROM contents.
>>
>> I compared AMD-Vi debug output between 3.12 and 3.14, but couldn't see
>> any difference. I compared /proc/interrupts between 3.12 and 3.14
>> and couldn't see any difference too so far.
>>
>>
>> qemu version I'm using is 1.7.0.
>>
>>
>> It is strange(?), that a second VM using PCI (legacy) pass through works
>> w/o any problem. I tried to start the problematic VM even w/o running
>> this VM - same result: machine is locked up hard.
>>
>>
>> Do you have any idea, what could be going on there? Or how to debug it
>> to see what happened?

> There weren't many vfio changes between 3.13 and 3.14.

It could be a pci problem, too? It is strange, that there is no problem
with the pci-card, but the pcie card hangs the machine!

> Have you tested whether the problem still occurs on 3.16 +

Same problem with 3.17.0

> newer QEMU?

Same problem With qemu 2.1.0.

>  Maybe also remove the ROM from the equation with the
> rombar=0 option for the vfio-pci device in QEMU.

Same problem :-(. The machine really is completely dead: it even pings
any more.



Regards,
Andreas
