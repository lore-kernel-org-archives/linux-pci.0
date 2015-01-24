Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:62538 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbbAXBBh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 23 Jan 2015 20:01:37 -0500
Received: by mail-ob0-f169.google.com with SMTP id va8so497745obc.0
        for <linux-pci@vger.kernel.org>; Fri, 23 Jan 2015 17:01:36 -0800 (PST)
Date: Fri, 23 Jan 2015 19:01:27 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org,
	Rob Herring <robherring2@gmail.com>,
	devicetree@vger.kernel.org,
	Peter Maydell <peter.maydell@linaro.org>,
	Russell King <linux@arm.linux.org.uk>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>, arm@kernel.org
Subject: Re: [PATCH 4/9] pci: add DT based ARM Versatile PCI host driver
Message-ID: <20150124010127.GA29776@google.com>
References: <1419967718-26909-1-git-send-email-robherring2@gmail.com>
 <1419967718-26909-5-git-send-email-robherring2@gmail.com>
 <2308474.mrIrUSfiTv@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2308474.mrIrUSfiTv@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 30, 2014 at 10:58:00PM +0100, Arnd Bergmann wrote:
> On Tuesday 30 December 2014 13:28:33 Rob Herring wrote:
> > +	list_for_each_entry(win, res, list) {
> > +		struct resource *parent, *res = win->res;
> > +
> > +		switch (resource_type(res)) {
> > +		case IORESOURCE_IO:
> > +			parent = &ioport_resource;
> > +			err = pci_remap_iospace(res, iobase);
> > +			if (err) {
> > +				dev_warn(dev, "error %d: failed to map resource %pR\n",
> > +					 err, res);
> > +				continue;
> > +			}
> > +			break;
> > +		case IORESOURCE_MEM:
> > +			parent = &iomem_resource;
> > +			res_valid |= !(res->flags & IORESOURCE_PREFETCH);
> > +
> > +			writel(res->start >> 28, PCI_IMAP(mem));
> > +			writel(PHYS_OFFSET >> 28, PCI_SMAP(mem));
> > +			mem++;
> > +
> > +			break;
> > +		case IORESOURCE_BUS:
> > +		default:
> > +			continue;
> > +		}
> > +
> > +		err = devm_request_resource(dev, parent, res);
> > +		if (err)
> > +			goto out_release_res;
> > +	}
> 
> I wonder if we should also request the physical resource for the I/O space
> window to have it show up in /proc/iomem. We are rather inconsistent in this
> regard between drivers.

I'd like that.  We are inconsistent, but I think it's useful to have this
information in /proc/iomem.  After all, it is physical address space that
we can't use for anything else, so I guess you could argue that it's
actually a bug to omit it.

> > +	pci_add_flags(PCI_ENABLE_PROC_DOMAINS);
> > +	pci_add_flags(PCI_REASSIGN_ALL_BUS | PCI_REASSIGN_ALL_RSRC);
> > +
> > +	bus = pci_scan_root_bus(&pdev->dev, 0, &pci_versatile_ops, &sys, &pci_res);
> > +	if (!bus)
> > +		return -ENOMEM;
> > +
> > +	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
> > +	pci_assign_unassigned_bus_resources(bus);
> > +
> > +	return 0;
> 
> One general question, mainly for Bjorn: pci_scan_root_bus adds all the devices
> at the Linux driver level by calling pci_bus_add_devices(), but then we call
> pci_fixup_irqs and pci_assign_unassigned_bus_resources after that, which will
> change the devices again. Is this how it's meant to work? How do we ensure
> that we have the correct irq number and resources by the time we enter the
> probe() function of the PCI device driver that gets bound to a device here?

Nope, that isn't how it's meant to work.  After pci_bus_add_devices()
completes, drivers can be already bound to the device, and the PCI core
should keep its mitts off things the driver could be using.  But I think
we've had this problem for a long time, and I haven't looked at it recently
to see how hard it would be to fix.

Bjorn
