Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:35789 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753258AbaBYSB5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Feb 2014 13:01:57 -0500
Date: Tue, 25 Feb 2014 18:01:11 +0000
From: Will Deacon <will.deacon@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"jgunthorpe@obsidianresearch.com" <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH v4] PCI: ARM: add support for generic PCI host controller
Message-ID: <20140225180111.GF23136@mudshark.cambridge.arm.com>
References: <1393268359-17224-1-git-send-email-will.deacon@arm.com>
 <1721648.K4nYY7eS55@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1721648.K4nYY7eS55@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd,

On Mon, Feb 24, 2014 at 07:23:23PM +0000, Arnd Bergmann wrote:
> On Monday 24 February 2014 18:59:19 Will Deacon wrote:
> > +    // BUS_ADDRESS(3)  CPU_PHYSICAL(2)  SIZE(2)
> > +    ranges = <0x1000000 0x0 0x01000000  0x0 0x01000000  0x0 0x00010000>,
> > +             <0x2000000 0x0 0x41000000  0x0 0x41000000  0x0 0x3f000000>;
> 
> The I/O window looks very odd. Why would you start it at bus address
> 0x01000000 rather than 0 like everyone else?

I was just trying to change the example, since Jason didn't like me using
CPU physical 0x0. There was also mention of maintaining a 1:1 mapping between
bus address and CPU physical address in a previous version of this thread.

