Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 28 Nov 2017 14:41:14 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Cc: bhelgaas@google.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, adouglas@cadence.com,
        stelford@cadence.com, dgary@cadence.com, kgopi@cadence.com,
        eandrews@cadence.com, thomas.petazzoni@free-electrons.com,
        sureshp@cadence.com, nsekhar@ti.com, linux-kernel@vger.kernel.org,
        robh@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/5] PCI: cadence: Add host driver for Cadence PCIe
 controller
Message-ID: <20171128204114.GE11228@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1511439189.git.cyrille.pitchen@free-electrons.com>
 <2670f7ddf59e708beb9d32bef1353e15bd4e1ecf.1511439189.git.cyrille.pitchen@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2670f7ddf59e708beb9d32bef1353e15bd4e1ecf.1511439189.git.cyrille.pitchen@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 23, 2017 at 04:01:48PM +0100, Cyrille Pitchen wrote:
> This patch adds support to the Cadence PCIe controller in host mode.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
> ---
>  drivers/Makefile                        |   1 +
>  drivers/pci/Kconfig                     |   1 +
>  drivers/pci/cadence/Kconfig             |  24 ++
>  drivers/pci/cadence/Makefile            |   2 +
>  drivers/pci/cadence/pcie-cadence-host.c | 425 ++++++++++++++++++++++++++++++++
>  drivers/pci/cadence/pcie-cadence.c      | 110 +++++++++
>  drivers/pci/cadence/pcie-cadence.h      | 325 ++++++++++++++++++++++++
>  7 files changed, 888 insertions(+)
>  create mode 100644 drivers/pci/cadence/Kconfig
>  create mode 100644 drivers/pci/cadence/Makefile
>  create mode 100644 drivers/pci/cadence/pcie-cadence-host.c
>  create mode 100644 drivers/pci/cadence/pcie-cadence.c
>  create mode 100644 drivers/pci/cadence/pcie-cadence.h

I prefer a single file per driver.  I assume you're anticipating
something like dwc, where the DesignWare core is incorporated into
several devices in slightly different ways.  But it doesn't look like
that's here yet, and personally, I'd rather split out the required
things when they actually become required, not ahead of time.

> diff --git a/drivers/Makefile b/drivers/Makefile
> index 1d034b680431..27bdd98784d9 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -18,6 +18,7 @@ obj-y				+= pwm/
>  
>  obj-$(CONFIG_PCI)		+= pci/
>  obj-$(CONFIG_PCI_ENDPOINT)	+= pci/endpoint/
> +obj-$(CONFIG_PCI_CADENCE)	+= pci/cadence/

I can't remember why we added CONFIG_PCI_ENDPOINT here instead of in
drivers/pci/Makefile.  Is there any way to move both CONFIG_PCI_ENDPOINT
and CONFIG_PCI_CADENCE into drivers/pci/Makefile so this is better
encapsulated?

>  # PCI dwc controller drivers
>  obj-y				+= pci/dwc/
>...

> + * struct cdns_pcie_rc_data - hardware specific data

"cdns" is a weird abbreviation for "Cadence", since "Cadence" doesn't
contain an "s".

>...
> +static int cdns_pcie_parse_request_of_pci_ranges(struct device *dev,
> +						 struct list_head *resources,
> +						 struct resource **bus_range)
> +{
> +	int err, res_valid = 0;
> +	struct device_node *np = dev->of_node;
> +	resource_size_t iobase;
> +	struct resource_entry *win, *tmp;
> +
> +	err = of_pci_get_host_bridge_resources(np, 0, 0xff, resources, &iobase);
> +	if (err)
> +		return err;
> +
> +	err = devm_request_pci_bus_resources(dev, resources);
> +	if (err)
> +		return err;
> +
> +	resource_list_for_each_entry_safe(win, tmp, resources) {
> +		struct resource *res = win->res;
> +
> +		switch (resource_type(res)) {
> +		case IORESOURCE_IO:
> +			err = pci_remap_iospace(res, iobase);
> +			if (err) {
> +				dev_warn(dev, "error %d: failed to map resource %pR\n",
> +					 err, res);
> +				resource_list_destroy_entry(win);
> +			}
> +			break;
> +		case IORESOURCE_MEM:
> +			res_valid |= !(res->flags & IORESOURCE_PREFETCH);
> +			break;
> +		case IORESOURCE_BUS:
> +			*bus_range = res;
> +			break;
> +		}
> +	}
> +
> +	if (res_valid)
> +		return 0;
> +
> +	dev_err(dev, "non-prefetchable memory resource required\n");
> +	return -EINVAL;
> +}

The code above is starting to look awfully familiar.  I wonder if it's
time to think about some PCI-internal interface that can encapsulate
this.  In this case, there's really nothing Cadence-specific here.
There are other callers where there *is* vendor-specific code, but
possibly that could be handled by returning pointers to bus number,
I/O port, and MMIO resources so the caller could do the
vendor-specific stuff?

Bjorn
