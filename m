Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:41206 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754253AbaBTTTD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 20 Feb 2014 14:19:03 -0500
Received: by mail-ie0-f180.google.com with SMTP id ar20so1590047iec.39
        for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2014 11:19:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20140220095518.7ca36f0a@skate>
References: <51DD88A4.1030506@keymile.com> <20130710185706.72b124a4@skate>
 <51DD9A8C.10608@keymile.com> <20130711163220.2b3adf38@skate>
 <53039894.10905@keymile.com> <20140218212751.07c2aeb5@skate>
 <53046D98.6020801@keymile.com> <20140219102658.76eec91e@skate>
 <53047BBB.6040108@keymile.com> <20140219143749.65ff3155@skate>
 <CAErSpo4=6VgJazaErcx=ztKhZ_62xBrQ6K1eN_dVpvV4R0T2ag@mail.gmail.com> <20140220095518.7ca36f0a@skate>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 20 Feb 2014 12:18:42 -0700
Message-ID: <CAErSpo5pG3eOG58MiCCOHgr_jQReH0uBnWQFvzQYg3qrOGpZEw@mail.gmail.com>
Subject: Re: pci-mvebu driver on km_kirkwood
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
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
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 20, 2014 at 1:55 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Dear Bjorn Helgaas,
>
> + Jason Gunthorpe.
>
> On Wed, 19 Feb 2014 14:45:48 -0700, Bjorn Helgaas wrote:
>
>> > Cool. However, I am not sure my fix is really correct, because is you
>> > had another PCIe device that needed 64 MB of memory space, the PCIe
>> > core would have allocated addresses 0xec000000 -> 0xf0000000 to it,
>> > which would have conflicted with the forced "power of 2 up-rounding"
>> > we've applied on the memory space of the first device.
>> >
>> > Therefore, I believe this constraint should be taken into account by
>> > the PCIe core when allocating the different memory regions for each
>> > device.
>> >
>> > Bjorn, the mvebu PCIe host driver has the constraint that the I/O and
>> > memory regions associated to each PCIe device of the emulated bridge
>> > have a size that is a power of 2.
>> >
>> > I am currently using the ->align_resource() hook to ensure that the
>> > start address of the resource matches certain other constraints, but I
>> > don't see a way of telling the PCI core that I need the resource to
>> > have its size rounded up to the next power of 2 size. Is there a way of
>> > doing this?
>> >
>> > In the case described by Gerlando, the PCI core has assigned a 192 MB
>> > region, but the Marvell hardware can only create windows that have a
>> > power of two size, i.e 256 MB. Therefore, the PCI core should be told
>> > this constraint, so that it doesn't allocate the next resource right
>> > after the 192 MB one.
>>
>> I'm not sure I understand this correctly, but I *think* this 192 MB
>> region that gets rounded up to 256 MB because of the Marvell
>> constraint is a host bridge aperture.  If that's the case, it's
>> entirely up to you (the host bridge driver author) to round it as
>> needed before passing it to pci_add_resource_offset().
>>
>> The PCI core will never allocate any space that is outside the host
>> bridge apertures.
>
> Hum, I believe there is a misunderstanding here. We are already using
> pci_add_resource_offset() to define the global aperture for the entire
> PCI bridge. This is not causing any problem.
>
> Let me give a little bit of background first.
>
> On Marvell hardware, the physical address space layout is configurable,
> through the use of "MBus windows". A "MBus window" is defined by a base
> address, a size, and a target device. So if the CPU needs to access a
> given device (such as PCIe 0.0 for example), then we need to create a
> "MBus window" whose size and target device match PCIe 0.0.

I was assuming "PCIe 0.0" was a host bridge, but it sounds like maybe
that's not true.  Is it really a PCIe root port?  That would mean the
MBus windows are some non-PCIe-compliant thing between the root
complex and the root ports, I guess.

