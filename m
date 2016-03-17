Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 17 Mar 2016 10:54:55 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Lukas Wunner <lukas@wunner.de>
cc: linux-pci@vger.kernel.org, <linux-acpi@vger.kernel.org>,
	<linux-pm@vger.kernel.org>,
	Andreas Noever <andreas.noever@gmail.com>,
	Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC 4/4] thunderbolt: Support runtime pm
In-Reply-To: <20160316162017.GA28372@wunner.de>
Message-ID: <Pine.LNX.4.44L0.1603171042520.2097-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 16 Mar 2016, Lukas Wunner wrote:

> > In all other controllers that I'm familiar with, there's a device to 
> > represent the controller, another device representing its upward link, 
> > and a bunch of devices representing the downward links.  The analogous 
> > approach here would make bridges 1 ... n children of bridge 0 (which 
> > sounds strange but might make more sense in the end).
> > 
> > The way you're doing it, how does the NHI driver know when to go into 
> > suspend?  The runtime PM core won't notify it when all the hotplugged 
> > devices attached to the other bridges have been suspended, since it's 
> > not their parent.
> 
> The NHI knows when something is plugged in, it talks to the switches
> in devices that are hotplugged to the controller. As I've explained
> in the lengthy comment in the middle of patch [4/4], we acquire a
> runtime pm ref for each switch that is plugged in and release one
> whenever a switch is unplugged.

If I understand correctly, that means you allow the Thunderbolt
controller to go into runtime suspend only when nothing is plugged into
any of the ports.  Is that right?  It's quite inefficient.

> > > The PCI subsystem pm_ops do not work properly for devices which can be
> > > put into D3cold by some other means than the standard _PSx ACPI platform
> > > methods: We do not want to wake up the chip before system sleep, yet
> > > pci_pm_prepare() does not return 1 as it should since pci_target_state()
> > > returns D3hot. We solve this by overriding pci_pm_prepare() using power
> > > domains. They are assigned to the bridges using a PCI quirk. We also do
> > > not want to wake the chip after system resume as pci_pm_complete() does,
> > > so we override that as well. Note that we can never remove and free the
> > > dev_pm_domain assigned to the bridges as there is no PCI remove fixup
> > > section. We also cannot bail out of the ->probe callback if allocation
> > > of the struct dev_pm_domain fails since the PCI enable fixup does not
> > > allow return values to be passed back.
> > > 
> > > It might be possible to implement a less kludgy solution which adheres
> > > to the hierarchical pm model and does not need a PCI enable quirk for
> > > the bridges if pcieport had runtime pm support both for itself and
> > > any service drivers registering with it. The runtime pm code could
> > > then be moved from the NHI to a new Thunderbolt service driver that
> > > gets used on the upstream bridge.
> > 
> > Or you could interpose another device structure between the upstream 
> > bridge and all the downstream bridges.
> 
> How? The structure is predetermined by the way the PCI devices and
> bridges are connected to each other. That was Intel's idea.

What I'm getting at is that we should have proper runtime-PM support
for bridges, i.e., I agree with what you wrote above.  A bridge can
safely go into runtime suspend when there are no unsuspended devices
attached to any of its downstream ports.  (That's how the USB hub
driver works, for instance.)  Doing things that way would make
everything simpler in the long run.

So my suggestion is that you change over to the "less kludgy solution"  
and work on that instead.

Alan Stern

