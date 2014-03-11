Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:61736 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753851AbaCKQyT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Mar 2014 12:54:19 -0400
Received: by mail-ie0-f169.google.com with SMTP id to1so9246832ieb.28
        for <linux-pci@vger.kernel.org>; Tue, 11 Mar 2014 09:54:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4fac9f912ff743309e959000c78b4e32@DM2PR05MB671.namprd05.prod.outlook.com>
References: <e1766e5c6aec48a588975c07fc00935d@DM2PR05MB671.namprd05.prod.outlook.com>
 <CAErSpo5DuFNQ3msknhO=m+chRAnt26FOZHkWAuyS-TaO78vcfA@mail.gmail.com> <4fac9f912ff743309e959000c78b4e32@DM2PR05MB671.namprd05.prod.outlook.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 11 Mar 2014 10:53:58 -0600
Message-ID: <CAErSpo5L5ox0DyHdvNhBhD8st4monK8HSqusaJQ4dDXH2T+=gg@mail.gmail.com>
Subject: Re: Faking a PCI interrupt
To: Rajat Jain <rajatjain@juniper.net>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Guenter Roeck <groeck@juniper.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 10, 2014 at 10:24 PM, Rajat Jain <rajatjain@juniper.net> wrote:
> Hello Bjorn,
>
>> >
>> > I have a broken PCI bridge (PCIe downstream port), that is not raising
>> interrupts at certain conditions.
>> >
>> > I'm trying to fool the driver into believing that the device is
>> actually sending interrupts by having a quirk that:
>> >
>> > 1) Polls the device register to monitor the interrupt condition.
>> >
>> > 2) When a condition is determined that needs an interrupt - calls the
>> driver's ISR method.
>> >
>> > My question - Instead of directly calling the ISR, is there a way my
>> quirk can fake an interrupt being generated, through the PCI subsystem?
>> That way, my quirk does not have to be a part of the (generic) PCI
>> driver.
>> >
>> > PCI bridge: Integrated Device Technology, Inc. PES12NT3 PCI Express
>> > Switch (rev 01) (prog-if 00 [Normal decode])
>> > Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>> > Stepping- SERR- FastB2B- DisINTx-
>> > Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
>> > <TAbort- <MAbort- >SERR- <PERR- INTx-
>> > Latency: 0
>> > Bus: primary=11, secondary=13, subordinate=13, sec-latency=0 I/O
>> > behind bridge: 0000f000-00000fff Memory behind bridge:
>> > 80000000-80ffffff Prefetchable memory behind bridge:
>> > 00000000fff00000-00000000000fffff Secondary status: 66MHz- FastB2B-
>> > ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
>> > BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>> >         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>> > Capabilities: [40] Express (v1) Downstream Port (Slot-), MSI 00
>> >         DevCap: MaxPayload 2048 bytes, PhantFunc 0, Latency L0s <64ns,
>> L1 <1us
>> >                 ExtTag+ RBE- FLReset-
>> >         DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
>> Unsupported-
>> >                 RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>> >                 MaxPayload 128 bytes, MaxReadReq 128 bytes
>> >         DevSta: CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr-
>> TransPend-
>> >         LnkCap: Port #1, Speed 2.5GT/s, Width x4, ASPM L0s L1, Latency
>> L0 <2us, L1 <4us
>> >                 ClockPM- Surprise- LLActRep- BwNot-
>> >         LnkCtl: ASPM Disabled; Disabled- Retrain- CommClk-
>> >                 ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>> >         LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk-
>> > DLActive- BWMgmt- ABWMgmt-
>> > Capabilities: [70] Power Management version 2
>> >         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-
>> ,D3hot+,D3cold+)
>> >         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>> > Capabilities: [100 v1] Virtual Channel
>> >         Caps:   LPEVC=0 RefClk=100ns PATEntryBits=2
>> >         Arb:    Fixed- WRR32- WRR64- WRR128-
>> >         Ctrl:   ArbSelect=Fixed
>> >         Status: InProgress-
>> >         VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>> >                 Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
>> >                 Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
>> >                 Status: NegoPending- InProgress- Kernel driver in use:
>> > pcieport
>>
>> Huh.  What interrupt are you expecting from it?  I don't see any
>> "interrupt enable" bits in your lspci (though I didn't go through
>> everything in detail).
>>
>> Or are you expecting an interrupt from a device below this bridge, and
>> that interrupt isn't getting passed through the bridge?
>
> Actually this is the hot-plug interrupt (link change notification from the bridge itself) that I'm trying to fake.
>
> This is an old PCIe switch on an existing shipping hardware. This switch does not support the Link status reporting ("LLActRep-" in lspci). Rather it has proprietary registers to determine link status, but no interrupt associated with change in that link status. I'm trying to make the pciehp believe that this bridge supports link state reporting by using a quirk to:
>
> 1) Override the config space access routines (using pci_bus_set_ops()) for this bridge so as to override values of link status / link ctrl / link capabilities with desired values etc.
>
> 2) Somehow generate an interrupt whenever the proprietary registers indicate link state changed. Currently I call pcie_isr directly (thus requiring the quirk to be a part of pciehp). But I'm trying to separate out the quirk into a platform specific code, out of pci subsystem.
>
> I know one of the options is to use the pciehp in polling mode, but that changes the mode for all the ports, not just a specific one.

Your quirk could set up a kernel thread for the device that does the
polling.  Then you'd have to figure out how to inject an interrupt
when necessary.  I don't think there's a PCI facility for that, but
there might be a generic way to signal an IRQ.

Or maybe it would be possible to enhance the pciehp polling mode to
work on a per-device basis, based on a bit set by a quirk.

> PS: The pciehp driver was not loaded and hence you do not see any interrupts enabled in the lspci output.

My question was more about what interrupts possibly *could* be
enabled.  Purely from a spec point of view, that is a function of what
the capability and control registers indicate, so it shouldn't depend
on whether a driver is loaded or not.  (It *would* depend on whether
your quirk has run and you've turned on this emulation stuff.)

Your device doesn't report that it supports a slot, so we assume
there's no Slot Control register, where we could enable interrupts for
attention button, power fault, presence detect, etc.  It does have
Link registers, but it doesn't claim to support interrupts for data
link layer active reporting, link bandwidth notification, etc.

It sounds like this bridge really doesn't look much like a standard
pciehp bridge.  Maybe it would make more sense to write a new hotplug
driver for it.  All of the signalling and bridge control stuff sounds
different.  Some of the backend logic for enumerating and removing PCI
devices would probably be duplicated, and that's an area where I think
we have a lot of room for improvement.  Even the existing drivers have
a lot of duplicated and almost-duplicated code there, and it would be
nice to refactor that.

Bjorn
