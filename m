Return-Path: <SRS0=4AP1=LG=endlessm.com=jian-hong@kernel.org>
Return-Path: <SRS0=4AP1=LG=endlessm.com=jian-hong@kernel.org>
MIME-Version: 1.0
In-Reply-To: <36bd086d-8d26-5162-ae24-95b259571221@gmail.com>
References: <ac30d4e6-6411-09e6-1205-96e3e8e29f6f@gmail.com>
 <20180820184438.GA154536@bhelgaas-glaptop.roam.corp.google.com>
 <9d7d960a-6c55-dc4b-7969-f5cf46bff0ce@gmail.com> <20180821.123108.89921430801253333.davem@davemloft.net>
 <da97e198-7683-e0ff-92a9-3b1b22da3757@gmail.com> <alpine.DEB.2.21.1808221222260.2514@nanos.tec.linutronix.de>
 <36bd086d-8d26-5162-ae24-95b259571221@gmail.com>
From: Jian-Hong Pan <jian-hong@endlessm.com>
Date: Thu, 23 Aug 2018 18:46:28 +0800
Message-ID: <CAPpJ_edz3H81EqRSg5jeOXoULt7AKwcTpNFL6Ntt8rhQBPFBFQ@mail.gmail.com>
Subject: Re: [PATCH] r8169: don't use MSI-X on RTL8106e
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, David Miller <davem@davemloft.net>, helgaas@kernel.org,
	Realtek linux nic maintainers <nic_swsd@realtek.com>, netdev@vger.kernel.org,
	Linux Kernel <linux-kernel@vger.kernel.org>, Linux Upstreaming Team <linux@endlessm.com>,
	linux-pci@vger.kernel.org, marc.zyngier@arm.com, hch@lst.de
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

2018-08-23 3:49 GMT+08:00 Heiner Kallweit <hkallweit1@gmail.com>:
> On 22.08.2018 13:44, Thomas Gleixner wrote:
>> On Tue, 21 Aug 2018, Heiner Kallweit wrote:
>>> On 21.08.2018 21:31, David Miller wrote:
>>>> From: Heiner Kallweit <hkallweit1@gmail.com>
>>>> Date: Mon, 20 Aug 2018 22:46:48 +0200
>>>>
>>>>> I'm in contact with Realtek and according to them few chip versions
>>>>> seem to clear MSI-X table entries on resume from suspend. Checking
>>>>> with them how this could be fixed / worked around.
>>>>> Worst case we may have to disable MSI-X in general.
>>>>
>>>> I worry that if the chip does this, and somehow MSI-X is enabled and
>>>> an interrupt is generated, the chip will write to the cleared out
>>>> MSI-X address.  This will either write garbage into memory or cause
>>>> a bus error and require PCI error recovery.
>>>>
>>>> It also looks like your test patch doesn't fix things for people who
>>>> have tested it.
>>>>
>>> The test patch was based on the first info from Realtek which made me
>>> think that the base address of the MSI-X table is cleared, what
>>> obviously is not the case.
>>>
>>> After some further tests it seems that the solution isn't as simple
>>> as storing the MSI-X table entries on suspend and restore them on
>>> resume. On my system (where MSI-X works fine) MSI-X table entries
>>> on resume are partially different from the ones on suspend.
>>
>> Which is not a surprise. Please don't try to fiddle with that at the driver
>> level. The irq and PCI core code are the ones in charge and if you'd
>> restore at the wrong point then hell breaks lose.
>>
> Instead of spending a lot of effort on a workaround which may not be
> acceptable, it may be better to fall back to MSI on all affected chip
> versions. For two chip versions which were reported to have this issues
> we're doing this already. I asked Realtek whether they have an overview
> which chip versions are affected, let's see ..
>
> The Realtek chips provide an alternative, register-based way to access
> the MSI-X table, and their Windows driver seems to use it. See here:
> https://patchwork.kernel.org/patch/4149171/
>
> But as we handle all MSI-X basics in the PCI core, this isn't an option.
>
>
>> Can you please do the following:

Tested on ASUS X441AUR equipped with RTL8106e.
This is the laptop whose ethernet does not come back after resume, if
it does not fallback to MSI.

Here is the full dmesg:
https://gist.github.com/starnight/e65a97c9bf2d558926895ab76974687e

>>  1) Store the PCI config space at suspend time

Before suspend:

