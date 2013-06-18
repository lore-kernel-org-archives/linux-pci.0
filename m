Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:27174 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753338Ab3FRFf6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jun 2013 01:35:58 -0400
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
Date: Tue, 18 Jun 2013 14:35:54 +0900
Message-id: <000001ce6be5$b3fd0730$1bf71590$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, June 17, 2013 9:45 PM, Arnd Bergmann wrote:
> On Monday 17 June 2013 18:45:52 Jingoo Han wrote:
> > On Friday, June 14, 2013 9:54 PM, Arnd Bergmann wrote:
> > >
[.....]
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

Aha, I see.
I will not provide a module_exit() function), as the mvebu driver does.

Best regards,
Jingoo Han

> 
> 	Arnd

