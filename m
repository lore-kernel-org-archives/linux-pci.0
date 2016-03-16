Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 16 Mar 2016 17:20:17 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Andreas Noever <andreas.noever@gmail.com>,
	Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC 4/4] thunderbolt: Support runtime pm
Message-ID: <20160316162017.GA28372@wunner.de>
References: <4560ddb26a2bb15eeaf8eab565ac41c35e36d092.1458126755.git.lukas@wunner.de>
 <Pine.LNX.4.44L0.1603161119100.2250-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.44L0.1603161119100.2250-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Alan,

On Wed, Mar 16, 2016 at 11:26:54AM -0400, Alan Stern wrote:
> On Wed, 16 Mar 2016, Lukas Wunner wrote:
> 
> > Document and implement Apple's ACPI-based (but nonstandard) mechanism
> > to power the controller up and down as needed.
> > 
> > This fixes (at least partially) a power regression introduced in
> > Linux 3.17 by 7bc5a2bad0b8 ("ACPI: Support _OSI("Darwin") correctly").
> > 
> > A Thunderbolt controller consists of an NHI (Native Host Interface) and
> > a set of bridges. Power is cut to the entire chip. The Linux pm model
> > assumes that runtime pm is governed by the parent device, i.e. the
> > upstream bridge driver, pcieport. In violation of this model we let a
> > child govern it, i.e. the NHI driver thunderbolt.ko. The traditional
> 
> The NHI driver is bound to bridge 0?  Your diagram indicates this but 
> you don't say so explicitly.

No, the NHI driver is bound to the NHI, that's a PCI device sitting on
a bus behind Downstream Bridge 0.

E.g. on a MacBookPro11,3 with a Falcon Ridge 4C it looks like this:

Upstream Bridge:
	06:00.0 PCI bridge [0604]: Intel Corporation Device [8086:156d]
	Bus: primary=06, secondary=07, subordinate=6c, sec-latency=0
Downstream Bridges:
	07:00.0 PCI bridge [0604]: Intel Corporation Device [8086:156d]
	Bus: primary=07, secondary=08, subordinate=08, sec-latency=0
	07:03.0 PCI bridge [0604]: Intel Corporation Device [8086:156d]
	Bus: primary=07, secondary=09, subordinate=39, sec-latency=0
	07:04.0 PCI bridge [0604]: Intel Corporation Device [8086:156d]
	Bus: primary=07, secondary=3a, subordinate=3a, sec-latency=0
	07:05.0 PCI bridge [0604]: Intel Corporation Device [8086:156d]
	Bus: primary=07, secondary=3b, subordinate=6b, sec-latency=0
	07:06.0 PCI bridge [0604]: Intel Corporation Device [8086:156d]
	Bus: primary=07, secondary=6c, subordinate=6c, sec-latency=0
NHI:
	08:00.0 System peripheral [0880]: Intel Corporation Device [8086:156c]
	Subsystem: Device [2222:1111]


> > hierarchical pm model is defeated by setting ignore_children on the
> > upstream bridge and downstream bridge 0, and by having the NHI update
> > all the bridges' runtime pm state in unison with itself. It is also the
> > NHI driver's job to save and restore PCI state of the bridges.
> > 
> > PCIe Port --- Upstream Bridge --+
> >                                 |
> >                                 +-- Downstream Bridge 0 --+
> >                                 |                         |
> >                                 |                         +-- NHI
> >                                 |
> >                                 +-- Downstream Bridge 1 ...
> >                                 |
> >                                 +-- Downstream Bridge 2 ... hotplugged
> >                                 |                           devices
> >                                 +-- Downstream Bridge 3 ...
> >                                 |
> >                                 +-- Downstream Bridge 4 ...
> 
> This may be a naive question: The diagram indicates a single upstream 
> bridge attached to a bunch of downstream bridges with nothing in 
> between.  Is that really how the kernel treats Thunderbolt controllers?

There's a bus in-between, bus 07 in the example above.
Buses are signified by a vertical line in this ascii drawing.


> In all other controllers that I'm familiar with, there's a device to 
> represent the controller, another device representing its upward link, 
> and a bunch of devices representing the downward links.  The analogous 
> approach here would make bridges 1 ... n children of bridge 0 (which 
> sounds strange but might make more sense in the end).
> 
> The way you're doing it, how does the NHI driver know when to go into 
> suspend?  The runtime PM core won't notify it when all the hotplugged 
> devices attached to the other bridges have been suspended, since it's 
> not their parent.

The NHI knows when something is plugged in, it talks to the switches
in devices that are hotplugged to the controller. As I've explained
in the lengthy comment in the middle of patch [4/4], we acquire a
runtime pm ref for each switch that is plugged in and release one
whenever a switch is unplugged.


> > The PCI subsystem pm_ops do not work properly for devices which can be
> > put into D3cold by some other means than the standard _PSx ACPI platform
> > methods: We do not want to wake up the chip before system sleep, yet
> > pci_pm_prepare() does not return 1 as it should since pci_target_state()
> > returns D3hot. We solve this by overriding pci_pm_prepare() using power
> > domains. They are assigned to the bridges using a PCI quirk. We also do
> > not want to wake the chip after system resume as pci_pm_complete() does,
> > so we override that as well. Note that we can never remove and free the
> > dev_pm_domain assigned to the bridges as there is no PCI remove fixup
> > section. We also cannot bail out of the ->probe callback if allocation
> > of the struct dev_pm_domain fails since the PCI enable fixup does not
> > allow return values to be passed back.
> > 
> > It might be possible to implement a less kludgy solution which adheres
> > to the hierarchical pm model and does not need a PCI enable quirk for
> > the bridges if pcieport had runtime pm support both for itself and
> > any service drivers registering with it. The runtime pm code could
> > then be moved from the NHI to a new Thunderbolt service driver that
> > gets used on the upstream bridge.
> 
> Or you could interpose another device structure between the upstream 
> bridge and all the downstream bridges.

How? The structure is predetermined by the way the PCI devices and
bridges are connected to each other. That was Intel's idea.

Best regards,

Lukas