Would you be happy with bus address 0x0 and CPU physical 0x01000000? (I
don't have a feel for realism in my virtual environment :)

> > +static int gen_pci_calc_io_offset(struct device *dev,
> > +				  struct of_pci_range *range,
> > +				  struct resource *res,
> > +				  resource_size_t *offset)
> > +{
> > +	static atomic_t wins = ATOMIC_INIT(0);
> > +	int err, idx, max_win;
> > +	unsigned int io_offset;
> > +
> > +	/* Ensure the CPU physical address is aligned to a 64K boundary */
> > +	range->size += range->cpu_addr & (SZ_64K - 1);
> > +	range->cpu_addr = round_down(range->cpu_addr, SZ_64K);
> > +	range->pci_addr = round_down(range->pci_addr, SZ_64K);
> > +
> > +	if (range->size > SZ_64K)
> > +		return -E2BIG;
> 
> What is the rounding for? Isn't it enough to round to PAGE_SIZE here?
> Do you just want to make sure it works with 64K pages on ARM64? I guess
> if you end up rounding for the mapping, you should later make sure
> that you still only register the original resource.

I need the alignment code so I can handle being passed a CPU physical
address which isn't 64K aligned. In this case, pci_ioremap_io needs a 64K
aligned address so that the __io macro does the right thing.

For example, I can tell kvmtool to place I/O space at CPU physical 0x16000,
bus address 0x6000 (so ports 0x0-0x5fff are unavailable). In that case, I
still need to map those lower ports for the __io macro to offset into the
window correctly.

> Presumably, the size would normally be 64K, so if you add anything
> for rounding, you just fail here. How about cropping to 64K in that
> case?

Yeah, I can do that instead of failing.

> > +	max_win = IO_SPACE_LIMIT + 1 / SZ_64K;
> > +	idx = atomic_inc_return(&wins);
> > +	if (idx >= max_win)
> > +		return -ENOSPC;
> > +
> > +	io_offset = (idx - 1) * SZ_64K;
> > +	err = pci_ioremap_io(io_offset, range->cpu_addr);
> 
> As discussed the last time, calling it "io_offset" here
> is extremely confusing. Don't do that, and call it "window"
> or something appropriate instead.

It's called io_offset because it *is* the thing I'm passing to
pci_add_resource, as you point out later. I can change the name once we've
sorted that out (more below).

> > +	if (err)
> > +		return err;
> > +
> > +	of_pci_range_to_resource(range, dev->of_node, res);
> > +	res->start = io_offset + range->pci_addr;
> > +	res->end = res->start + range->size - 1;
> 
> You have just rounded down range->pci_addr, so the resource
> now contains more than what the bus node described.

I've attempted to fix this below.

> > +	prop = of_get_property(of_chosen, "linux,pci-probe-only", NULL);
> 
> of_property_read_bool()

Ok.

> 
> > +	if (of_pci_parse_bus_range(np, &pci->cfg.bus_range))
> > +		pci->cfg.bus_range = (struct resource) {
> > +			.name	= np->name,
> > +			.start	= 0,
> > +			.end	= 0xff,
> > +			.flags	= IORESOURCE_BUS,
> > +		};
> 
> I wonder if this should just be part of of_pci_parse_bus_range(),
> or maybe an extended helper.

Sure, although I want to get to the point where we're happy with this driver
(from a technical perspective) before I try and split it up into helpers.

> > +	/* Limit the bus-range to fit within reg */
> > +	bus_max = pci->cfg.bus_range.start +
> > +		  (resource_size(&pci->cfg.res) >> pci->cfg.ops->bus_shift) - 1;
> > +	pci->cfg.bus_range.end = min_t(resource_size_t, pci->cfg.bus_range.end,
> > +				       bus_max);
> 
> I think I would instead print a warning and bail out here. This should
> only happen for inconsistent DT properties.

Not sure; that forces somebody to provide a bus-range property if their reg
property doesn't describe the entire [E]CAM space. I think the truncation is
useful in that case.

> > +		err = request_resource(parent, res);
> > +		if (err)
> > +			goto out_release_res;
> > +
> > +		pci_add_resource_offset(&sys->resources, res, offset);
> > +	}
> 
> Wrong offset for the I/O space. Why not call pci_add_resource_offset()
> directly from gen_pci_calc_io_offset where you have the right number?

You're thinking of passing in io_offset - range->pci_addr, right? So, along
with the earlier feedback, we get something along the lines of (I can move the
resource registration in here, but this is just for discussion atm):


static int gen_pci_calc_io_offset(struct device *dev,
				  struct of_pci_range *range,
				  struct resource *res,
				  resource_size_t *offset)
{
	static atomic_t wins = ATOMIC_INIT(0);
	int err, idx, max_win;
	unsigned int window;

	max_win = (IO_SPACE_LIMIT + 1) / SZ_64K;
	idx = atomic_inc_return(&wins);
	if (idx >= max_win)
		return -ENOSPC;

	window = (idx - 1) * SZ_64K;
	err = pci_ioremap_io(window, round_down(range->cpu_addr, SZ_64K));
	if (err)
		return err;

	of_pci_range_to_resource(range, dev->of_node, res);
	res->start = window + range->pci_addr;
	res->end = res->start + range->size - 1;
	*offset = window - range->pci_addr;
	return 0;
}


In that case, the PCI core (in pci_create_root_bus) does:


	/* Add initial resources to the bus */
	list_for_each_entry_safe(window, n, resources, list) {
		list_move_tail(&window->list, &bridge->windows);
		res = window->res;
		offset = window->offset;
		if (res->flags & IORESOURCE_BUS)
			pci_bus_insert_busn_res(b, bus, res->end);
		else
			pci_bus_add_resource(b, res, 0);
		if (offset) {
			if (resource_type(res) == IORESOURCE_IO)
				fmt = " (bus address [%#06llx-%#06llx])";
			else
				fmt = " (bus address [%#010llx-%#010llx])";
			snprintf(bus_addr, sizeof(bus_addr), fmt,
				 (unsigned long long) (res->start - offset),
				 (unsigned long long) (res->end - offset));
		} else
			bus_addr[0] = '\0';
		dev_info(&b->dev, "root bus resource %pR%s\n", res, bus_addr);
	}


so here, we print out the `bus address' by computing res->start (window +
range->pci_addr in my driver) - window->offset. That means that
window->offset needs to equal window, otherwise the probing code gets in a
pickle:

  pci_bus 0000:00: root bus resource [io 0x6000-0xffff] (bus address [0xc000-0x15fff])

and then attempts to re-assign BARs with bogus addresses.

If I do:

	*offset = window;

then things work as expected (this is all referring back to the kvmtool example
I mentioned earlier in this mail).

As discussed on IRC, we're almost certainly continuing to talk past each
other, but hopefully this example helps show where I'm coming from with the
current code.

> > +	bus_range = &pci->cfg.bus_range;
> > +	for (busn = bus_range->start; busn <= bus_range->end; ++busn) {
> > +		u32 idx = busn - bus_range->start;
> > +		u32 sz = 1 << pci->cfg.ops->bus_shift;
> > +
> > +		pci->cfg.win[idx] = devm_ioremap(dev,
> > +						 pci->cfg.res.start + busn * sz,
> > +						 sz);
> > +		if (!pci->cfg.win[idx]) {
> > +			err = -ENOMEM;
> > +			goto out_unmap_cfg;
> > +		}
> > +	}
> 
> I saw a trick in the tegra driver that maps the buses dynamically during
> probe. While I mentioned that we can't dynamically map/unmap the config
> space during access, it's probably fine to just map each bus at the first
> access, since that will happen during the initial bus probe that is allowed
> to sleep.

I don't really see what that gains us if we have the bus-range property
(which keeps the config accessors pretty clean).

Cheers,

Will
