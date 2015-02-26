Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:35122 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753648AbbBZRqk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Feb 2015 12:46:40 -0500
Received: by iecrl12 with SMTP id rl12so18481232iec.2
        for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2015 09:46:39 -0800 (PST)
Date: Thu, 26 Feb 2015 11:46:35 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Alnie <memobook80@comcast.net>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Takashi Iwai <tiwai@suse.de>
Subject: Re: PCI Issues with ExpressCard/54 Audio Device
Message-ID: <20150226174635.GA25765@google.com>
References: <1703881568.13072732.1424911985807.JavaMail.zimbra@comcast.net>
 <1602089933.13084034.1424913145538.JavaMail.zimbra@comcast.net>
 <CAErSpo6E5EMDUA8tHRZYF6rgfRqtHEZtG4EyVcMSRL02T3Ttyg@mail.gmail.com>
 <54EED7D2.7000205@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54EED7D2.7000205@comcast.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 26, 2015 at 12:22:42AM -0800, Alnie wrote:

> I just compiled this but I'm a bit unfamiliar, sorry :( It is giving
> me "mmap error". Is this the what you are looking for?
> 
> ./mem -N -m -s 0xf4000000
> ./mem: request seek to 4093640704, but -201326592 returned

4093640704 (unsigned) = 0xf4000000, -201326592 (signed) = 0xf4000000,
so this might be OK.

> F4000000:FF

That's the sort of thing I was looking for, but the mmap error concerns me,
so I'm not confident that this tells us anything.  Also, we should look at
more of the space to make sure that we get 0xff when reading *anything* on
the device.

> 05:00.0 PCI bridge: Creative Labs [SB X-Fi Xtreme Audio] CA0110-IBG
> PCI to PCIe Bridge (prog-if 00 [Normal decode])

Interesting.  The description looks backwards -- this is a PCIe to PCI
bridge, not the other way around.  I posted a fix for that at
https://pci-ids.ucw.cz/read/PC/1102/7006?action=list

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

This looks suspicious: the bridge logged an Unsupported Request error.
Let's see if we can figure out if this error is left there by BIOS or if
the PCI core or the driver or rdwrmem is doing something that causes it.

Can you try this:

  - Boot without the snd_hda_intel driver at all
  - Collect "lspci -vvs05:00.0" output
  - Load snd_hda_intel
  - Collect "lspci -vvs05:00.0" output
  - Poke around with rdwr
  - Collect "lspci -vvs05:00.0" output

> 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
> 		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
> 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> 		AERCap:	First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
