Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from resqmta-po-06v.sys.comcast.net ([96.114.154.165]:43818 "EHLO
	resqmta-po-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753877AbbBZIXD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Feb 2015 03:23:03 -0500
Message-ID: <54EED7D2.7000205@comcast.net>
Date: Thu, 26 Feb 2015 00:22:42 -0800
From: Alnie <memobook80@comcast.net>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Takashi Iwai <tiwai@suse.de>
Subject: Re: PCI Issues with ExpressCard/54 Audio Device
References: <1703881568.13072732.1424911985807.JavaMail.zimbra@comcast.net> <1602089933.13084034.1424913145538.JavaMail.zimbra@comcast.net> <CAErSpo6E5EMDUA8tHRZYF6rgfRqtHEZtG4EyVcMSRL02T3Ttyg@mail.gmail.com>
In-Reply-To: <CAErSpo6E5EMDUA8tHRZYF6rgfRqtHEZtG4EyVcMSRL02T3Ttyg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/25/2015 10:55 PM, Bjorn Helgaas wrote:
> [+cc Takashi]
>
> On Wed, Feb 25, 2015 at 5:12 PM, Alnie <memobook80@comcast.net> wrote:
>> Hi, I am seeking feedback in regards to issues with a ExpressCard/54 audio card (http://www.notebookreview.com/notebookreview/creative-soundblaster-x-fi-xtreme-audio-for-notebook-review/) under Linux (same card has been working fine in Win 7). After recently having a conversation on alsa-devel about it, it was decided it seems to be a PCI issue. The "devices" in question....
>
> Hi Alnie,
>
> I'm sorry you're running into a problem, but thanks for the report!
>
>> 05:00.0 PCI bridge: Creative Labs [SB X-Fi Xtreme Audio] CA0110-IBG PCI to PCIe Bridge (prog-if 00 [Normal decode])
>>       Physical Slot: 3
>>       Flags: bus master, fast devsel, latency 0
>>       Bus: primary=05, secondary=06, subordinate=0c, sec-latency=36
>>       Memory behind bridge: f4300000-f43fffff
>>       Capabilities: [50] Power Management version 3
>>       Capabilities: [60] MSI: Enable- Count=1/16 Maskable- 64bit+
>>       Capabilities: [80] Subsystem: Creative Labs Device 0040
>>       Capabilities: [90] Express PCI-Express to PCI/PCI-X Bridge, MSI 00
>>       Capabilities: [100] Advanced Error Reporting
>>
>> 06:00.0 Audio device: Creative Labs [SB X-Fi Xtreme Audio] CA0110-IBG
>>       Subsystem: Creative Labs SB1040
>>       Flags: bus master, fast Back2Back, medium devsel, latency 32, IRQ 19
>>       Memory at f4300000 (32-bit, non-prefetchable) [size=16K]
>>       Capabilities: [dc] Power Management version 3
>>       Kernel driver in use: snd_hda_intel
>>
>>
>>
>> dmesg output... http://pastebin.com/66UE659K
>>
>> and comments in regard to it... http://mailman.alsa-project.org/pipermail/alsa-devel/2015-February/088237.html
>>>
>>> [ 2619.199658] pciehp 0000:00:1c.3:pcie04: Card not present on Slot(3)
>>> [ 2619.199666] pciehp 0000:00:1c.3:pcie04: slot(3): Link Down event
>>> [ 2619.199674] pciehp 0000:00:1c.3:pcie04: Link Down event ignored on
>>> slot(3): already powering off
>>> [ 2619.199911] pci_bus 0000:06: busn_res: [bus 06-0c] is released
>>> [ 2620.757928] pciehp 0000:00:1c.3:pcie04: Card present on Slot(3)
>>> [ 2620.767950] pciehp 0000:00:1c.3:pcie04: slot(3): Link Up event
>>> [ 2620.767985] pciehp 0000:00:1c.3:pcie04: Link Up event ignored on
>>> slot(3): already powering on
>>
>> pciehp reacted power off and on here, and...
>>
>>> [ 2620.876160] pci 0000:05:00.0: [1102:7006] type 01 class 0x060400
>>> [ 2620.876426] pci 0000:05:00.0: supports D1 D2
>>> [ 2620.876719] pci 0000:05:00.0: bridge configuration invalid ([bus
>>> 00-00]), reconfiguring
>>> [ 2620.876928] pci_bus 0000:06: busn_res: can not insert [bus 06-ff]
>>> under [bus 05-0c] (conflicts with (null) [bus 05-0c])
>>
>> .... and something failed here for the PCI bridge device.
>>
>>> [ 2620.876967] pci 0000:06:00.0: [1102:0009] type 00 class 0x040300
>>> [ 2620.877013] pci 0000:06:00.0: reg 0x10: [mem 0x00000000-0x00003fff]
>>> [ 2620.877203] pci 0000:06:00.0: supports D1 D2
>>> [ 2620.877443] pci 0000:05:00.0: PCI bridge to [bus 06-ff]
>>> [ 2620.877462] pci 0000:05:00.0:   bridge window [io  0x0000-0x0fff]
>>> [ 2620.877474] pci 0000:05:00.0:   bridge window [mem 0x00000000-0x000fffff]
>>> [ 2620.877492] pci 0000:05:00.0:   bridge window [mem
>>> 0x00000000-0x000fffff 64bit pref]
>>> [ 2620.877500] pci_bus 0000:06: busn_res: [bus 06-ff] end is updated to 06
>>> [ 2620.877559] pci 0000:05:00.0: BAR 14: assigned [mem
>>> 0xf4300000-0xf43fffff]
>>> [ 2620.877568] pci 0000:05:00.0: BAR 15: assigned [mem
>>> 0xf4000000-0xf40fffff 64bit pref]
>>> [ 2620.877574] pci 0000:05:00.0: BAR 13: assigned [io  0x2000-0x2fff]
>>> [ 2620.877582] pci 0000:06:00.0: BAR 0: assigned [mem 0xf4300000-0xf4303fff]
>>> [ 2620.877595] pci 0000:05:00.0: PCI bridge to [bus 06]
>>> [ 2620.877603] pci 0000:05:00.0:   bridge window [io  0x2000-0x2fff]
>>> [ 2620.877618] pci 0000:05:00.0:   bridge window [mem 0xf4300000-0xf43fffff]
>>> [ 2620.877630] pci 0000:05:00.0:   bridge window [mem
>>> 0xf4000000-0xf40fffff 64bit pref]
>>> [ 2620.877647] pcieport 0000:00:1c.3: PCI bridge to [bus 05-0c]
>>> [ 2620.877655] pcieport 0000:00:1c.3:   bridge window [io  0x2000-0x2fff]
>>> [ 2620.877667] pcieport 0000:00:1c.3:   bridge window [mem
>>> 0xf4300000-0xf7efffff]
>>> [ 2620.877677] pcieport 0000:00:1c.3:   bridge window [mem
>>> 0xf4000000-0xf40fffff 64bit pref]
>>> [ 2620.877990] pci 0000:05:00.0: enabling device (0000 -> 0003)
>>> [ 2620.878013] snd_hda_intel 0000:06:00.0: enabling device (0000 -> 0002)
>>> [ 2620.882747] azx_single_wait_for_response: 108 callbacks suppressed
>>> [ 2620.882753] snd_hda_intel 0000:06:00.0: Codec #1 probe error;
>>> disabling it...
>>> [ 2620.887052] snd_hda_intel 0000:06:00.0: no AFG or MFG node found
>>> [ 2620.887058] snd_hda_intel 0000:06:00.0: no codecs initialized
>>
>>
>>
>> I've tried many kernels from 2.6 to 3.18 with similar results. Willing to retrieve more info. Thank you :)
>
> It looks like you booted with the card already installed, then removed
> and reinstalled it.  Did the card work at any point?  If it worked
> before the hotplug, then we need to look for a hotplug problem.  If it
> never worked, then we can ignore hotplug for now.
>
> My guess is that the card never worked at all and hotplug isn't an issue here.


Correct. The card has not worked at any point for me in Linux.


>
> The pciehp messages above are a bit scary looking, but I don't think
> they actually show a problem.  It looks like you booted with the
> ExpressCard present, and it was configured like this:
>
>    pci 0000:00:1c.3: PCI bridge to [bus 05-0c]
>    pci 0000:00:1c.3:   bridge window [io  0x2000-0x2fff]
>    pci 0000:00:1c.3:   bridge window [mem 0xf4300000-0xf7efffff]
>    pci 0000:00:1c.3:   bridge window [mem 0xf4000000-0xf40fffff 64bit pref]
>    pci 0000:05:00.0: PCI bridge to [bus 06-0c]
>    pci 0000:05:00.0:   bridge window [mem 0xf4300000-0xf43fffff]
>    pci 0000:06:00.0: [1102:0009] type 00 class 0x040300
>    pci 0000:06:00.0: reg 0x10: [mem 0xf4300000-0xf4303fff]
>    pciehp 0000:00:1c.3:pcie04: Slot #3 AttnBtn- AttnInd- PwrInd-
> PwrCtrl- MRL- Interlock- NoCompl- LLActRep+
>
> The kernel didn't change anything on the device, but the driver complained:
>
>    snd_hda_intel 0000:06:00.0: Codec #1 probe error; disabling it...
>    snd_hda_intel 0000:06:00.0: no AFG or MFG node found
>    snd_hda_intel 0000:06:00.0: no codecs initialized
>
> I assume the device is not working at this point.  (Correct me if I'm
> wrong.)  Some time later, at timestamp 2620, it looks like you
> unplugged and replugged the ExpressCard.  We reconfigured the bridge
> and device like this:
>
>    pci 0000:05:00.0: PCI bridge to [bus 06]
>    pci 0000:05:00.0:   bridge window [io  0x2000-0x2fff]
>    pci 0000:05:00.0:   bridge window [mem 0xf4300000-0xf43fffff]
>    pci 0000:05:00.0:   bridge window [mem 0xf4000000-0xf40fffff 64bit pref]
>    pci 0000:06:00.0: BAR 0: assigned [mem 0xf4300000-0xf4303fff]
>
> This is slightly different than what we had initially:
>
>    - 05:00.0 bridge bus aperture is [bus 06] instead of [bus 06-0c]
>    - 05:00.0 bridge io aperture is enabled instead of disabled
>    - 05:00.0 bridge mem pref aperture is enabled instead of disabled
>
> But none of these is a problem and the audio device itself at 06:00.0
> is programmed identically to what we had initially.  And it looks like
> the driver complains exactly the same way it did at boot-time.  So I
> don't think this is related to hotplug.
>
> Can you use a program like this:
> http://cmp.felk.cvut.cz/~pisa/linux/rdwrmem.c to read some of the
> device registers, e.g., the ones mapped by BAR 0 at 0xf4300000?  I
> don't know what the register layout is, but if you get all 0xff
> responses, that might indicate that the device isn't responding,
> either because we haven't enabled it correctly or we haven't routed
> that space correctly, or ....  If you get any data that is NOT all
> ones, that means the device is responding.

I just compiled this but I'm a bit unfamiliar, sorry :( It is giving me 
"mmap error". Is this the what you are looking for?

./mem -N -m -s 0xf4000000
./mem: request seek to 4093640704, but -201326592 returned
F4000000:FF

>
> Could you also collect the output of "lspci -vvs00:1c.3"

00:1c.3 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express 
Port 4 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=05, subordinate=0c, sec-latency=0
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: f4300000-f7efffff
	Prefetchable memory behind bridge: 00000000f4000000-00000000f40fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #4, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency 
L0s <256ns, L1 <4us
			ClockPM- Surprise- LLActRep+ BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ 
BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
			Slot #3, PowerLimit 6.500W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt+ HPIrq+ LinkChg+
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee0300c  Data: 4122
	Capabilities: [90] Subsystem: Lenovo Device 20f3
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed+ WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
			Status:	NegoPending- InProgress-
	Capabilities: [180 v1] Root Complex Link
		Desc:	PortNumber=04 ComponentID=02 EltType=Config
		Link0:	Desc:	TargetPort=00 TargetComponent=02 AssocRCRB- 
LinkType=MemMapped LinkValid+
			Addr:	00000000fed1c000
	Kernel driver in use: pcieport


> lspci -vvs05:000"

05:00.0 PCI bridge: Creative Labs [SB X-Fi Xtreme Audio] CA0110-IBG PCI 
to PCIe Bridge (prog-if 00 [Normal decode])
	Physical Slot: 3
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=05, secondary=06, subordinate=0c, sec-latency=36
	Memory behind bridge: f4300000-f43fffff
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+
	Capabilities: [60] MSI: Enable- Count=1/16 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [80] Subsystem: Creative Labs Device 0040
	Capabilities: [90] Express (v1) PCI-Express to PCI/PCI-X Bridge, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+ BrConfRtry-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency 
L0s <512ns, L1 <16us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- 
BWMgmt- ABWMgmt-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq+ ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ 
MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-



>and "lspci -vvs06:00.0"?

06:00.0 Audio device: Creative Labs [SB X-Fi Xtreme Audio] CA0110-IBG
	Subsystem: Creative Labs SB1040
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B+ DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at f4300000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [dc] Power Management version 3
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: snd_hda_intel


> Bjorn
>
