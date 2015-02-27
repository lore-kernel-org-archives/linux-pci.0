Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from resqmta-po-06v.sys.comcast.net ([96.114.154.165]:37698 "EHLO
	resqmta-po-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754182AbbB0ACK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Feb 2015 19:02:10 -0500
Message-ID: <54EFB400.4000904@comcast.net>
Date: Thu, 26 Feb 2015 16:02:08 -0800
From: Alnie <memobook80@comcast.net>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Takashi Iwai <tiwai@suse.de>
Subject: Re: PCI Issues with ExpressCard/54 Audio Device
References: <1703881568.13072732.1424911985807.JavaMail.zimbra@comcast.net> <1602089933.13084034.1424913145538.JavaMail.zimbra@comcast.net> <CAErSpo6E5EMDUA8tHRZYF6rgfRqtHEZtG4EyVcMSRL02T3Ttyg@mail.gmail.com> <54EED7D2.7000205@comcast.net> <20150226174635.GA25765@google.com> <54EF74CF.7050909@comcast.net> <20150226231843.GC25765@google.com>
In-Reply-To: <20150226231843.GC25765@google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 02/26/2015 03:18 PM, Bjorn Helgaas wrote:
> On Thu, Feb 26, 2015 at 11:32:31AM -0800, Alnie wrote:
>> On 02/26/2015 09:46 AM, Bjorn Helgaas wrote:
>>> On Thu, Feb 26, 2015 at 12:22:42AM -0800, Alnie wrote:
>
>>>> 	Capabilities: [100 v1] Advanced Error Reporting
>>>> 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
>>>> MalfTLP- ECRC- UnsupReq+ ACSViol-
>>>
>>> This looks suspicious: the bridge logged an Unsupported Request error.
>>> Let's see if we can figure out if this error is left there by BIOS or if
>>> the PCI core or the driver or rdwrmem is doing something that causes it.
>>>
>>> Can you try this:
>>>
>>>    - Boot without the snd_hda_intel driver at all
>>>    - Collect "lspci -vvs05:00.0" output
>>
>> blacklist snd_hda_intel
>>
>> 05:00.0 PCI bridge: Creative Labs [SB X-Fi Xtreme Audio] CA0110-IBG
>> PCI to PCIe Bridge (prog-if 00 [Normal decode])
>> ...
>> 	Capabilities: [100 v1] Advanced Error Reporting
>> 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
>> MalfTLP- ECRC- UnsupReq+ ACSViol-
>
> All three of your lspci outputs are identical, so it looks like the BIOS
> probably left UnsupReq set.  Maybe the kernel should log that and clear it
> at boot.  I sort of doubt this is the problem, but we can try clearing
> those errors manually:
>
>    lspci -vvs05:00.0

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


>    setpci -s05:00.0 0x9a.w=0x0a		# clear UncorrErr UnsuppReq
>    setpci -s05:00.0 0x104.l=0x00100000	# clear AER UnsupReq
>    lspci -vvs05:00.0

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
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency 
L0s <512ns, L1 <16us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- 
BWMgmt- ABWMgmt-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ 
MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-

>    modprobe snd-hda-intel
>

Same complaint comes up (no codecs found)

>>>    - Poke around with rdwr
>>
>> (I am unfamiliar with this & hex, was trying different things,
>> please correct me in case)
>>
>> # ./mem -N -m -s 0xf4300000
>> ./mem: request seek to 4096786432, but -198180864 returned
>> F4300000:00
>> # ./mem -N -m -s f4300000
>> 00000000:53
>> # ./mem -N -m -s f4310000
>> 00000000:53
>> # ./mem -N -m -s 0xf4310000
>> ./mem: request seek to 4096851968, but -198115328 returned
>> F4310000:FF
>
> The first and last ones are on the right track.  The program uses strtoul()
> to convert the address.  That function assumes decimal unless there's a
> "0x" prefix.  So "-s f4300000" converts to zero, and "-s 0xf4300000" does
> what you want.
>
> The device is at [mem 0xf4300000-0xf4303fff], so anything in that region
> should respond.  Why don't you try this, which should dump the whole
> region:
>
>    ./mem -N -m -s 0xf4300000 -l 0x4000
>

http://pastebin.com/eHEsZNmU

> But what's interesting already is that you found these:
>
>    F4300000:00
>    F4310000:FF
>
> So we got 0x00 at 0xf4300000, which means the device did respond there.
> If that path to the device works, all PCI accesses to it *should* work.
>
> Bjorn
>
