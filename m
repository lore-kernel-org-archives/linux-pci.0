Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:55545 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754397AbaBTIz1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 20 Feb 2014 03:55:27 -0500
Date: Thu, 20 Feb 2014 09:55:18 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gerlando Falauto <gerlando.falauto@keymile.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Jason Cooper <jason@lakedaemon.net>,
	"Longchamp, Valentin" <Valentin.Longchamp@keymile.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: pci-mvebu driver on km_kirkwood
Message-ID: <20140220095518.7ca36f0a@skate>
In-Reply-To: <CAErSpo4=6VgJazaErcx=ztKhZ_62xBrQ6K1eN_dVpvV4R0T2ag@mail.gmail.com>
References: <51DD88A4.1030506@keymile.com>
	<20130710185706.72b124a4@skate>
	<51DD9A8C.10608@keymile.com>
	<20130711163220.2b3adf38@skate>
	<53039894.10905@keymile.com>
	<20140218212751.07c2aeb5@skate>
	<53046D98.6020801@keymile.com>
	<20140219102658.76eec91e@skate>
	<53047BBB.6040108@keymile.com>
	<20140219143749.65ff3155@skate>
	<CAErSpo4=6VgJazaErcx=ztKhZ_62xBrQ6K1eN_dVpvV4R0T2ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Bjorn Helgaas,

+ Jason Gunthorpe.

On Wed, 19 Feb 2014 14:45:48 -0700, Bjorn Helgaas wrote:

> > Cool. However, I am not sure my fix is really correct, because is you
> > had another PCIe device that needed 64 MB of memory space, the PCIe
> > core would have allocated addresses 0xec000000 -> 0xf0000000 to it,
> > which would have conflicted with the forced "power of 2 up-rounding"
> > we've applied on the memory space of the first device.
> >
> > Therefore, I believe this constraint should be taken into account by
> > the PCIe core when allocating the different memory regions for each
> > device.
> >
> > Bjorn, the mvebu PCIe host driver has the constraint that the I/O and
> > memory regions associated to each PCIe device of the emulated bridge
> > have a size that is a power of 2.
> >
> > I am currently using the ->align_resource() hook to ensure that the
> > start address of the resource matches certain other constraints, but I
> > don't see a way of telling the PCI core that I need the resource to
> > have its size rounded up to the next power of 2 size. Is there a way of
> > doing this?
> >
> > In the case described by Gerlando, the PCI core has assigned a 192 MB
> > region, but the Marvell hardware can only create windows that have a
> > power of two size, i.e 256 MB. Therefore, the PCI core should be told
> > this constraint, so that it doesn't allocate the next resource right
> > after the 192 MB one.
> 
> I'm not sure I understand this correctly, but I *think* this 192 MB
> region that gets rounded up to 256 MB because of the Marvell
> constraint is a host bridge aperture.  If that's the case, it's
> entirely up to you (the host bridge driver author) to round it as
> needed before passing it to pci_add_resource_offset().
> 
> The PCI core will never allocate any space that is outside the host
> bridge apertures.

Hum, I believe there is a misunderstanding here. We are already using
pci_add_resource_offset() to define the global aperture for the entire
PCI bridge. This is not causing any problem.

Let me give a little bit of background first.

On Marvell hardware, the physical address space layout is configurable,
through the use of "MBus windows". A "MBus window" is defined by a base
address, a size, and a target device. So if the CPU needs to access a
given device (such as PCIe 0.0 for example), then we need to create a
"MBus window" whose size and target device match PCIe 0.0.

Since Armada XP has 10 PCIe interfaces, we cannot just statically
create as many MBus windows as there are PCIe interfaces: it would both
exhaust the number of MBus windows available, and also exhaust the
physical address space, because we would have to create very large
windows, just in case the PCIe device plugged behind this interface
needs large BARs.

So, what the pci-mvebu.c driver does is that it creates an emulated PCI
bridge. This emulated bridge is used to let the Linux PCI core
enumerate the real physical PCI devices behind the bridge, allocate a
range of physical addresses that is available for each of these
devices, and write them to the bridge registers. Since the bridge is
not a real one, but emulated, but trap those writes, and use them to
create the MBus windows that will allow the CPU to actually access the
device, at the base address chosen by the Linux PCI core during the
enumeration process.

However, MBus windows have a certain constraint that they must have a
power of two size, so the Linux PCI core should not write to one of the
bridge PCI_MEMORY_BASE / PCI_MEMORY_LIMIT registers any range of
address whose size is not a power of 2.

Let me take the example of Gerlando:

pci 0000:01:00.0: BAR 1: assigned [mem 0xe0000000-0xe7ffffff]
pci 0000:01:00.0: BAR 3: assigned [mem 0xe8000000-0xe87fffff]
pci 0000:01:00.0: BAR 4: assigned [mem 0xe8800000-0xe8801fff]
pci 0000:01:00.0: BAR 0: assigned [mem 0xe8802000-0xe8802fff]
pci 0000:01:00.0: BAR 2: assigned [mem 0xe8803000-0xe8803fff]
pci 0000:01:00.0: BAR 5: assigned [mem 0xe8804000-0xe8804fff]
pci 0000:00:01.0: PCI bridge to [bus 01]
pci 0000:00:01.0:   bridge window [mem 0xe0000000-0xebffffff]

So, pci 0000:01:00 is the real device, which has a number of BARs of a
certain size. Taking into account all those BARs, the Linux PCI core
decides to assign [mem 0xe0000000-0xebffffff] to the bridge (last line
of the log above). The problem is that [mem 0xe0000000-0xebffffff] is
192 MB, but we would like the Linux PCI core to extend that to 256 MB.

As you can see it is not about the global aperture associated to the
bridge, but about the size of the window associated to each "port" of
the bridge.

Does that make sense? Keep in mind that I'm still not completely
familiar with the PCI terminology, so maybe the above explanation does
not use the right terms.

Thanks for your feedback,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
