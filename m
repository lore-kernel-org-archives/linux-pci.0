Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.13]:60946 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184AbaBXTaB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 24 Feb 2014 14:30:01 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will.deacon@arm.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, jgunthorpe@obsidianresearch.com
Subject: Re: [PATCH v4] PCI: ARM: add support for generic PCI host controller
Date: Mon, 24 Feb 2014 20:23:23 +0100
Message-ID: <1721648.K4nYY7eS55@wuerfel>
In-Reply-To: <1393268359-17224-1-git-send-email-will.deacon@arm.com>
References: <1393268359-17224-1-git-send-email-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 24 February 2014 18:59:19 Will Deacon wrote:
> +    // BUS_ADDRESS(3)  CPU_PHYSICAL(2)  SIZE(2)
> +    ranges = <0x1000000 0x0 0x01000000  0x0 0x01000000  0x0 0x00010000>,
> +             <0x2000000 0x0 0x41000000  0x0 0x41000000  0x0 0x3f000000>;

The I/O window looks very odd. Why would you start it at bus address
0x01000000 rather than 0 like everyone else?

> +static int gen_pci_calc_io_offset(struct device *dev,
> +				  struct of_pci_range *range,
> +				  struct resource *res,
> +				  resource_size_t *offset)
> +{
> +	static atomic_t wins = ATOMIC_INIT(0);
> +	int err, idx, max_win;
> +	unsigned int io_offset;
> +
> +	/* Ensure the CPU physical address is aligned to a 64K boundary */
> +	range->size += range->cpu_addr & (SZ_64K - 1);
> +	range->cpu_addr = round_down(range->cpu_addr, SZ_64K);
> +	range->pci_addr = round_down(range->pci_addr, SZ_64K);
> +
> +	if (range->size > SZ_64K)
> +		return -E2BIG;

What is the rounding for? Isn't it enough to round to PAGE_SIZE here?
Do you just want to make sure it works with 64K pages on ARM64? I guess
if you end up rounding for the mapping, you should later make sure
that you still only register the original resource.

Presumably, the size would normally be 64K, so if you add anything
for rounding, you just fail here. How about cropping to 64K in that
case?

> +	max_win = IO_SPACE_LIMIT + 1 / SZ_64K;
> +	idx = atomic_inc_return(&wins);
> +	if (idx >= max_win)
> +		return -ENOSPC;
> +
> +	io_offset = (idx - 1) * SZ_64K;
> +	err = pci_ioremap_io(io_offset, range->cpu_addr);

As discussed the last time, calling it "io_offset" here
is extremely confusing. Don't do that, and call it "window"
or something appropriate instead.

> +	if (err)
> +		return err;
> +
> +	of_pci_range_to_resource(range, dev->of_node, res);
> +	res->start = io_offset + range->pci_addr;
> +	res->end = res->start + range->size - 1;

You have just rounded down range->pci_addr, so the resource
now contains more than what the bus node described.

> +	prop = of_get_property(of_chosen, "linux,pci-probe-only", NULL);

of_property_read_bool()

> +	if (of_pci_parse_bus_range(np, &pci->cfg.bus_range))
> +		pci->cfg.bus_range = (struct resource) {
> +			.name	= np->name,
> +			.start	= 0,
> +			.end	= 0xff,
> +			.flags	= IORESOURCE_BUS,
> +		};

I wonder if this should just be part of of_pci_parse_bus_range(),
or maybe an extended helper.

> +	/* Limit the bus-range to fit within reg */
> +	bus_max = pci->cfg.bus_range.start +
> +		  (resource_size(&pci->cfg.res) >> pci->cfg.ops->bus_shift) - 1;
> +	pci->cfg.bus_range.end = min_t(resource_size_t, pci->cfg.bus_range.end,
> +				       bus_max);

I think I would instead print a warning and bail out here. This should
only happen for inconsistent DT properties.

> +		err = request_resource(parent, res);
> +		if (err)
> +			goto out_release_res;
> +
> +		pci_add_resource_offset(&sys->resources, res, offset);
> +	}

Wrong offset for the I/O space. Why not call pci_add_resource_offset()
directly from gen_pci_calc_io_offset where you have the right number?

> +	bus_range = &pci->cfg.bus_range;
> +	for (busn = bus_range->start; busn <= bus_range->end; ++busn) {
> +		u32 idx = busn - bus_range->start;
> +		u32 sz = 1 << pci->cfg.ops->bus_shift;
> +
> +		pci->cfg.win[idx] = devm_ioremap(dev,
> +						 pci->cfg.res.start + busn * sz,
> +						 sz);
> +		if (!pci->cfg.win[idx]) {
> +			err = -ENOMEM;
> +			goto out_unmap_cfg;
> +		}
> +	}

I saw a trick in the tegra driver that maps the buses dynamically during
probe. While I mentioned that we can't dynamically map/unmap the config
space during access, it's probably fine to just map each bus at the first
access, since that will happen during the initial bus probe that is allowed
to sleep.

	Arnd
