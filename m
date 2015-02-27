Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:39629 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751718AbbB0Aew (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Feb 2015 19:34:52 -0500
Received: by iecvy18 with SMTP id vy18so23453780iec.6
        for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2015 16:34:51 -0800 (PST)
Date: Thu, 26 Feb 2015 18:34:48 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Alnie <memobook80@comcast.net>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Takashi Iwai <tiwai@suse.de>
Subject: Re: PCI Issues with ExpressCard/54 Audio Device
Message-ID: <20150227003448.GH25765@google.com>
References: <1703881568.13072732.1424911985807.JavaMail.zimbra@comcast.net>
 <1602089933.13084034.1424913145538.JavaMail.zimbra@comcast.net>
 <CAErSpo6E5EMDUA8tHRZYF6rgfRqtHEZtG4EyVcMSRL02T3Ttyg@mail.gmail.com>
 <54EED7D2.7000205@comcast.net>
 <20150226174635.GA25765@google.com>
 <54EF74CF.7050909@comcast.net>
 <20150226231843.GC25765@google.com>
 <54EFB400.4000904@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54EFB400.4000904@comcast.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 26, 2015 at 04:02:08PM -0800, Alnie wrote:
> 
> 
> On 02/26/2015 03:18 PM, Bjorn Helgaas wrote:
> >On Thu, Feb 26, 2015 at 11:32:31AM -0800, Alnie wrote:
> >>On 02/26/2015 09:46 AM, Bjorn Helgaas wrote:
> >>>On Thu, Feb 26, 2015 at 12:22:42AM -0800, Alnie wrote:
> >
> >>>>	Capabilities: [100 v1] Advanced Error Reporting
> >>>>		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> >>>>MalfTLP- ECRC- UnsupReq+ ACSViol-
> >>>
> >>>This looks suspicious: the bridge logged an Unsupported Request error.
> >>>Let's see if we can figure out if this error is left there by BIOS or if
> >>>the PCI core or the driver or rdwrmem is doing something that causes it.
> >>>
> >>>Can you try this:
> >>>
> >>>   - Boot without the snd_hda_intel driver at all
> >>>   - Collect "lspci -vvs05:00.0" output
> >>
> >>blacklist snd_hda_intel
> >>
> >>05:00.0 PCI bridge: Creative Labs [SB X-Fi Xtreme Audio] CA0110-IBG
> >>PCI to PCIe Bridge (prog-if 00 [Normal decode])
> >>...
> >>	Capabilities: [100 v1] Advanced Error Reporting
> >>		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> >>MalfTLP- ECRC- UnsupReq+ ACSViol-
> >
> >All three of your lspci outputs are identical, so it looks like the BIOS
> >probably left UnsupReq set.  Maybe the kernel should log that and clear it
> >at boot.  I sort of doubt this is the problem, but we can try clearing
> >those errors manually:
> >
> >   lspci -vvs05:00.0
> 
> 05:00.0 PCI bridge: Creative Labs [SB X-Fi Xtreme Audio] CA0110-IBG
> PCI to PCIe Bridge (prog-if 00 [Normal decode])
> 	Physical Slot: 3
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Bus: primary=05, secondary=06, subordinate=0c, sec-latency=36
> 	Memory behind bridge: f4300000-f43fffff
> 	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort+ <SERR- <PERR-
> 	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
> 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> 	Capabilities: [50] Power Management version 3
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> 		Bridge: PM- B3+
> 	Capabilities: [60] MSI: Enable- Count=1/16 Maskable- 64bit+
> 		Address: 0000000000000000  Data: 0000
> 	Capabilities: [80] Subsystem: Creative Labs Device 0040
> 	Capabilities: [90] Express (v1) PCI-Express to PCI/PCI-X Bridge, MSI 00
> 		DevCap:	MaxPayload 512 bytes, PhantFunc 0
> 			ExtTag- AttnBtn- AttnInd- PwrInd- RBE-
> 		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> 			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+ BrConfRtry-
> 			MaxPayload 128 bytes, MaxReadReq 512 bytes
> 		DevSta:	CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
> 		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
> Latency L0s <512ns, L1 <16us
> 			ClockPM- Surprise- LLActRep- BwNot-
> 		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
> 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> 		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
> BWMgmt- ABWMgmt-
> 	Capabilities: [100 v1] Advanced Error Reporting
> 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq+ ACSViol-
> 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
> 		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
> 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> 		AERCap:	First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
> 
> 
> >   setpci -s05:00.0 0x9a.w=0x0a		# clear UncorrErr UnsuppReq
> >   setpci -s05:00.0 0x104.l=0x00100000	# clear AER UnsupReq
> >   lspci -vvs05:00.0
> 
> 05:00.0 PCI bridge: Creative Labs [SB X-Fi Xtreme Audio] CA0110-IBG
> PCI to PCIe Bridge (prog-if 00 [Normal decode])
> 	Physical Slot: 3
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Bus: primary=05, secondary=06, subordinate=0c, sec-latency=36
> 	Memory behind bridge: f4300000-f43fffff
> 	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort+ <SERR- <PERR-
> 	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
> 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> 	Capabilities: [50] Power Management version 3
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> 		Bridge: PM- B3+
> 	Capabilities: [60] MSI: Enable- Count=1/16 Maskable- 64bit+
> 		Address: 0000000000000000  Data: 0000
> 	Capabilities: [80] Subsystem: Creative Labs Device 0040
> 	Capabilities: [90] Express (v1) PCI-Express to PCI/PCI-X Bridge, MSI 00
> 		DevCap:	MaxPayload 512 bytes, PhantFunc 0
> 			ExtTag- AttnBtn- AttnInd- PwrInd- RBE-
> 		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> 			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+ BrConfRtry-
> 			MaxPayload 128 bytes, MaxReadReq 512 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
> 		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
> Latency L0s <512ns, L1 <16us
> 			ClockPM- Surprise- LLActRep- BwNot-
> 		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
> 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> 		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
> BWMgmt- ABWMgmt-
> 	Capabilities: [100 v1] Advanced Error Reporting
> 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
> 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
> 		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
> 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> 		AERCap:	First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
> 
> >   modprobe snd-hda-intel
> >
> 
> Same complaint comes up (no codecs found)

So it looks like the Unsupported Request error is unrelated to the problem
you're seeing.  Probably left over from something the BIOS did when it
enumerated devices.

You could look at "lspci -vv" again after clearing the errors and loading
the driver.  But I think it will be the same as it was after you manually
cleared the errors.

Oh, one more idea: *before* clearing the errors, can you collect
"lspci -xxxxs05:00.0" output?  That will give us more AER log registers,
and it's possible there's a clue there.  It's conceivable that we have
an MPS issue that causes the Unsupported Request error.

Just to be exhaustive, can you also stash the "lspci -vvv" output for the
entire system somewhere (again, before clearing the error).

> >The device is at [mem 0xf4300000-0xf4303fff], so anything in that region
> >should respond.  Why don't you try this, which should dump the whole
> >region:
> >
> >   ./mem -N -m -s 0xf4300000 -l 0x4000
> >
> 
> http://pastebin.com/eHEsZNmU

The data there looks fine, at least from a PCI perspective:

  F4300000:00 33 00 01 3C 00 1D 00 01 00 00 00 00 00 00 00
  F4300010:00 00 00 00 00 00 00 00 3C 00 1D 00 00 00 00 00
  F4300020:00 00 00 C0 00 00 00 00 00 00 00 00 00 00 00 00
  F4300030:0F FA 24 A8 00 00 00 00 00 00 00 00 00 00 00 00
  ...

That means the device itself seems happy and is responding to read
requests.

The only thing left I can think of to do is to instrument the driver and
see where it gets data that it doesn't expect.  So I'm going to punt this
back to you, Takashi :)  Don't hesitate to send it back to me if you find
something that looks like a PCI problem, but I don't see one yet.

Bjorn
