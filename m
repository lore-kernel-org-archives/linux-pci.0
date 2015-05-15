Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:33406 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934365AbbEOWLx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 May 2015 18:11:53 -0400
Received: by igbpi8 with SMTP id pi8so49930212igb.0
        for <linux-pci@vger.kernel.org>; Fri, 15 May 2015 15:11:52 -0700 (PDT)
Date: Fri, 15 May 2015 17:11:49 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Guenter Roeck <groeck@juniper.net>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: BAR 7 io space assignment errors
Message-ID: <20150515221149.GA31666@google.com>
References: <20150515172836.GA27797@svl-evodev-groeck.juniper.net>
 <CAErSpo5R0WF7J1OCagXNB2PcFUnNDB3LD6Q8A3pi=YYswzsaLw@mail.gmail.com>
 <20150515200422.GA29321@svl-evodev-groeck.juniper.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150515200422.GA29321@svl-evodev-groeck.juniper.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 15, 2015 at 01:04:22PM -0700, Guenter Roeck wrote:
> Hi Bjorn,
> 
> On Fri, May 15, 2015 at 02:25:34PM -0500, Bjorn Helgaas wrote:
> > [+cc Yinghai]
> > 
> > Hi Guenter,
> > 
> > On Fri, May 15, 2015 at 12:28 PM, Guenter Roeck <groeck@juniper.net> wrote:
> > > Hi all,
> > >
> > > ever since 3.18(ish), we see lots of pcie io range allocation error messages
> > > when booting our systems.
> > >
> > > pcieport 0000:02:00.0: res[7]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
> > > pcieport 0000:02:00.0: BAR 7: no space for [io  size 0x1000]
> > > pcieport 0000:02:00.0: BAR 7: failed to assign [io  size 0x1000]
> > >
> > > This is repeated for each port.
> > >
> > > What we atually _want_ is no IO address range, but so far I have not been able to
> > > tell this to the code (or to the bridge).
> > 
> > What information does the core have that we could use to figure out
> > that you want no I/O space?  For example, does the host bridge have no
> > I/O apertures?  Or are there no devices below 02:00.0 that require I/O
> > space?  If you can post a complete dmesg log, that should contain this
> > information.
> > 
> We know that we don't need IO space behind the bridge.
> 
> Question would be what information the core would need. I have tried
> to pre-program PCI_IO_BASE and PCI_IO_LIMIT on the bridge ports,
> but that doesn't seem to be the right solution (and it was just a
> wild shot anyway ;-).

The core tries to assign address space before drivers start claiming
devices because it's very difficult to move devices after drivers are
attached.  To avoid assigning I/O space to a bridge, the core would have to
know that (1) no devices below the bridge have I/O BARs, and (2) there's no
hotplug slot where a new device could be added below the bridge.

In your specific case, I suspect that you have hotplug bridges, but you
*know* exactly what devices can be "hot-plugged" and you know they don't
need I/O space.  But there's no good way to tell that to the PCI core.

> > Is the problem that some device doesn't work, or is it just extra
> > annoying messages.  We should fix something in either case, of course,
> > but it's more urgent if a device used to work but no longer does.
> > 
> Just the extra annoying messages. The messages below are just the beginning;
> there are many more when the actual devices behind the bridge ports come
> online.

This sounds like an interesting topology.  A device coming online later is
a hotplug event from the core's point of view.  Since the core can't tell
what a hot-added device is going to be, it allocates a default amount of
space (pci_hotplug_io_size) to accomodate it.  You can influence that with
the "pci=hpiosize=" boot parameter.  Maybe "pci=hpiosize=0" would help in
your case, but we'd still have the problem that the messages don't make
sense to the average user (including me).

  fsl-pci fff70a000.pcie: PCI host bridge to bus 0000:00
  pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
  pci 0000:00:00.0: PCI bridge to [bus 01-ff]      # Root Port
  pci 0000:00:00.0:   bridge window [io  0x0000-0x0fff]

The host bridge does have an I/O aperture, and it looks like firmware set
up the 00:00.0 bridge with a small piece of that.  That's sort of a waste:
supposedly we have 64K of I/O space available on bus 00, and 4K of that is
routed to [bus 01-ff].  The other 60K could be used by other devices on bus
00, but it doesn't look like there *are* any, so it is wasted.

  pci 0000:01:00.0: PCI bridge to [bus 02-ff]      # Upstream Port
  pci 0000:02:00.0: PCI bridge to [bus 40-4f]      # Downstream Port 0x0
  ...
  pci 0000:02:0d.0: PCI bridge to [bus a0-af]      # Downstream Port 0xa

  pci 0000:02:00.0: bridge window [io  0x1000-0x0fff] to [bus 40-4f] add_size 1000
  ...
  pci 0000:02:0d.0: bridge window [io  0x1000-0x0fff] to [bus a0-af] add_size 1000

I'm guessing these Downstream Ports all have "is_hotplug_bridge" set
because they have the "Hot-Plug Capable" bit set in their Slot Capabilities
register.  We're trying to allocate 0x1000 I/O ports for each, and there
are 0xb of them, so we'd need 0xb000 I/O ports at the 01:00.0 bridge:

  pci 0000:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-ff] add_size b000

pci_hotplug_io_size defaults to 256, but standard PCI bridges don't support
I/O windows smaller than 4K, so they all got rounded up to 4K (0x1000).

I would love it if somebody would clean up those messages and make them all
consistent.  There's useful information there, so I'm not sure we want to
get rid of them, but I think there's some redundancy we might be able to
fix.

Bjorn
