Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:35626 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932200AbbERPzu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 18 May 2015 11:55:50 -0400
Received: by iesa3 with SMTP id a3so86996104ies.2
        for <linux-pci@vger.kernel.org>; Mon, 18 May 2015 08:55:50 -0700 (PDT)
Date: Mon, 18 May 2015 10:55:46 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Guenter Roeck <groeck@juniper.net>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: BAR 7 io space assignment errors
Message-ID: <20150518155546.GM31666@google.com>
References: <20150515172836.GA27797@svl-evodev-groeck.juniper.net>
 <CAErSpo5R0WF7J1OCagXNB2PcFUnNDB3LD6Q8A3pi=YYswzsaLw@mail.gmail.com>
 <20150515200422.GA29321@svl-evodev-groeck.juniper.net>
 <20150515221149.GA31666@google.com>
 <20150516022713.GA4417@svl-evodev-groeck.juniper.net>
 <20150516131209.GD31666@google.com>
 <20150516164151.GA2042@svl-evodev-groeck.juniper.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150516164151.GA2042@svl-evodev-groeck.juniper.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, May 16, 2015 at 09:41:51AM -0700, Guenter Roeck wrote:
> Hi Bjorn,
> 
> On Sat, May 16, 2015 at 08:12:09AM -0500, Bjorn Helgaas wrote:
> > > The problem is that I can not reprogram PCI_IO_BASE on 0000:00:00.0.
> > > Here is a debug log:
> > > 
> > > pci 0000:00:00.0: io base written 0xe0f0 reads back as 0x0
> > > pci 0000:00:00.0: io base written 0xf000 reads back as 0x0
> > 
> > That's odd; that's a non-conformant bridge.  Per spec (PCI-to-PCI Bridge
> > r1.2, sec 3.2.5.6), for a bridge that implements an I/O address range, the
> > upper four bits of I/O Base is writable.
> > 
> > But I suspect this bridge is discovered via OF and there's something broken
> > about how config access is done.  That's arch code and I don't know much
> > about it.
> > 
> Maybe. I'll dig into it some more.
> 
> > Or maybe the hardware itself is not quite spec-compliant, although it would
> > be strange to have I/O aperture addresses hard-wired into the hardware.  
> > 
> This is a Freesale P2020. We should have the specification somewhere.
> Guess it may be time for some digging in there.

Hmm, I spoke too fast above.  I assumed that we checked whether the
bridge actually implements an I/O aperture, but pci_read_bridge_io()
doesn't do that.  On a bridge that doesn't implement an I/O range, both I/O
Base and I/O Limit must be read-only zeroes.  But pci_read_bridge_io()
doesn't test whether they are writable, so it treats that situation as an
enabled [io 0x0000-0x0fff] window.

pci_bridge_check_ranges() *does* check for writability, but it might be
too late to make a difference in this case.  I would like to get rid of 
pci_bridge_check_ranges() anyway; it seems like whatever it does should be
folded into pci_read_bridge_io() and pci_read_bridge_mmio_pref().

Bottom line, 

1) I don't know whether your bridge actually implements an I/O aperture,
and 2) I think pci_read_bridge_io() should check for writability.

> > > The io ranges of ports behind it (ie the ones below) are programmable.
> > > I can try to find out if there is a means to program the io range
> > > on 0000:00:00.0, but I would prefer to just disable the io range
> > > fpci_bridge_check_rangesor
> > > everything downstream of it.
> > 
> > As far as I can tell, you don't need any I/O port space anywhere in this
> > hierarchy.  If you could disable this host bridge I/O aperture:
> > 
> >   PCI host bridge /pcie@a000 (primary) ranges:
> >     IO 0x0000000fffc00000..0x0000000fffc0ffff -> 0x0000000000000000
> > 
> > e.g., remove it from the OF description of the bridge, the core could know
> > that it needn't bother trying to assign I/O space.  It might not be smart
> > enough to notice that today, but it would at least be possible in
> > principle.
> > 
> I tried this. Unfortunately, the PCI core code still tries to assign
> the IO space to all ports downstream of it, and I end up with the same
> problem, ie lots of BAR 7 messages.

Yep, sounds like the core isn't smart enough to notice that.  But it
*could* and probably should be.

> PCI host bridge /pcie@a000 (primary) ranges:
>  MEM 0x0000000c00000000..0x0000000c3fffffff -> 0x0000000080000000 
> ...
> pci 0000:00:00.0: PCI bridge to [bus 01-ff]
> pci 0000:00:00.0:   bridge window [io  0x0000-0x0fff]
> pci 0000:00:00.0:   bridge window [mem 0xc00000000-0xc3fffffff]
> pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
> 
> Partially this is because pci_read_bridge_io() doesn't care if IO is supported
> or not - it reads 0x0 from the IO_BASE/IO_LIMIT register and interprets it as 
> 0x0000-0x0fff range. Even if I change pci_read_bridge_io() to not add an io
> range if base == limit == 0, the result is not much better. Then I get
> 
> pci 0000:00:00.0: PCI bridge to [bus 01-ff]
> pci 0000:00:00.0:   bridge window [mem 0xc00000000-0xc3fffffff]
> pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
> 
> and no BAR 7 message for the root port, but still for all other ports.

Right.  All the other bridges (01:00.0, 02:00.0, etc.) have a non-zero I/O
Base, so they clearly implement I/O apertures.  We should make the core
smart enough to stop trying to assign I/O space when there's none
available.

We just have to figure out the best way to do that.  If we find a bridge
(either host bridge or PCI-PCI bridge) that doesn't implement an I/O
aperture, we should be able to just ignore I/O space below it.  If we find
one with a disabled aperture, we probably want to size the downstream
devices and potentially enable the aperture.

Bjorn
