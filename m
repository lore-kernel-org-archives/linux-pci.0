Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:51150 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S935126AbcCPP04 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 16 Mar 2016 11:26:56 -0400
Date: Wed, 16 Mar 2016 11:26:54 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Lukas Wunner <lukas@wunner.de>
cc: linux-pci@vger.kernel.org, <linux-acpi@vger.kernel.org>,
	<linux-pm@vger.kernel.org>,
	Andreas Noever <andreas.noever@gmail.com>,
	Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC 4/4] thunderbolt: Support runtime pm
In-Reply-To: <4560ddb26a2bb15eeaf8eab565ac41c35e36d092.1458126755.git.lukas@wunner.de>
Message-ID: <Pine.LNX.4.44L0.1603161119100.2250-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 16 Mar 2016, Lukas Wunner wrote:

> Document and implement Apple's ACPI-based (but nonstandard) mechanism
> to power the controller up and down as needed.
> 
> This fixes (at least partially) a power regression introduced in
> Linux 3.17 by 7bc5a2bad0b8 ("ACPI: Support _OSI("Darwin") correctly").
> 
> A Thunderbolt controller consists of an NHI (Native Host Interface) and
> a set of bridges. Power is cut to the entire chip. The Linux pm model
> assumes that runtime pm is governed by the parent device, i.e. the
> upstream bridge driver, pcieport. In violation of this model we let a
> child govern it, i.e. the NHI driver thunderbolt.ko. The traditional

The NHI driver is bound to bridge 0?  Your diagram indicates this but 
you don't say so explicitly.

> hierarchical pm model is defeated by setting ignore_children on the
> upstream bridge and downstream bridge 0, and by having the NHI update
> all the bridges' runtime pm state in unison with itself. It is also the
> NHI driver's job to save and restore PCI state of the bridges.
> 
> PCIe Port --- Upstream Bridge --+
>                                 |
>                                 +-- Downstream Bridge 0 --+
>                                 |                         |
>                                 |                         +-- NHI
>                                 |
>                                 +-- Downstream Bridge 1 ...
>                                 |
>                                 +-- Downstream Bridge 2 ... hotplugged
>                                 |                           devices
>                                 +-- Downstream Bridge 3 ...
>                                 |
>                                 +-- Downstream Bridge 4 ...

This may be a naive question: The diagram indicates a single upstream 
bridge attached to a bunch of downstream bridges with nothing in 
between.  Is that really how the kernel treats Thunderbolt controllers?

In all other controllers that I'm familiar with, there's a device to 
represent the controller, another device representing its upward link, 
and a bunch of devices representing the downward links.  The analogous 
approach here would make bridges 1 ... n children of bridge 0 (which 
sounds strange but might make more sense in the end).

The way you're doing it, how does the NHI driver know when to go into 
suspend?  The runtime PM core won't notify it when all the hotplugged 
devices attached to the other bridges have been suspended, since it's 
not their parent.

> The PCI subsystem pm_ops do not work properly for devices which can be
> put into D3cold by some other means than the standard _PSx ACPI platform
> methods: We do not want to wake up the chip before system sleep, yet
> pci_pm_prepare() does not return 1 as it should since pci_target_state()
> returns D3hot. We solve this by overriding pci_pm_prepare() using power
> domains. They are assigned to the bridges using a PCI quirk. We also do
> not want to wake the chip after system resume as pci_pm_complete() does,
> so we override that as well. Note that we can never remove and free the
> dev_pm_domain assigned to the bridges as there is no PCI remove fixup
> section. We also cannot bail out of the ->probe callback if allocation
> of the struct dev_pm_domain fails since the PCI enable fixup does not
> allow return values to be passed back.
> 
> It might be possible to implement a less kludgy solution which adheres
> to the hierarchical pm model and does not need a PCI enable quirk for
> the bridges if pcieport had runtime pm support both for itself and
> any service drivers registering with it. The runtime pm code could
> then be moved from the NHI to a new Thunderbolt service driver that
> gets used on the upstream bridge.

Or you could interpose another device structure between the upstream 
bridge and all the downstream bridges.

Alan Stern

