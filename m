Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57987 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751302AbcBXADK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 23 Feb 2016 19:03:10 -0500
Date: Tue, 23 Feb 2016 18:03:06 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Harvey Partridge <harveyp@hotmail.fr>
Cc: linux-pci@vger.kernel.org
Subject: Re: PCI/USB 2.0 4 port hub fails to install under Ubuntu 12.04
Message-ID: <20160224000306.GA8482@localhost>
References: <loom.20160223T003705-325@post.gmane.org>
 <20160223142942.GA14394@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160223142942.GA14394@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[I'm replying to linux-pci so this will be archived and possibly
useful for others who search for similar issues]

On Tue, Feb 23, 2016 at 08:29:42AM -0600, Bjorn Helgaas wrote:
> Hi Harvey,
> 
> Thanks a lot for your report, and sorry you're having problems.
> 
> On Tue, Feb 23, 2016 at 12:06:54AM +0000, Harvey Partridge wrote:
> > Bonjour,
> > 
> > I have a very old Hewlett-Packard PC with Ubuntu 12.04. Recently my built-in
> > usb ports have become very flaky so I have bought a new low profile PCI
> > 4-port USB 2.0 hub (VIA Technologies, Inc.) which has failed to install.
> 
> This is a plug-in PCI card, right?
> 
> > Immediately apparent is the !!!error notice. I have spent several hours in
> > research with no success - I am obviously not doing it right!
> > 
> > Odd, too, that lspci and lshw only enumerate 3 ports on this card, whereas
> > there are 4.
> > 
> > Any help gratefully received. Failing direct help, I should appreciate some
> > pointers on how to start self-helping ... Ta! For example, I imagine it
> > would be useful to understand the error message!
> > 
> > I shall be glad to supply any further diagnostics - just tell me!
> > I am not a stranger to programming, but my major interests have been DBs
> > rather than hardware...
> > 
> > PCI/VEN_1106&DEV_303A&REV_61
> > 
> > lsusb does not find these ports
> > dmesg has no references to this card, that I can discover/recognise.
> > 
> > lspci -vvv -s 01:01
> > 
> > 01:01.0 Non-VGA unclassified device: VIA Technologies, Inc. Device 303a (rev 61)
> > Subsystem: Accelgraphics Inc. Device 0003
> > !!! Invalid class 0000 for header type 02
> > Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> > Stepping- SERR- FastB2B- DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
> > DEVSEL=medium >TAbort- SERR- Latency: 22
> > Interrupt: pin A routed to IRQ 0
> > Region 0: Memory at (32-bit, non-prefetchable) [disabled]
> > Bus: primary=00, secondary=00, subordinate=02, sec-latency=0
> > Memory window 0: 00020000-0002fce1 [disabled]
> > Memory window 1: 00020000-00020000 [disabled]
> > I/O window 0: 00001104-00000003 [disabled]
> > I/O window 1: 00000080-00000003 [disabled]
> > BridgeCtl: Parity- SERR+ ISA- VGA- MAbort- >Reset- 16bInt- PostWrite- 
> 
> This particular device looks like a bridge, not a USB controller.  Can
> you collect the complete "lspci -vvvxxx" output (as root) and the
> complete dmesg log?
> 
> The first step is to figure out whether the PCI core is enumerating
> the device.  If nothing else works, you could collect the dmesg log
> with the card removed, then again with the card installed, and diff
> the two.  The PCI core prints at least one line for each PCI device it
> finds.

With the card installed, your dmesg log shows the following new
devices:

  pci 0000:01:01.0: [1106:3038] type 0 class 0x000c03
  pci 0000:01:01.1: [1106:3038] type 0 class 0x000c03
  pci 0000:01:01.2: [1106:3104] type 0 class 0x000c03

But I think there's a hardware problem with your card or the bus it's
plugged into.  Look at the hex data:

  01:01.0 Non-VGA unclassified device: VIA Technologies, Inc. Device 303a
    00: 06 11 3a 30 04 00 12 02 61 00 03 0c 00 16 82 00
    10: 00 00 02 00 00 00 02 00 00 00 02 00 00 00 02 00
    20: e1 fc 02 00 00 00 02 00 00 00 02 00 06 11 3a 30
    30: 00 00 02 00 80 00 02 00 00 00 02 00 00 01 02 00
  01:01.1 Non-VGA unclassified device: VIA Technologies, Inc. Device 303a
    00: 06 11 3a 30 04 00 12 02 61 00 03 0c 00 16 82 00
    10: 00 00 02 00 00 00 02 00 00 00 02 00 00 00 02 00
    20: e1 fc 02 00 00 00 02 00 00 00 02 00 06 11 3a 30
    30: 00 00 02 00 80 00 02 00 00 00 02 00 00 02 02 00
  01:01.2 Non-VGA unclassified device: VIA Technologies, Inc.  VT6105/VT6106S
    00: 06 11 06 31 04 00 12 02 63 20 03 0c 00 16 82 00
    10: 00 00 02 00 00 00 02 00 00 00 02 00 00 00 02 00
    20: 00 00 02 00 00 00 02 00 00 00 02 00 06 11 06 31
    30: 00 00 02 00 80 00 02 00 00 00 02 00 00 03 02 00
               ^           ^           ^           ^

Bit 0x02 of every byte with low-order address bits of 0x2 is set.  I
think that wire on the bus is stuck.

Can you try a different copy of the same board?  Clean out the socket?
I'm guessing you don't have another copy of the motherboard to try.
But this sure looks like a hardware problem, not a software one.

Bjorn
