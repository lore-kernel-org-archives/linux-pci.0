Return-Path: <SRS0=ZCmE=LE=gmail.com=hkallweit1@kernel.org>
Return-Path: <SRS0=ZCmE=LE=gmail.com=hkallweit1@kernel.org>
Subject: Re: [PATCH] r8169: don't use MSI-X on RTL8106e
To: Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <helgaas@kernel.org>,
 jian-hong@endlessm.com
Cc: David Miller <davem@davemloft.net>, nic_swsd@realtek.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux@endlessm.com,
 linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Christoph Hellwig <hch@lst.de>
References: <20180815062110.16155-1-jian-hong@endlessm.com>
 <20180816.122131.604270853620318143.davem@davemloft.net>
 <458efbf9-5971-653a-e7cd-8c56ba055648@gmail.com>
 <20180816.123958.750435252621963789.davem@davemloft.net>
 <ac30d4e6-6411-09e6-1205-96e3e8e29f6f@gmail.com>
 <20180820184438.GA154536@bhelgaas-glaptop.roam.corp.google.com>
 <02c08346-3901-9c39-a837-f04e283794d5@arm.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <74d977b1-10a9-9b6e-4e92-0462ac0d2b35@gmail.com>
Date: Tue, 21 Aug 2018 22:54:17 +0200
MIME-Version: 1.0
In-Reply-To: <02c08346-3901-9c39-a837-f04e283794d5@arm.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 21.08.2018 10:28, Marc Zyngier wrote:
> On 20/08/18 19:44, Bjorn Helgaas wrote:
>> [+cc Marc, Thomas, Christoph, linux-pci)
>> (beginning of thread at [1])
>>
>> On Thu, Aug 16, 2018 at 09:50:48PM +0200, Heiner Kallweit wrote:
>>> On 16.08.2018 21:39, David Miller wrote:
>>>> From: Heiner Kallweit <hkallweit1@gmail.com>
>>>> Date: Thu, 16 Aug 2018 21:37:31 +0200
>>>>
>>>>> On 16.08.2018 21:21, David Miller wrote:
>>>>>> From: <jian-hong@endlessm.com>
>>>>>> Date: Wed, 15 Aug 2018 14:21:10 +0800
>>>>>>
>>>>>>> Found the ethernet network on ASUS X441UAR doesn't come back on resume
>>>>>>> from suspend when using MSI-X.  The chip is RTL8106e - version 39.
>>>>>>
>>>>>> Heiner, please take a look at this.
>>>>>>
>>>>>> You recently disabled MSI-X on RTL8168g for similar reasons.
>>>>>>
>>>>>> Now that we've seen two chips like this, maybe there is some other
>>>>>> problem afoot.
>>>>>>
>>>>> Thanks for the hint. I saw it already and just contacted Realtek
>>>>> whether they are aware of any MSI-X issues with particular chip
>>>>> versions. With the chip versions I have access to MSI-X works fine.
>>>>>
>>>>> There's also the theoretical option that the issues are caused by
>>>>> broken BIOS's. But so far only chip versions have been reported
>>>>> which are very similar, at least with regard to version number
>>>>> (2x VER_40, 1x VER_39). So they may share some buggy component.
>>>>>
>>>>> Let's see whether Realtek can provide some hint.
>>>>> If more chip versions are reported having problems with MSI-X,
>>>>> then we could switch to a whitelist or disable MSI-X in general.
>>>>
>>>> It could be that we need to reprogram some register(s) on resume,
>>>> which normally might not be needed, and that is what is causing the
>>>> problem with some chips.
>>>>
>>> Indeed. That's what I'm checking with Realtek.
>>> In the register list in the r8169 driver there's one entry which
>>> seems to indicate that there are MSI-X specific settings.
>>> However this register isn't used, and the r8168 vendor driver
>>> uses only MSI. And there are no public datasheets.
>>
>> Do we have any information about these chip versions in other systems?
>> Or other devices using MSI-X in the same ASUS system?  It seems
>> possible that there's some PCI core or suspend/resume issue with MSI-X
>> and this patch just avoids it without fixing the root cause.
>>
>> It might be useful to have a kernel.org bugzilla with the complete
>> dmesg, "sudo lspci -vv" output, and /proc/interrupts contents archived
>> for future reference.
> 
> The one system I have with a Realtek chip seems happy enough with MSI-X,
> but it never gets suspended.

Other owners of affected chip versiosn made the same experience, MSI-X
works fine until resume from suspend.

> There is comment in the patch that I don't quite get:
> 
>> It is the IRQ 127 - PCI-MSI used by enp2s0.  However, lspci lists MSI is
>> disabled and MSI-X is enabled which conflicts to the interrupt table.
> 
> What do you mean by "conflicts"? With what? Another question is whether
> you've loaded any firmware (some versions of the Realtek HW seem to require
> it).
> 
These "conflicts" were a misunderstanding which was clarified with the
reporter. "PCI-MSI" as irq chip name in /proc/interrupts output was
interpreted in a way that a MSI irq is used, not a MSI-X irq.

The firmware is for the PHY only, that's at least my experience on
the chip versions I have for testing.

> For the posterity, some data from my own system, which I don't know if it
> has any relevance to the problem at hand.
> 
> Thanks,
> 
> 	M.
> 
> [    2.624963] r8169 0000:02:00.0 eth0: RTL8168g/8111g, 5a:fe:ad:ce:11:00, XID 4c000800, IRQ 26
> [    2.633398] r8169 0000:02:00.0 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
> 
>  26:         50     997005          0          0       MSI 1048576 Edge      enp2s0
> 
> 02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 0c)
> 	Subsystem: Realtek Semiconductor Co., Ltd. RTL8111/8168 PCI Express Gigabit Ethernet controller
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin A routed to IRQ 25
> 	Region 0: I/O ports at 1000 [size=256]
> 	Region 2: Memory at 100004000 (64-bit, prefetchable) [size=4K]
> 	Region 4: Memory at 100000000 (64-bit, prefetchable) [size=16K]
> 	Capabilities: [40] Power Management version 3
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
> 		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> 	Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
> 		Address: 0000000000000000  Data: 0000
> 	Capabilities: [70] Express (v2) Endpoint, MSI 01
> 		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
> 			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0.000W
> 		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> 			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 4096 bytes
> 		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
> 		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s unlimited, L1 <64us
> 			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
> 		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
> 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> 		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
> 		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+, OBFF Via message/WAKE#
> 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
> 		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
> 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
> 			 Compliance De-emphasis: -6dB
> 		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
> 			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> 	Capabilities: [b0] MSI-X: Enable+ Count=4 Masked-
> 		Vector table: BAR=4 offset=00000000
> 		PBA: BAR=4 offset=00000800
> 	Capabilities: [d0] Vital Product Data
> pcilib: sysfs_read_vpd: read failed: Input/output error
> 		Not readable
> 	Capabilities: [100 v1] Advanced Error Reporting
> 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> 		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
> 		CESta:	RxErr+ BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
> 		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
> 	Capabilities: [140 v1] Virtual Channel
> 		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
> 		Arb:	Fixed- WRR32- WRR64- WRR128-
> 		Ctrl:	ArbSelect=Fixed
> 		Status:	InProgress-
> 		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
> 			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
> 			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
> 			Status:	NegoPending- InProgress-
> 	Capabilities: [160 v1] Device Serial Number 00-00-00-00-00-00-00-00
> 	Capabilities: [170 v1] Latency Tolerance Reporting
> 		Max snoop latency: 0ns
> 		Max no snoop latency: 0ns
> 	Kernel driver in use: r8169
> 
> 
