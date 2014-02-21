Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:47820 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725AbaBUTGK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Feb 2014 14:06:10 -0500
Received: by mail-ie0-f173.google.com with SMTP id lx4so1641273iec.32
        for <linux-pci@vger.kernel.org>; Fri, 21 Feb 2014 11:06:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20140221002438.GE19893@obsidianresearch.com>
References: <20130711163220.2b3adf38@skate> <53039894.10905@keymile.com>
 <20140218212751.07c2aeb5@skate> <53046D98.6020801@keymile.com>
 <20140219102658.76eec91e@skate> <53047BBB.6040108@keymile.com>
 <20140219143749.65ff3155@skate> <CAErSpo4=6VgJazaErcx=ztKhZ_62xBrQ6K1eN_dVpvV4R0T2ag@mail.gmail.com>
 <20140220095518.7ca36f0a@skate> <CAErSpo5pG3eOG58MiCCOHgr_jQReH0uBnWQFvzQYg3qrOGpZEw@mail.gmail.com>
 <20140221002438.GE19893@obsidianresearch.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 21 Feb 2014 12:05:49 -0700
Message-ID: <CAErSpo5c=iMHM_uATxsiUthaHtt-UvX6ySQx2pVgfJT4ABuWGQ@mail.gmail.com>
Subject: Re: pci-mvebu driver on km_kirkwood
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gerlando Falauto <gerlando.falauto@keymile.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Jason Cooper <jason@lakedaemon.net>,
	"Longchamp, Valentin" <Valentin.Longchamp@keymile.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Gavin, Ben for EEH alignment question below]

On Thu, Feb 20, 2014 at 5:24 PM, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
> On Thu, Feb 20, 2014 at 12:18:42PM -0700, Bjorn Helgaas wrote:
>
>> > On Marvell hardware, the physical address space layout is configurable,
>> > through the use of "MBus windows". A "MBus window" is defined by a base
>> > address, a size, and a target device. So if the CPU needs to access a
>> > given device (such as PCIe 0.0 for example), then we need to create a
>> > "MBus window" whose size and target device match PCIe 0.0.
> ...

> So the driver creates a 'compliant' config space for the root
> port. Building the config space requires harmonizing registers related
> to the PCI-E and registers related to internal routing and dealing
> with the mismatch between what the hardware can actualy provide and
> what the PCI spec requires it provide.
> ...

>> > Since Armada XP has 10 PCIe interfaces, we cannot just statically
>> > create as many MBus windows as there are PCIe interfaces: it would both
>> > exhaust the number of MBus windows available, and also exhaust the
>> > physical address space, because we would have to create very large
>> > windows, just in case the PCIe device plugged behind this interface
>> > needs large BARs.
> ...

>> I'm still not sure I understand what's going on here.  It sounds like
>> your emulated bridge basically wraps the host bridge and makes it look
>> like a PCI-PCI bridge.  But I assume the host bridge itself is also
>> visible, and has apertures (I guess these are the MBus windows?)
>
> No, there is only one bridge, it is a per-physical-port MBUS / PCI-E
> bridge. It performs an identical function to the root port bridge
> described in PCI-E. MBUS serves as the root-complex internal bus 0.
>
> There isn't 2 levels of bridging, so the MBUS / PCI-E bridge can
> claim any system address and there is no such thing as a 'host
> bridge'.
>
> What Linux calls 'the host bridge aperture' is simply a wack of
> otherwise unused physical address space, it has no special properties.
>
>> It'd be nice if dmesg mentioned the host bridge explicitly as we do on
>> other architectures; maybe that would help understand what's going on
>> under the covers.  Maybe a longer excerpt would already have this; you
>> already use pci_add_resource_offset(), which is used when creating the
>> root bus, so you must have some sort of aperture before enumerating.
>
> Well, /proc/iomem looks like this:
>
> e0000000-efffffff : PCI MEM 0000
>   e0000000-e00fffff : PCI Bus 0000:01
>     e0000000-e001ffff : 0000:01:00.0
>
> 'PCI MEM 0000' is the 'host bridge aperture' it is an arbitary
> range of address space that doesn't overlap anything.
>
> 'PCI Bus 0000:01' is the MBUS / PCI-E root port bridge for physical
> port 0

Thanks for making this more concrete.  Let me see if I understand any better:

- e0000000-efffffff is the "host bridge aperture" but it doesn't
correspond to an actual aperture in hardware (there are no registers
where you set this range).  The only real use for this range is to be
the arena within which the PCI core can assign space to the Root
Ports.  This is static and you don't need to change it based on what
devices we discover.

- There may be several MBus/PCIe Root Ports, and you want to configure
their apertures at enumeration-time based on what devices are below
them.  As you say, the PCI core supports this except that MBus
apertures must be a power-of-two in size and aligned on their size,
while ordinary PCI bridge windows only need to start and end on 1MB
boundaries.

- e0000000-e00fffff is an example of one MBus/PCIe aperture, and this
space is available on PCI bus 01.  This one happens to be 1MB in size,
but it could be 2MB, 4MB, etc., but not 3MB like a normal bridge
window could be.

- You're currently using the ARM ->align_resource() hook (part of
pcibios_align_resource()), which is used in the bowels of the
allocator (__find_resource()) and affects the starting address of the
region we allocate, but not the size.  So you can force the start of
an MBus aperture to be power-of-two aligned, but not the end.

The allocate_resource() alignf argument is only used by PCI and
PCMCIA, so it doesn't seem like it would be too terrible to extend the
alignf interface so it could control the size, too.  Would something
like that solve this problem?

I first wondered if you could use pcibios_window_alignment(), but it
doesn't know the amount of space we need below the bridge, and it also
can't affect the size of the window or the ending address, so I don't
think it will help.

But I wonder if powerpc has a similar issue here: I think EEH might
need, for example 16MB bridge window alignment.  Since
pcibios_window_alignment() only affects the *starting* address, could
the core assign a 9MB window whose starting address is 16MB-aligned?
Could EEH deal with that?  What if the PCI core assigned the space
right after the 9MB window to another device?

Bjorn
