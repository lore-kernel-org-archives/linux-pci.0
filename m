Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:39946 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753584AbaCKCZV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Mar 2014 22:25:21 -0400
Received: by mail-ie0-f179.google.com with SMTP id lx4so8273277iec.38
        for <linux-pci@vger.kernel.org>; Mon, 10 Mar 2014 19:25:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e1766e5c6aec48a588975c07fc00935d@DM2PR05MB671.namprd05.prod.outlook.com>
References: <e1766e5c6aec48a588975c07fc00935d@DM2PR05MB671.namprd05.prod.outlook.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 10 Mar 2014 20:25:00 -0600
Message-ID: <CAErSpo5DuFNQ3msknhO=m+chRAnt26FOZHkWAuyS-TaO78vcfA@mail.gmail.com>
Subject: Re: Faking a PCI interrupt
To: Rajat Jain <rajatjain@juniper.net>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Guenter Roeck <groeck@juniper.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 10, 2014 at 4:04 PM, Rajat Jain <rajatjain@juniper.net> wrote:
> Hello,
>
> I have a broken PCI bridge (PCIe downstream port), that is not raising interrupts at certain conditions.
>
> I'm trying to fool the driver into believing that the device is actually sending interrupts by having a quirk that:
>
> 1) Polls the device register to monitor the interrupt condition.
>
> 2) When a condition is determined that needs an interrupt - calls the driver's ISR method.
>
> My question - Instead of directly calling the ISR, is there a way my quirk can fake an interrupt being generated, through the PCI subsystem? That way, my quirk does not have to be a part of the (generic) PCI driver.
>
> PCI bridge: Integrated Device Technology, Inc. PES12NT3 PCI Express Switch (rev 01) (prog-if 00 [Normal decode])
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Bus: primary=11, secondary=13, subordinate=13, sec-latency=0
> I/O behind bridge: 0000f000-00000fff
> Memory behind bridge: 80000000-80ffffff
> Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
> Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> Capabilities: [40] Express (v1) Downstream Port (Slot-), MSI 00
>         DevCap: MaxPayload 2048 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
>                 ExtTag+ RBE- FLReset-
>         DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>                 RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                 MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta: CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
>         LnkCap: Port #1, Speed 2.5GT/s, Width x4, ASPM L0s L1, Latency L0 <2us, L1 <4us
>                 ClockPM- Surprise- LLActRep- BwNot-
>         LnkCtl: ASPM Disabled; Disabled- Retrain- CommClk-
>                 ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
> Capabilities: [70] Power Management version 2
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [100 v1] Virtual Channel
>         Caps:   LPEVC=0 RefClk=100ns PATEntryBits=2
>         Arb:    Fixed- WRR32- WRR64- WRR128-
>         Ctrl:   ArbSelect=Fixed
>         Status: InProgress-
>         VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>                 Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
>                 Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
>                 Status: NegoPending- InProgress-
> Kernel driver in use: pcieport

Huh.  What interrupt are you expecting from it?  I don't see any
"interrupt enable" bits in your lspci (though I didn't go through
everything in detail).

Or are you expecting an interrupt from a device below this bridge, and
that interrupt isn't getting passed through the bridge?

Bjorn
