Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:43179 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756902AbaBUAYo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 20 Feb 2014 19:24:44 -0500
Date: Thu, 20 Feb 2014 17:24:38 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Bjorn Helgaas <bhelgaas@google.com>
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
	Lior Amsalem <alior@marvell.com>
Subject: Re: pci-mvebu driver on km_kirkwood
Message-ID: <20140221002438.GE19893@obsidianresearch.com>
References: <20130711163220.2b3adf38@skate>
 <53039894.10905@keymile.com>
 <20140218212751.07c2aeb5@skate>
 <53046D98.6020801@keymile.com>
 <20140219102658.76eec91e@skate>
 <53047BBB.6040108@keymile.com>
 <20140219143749.65ff3155@skate>
 <CAErSpo4=6VgJazaErcx=ztKhZ_62xBrQ6K1eN_dVpvV4R0T2ag@mail.gmail.com>
 <20140220095518.7ca36f0a@skate>
 <CAErSpo5pG3eOG58MiCCOHgr_jQReH0uBnWQFvzQYg3qrOGpZEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo5pG3eOG58MiCCOHgr_jQReH0uBnWQFvzQYg3qrOGpZEw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 20, 2014 at 12:18:42PM -0700, Bjorn Helgaas wrote:

> > On Marvell hardware, the physical address space layout is configurable,
> > through the use of "MBus windows". A "MBus window" is defined by a base
> > address, a size, and a target device. So if the CPU needs to access a
> > given device (such as PCIe 0.0 for example), then we need to create a
> > "MBus window" whose size and target device match PCIe 0.0.
> 
> I was assuming "PCIe 0.0" was a host bridge, but it sounds like maybe
> that's not true.  Is it really a PCIe root port?  That would mean the
> MBus windows are some non-PCIe-compliant thing between the root
> complex and the root ports, I guess.

It really is a root port. The hardware acts like a root port at the
TLP level. It has all the root port specific stuff in some format but
critically, completely lacks a compliant config space for a root
port bridge.

So the driver creates a 'compliant' config space for the root
port. Building the config space requires harmonizing registers related
to the PCI-E and registers related to internal routing and dealing
with the mismatch between what the hardware can actualy provide and
what the PCI spec requires it provide.

The only mismatch that gets exposed to the PCI core we know about is
the bridge window address alignment restrictions.

This is what Thomas has been asking about.

> > Since Armada XP has 10 PCIe interfaces, we cannot just statically
> > create as many MBus windows as there are PCIe interfaces: it would both
> > exhaust the number of MBus windows available, and also exhaust the
> > physical address space, because we would have to create very large
> > windows, just in case the PCIe device plugged behind this interface
> > needs large BARs.
> 
> Everybody else in the world *does* statically configure host bridge
> apertures before enumerating the devices below the bridge.  

The original PCI-E driver for this hardware did use a 1 root port per
host bridge model, with static host bridge aperture allocation and so
forth.

It works fine, just like everyone else in the world, as long as you
have only 1 or 2 ports. The XP hardware had *10* ports on a single
32 bit machine. You run out of address space, you run out of
HW routing resources, it just doesn't work acceptably.

> I see why you want to know what devices are there before deciding
> whether and how large to make an MBus window.  But that is new
> functionality that we don't have today, and the general idea is not

Well, in general, it isn't new core functionality, it is functionality
that already exists to support PCI bridges.

Choosing to use a one host bridge to N root port bridge model lets the
driver use all that functionality and the only wrinkle that becomes
visible to the PCI core as a whole is the non-compliant alignment
restriction on the bridge window BAR.

This also puts the driver in alignment with the PCI-E specs for root
complexes, which means user space can actually see things like the
PCI-E root port link capability block and makes it hot plug work
properly (I am actively using hot plug with this driver)

I personaly think this is a reasonable way to support this highly
flexible HW.

> I'm still not sure I understand what's going on here.  It sounds like
> your emulated bridge basically wraps the host bridge and makes it look
> like a PCI-PCI bridge.  But I assume the host bridge itself is also
> visible, and has apertures (I guess these are the MBus windows?)  

No, there is only one bridge, it is a per-physical-port MBUS / PCI-E
bridge. It performs an identical function to the root port bridge
described in PCI-E. MBUS serves as the root-complex internal bus 0.

There isn't 2 levels of bridging, so the MBUS / PCI-E bridge can
claim any system address and there is no such thing as a 'host
bridge'.

What Linux calls 'the host bridge aperture' is simply a wack of
otherwise unused physical address space, it has no special properties.

> It'd be nice if dmesg mentioned the host bridge explicitly as we do on
> other architectures; maybe that would help understand what's going on
> under the covers.  Maybe a longer excerpt would already have this; you
> already use pci_add_resource_offset(), which is used when creating the
> root bus, so you must have some sort of aperture before enumerating.

Well, /proc/iomem looks like this:

e0000000-efffffff : PCI MEM 0000
  e0000000-e00fffff : PCI Bus 0000:01
    e0000000-e001ffff : 0000:01:00.0

'PCI MEM 0000' is the 'host bridge aperture' it is an arbitary
range of address space that doesn't overlap anything.

'PCI Bus 0000:01' is the MBUS / PCI-E root port bridge for physical
port 0

'0000:01:00.0' is BAR 0 of an an off-chip device.

> If 01:00.0 is a PCIe endpoint, it must have a root port above it, so
> that means 00:01.0 must be the root port.  But I think you're saying
> that 00:01.0 is actually *emulated* and isn't PCIe-compliant, e.g., it
> has extra window alignment restrictions.  

It is important to understand that the emulation is only of the root
port bridge configuration space. The underlying TLP processing is done
in HW and is compliant.

> I'm scared about what other non-PCIe-compliant things there might
> be.  What happens when the PCI core configures MPS, ASPM, etc.,

As the TLP processing and the underlying PHY are all compliant these
things are all supported in HW.

MPS is supported directly by the HW

ASPM is supported by the HW, as is the entire link capability and
status block.

AER is supported directly by the HW

But here is the thing, without the software emulated config space
there would be no sane way for the Linux PCI core to access these
features. The HW simply does not present them in a way that the core
code can understand without a SW intervention of some kind.

Jason