> Since Armada XP has 10 PCIe interfaces, we cannot just statically
> create as many MBus windows as there are PCIe interfaces: it would both
> exhaust the number of MBus windows available, and also exhaust the
> physical address space, because we would have to create very large
> windows, just in case the PCIe device plugged behind this interface
> needs large BARs.

Everybody else in the world *does* statically configure host bridge
apertures before enumerating the devices below the bridge.  I see why
you want to know what devices are there before deciding whether and
how large to make an MBus window.  But that is new functionality that
we don't have today, and the general idea is not Marvell-specific, so
other systems might want something like this, too.  So I'm not sure if
using quirks to try to wedge it into the current PCI core is the right
approach.  I don't have another proposal, but we should at least think
about what direction we want to take.

> So, what the pci-mvebu.c driver does is that it creates an emulated PCI
> bridge. This emulated bridge is used to let the Linux PCI core
> enumerate the real physical PCI devices behind the bridge, allocate a
> range of physical addresses that is available for each of these
> devices, and write them to the bridge registers. Since the bridge is
> not a real one, but emulated, but trap those writes, and use them to
> create the MBus windows that will allow the CPU to actually access the
> device, at the base address chosen by the Linux PCI core during the
> enumeration process.
>
> However, MBus windows have a certain constraint that they must have a
> power of two size, so the Linux PCI core should not write to one of the
> bridge PCI_MEMORY_BASE / PCI_MEMORY_LIMIT registers any range of
> address whose size is not a power of 2.

I'm still not sure I understand what's going on here.  It sounds like
your emulated bridge basically wraps the host bridge and makes it look
like a PCI-PCI bridge.  But I assume the host bridge itself is also
visible, and has apertures (I guess these are the MBus windows?)  So
when you first discover the host bridge, before enumerating anything
below it, what apertures does it have?  Do you leave them disabled
until after we enumerate the devices, figure out how much space they
need, and configure the emulated PCI-PCI bridge to enable the MBus
windows?

It'd be nice if dmesg mentioned the host bridge explicitly as we do on
other architectures; maybe that would help understand what's going on
under the covers.  Maybe a longer excerpt would already have this; you
already use pci_add_resource_offset(), which is used when creating the
root bus, so you must have some sort of aperture before enumerating.

> Let me take the example of Gerlando:
>
> pci 0000:01:00.0: BAR 1: assigned [mem 0xe0000000-0xe7ffffff]
> pci 0000:01:00.0: BAR 3: assigned [mem 0xe8000000-0xe87fffff]
> pci 0000:01:00.0: BAR 4: assigned [mem 0xe8800000-0xe8801fff]
> pci 0000:01:00.0: BAR 0: assigned [mem 0xe8802000-0xe8802fff]
> pci 0000:01:00.0: BAR 2: assigned [mem 0xe8803000-0xe8803fff]
> pci 0000:01:00.0: BAR 5: assigned [mem 0xe8804000-0xe8804fff]
> pci 0000:00:01.0: PCI bridge to [bus 01]
> pci 0000:00:01.0:   bridge window [mem 0xe0000000-0xebffffff]
>
> So, pci 0000:01:00 is the real device, which has a number of BARs of a
> certain size. Taking into account all those BARs, the Linux PCI core
> decides to assign [mem 0xe0000000-0xebffffff] to the bridge (last line
> of the log above). The problem is that [mem 0xe0000000-0xebffffff] is
> 192 MB, but we would like the Linux PCI core to extend that to 256 MB.

If 01:00.0 is a PCIe endpoint, it must have a root port above it, so
that means 00:01.0 must be the root port.  But I think you're saying
that 00:01.0 is actually *emulated* and isn't PCIe-compliant, e.g., it
has extra window alignment restrictions.  I'm scared about what other
non-PCIe-compliant things there might be.  What happens when the PCI
core configures MPS, ASPM, etc.,

> As you can see it is not about the global aperture associated to the
> bridge, but about the size of the window associated to each "port" of
> the bridge.

Bjorn
