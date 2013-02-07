Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:57242 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754325Ab3BGQTK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Feb 2013 11:19:10 -0500
Date: Thu, 7 Feb 2013 17:19:04 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Andrew Murray <andrew.murray@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
Message-ID: <20130207171904.70270598@skate>
In-Reply-To: <20130207155117.GA19666@arm.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
	<20130129132204.GA23886@arm.com>
	<20130207153750.0fef1192@skate>
	<20130207155117.GA19666@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Andrew Murray,

On Thu, 7 Feb 2013 15:51:17 +0000, Andrew Murray wrote:

> > First of all, I didn't reimplement the pcibios_get_phb_of_node(), but
> > instead, as Thierry Reding suggested, simply implemented the
> > hw_pci.scan() function as follows:
> 
> I've not had any time to test Thierry's solution to avoid implementing
> pcibios_get_phb_of_node - but it did seem to work for him and seem correct
> at the time.

At least there are device tree nodes associated to PCI devices, so it
looks good from this perspective.


> > To me, the "struct pci_dev" representing the real PCIe devices should
> > have a NULL "struct device_node" pointer, because those device are not
> > represented in the DT. If this was the case, then the of_irq_map_pci()
> > would go one level up in the PCI hierarchy, find the "struct pci_dev"
> > that corresponds to the PCI-to-PCI bridge, which generates an laddr[]
> > having a bus number a devfn value matching the interrupt-map property.
> 
> Yes this is my current understanding.

Ok. But that's not what happens: the "struct pci_dev" representing the
real PCIe device *DOES* have a non-NULL struct device_node pointer. And
this is what makes the entire thing fail.

> I would suggest the issue isn't in the PCI/DT code. This is what I see

I believe it is, because as I said above, the struct pci_dev associated
to a real PCIe device should not have a struct device_node pointer,
because this PCIe device has been dynamically enumerated and is
therefore not part of the device tree.

> with my implementation (which uses an implementation of
> pcibios_get_phb_of_node) - I'd like to believe this is correct behaviour:
> 
> - of_irq_map_pci is called for an endpoint (5:0:0), its pdev->dev.of_node
>   is NULL. As I don't have a representation of this endpoint in my DT the
>   of_irq_map_pci code proceeds to walk the fabric.

I believe this should be the behavior. But this not what happens: the
pdev->dev.of_node of an endpoint pci_dev is not NULL.

> - Starting with the pdev for 5:0:0, of_irq_map_pci sees it has a parent
>   (downstream switch bridge), in this case pdev(5:0:0)->bus->self->dev.of_node
>   is NULL, due to this swizzling occurs and we walk the parent's bus (bus 2)
> - This continues to bus 1 and then bus 0 where of_irq_map_pci realises that
>   it has no parent (its the host bridge). Due to the implementation of
>   pcibios_get_phb_of_node a of_node is produced, this is then used to construct
>   a lspec (for bus number 0).
> 
> The of_irq_map_pci code stops walking as soon as it finds a function in the
> tree that has a device node. This suggests that if you represent a bridge
> you must also include an interrupt-map. The problem here is that you have
> represented a bridge but not included a map.

I understood that it walks up the PCI hierarchy, and that's fine. As
I've shown in my previous e-mail, the only problem is that this
pdev->dev.of_node should be NULL for the PCIe endpoint device. If it
were NULL, then everything would work correctly, as I could confirmed
by the hack I did in of_irq_map_pci().

> I can think of three solutions:
> 
> 1. Something like this:
> 
>                  } else {
>                          /* We found a P2P bridge, check if it has a node */
>                          ppnode = pci_device_to_OF_node(ppdev);
>  +                       if (ppnode doesnt have an interrupt-map)//if (pdev->bus->number != 0)
>  +                               ppnode = NULL;
>                  }
> 
> 2. Remove the bridges from the DT? Or remove the map from pcie-controller and
>    add a map each to pcie@0,1 and pcie@1,1?
> 
> 3. Change the mask of your map so that it doesn't care about bus numbers. I
>    have a map that looks like this:
> 
>                 interrupt-map-mask = <0 0 0 7>;
>                 interrupt-map = <0 0 0 1 ... //anything coming in on INTA
>                                  0 0 0 2 ... //anything coming in on INTB
>                                  0 0 0 3 ... ...
>                                  0 0 0 4 ... ...

Unfortunately, I don't quite agree with any of your three solutions. I
still do believe the root problem is that pdev->dev.of_node should be
NULL for the PCIe endpoints, since those devices are not probed with
the Device Tree.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
