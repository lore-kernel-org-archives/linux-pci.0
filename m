Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 27 May 2015 16:04:47 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] PCI: Only enable IO window if supported
Message-ID: <20150527210447.GY32152@google.com>
References: <1432342336-25832-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432342336-25832-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Lorenzo, Suravee, Will]

I cc'd Lorenzo, Suravee, and Will because Lorenzo is working on calling
pci_read_bases() from the PCI core instead of from arch code, and there are
likely some dependencies between these two things.

On Fri, May 22, 2015 at 05:52:16PM -0700, Guenter Roeck wrote:
> The PCI subsystem always assumes that I/O is supported on PCIe bridges
> and tries to assign an I/O window to each port even if that is not
> the case.
> 
> This may result in messages such as
> 
> pcieport 0000:02:00.0: res[7]=[io  0x1000-0x0fff]
> 					get_res_add_size add_size 1000
> pcieport 0000:02:00.0: BAR 7: no space for [io  size 0x1000]
> pcieport 0000:02:00.0: BAR 7: failed to assign [io  size 0x1000]
> 
> for each bridge port, even if a port or its parent does not support
> I/O in the first place.
> 
> To avoid this message, check if a port supports I/O before trying to
> enable it. Also check if port's parent supports I/O, and only modify
> a port's I/O resource size if both the port and its parent support I/O.
> 
> If IO is disabled after the initial port scan, the IO base and size
> registers are set to 0x00f0 to indicate that IO is disabled. A later
> rescan interprets this as "IO supported" and enables the IO range,
> even if the parent does not support IO. Handle this situation as well.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/pci/probe.c     | 14 ++++++++++++++
>  drivers/pci/setup-bus.c |  4 ++--
>  include/linux/pci.h     |  9 +++++++++
>  3 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 6675a7a1b9fc..f4944ef45148 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -354,6 +354,20 @@ static void pci_read_bridge_io(struct pci_bus *child)
>  	base = (io_base_lo & io_mask) << 8;
>  	limit = (io_limit_lo & io_mask) << 8;
>  
> +	/* If necessary, check if the bridge supports an I/O aperture */
> +	if (!io_base_lo && !io_limit_lo) {
> +		u16 io;
> +
> +		if (!pci_parent_supports_io(child))
> +			return;
> +
> +		pci_write_config_word(dev, PCI_IO_BASE, 0xe0f0);
> +		pci_read_config_word(dev, PCI_IO_BASE, &io);
> +		pci_write_config_word(dev, PCI_IO_BASE, 0x0);
> +		if (!io)
> +			return;
> +	}

I really like the idea of pushing this into pci_read_bridge_io().

I wonder if we can do the same with pci_read_bridge_mmio_pref(), and
somehow get rid of pci_bridge_check_ranges() altogether?

I think I looked at doing that a while back, and it seems like there was
some wrinkle, but I don't remember what it was.

It does make sense that if the bridge supports an I/O aperture, but there's
no possibility of I/O resources on the primary side, we should pretend the
bridge has no I/O aperture.  But I think it might be nice to emit a
diagnostic about *why* we're ignoring it.  Otherwise there's a little
discrepancy between dmesg and lspci.

> +
>  	if ((io_base_lo & PCI_IO_RANGE_TYPE_MASK) == PCI_IO_RANGE_TYPE_32) {
>  		u16 io_base_hi, io_limit_hi;
>  
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 4fd0cacf7ca0..963b31a109a9 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -750,12 +750,12 @@ static void pci_bridge_check_ranges(struct pci_bus *bus)
>  	b_res[1].flags |= IORESOURCE_MEM;
>  
>  	pci_read_config_word(bridge, PCI_IO_BASE, &io);
> -	if (!io) {
> +	if (!io && pci_parent_supports_io(bus)) {
>  		pci_write_config_word(bridge, PCI_IO_BASE, 0xe0f0);
>  		pci_read_config_word(bridge, PCI_IO_BASE, &io);
>  		pci_write_config_word(bridge, PCI_IO_BASE, 0x0);
>  	}
> -	if (io)
> +	if (io && (io != 0x00f0 || pci_parent_supports_io(bus)))

I *think* this 0x00f0 depends on what pci_setup_bridge_io() writes to
PCI_IO_BASE when it disables an I/O aperture.  Depending on that particular
value here is sort of ugly and would need at least a comment if we can't
figure out a better way to do it.

But it would be ideal if we could get rid of pci_bridge_check_ranges()
altogether and have the rule that we read bridge window characteristics
(IORESOURCE_IO, IORESOURCE_MEM, IORESOURCE_PREFETCH, IORESOURCE_MEM_64)
once when we enumerate the bridge.  After that, the only changes would be
to change res->start and res->end and update the hardware correspondingly.

I'd like res->flags to reflect the capabilities of the hardware, not
whether the window is currently enabled.

>  		b_res[0].flags |= IORESOURCE_IO;
>  
>  	/*  DECchip 21050 pass 2 errata: the bridge may miss an address
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 353db8dc4c6e..f3de9e24aab1 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -489,6 +489,15 @@ static inline bool pci_is_root_bus(struct pci_bus *pbus)
>  	return !(pbus->parent);
>  }
>  
> +/*
> + * Returns true if the parent bus supports an I/O aperture.
> + */
> +static inline bool pci_parent_supports_io(struct pci_bus *pbus)
> +{
> +	return pci_is_root_bus(pbus) || pci_is_root_bus(pbus->parent) ||
> +	       (pbus->parent->resource[0]->flags & IORESOURCE_IO);

This is not obvious to me.  There are host bridges that do not have I/O
apertures, so I don't see what the pci_is_root_bus() tests have to do with
this.  The resource[0]->flags & IORESOURCE_IO part does make sense to me.

I think at the root bus, we'd have to iterate through all the host bridge
resources to figure out whether there are any I/O apertures.

> +}
> +
>  /**
>   * pci_is_bridge - check if the PCI device is a bridge
>   * @dev: PCI device
> -- 
> 2.1.0
> 
