Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:60770 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357AbaBDTNw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 4 Feb 2014 14:13:52 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Liviu.Dudau@arm.com,
	linux-pci@vger.kernel.org, bhelgaas@google.com, mohit.kumar@st.com
Subject: Re: [PATCH 2/3] PCI: ARM: add support for virtual PCI host controller
Date: Tue, 04 Feb 2014 20:13:49 +0100
Message-ID: <3460536.Sh23gjDa6X@wuerfel>
In-Reply-To: <1391532784-1953-3-git-send-email-will.deacon@arm.com>
References: <1391532784-1953-1-git-send-email-will.deacon@arm.com> <1391532784-1953-3-git-send-email-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 04 February 2014 16:53:03 Will Deacon wrote:
> +
> +- ranges         : As described in IEEE Std 1275-1994, but must provide
> +                   at least a definition of the Configuration Space plus
> +                   one or both of IO and Memory Space.
> +

I might need to reread the spec, but I think the config space is not
actually supposed to be in the 'ranges' of the host bridge at all,
and it should just be listed in the 'reg'.

IIRC the reason why the config space is part of the three-cell address
is so that you can have funky ways to say "memory space of the device
with bus/dev/fn is actually translated to address X rather then Y".

It's too late to change that for the other drivers now, after the
binding is established.

> +Configuration Space is assumed to be memory-mapped (as opposed to being
> +accessed via an ioport) and laid out with a direct correspondence to the
> +geography of a PCI bus address, by concatenating the various components
> +to form a 24-bit offset:
> +
> +        cfg_offset(bus, device, function, register) =
> +                bus << 16 | device << 11 | function << 8 | register

This won't allow extended config space. Why not just do the
regular mmconfig layout and make this:

	cfg_offset(bus, device, function, register) =
		bus << 20 | device << 15 | function << 12 | register;

> +static int virt_pci_setup(int nr, struct pci_sys_data *sys)
> +{
> +	struct virt_pci *pci = sys->private_data;
> +
> +	if (resource_type(&pci->io)) {
> +		pci_add_resource(&sys->resources, &pci->io);
> +		pci_ioremap_io(nr * resource_size(&pci->io), pci->io.start);
> +	}

This should really compute an io_offset.

> +	if (resource_type(&pci->mem))
> +		pci_add_resource(&sys->resources, &pci->mem);

and also a mem_offset, which is something different.

> +	pci->cfg_base = devm_ioremap_resource(pci->dev, &pci->cfg);
> +	return !IS_ERR(pci->cfg_base);
> +}
> +
> +static const struct of_device_id virt_pci_of_match[] = {
> +	{ .compatible = "linux,pci-virt" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, virt_pci_of_match);

I don't think we even want "virt" in the compatible string. The
binding should be generic enough that it can actually work with
real hardware.

> +	for_each_of_pci_range(&parser, &range) {
> +		u32 restype = range.flags & IORESOURCE_TYPE_BITS;
> +
> +		switch (restype) {
> +		case IORESOURCE_IO:
> +			if (resource_type(&pci->io))
> +				dev_warn(dev,
> +					 "ignoring additional io resource\n");
> +			else
> +				of_pci_range_to_resource(&range, np, &pci->io);
> +			break;
> +		case IORESOURCE_MEM:
> +			if (resource_type(&pci->mem))
> +				dev_warn(dev,
> +					 "ignoring additional mem resource\n");
> +			else
> +				of_pci_range_to_resource(&range, np, &pci->mem);
> +			break;

This shows once more that the range parser code is suboptimal. So far
every single driver got the I/O space wrong here, because the obvious
way to write this function is also completely wrong.

What you get out of "of_pci_range_to_resource(&range, np, &pci->io)"
is not the resource you want to pass into pci_add_resource()
later.

> +	memset(&hw, 0, sizeof(hw));
> +	hw.nr_controllers	= 1;
> +	hw.private_data		= (void **)&pci;
> +	hw.setup		= virt_pci_setup;
> +	hw.map_irq		= of_irq_parse_and_map_pci;
> +	hw.ops			= &virt_pci_ops;
> +	pci_common_init_dev(dev, &hw);

Since most fields here are constant, I'd just write this as

	struct hw_pci hw = {
		.nr_controllers = 1,
		.setup = virt_pci_setup,
		...
	};

	Arnd
