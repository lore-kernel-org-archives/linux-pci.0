Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:34573 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155AbbEPNMN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 16 May 2015 09:12:13 -0400
Received: by ieczm2 with SMTP id zm2so69479090iec.1
        for <linux-pci@vger.kernel.org>; Sat, 16 May 2015 06:12:12 -0700 (PDT)
Date: Sat, 16 May 2015 08:12:09 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Guenter Roeck <groeck@juniper.net>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: BAR 7 io space assignment errors
Message-ID: <20150516131209.GD31666@google.com>
References: <20150515172836.GA27797@svl-evodev-groeck.juniper.net>
 <CAErSpo5R0WF7J1OCagXNB2PcFUnNDB3LD6Q8A3pi=YYswzsaLw@mail.gmail.com>
 <20150515200422.GA29321@svl-evodev-groeck.juniper.net>
 <20150515221149.GA31666@google.com>
 <20150516022713.GA4417@svl-evodev-groeck.juniper.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150516022713.GA4417@svl-evodev-groeck.juniper.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 15, 2015 at 07:27:13PM -0700, Guenter Roeck wrote:
> On Fri, May 15, 2015 at 05:11:49PM -0500, Bjorn Helgaas wrote:
> > This sounds like an interesting topology.  A device coming online later is
> > a hotplug event from the core's point of view.  Since the core can't tell
> > what a hot-added device is going to be, it allocates a default amount of
> > space (pci_hotplug_io_size) to accomodate it.  You can influence that with
> > the "pci=hpiosize=" boot parameter.  Maybe "pci=hpiosize=0" would help in
> > your case, but we'd still have the problem that the messages don't make
> > sense to the average user (including me).
> > 
> Also, I don't really want to specify lots of boot parameters if I can avoid it.

Yes, I agree completely.  I hate boot parameters.

> >   fsl-pci fff70a000.pcie: PCI host bridge to bus 0000:00
> >   pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
> >   pci 0000:00:00.0: PCI bridge to [bus 01-ff]      # Root Port
> >   pci 0000:00:00.0:   bridge window [io  0x0000-0x0fff]
> > 
> > The host bridge does have an I/O aperture, and it looks like firmware set
> > up the 00:00.0 bridge with a small piece of that.  That's sort of a waste:
> > supposedly we have 64K of I/O space available on bus 00, and 4K of that is
> > routed to [bus 01-ff].  The other 60K could be used by other devices on bus
> > 00, but it doesn't look like there *are* any, so it is wasted.
> > 
> The problem is that I can not reprogram PCI_IO_BASE on 0000:00:00.0.
> Here is a debug log:
> 
> pci 0000:00:00.0: io base written 0xe0f0 reads back as 0x0
> pci 0000:00:00.0: io base written 0xf000 reads back as 0x0

That's odd; that's a non-conformant bridge.  Per spec (PCI-to-PCI Bridge
r1.2, sec 3.2.5.6), for a bridge that implements an I/O address range, the
upper four bits of I/O Base is writable.

But I suspect this bridge is discovered via OF and there's something broken
about how config access is done.  That's arch code and I don't know much
about it.

Or maybe the hardware itself is not quite spec-compliant, although it would
be strange to have I/O aperture addresses hard-wired into the hardware.  

> The io ranges of ports behind it (ie the ones below) are programmable.
> I can try to find out if there is a means to program the io range
> on 0000:00:00.0, but I would prefer to just disable the io range for
> everything downstream of it.

As far as I can tell, you don't need any I/O port space anywhere in this
hierarchy.  If you could disable this host bridge I/O aperture:

  PCI host bridge /pcie@a000 (primary) ranges:
    IO 0x0000000fffc00000..0x0000000fffc0ffff -> 0x0000000000000000

e.g., remove it from the OF description of the bridge, the core could know
that it needn't bother trying to assign I/O space.  It might not be smart
enough to notice that today, but it would at least be possible in
principle.

> "bridge window [io  0x1000-0x0fff]" for sure looks odd. Maybe it means
> something to you, but for me it is just confusing.

"The I/O Limit register can be programmed to a smaller value than the I/O
Base register, if there are no I/O addresses on the secondary side of the
bridge."  So this would ordinarily mean the I/O window is disabled.  But I
agree, this is a confusing way to say it.

Bjorn
