Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:53373 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321AbaL3V6M (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 30 Dec 2014 16:58:12 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robherring2@gmail.com>, devicetree@vger.kernel.org,
	Peter Maydell <peter.maydell@linaro.org>,
	Russell King <linux@arm.linux.org.uk>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>, arm@kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 4/9] pci: add DT based ARM Versatile PCI host driver
Date: Tue, 30 Dec 2014 22:58 +0100
Message-ID: <2308474.mrIrUSfiTv@wuerfel>
In-Reply-To: <1419967718-26909-5-git-send-email-robherring2@gmail.com>
References: <1419967718-26909-1-git-send-email-robherring2@gmail.com> <1419967718-26909-5-git-send-email-robherring2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 30 December 2014 13:28:33 Rob Herring wrote:
> From: Rob Herring <robh@kernel.org>
> 
> This converts the Versatile PCI host code to a platform driver using
> the commom DT parsing and setup. The driver uses only an empty ARM
> pci_sys_data struct and does not use pci_common_init_dev init function.
> The old host code will be removed in a subsequent commit when Versatile
> is completely converted to DT.
> 
> I've tested this on QEMU with the sym53c8xx driver in both i/o and
> memory mapped modes.

Ah, this is quite clever, I think you tried to explain to me what you
did with the pci_sys_data before, but I didn't get it then.
 
> +
> +static void __iomem *__pci_addr(struct pci_bus *bus,
> +				unsigned int devfn, int offset)
> +{
> +	unsigned int busnr = bus->number;
> +
> +	/*
> +	 * Trap out illegal values
> +	 */
> +	BUG_ON(offset > 255);
> +	BUG_ON(busnr > 255);
> +	BUG_ON(devfn > 255);

Isn't an offset>255 something that can be triggered by a non-broken
driver or even user space?

Maybe just return PCIBIOS_BAD_REGISTER_NUMBER in this case?

> +static int versatile_pci_parse_request_of_pci_ranges(struct device *dev,
> +						     struct list_head *res)
> +{
> +	int err, mem = 1, res_valid = 0;
> +	struct device_node *np = dev->of_node;
> +	resource_size_t iobase;
> +	struct pci_host_bridge_window *win;
> +
> +	err = of_pci_get_host_bridge_resources(np, 0, 0xff, res, &iobase);
> +	if (err)
> +		return err;
> +
> +	list_for_each_entry(win, res, list) {
> +		struct resource *parent, *res = win->res;
> +
> +		switch (resource_type(res)) {
> +		case IORESOURCE_IO:
> +			parent = &ioport_resource;
> +			err = pci_remap_iospace(res, iobase);
> +			if (err) {
> +				dev_warn(dev, "error %d: failed to map resource %pR\n",
> +					 err, res);
> +				continue;
> +			}
> +			break;
> +		case IORESOURCE_MEM:
> +			parent = &iomem_resource;
> +			res_valid |= !(res->flags & IORESOURCE_PREFETCH);
> +
> +			writel(res->start >> 28, PCI_IMAP(mem));
> +			writel(PHYS_OFFSET >> 28, PCI_SMAP(mem));
> +			mem++;
> +
> +			break;
> +		case IORESOURCE_BUS:
> +		default:
> +			continue;
> +		}
> +
> +		err = devm_request_resource(dev, parent, res);
> +		if (err)
> +			goto out_release_res;
> +	}

I wonder if we should also request the physical resource for the I/O space
window to have it show up in /proc/iomem. We are rather inconsistent in this
regard between drivers.

> +	pci_add_flags(PCI_ENABLE_PROC_DOMAINS);
> +	pci_add_flags(PCI_REASSIGN_ALL_BUS | PCI_REASSIGN_ALL_RSRC);
> +
> +	bus = pci_scan_root_bus(&pdev->dev, 0, &pci_versatile_ops, &sys, &pci_res);
> +	if (!bus)
> +		return -ENOMEM;
> +
> +	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
> +	pci_assign_unassigned_bus_resources(bus);
> +
> +	return 0;

One general question, mainly for Bjorn: pci_scan_root_bus adds all the devices
at the Linux driver level by calling pci_bus_add_devices(), but then we call
pci_fixup_irqs and pci_assign_unassigned_bus_resources after that, which will
change the devices again. Is this how it's meant to work? How do we ensure
that we have the correct irq number and resources by the time we enter the
probe() function of the PCI device driver that gets bound to a device here?

	Arnd
