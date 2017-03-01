Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752524AbdCAPjz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Mar 2017 10:39:55 -0500
Date: Wed, 1 Mar 2017 09:39:19 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Joshua Kinard <kumba@gentoo.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Linux/MIPS <linux-mips@linux-mips.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 12/12] MIPS: PCI: Fix IP27 for the PCI_PROBE_ONLY case
Message-ID: <20170301153919.GA13171@bhelgaas-glaptop.roam.corp.google.com>
References: <CAErSpo4LsrPCtdZwp6CyT0jKhXLt3j=fGSiFjpRRTPUjFoKHtQ@mail.gmail.com>
 <c7ed6a1d-f625-d294-8910-dd2d93d34292@gentoo.org>
 <20170213224512.GA8080@bhelgaas-glaptop.roam.corp.google.com>
 <8ec2a0bf-6bd7-1366-38bc-7f7ba9a29971@gentoo.org>
 <20170214145628.GA10418@bhelgaas-glaptop.roam.corp.google.com>
 <926cfb3a-085f-164b-4ec3-76dc9db3298b@gentoo.org>
 <20170224183803.GB15547@bhelgaas-glaptop.roam.corp.google.com>
 <eefac3de-c857-4bc9-72cb-dec4d2b3a756@gentoo.org>
 <20170227163609.GA11162@bhelgaas-glaptop.roam.corp.google.com>
 <8caa732f-cbfe-1c91-4b00-be8693c653ed@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8caa732f-cbfe-1c91-4b00-be8693c653ed@gentoo.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 27, 2017 at 07:25:58PM -0500, Joshua Kinard wrote:
> On 02/27/2017 11:36, Bjorn Helgaas wrote:
> > On Sat, Feb 25, 2017 at 04:34:12AM -0500, Joshua Kinard wrote:
> >> On 02/24/2017 13:38, Bjorn Helgaas wrote:
> >>> On Fri, Feb 24, 2017 at 03:50:26AM -0500, Joshua Kinard wrote:

> So the logic used to read the vendor/dev IDs can probably be
> extended to poke the BARs via the ~0 trick OR read out the
> pre-defined mappings from ARCS firmware, then use that info to size
> out the BRIDGE windows into Crosstalk space and then set up our
> IORESOURCE_MEM and IORESOURCE_IO structs with the right information
> to pass into register_pci_controller().

As you probably know, you can determine the size of a BAR regardless of
whether it has been assigned.  So it doesn't matter whether ARCS has
already assigned anything.  See __pci_read_base().

> I dunno, I'll probably try reading the ARCS mappings idea first, as
> that seems easier.  I won't have a lot of time to play with things
> in March, so getting something to work, even if it is sub-optimal,
> is better than nothing working at all.

The simplest possible thing is to enable some pre-defined set of
windows and accept that this may lead to configuration restrictions,
e.g., a device with large BARs may work only in certain slots.

> Each window, at least on Octane, lives at distinct addresses in
> Crosstalk space.  A specific address within each window can point to
> the same device on a subordinate PCI bus, but I think that will be
> transparent to the Linux PCI core.  My thinking is, if I setup
> IORESOURCE_MEM structs for each window for each BRIDGE widget, then
> the PCI code will check each struct to see which one contains the
> address range that the PCI device's BAR wants.
> 
> E.g., Using widget 0xd as an example for readability, if I know my
> three windows in Crosstalk space are:
>     Small:  0x0000_1d00_0000 - 0x0000_1dff_ffff
>     Medium: 0x000e_8000_0000 - 0x000e_ffff_ffff
>     Large:  0x00d0_0000_0000 - 0x00df_ffff_ffff
> 
> And for that specific BRIDGE, if I pass those three ranges as
> IORESOURCE_MEM structs, then shouldn't the PCI core, if it is told
> that a specific devices BAR wants range 1d200000 to 1d203fff, select
> the small window mapping?  E,g., is it going to try to find the
> smallest possible window to fit first?  Or will it instead try to
> match using the large window?

No, when matching a BAR value to a host bridge window, the PCI core
will definitely not look for the smallest (or largest) window that
contains the BAR.  

The core reads the BAR value (a bus address), then searches the host
bridge windows for one that maps to a region that contains the bus
address.  This happens in pcibios_bus_to_resource(), which is called
by __pci_read_base().

The search order is undefined because the core assumes the windows do
not overlap in PCI bus address space.  It can't deal with two windows
that map to the same PCI space because when we allocate space when
assigning a BAR, we search for available CPU address space, not for
available PCI bus address space.

If window A and window B both map to PCI bus address X, we may assign
space from window A to PCI BAR 1 and space from window B to PCI BAR 2.
Then we have two BARs at the same PCI bus address, which will cause
conflicts.

I don't think we currently check in the PCI core for host bridge
windows that map to overlapping PCI bus space.  Maybe we should, and
just reject anything that overlaps.

Bjorn
