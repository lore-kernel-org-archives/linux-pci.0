Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:57905 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644Ab3FRDw5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jun 2013 23:52:57 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Arnd Bergmann' <arnd@arndb.de>,
	linux-arm-kernel@lists.infradead.org
Cc: 'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>,
	'Jason Gunthorpe' <jgunthorpe@obsidianresearch.com>,
	linux-samsung-soc@vger.kernel.org,
	'Siva Reddy Kallam' <siva.kallam@samsung.com>,
	'Surendranath Gurivireddy Balla' <suren.reddy@samsung.com>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	'Thierry Reding' <thierry.reding@avionic-design.de>,
	linux-kernel@vger.kernel.org,
	'Grant Likely' <grant.likely@secretlab.ca>,
	'Kukjin Kim' <kgene.kim@samsung.com>,
	'Thomas Abraham' <thomas.abraham@linaro.org>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	'Andrew Murray' <andrew.murray@arm.com>,
	Jingoo Han <jg1.han@samsung.com>
References: <000b01ce6839$0f0455d0$2d0d0170$@samsung.com>
 <3539874.V7zkhbMg0b@wuerfel> <005e01ce6b3f$74e3c940$5eab5bc0$@samsung.com>
 <7174350.I5qK0sQfHM@wuerfel>
In-reply-to: <7174350.I5qK0sQfHM@wuerfel>
Subject: Re: [PATCH V5 1/3] pci: Add PCIe driver for Samsung Exynos
Date: Tue, 18 Jun 2013 12:52:54 +0900
Message-id: <000001ce6bd7$50146e60$f03d4b20$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, June 17, 2013 9:45 PM, Arnd Bergmann wrote:
> On Monday 17 June 2013 18:45:52 Jingoo Han wrote:
> > On Friday, June 14, 2013 9:54 PM, Arnd Bergmann wrote:
> > >
> > > Please look up the documentation about inbound viewport and describe
> > > in a code comment what it does. I /assume/ that this is how DMA accesses
> > > from the bus get translated into AXI bus transactions. If so, you have
> > > to let the window translate addresses from RAM. If it's something else,
> > > then you should document what it is and how it needs to be set up.
> >
> > One of our hardware engineer confirmed it.
> > He said that these inbound functions are unnecessary.
> > Also, I checked that PCIe works properly without these functions.
> > So, I will remove these inbound functions.
> 
> Ok, good. So DMA just gets translated 1:1 independent of the
> inbound viewport? Have you tested this with PCI device using
> DMA?

According to our hardware engineer,
He said that
"That's correct. We tested it by doing a memory write from the device.
A device DMA is a series of memory r/w so I expect it to work same way."

Also, he thought that I already tested too, since it works after removing
the functions.

> 
> > static int exynos_pcie_setup(int nr, struct pci_sys_data *sys)
> > {
> > 	struct pcie_port *pp;
> >
> > 	pp = sys_to_pcie(sys);
> >
> > 	if (!pp)
> > 		return 0;
> >
> > 	if (global_io_offset < SZ_1M && pp->config.io_size > 0) {
> > 		sys->io_offset = global_io_offset - pp->config.io_bus_addr; /* normally 0 */
> > 		pci_ioremap_io(sys->io_offset, pp->io.start);
> > 		global_io_offset += SZ_64K;
> > 	}
> >
> > 	sys->mem_offset = pp->mem.start - pp->config.mem_bus_addr; /* normally 0 */
> >
> > 	pci_add_resource_offset(&sys->resources, &pp->io, sys->io_offset);
> > 	pci_add_resource_offset(&sys->resources, &pp->mem, sys->mem_offset);
> >
> >         return 1;
> > }
> 
> This is what I meant, yes.
> 
> > In this case, boot message is as below:
> >
> > PCI host bridge to bus 0000:00
> > pci_bus 0000:00: root bus resource [io  0x40001000-0x40010fff]
> > pci_bus 0000:00: root bus resource [mem 0x40011000-0x5fffffff]
> > pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
> > pci 0000:00:00.0: [144d:a549] type 01 class 0x060400
> > [.....]
> > PCI host bridge to bus 0001:00
> > pci_bus 0001:00: root bus resource [io  0x60001000-0x60010fff] (bus address [0x5fff1000-0x6000
> > 0fff])
> > pci_bus 0001:00: root bus resource [mem 0x60011000-0x7fffffff]
> > pci_bus 0001:00: No busn resource found for root bus, will use [bus 00-ff]
> > pci 0001:00:00.0: [144d:a549] type 01 class 0x060400
> 
> The io resources here look wrong. I would have expected
> 
> pci_bus 0000:00: root bus resource [io  0x001000-0x00ffff]
> pci_bus 0001:00: root bus resource [io  0x010000-0x01ffff] (bus address [0x000000-0x00ffff])
> 
> Please have a look at the pci-mvebu driver and how it calculates its
> 'realio' resource.

I looked at the pci-mvebu driver,
Then I fixed it as the pci-mvebu driver did.
Also, I added 'global_io_offset'.

@@ -909,6 +909,12 @@ static int __init exynos_pcie_probe(struct platform_device *pdev)
                if (restype == IORESOURCE_IO) {
                        of_pci_range_to_resource(&range, np, &pp->io);
                        pp->io.name = "I/O";
+                       pp->io.start = max_t(resource_size_t,
+                                               PCIBIOS_MIN_IO,
+                                               range.pci_addr + global_io_offset);
+                       pp->io.end = min_t(resource_size_t,
+                                               IO_SPACE_LIMIT,
+                                               range.pci_addr + range.size + global_io_offset);
                        pp->config.io_size = resource_size(&pp->io);
                        pp->config.io_bus_addr = range.pci_addr;

In this case, boot message is as below:

PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x1000-0x10000]
pci_bus 0000:00: root bus resource [mem 0x40011000-0x5fffffff]
[.....]
PCI host bridge to bus 0001:00
pci_bus 0001:00: root bus resource [io  0x10000-0x20000] (bus address [0x0000-0x10000])
pci_bus 0001:00: root bus resource [mem 0x60011000-0x7fffffff]



> 
> > > > > > +static int __exit exynos_pcie_remove(struct platform_device *pdev)
> > > > > > +{
> > > > > > +	struct pcie_port *pp = platform_get_drvdata(pdev);
> > > > > > +
> > > > > > +	clk_disable_unprepare(pp->bus_clk);
> > > > > > +	clk_disable_unprepare(pp->clk);
> > > > > > +
> > > > > > +	return 0;
> > > > > > +}
> > > > >
> > > > > You also don't remove the PCI devices here, as mentioned in an earlier
> > > > > review.
> > > >
> > > > I reviewed Marvell PCIe driver and Tegra PCIe driver; however,
> > > > I cannot know what you mean.
> > > >
> > > > Could let me know which additional functions are needed?
> > >
> > > The mvebu driver does not allow module unload. I haven't looked at the
> > > tegra driver. If you allow unloading the driver and provide a 'remove'
> > > callback, that callback needs to clean up the entire bus and remove
> > > all child devices that were added as well as undo everything the
> > > probe function did. I think it would be great if you can do that, although
> > > it might not be easy. The simplest solution would be to not support
> > > unloading though.
> >
> > As the mvebu driver uses platform_driver_probe(), the Exynos driver uses
> > platform_driver_probe(). Thus, I will not provide a 'remove' callback.
> 
> Well, the important part is not to provide a module_exit() function, which
> will ensure the driver cannot be unloaded.

I will remove a 'remove' callback. Is it OK?
Or what should I do?


Thank you for your comment. :)

Best regards,
Jingoo Han

> 
> 	Arnd

