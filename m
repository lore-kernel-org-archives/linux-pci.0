Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752757AbeC2V30 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Mar 2018 17:29:26 -0400
Date: Thu, 29 Mar 2018 16:29:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 2/5] PCI: Take bridge window alignment into account
 when distributing resources
Message-ID: <20180329212921.GJ7759@bhelgaas-glaptop.roam.corp.google.com>
References: <20180226132112.81447-1-mika.westerberg@linux.intel.com>
 <20180226132112.81447-3-mika.westerberg@linux.intel.com>
 <20180327192318.GC7759@bhelgaas-glaptop.roam.corp.google.com>
 <20180328120120.GA2703@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180328120120.GA2703@lahna.fi.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 28, 2018 at 03:01:20PM +0300, Mika Westerberg wrote:
> On Tue, Mar 27, 2018 at 02:23:18PM -0500, Bjorn Helgaas wrote:
> > On Mon, Feb 26, 2018 at 04:21:09PM +0300, Mika Westerberg wrote:
> > > When connecting a Thunderbolt endpoint which itself has internal PCIe
> > > switch (not the integrated one) the way we currently distribute
> > 
> > I don't understand this distinction between "internal PCIe switch" and
> > "integrated one".
> 
> I tried to explain here that Thunderbolt endpoint itself has an internal
> (integrated) PCIe switch.

I was confused by this because I thought you meant "Endpoint" in the
sense used in the PCIe spec, i.e., something with a type 0 config
header.  But you're using "endpoint" to mean "some collection of
devices with a Thunderbolt interface on one side".

> > >From a PCI point of view, I assume you're adding a switch with 4 NIC
> > endpoints below it.
> 
> Yes, exactly.
> 
> The PCIe device in question is Intel Gigabit ET2 Quad Port Server
> adapter.
> 
> > > resources does not always work well because devices below
> > > non-hotplug bridges might need to have their MMIO resources
> > > aligned to something else than 1 MB boundary. As an example
> > > connecting a server grade 4-port GbE add in card adds another
> > > PCIe switch leading to GbE devices that want to have their MMIO
> > > resources aligned to 2 MB boundary instead.
> > 
> > Is there something unique about Thunderbolt here?  I assume from a
> > PCI point of view, these NIC ports have BARs that are 2 MB or
> > larger and hence need 2 MB or larger alignment?
> 
> No, this is not unique to Thunderbolt in any way.

I think this is a case of confusing things by mentioning irrelevant
details, e.g., leading off with "When connecting a Thunderbolt
endpoint" when the problem can occur when hot-adding any PCIe device
(or maybe only when adding a bridge?  I don't know).

It's good to mention a specific example, but I think it's best if you
can describe the situation as generically as possible first, then cite
the case at hand in a way that it's obvious this is just one of many
possibilities.

> > I don't understand how this can work.  You have this:
> > 
> >   for_each_pci_bridge(dev, bus) {
> >     if (!hotplug_bridges && normal_bridges == 1) {
> >       pci_bus_distribute_available_resources(...);   # block 1
> >     } else if (dev->is_hotplug_bridge) {
> >       ...                                            # block 2
> >       pci_bus_distribute_available_resources(...);
> >     } else {
> >       ...                                            # block 3
> >     }
> >   }
> > 
> > This patch adds block 3.  Block 3 doesn't do anything with side
> > effects, i.e., it only updates local variables like io_start,
> > remaining_io, mmio_start, remaining_mmio, etc.
> 
> It updates remaining_* so that the next bridge resource is aligned
> properly (if there is going to be one).

What do you mean by "aligned properly"?  The spec requires that bridge
memory windows be 1MB aligned and I/O windows 4KB aligned.  Does the
current code do that wrong?

> > Those may be used in subsequent iterations, but it's only useful
> > if there *are* subsequent iterations, so this is dependent on the
> > order we iterate through the bridges.  It seems like we want the
> > same results no matter what the order.
> 
> Here again we walk over the bridges using recursive calls so we need
> to know upfront the alignment before we do next call to
> pci_bus_distribute_available_resources() and that information is
> only available when previous bridge is already handled. I suppose
> this can be done in a better way but unfortunately I have no idea
> how :-( Can you suggest something concrete I could do instead if
> this is not sufficient?

I don't understand this well enough to have any great suggestions.

I did notice that the "!hotplug_bridges && normal_bridges == 1" case
doesn't look like it needs to be in the for_each_pci_bridge() loop
because there's only one bridge (I think "hotplug_bridges == 0 &&
normal_bridges == 1" would be slightly easier to read).

And I suspect you might want to handle the "hotplug_bridges == 1 &&
normal_bridges == 0" case identically.  That would mean you could pull
these "list_is_singular()" cases out of the loop, which makes sense
because if there's only one bridge, it should get everything.