dev@endless:~$ sudo lspci -xnnvvs 02:00.0
02:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
RTL8101/2/6E PCI Express Fast/Gigabit Ethernet controller [10ec:8136]
(rev 07)
Subsystem: ASUSTeK Computer Inc. RTL810xE PCI Express Fast Ethernet
controller [1043:200f]
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 16
Region 0: I/O ports at e000 [size=256]
Region 2: Memory at ef100000 (64-bit, non-prefetchable) [size=4K]
Region 4: Memory at e0000000 (64-bit, prefetchable) [size=16K]
Capabilities: [40] Power Management version 3
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
Address: 0000000000000000  Data: 0000
Capabilities: [70] Express (v2) Endpoint, MSI 01
DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 <64us
ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 10.000W
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 512 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency
L0s unlimited, L1 <64us
ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+, OBFF Via
message/WAKE#
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Disabled
LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [b0] MSI-X: Enable+ Count=4 Masked-
Vector table: BAR=4 offset=00000000
PBA: BAR=4 offset=00000800
Capabilities: [d0] Vital Product Data
pcilib: sysfs_read_vpd: read failed: Input/output error
Not readable
Capabilities: [100 v1] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
Capabilities: [140 v1] Virtual Channel
Caps: LPEVC=0 RefClk=100ns PATEntryBits=1
Arb: Fixed- WRR32- WRR64- WRR128-
Ctrl: ArbSelect=Fixed
Status: InProgress-
VC0: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl: Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
Status: NegoPending- InProgress-
Capabilities: [160 v1] Device Serial Number 01-00-00-00-36-4c-e0-00
Capabilities: [170 v1] Latency Tolerance Reporting
Max snoop latency: 3145728ns
Max no snoop latency: 3145728ns
Kernel driver in use: r8169
Kernel modules: r8169
00: ec 10 36 81 07 04 10 00 07 00 00 02 10 00 00 00
10: 01 e0 00 00 00 00 00 00 04 00 10 ef 00 00 00 00
20: 0c 00 00 e0 00 00 00 00 00 00 00 00 43 10 0f 20
30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 01 00 00

>>  2) Compare the PCI config space at resume time and print the difference

After resume:

dev@endless:~$ sudo lspci -xnnvvs 02:00.0
02:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
RTL8101/2/6E PCI Express Fast/Gigabit Ethernet controller [10ec:8136]
(rev 07)
Subsystem: ASUSTeK Computer Inc. RTL810xE PCI Express Fast Ethernet
controller [1043:200f]
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 16
Region 0: I/O ports at e000 [size=256]
Region 2: Memory at ef100000 (64-bit, non-prefetchable) [size=4K]
Region 4: Memory at e0000000 (64-bit, prefetchable) [size=16K]
Capabilities: [40] Power Management version 3
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
Address: 0000000000000000  Data: 0000
Capabilities: [70] Express (v2) Endpoint, MSI 01
DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 <64us
ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 10.000W
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 512 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency
L0s unlimited, L1 <64us
ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+, OBFF Via
message/WAKE#
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Disabled
LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [b0] MSI-X: Enable+ Count=4 Masked-
Vector table: BAR=4 offset=00000000
PBA: BAR=4 offset=00000800
Capabilities: [d0] Vital Product Data
pcilib: sysfs_read_vpd: read failed: Input/output error
Not readable
Capabilities: [100 v1] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
Capabilities: [140 v1] Virtual Channel
Caps: LPEVC=0 RefClk=100ns PATEntryBits=1
Arb: Fixed- WRR32- WRR64- WRR128-
Ctrl: ArbSelect=Fixed
Status: InProgress-
VC0: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl: Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
Status: NegoPending- InProgress-
Capabilities: [160 v1] Device Serial Number 01-00-00-00-36-4c-e0-00
Capabilities: [170 v1] Latency Tolerance Reporting
Max snoop latency: 3145728ns
Max no snoop latency: 3145728ns
Kernel driver in use: r8169
Kernel modules: r8169
00: ec 10 36 81 07 04 10 00 07 00 00 02 10 00 00 00
10: 01 e0 00 00 00 00 00 00 04 00 10 ef 00 00 00 00
20: 0c 00 00 e0 00 00 00 00 00 00 00 00 43 10 0f 20
30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 01 00 00

After comparing, there is no difference between before suspend and after resume.

Regards,
Jian-Hong Pan

>> Do that on a working and a non-working version of Realtek NICs.
>>
>> Thanks,
>>
>>       tglx
>>
>>
>>
>
