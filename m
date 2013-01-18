Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:42931 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755340Ab3ARXPW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 Jan 2013 18:15:22 -0500
Received: by mail-ob0-f182.google.com with SMTP id 16so4238405obc.27
        for <linux-pci@vger.kernel.org>; Fri, 18 Jan 2013 15:15:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1301181449440.31163@jlaw-desktop.mno.stratus.com>
References: <alpine.DEB.2.02.1301181302260.31163@jlaw-desktop.mno.stratus.com>
	<CAL-B5D0+6uO7WDYR7inmZKdU0h8-bpkOs_CzbF0bD2b9i6=1ZA@mail.gmail.com>
	<alpine.DEB.2.02.1301181449440.31163@jlaw-desktop.mno.stratus.com>
Date: Fri, 18 Jan 2013 16:15:21 -0700
Message-ID: <CAL-B5D2-=x+Y-f9x+QyX+3j3F=CbfY6mRGE6mnmvuhM-zMKGnw@mail.gmail.com>
Subject: Re: PCIe ASPM crash on device removal
From: Myron Stowe <myron.stowe@gmail.com>
To: Joe Lawrence <Joe.Lawrence@stratus.com>
Cc: linux-pci <linux-pci@vger.kernel.org>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Myron Stowe <mstowe@redhat.com>,
	David Bulkow <david.bulkow@stratus.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 18, 2013 at 12:53 PM, Joe Lawrence <Joe.Lawrence@stratus.com> wrote:
> On Fri, 18 Jan 2013, Myron Stowe wrote:
>
>> On Fri, Jan 18, 2013 at 11:22 AM, Joe Lawrence <Joe.Lawrence@stratus.com>wrote:
>>
>> > The Stratus PCI topology includes a branch that looks like:
>> >
>> > ... -00.0-[03-3c]----00.0-[04-2d]--+- ...
>> >                                    |
>> >                                    \-01.0-[2c-2d]--+-00.0
>> >                                                    +-00.1
>> >                                                    \-1f.0
>> >
>> > This is an interesting topology.  The switch contains an Express capable
>> downstream port - 04:01.0 - leading to PCI (non-Express) devices (2c:00.0,
>> 2c:00.1, and 2c:1f.0).  Would Express links even be used in this topology?
>> I'm guessing not, which brings up the question: why would ASPM be inserting
>> link state structures into its link_list for such a topology?  Seems like
>> the proper thing to do is change the code in the beginning of
>> pcie_aspm_init_link_state, or pcie_aspm_sanity_check() with some
>> re-factoring, to short-circuit out and do nothing (even when ASPM is
>> enabled in the kernel).
>>
>> Could you supply an "lspci -xxx -vvs 04:01.0?  It would be interesting to
>> see what the "express capabilities" LnkCap indicates with respect to its
>> ASPM bits (11:10 Active State Power Management (ASPM) Support bits).
>>
>> Myron
>
> Hi Myron,
>
> See lspci output below (hopefully won't be word wrap mangled)
>
> -- Joe
>
>
> 04:01.0 PCI bridge: Device 1bcf:0009 (rev 01) (prog-if 00 [Normal decode])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0, Cache Line Size: 64 bytes
>         Bus: primary=04, secondary=2c, subordinate=2d, sec-latency=0
>         I/O behind bridge: 00005000-00005fff
>         Memory behind bridge: 90000000-92ffffff
>         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
>         BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>         Capabilities: [b0] Express (v2) Downstream Port (Slot-), MSI 00
>                 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
>                         ExtTag- RBE- FLReset-
>                 DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
>                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
>                         MaxPayload 256 bytes, MaxReadReq 512 bytes
>                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
>                 LnkCap: Port #1, Speed 5GT/s, Width x4, ASPM L1, Latency L0 unlimited, L1 <1us
>                         ClockPM- Surprise- LLActRep- BwNot-
>                 LnkCtl: ASPM Disabled; Disabled- Retrain- CommClk-
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>                 DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF Not Supported ARIFwd-
>                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
>                 LnkCtl2: Target Link Speed: Unknown, EnterCompliance+ SpeedDis-, Selectable De-emphasis: -6dB
>                          Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS+
>                          Compliance De-emphasis: -6dB
>                 LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
>                          EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
>         Capabilities: [ec] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [100 v1] Advanced Error Reporting
>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UESvrt: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
>                 AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
>         Kernel driver in use: pcieport
> 00: cf 1b 09 00 07 00 10 00 01 00 04 06 10 00 01 00
> 10: 00 00 00 00 00 00 00 00 04 2c 2d 00 51 51 00 00
> 20: 00 90 f0 92 f1 ff 01 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 b0 00 00 00 00 00 00 00 0b 01 00 00
> 40: 00 01 00 00 10 00 00 00 0a 00 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 10 ec 62 00 01 00 00 00 3f 28 00 00 42 78 00 01
> c0: 00 00 41 10 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 1f 08 01 00 00 00 00 00 00 00 00 00 01 00 02 c8
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>

Joe:

Thanks for the data.  So the downstream port of interest has ASPM link
capability but it's currently not enabled - see LnkCap and LnkCtl
above.

I'm still do not understand if PCI Express links would even be
involved in a topology where all the devices connected below the
downstream port are PCI and not PCI Express.  Seems as if the ASPM
code is going to a lot of work to put link state structures in place
for all these devices that would not be capable of supporting ASPM.

I'm still trying to come up to speed understanding ASPM so hopefully
someone knowledgeable can help clue me in.

Myron
