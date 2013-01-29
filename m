Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:34519 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988Ab3A2Np1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jan 2013 08:45:27 -0500
Date: Tue, 29 Jan 2013 14:45:22 +0100
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
Message-ID: <20130129144522.44ed7373@skate>
In-Reply-To: <20130129132204.GA23886@arm.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
	<20130129132204.GA23886@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Andrew Murray,

On Tue, 29 Jan 2013 13:22:04 +0000, Andrew Murray wrote:

> > +static int __init mvebu_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
> > +{
> 
> [snip]
> 
> > +
> > +       /*
> > +        * Build an laddr array that describes the PCI device in a DT
> > +        * way
> > +        */
> > +       laddr[0] = cpu_to_be32(port->devfn << 8);
> > +       laddr[1] = laddr[2] = 0;
> > +       intspec = cpu_to_be32(pin);
> > +
> > +       ret = of_irq_map_raw(port->dn, &intspec, 1, laddr, &oirq);
> > +       if (ret) {
> > +               dev_err(&pcie->pdev->dev,
> > +                       "%s: of_irq_map_raw() failed, %d\n",
> > +                       __func__, ret);
> > +               return ret;
> > +       }
> 
> Are you able to replace the above code with a call to of_irq_map_pci? I'm not
> sure which approach is better. The of_irq_map_pci function doesn't require the
> pin argument and instead uses the DT and/or performs its own pin swizzling. I
> guess this means that if there are PCIe devices in the DT tree that does any
> thing strange with pins then it would be reflected in the IRQ you get. I've
> found that you will also need to provide an implementation of
> pcibios_get_phb_of_node for this to work correctly (see my RFC bios32 patch).

I did try using the of_irq_map_pci() function, but unfortunately, it
didn't work. IIRC, it didn't work because none of the pci_dev in my PCI
tree had any 'struct device_node' associated to them, or at least not
the one that had the right pdev->bus->number and pdev->devfn.

But, I guess that your patch that implements pcibios_get_phb_of_node()
should fix this problem. I'll try this. Thanks!

> > +static int mvebu_pcie_init(void)
> > +{
> > +       return platform_driver_probe(&mvebu_pcie_driver,
> > +                                    mvebu_pcie_probe);
> > +}
> 
> If you have multiple 'mvebu-pcie' in your DT then you will end up
> with multiple calls to
> mvebu_pcie_probe/mvebu_pcie_enable/pci_common_init.

Right. In practice, there will only ever be a single DT node, since all
PCIe interfaces are sub-nodes of the PCI controller node. But I
understand the theoretical problem.

> However pci_common_init/pcibios_init_hw assumes it will only ever be called
> once, and will thus result in trying to create multiple busses with the same
> bus number. (The first root bus it creates is always zero provided you haven't
> implemented hw->scan).
> 
> I noticed this in Thierry's patch set and posted an RFC patch which overcomes
> this issue (patchwork.kernel.org/patch/2001171) and others. Perhaps you would
> want to include this in your patchset?

Sure, I'll give it a test, and report if it works for me.

Thanks a lot!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
