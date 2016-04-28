Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60803 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750847AbcD1Vry (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 28 Apr 2016 17:47:54 -0400
Date: Thu, 28 Apr 2016 16:47:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tomasz Nowicki <tn@semihalf.com>
Cc: arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com,
	rafael@kernel.org, hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org,
	jiang.liu@linux.intel.com, jchandra@broadcom.com,
	robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jcm@redhat.com
Subject: Re: [PATCH V6 07/13] PCI: Provide common functions for ECAM mapping
Message-ID: <20160428214749.GF25125@localhost>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
 <1460740008-19489-8-git-send-email-tn@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1460740008-19489-8-git-send-email-tn@semihalf.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 15, 2016 at 07:06:42PM +0200, Tomasz Nowicki wrote:
> From: Jayachandran C <jchandra@broadcom.com>
> 
> Add config option PCI_GENERIC_ECAM and file drivers/pci/ecam.c to
> provide generic functions for accessing memory mapped PCI config space.
> 
> The API is defined in drivers/pci/ecam.h and is written to replace the
> API in drivers/pci/host/pci-host-common.h. The file defines a new
> 'struct pci_config_window' to hold the information related to a PCI
> config area and its mapping. This structure is expected to be used as
> sysdata for controllers that have ECAM based mapping.
> 
> Helper functions are provided to setup the mapping, free the mapping
> and to implement the map_bus method in 'struct pci_ops'

Spec reference: PCI Express Base Specification, rev 3.0, sec 7.2.2.

> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
> ---
>  drivers/pci/Kconfig  |   3 ++
>  drivers/pci/Makefile |   2 +
>  drivers/pci/ecam.c   | 137 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/ecam.h   |  61 +++++++++++++++++++++++
>  4 files changed, 203 insertions(+)
>  create mode 100644 drivers/pci/ecam.c
>  create mode 100644 drivers/pci/ecam.h
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 209292e..e930d62 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -83,6 +83,9 @@ config HT_IRQ
>  config PCI_ATS
>  	bool
>  
> +config PCI_GENERIC_ECAM
> +	bool

"PCI_ECAM" is enough, I think.  It's defined by and required by the
spec unless there's some arch-specific interface.  Plus, if I
understand correctly, this infrastructure supports non-generic ECAM
implementations as well, since the caller supplies "struct
pci_generic_ecam_ops *ops".

>  config PCI_IOV
>  	bool "PCI IOV support"
>  	depends on PCI
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 2154092..810aec8 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -55,6 +55,8 @@ obj-$(CONFIG_PCI_SYSCALL) += syscall.o
>  
>  obj-$(CONFIG_PCI_STUB) += pci-stub.o
>  
> +obj-$(CONFIG_PCI_GENERIC_ECAM) += ecam.o
> +
>  obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
>  
>  obj-$(CONFIG_OF) += of.o
> diff --git a/drivers/pci/ecam.c b/drivers/pci/ecam.c
> new file mode 100644
> index 0000000..ff04c01
> --- /dev/null
> +++ b/drivers/pci/ecam.c
> @@ -0,0 +1,137 @@
> +/*
> + * Copyright 2016 Broadcom
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, version 2, as
> + * published by the Free Software Foundation (the "GPL").
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License version 2 (GPLv2) for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * version 2 (GPLv2) along with this source code.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/slab.h>
> +
> +#include "ecam.h"
> +
> +/*
> + * On 64 bit systems, we do a single ioremap for the whole config space
> + * since we have enough virtual address range available. On 32 bit, do an
> + * ioremap per bus.
> + */
> +static const bool per_bus_mapping = !config_enabled(CONFIG_64BIT);
> +
> +/*
> + * Create a PCI config space window
> + *  - reserve mem region
> + *  - alloc struct pci_config_window with space for all mappings
> + *  - ioremap the config space
> + */
> +struct pci_config_window *pci_generic_ecam_create(struct device *dev,
> +				phys_addr_t addr, u8 bus_start, u8 bus_end,

Can you take pointers to struct resources here instead of addr,
bus_start, and bus_end?  The caller probably has them already, and
then you could add a useful printk like:

  dev_info(dev, "ECAM for %pR at %pR\n", busn_res, mmio_res);

Would have to be careful about the struct resource lifetimes though.

If you had the MMIO resource here, you could also do the range
checking you currently have in gen_pci_init() here instead, so all
callers could benefit.

> +				struct pci_generic_ecam_ops *ops)
> +{
> +	struct pci_config_window *cfg;
> +	unsigned int bus_shift, bus_range, bsz, mapsz;
> +	int i, nidx;
> +	int err = -ENOMEM;
> +
> +	if (bus_end < bus_start)
> +		return ERR_PTR(-EINVAL);
> +
> +	bus_shift = ops->bus_shift;
> +	bus_range = bus_end - bus_start + 1;
> +	bsz = 1 << bus_shift;
> +	nidx = per_bus_mapping ? bus_range : 1;
> +	mapsz = per_bus_mapping ? bsz : bus_range * bsz;
> +	cfg = kzalloc(sizeof(*cfg) + nidx * sizeof(cfg->win[0]), GFP_KERNEL);
> +	if (!cfg)
> +		return ERR_PTR(-ENOMEM);
> +
> +	cfg->bus_start = bus_start;
> +	cfg->bus_end = bus_end;
> +	cfg->ops = ops;
> +
> +	if (!request_mem_region(addr, bus_range * bsz, "Configuration Space"))
> +		goto err_exit;
> +
> +	/* cfgaddr has to be set after request_mem_region */
> +	cfg->cfgaddr = addr;
> +
> +	for (i = 0; i < nidx; i++) {
> +		cfg->win[i] = ioremap(addr + i * mapsz, mapsz);
> +		if (!cfg->win[i])
> +			goto err_exit;
> +	}
> +
> +	if (cfg->ops->init) {
> +		err = cfg->ops->init(dev, cfg);
> +		if (err)
> +			goto err_exit;
> +	}
> +	return cfg;
> +
> +err_exit:
> +	pci_generic_ecam_free(cfg);
> +	return ERR_PTR(err);
> +}
> +
> +/*
> + * Free a config space mapping
> + */

Superfluous comment.

> +void pci_generic_ecam_free(struct pci_config_window *cfg)
> +{
> +	unsigned int bus_range;
> +	int i, nidx;
> +
> +	bus_range = cfg->bus_end - cfg->bus_start + 1;
> +	nidx = per_bus_mapping ? bus_range : 1;
> +	for (i = 0; i < nidx; i++)
> +		if (cfg->win[i])
> +			iounmap(cfg->win[i]);
> +	if (cfg->cfgaddr)
> +		release_mem_region(cfg->cfgaddr,
> +				   bus_range << cfg->ops->bus_shift);
> +	kfree(cfg);
> +}
> +
> +/*
> + * Function to implement the pci_ops ->map_bus method
> + */
> +void __iomem *pci_generic_ecam_map_bus(struct pci_bus *bus, unsigned int devfn,
> +				       int where)
> +{
> +	struct pci_config_window *cfg = bus->sysdata;

I don't really like the use of bus->sysdata here, because sysdata is
explicitly arch-specific.

But I guess we're in a bind right now: it'd be nice to save the cfg
pointer in struct pci_host_bridge, but you have to call
pci_generic_ecam_create() before the struct pci_host_bridge has been
allocated, and you have to pass the pointer into pci_scan_root_bus(),
and there's no generic way to do that yet.

So I guess this will have to do for now.

> +	unsigned int devfn_shift = cfg->ops->bus_shift - 8;
> +	unsigned int busn = bus->number;
> +	void __iomem *base;
> +
> +	if (busn < cfg->bus_start || busn > cfg->bus_end)
> +		return NULL;
> +
> +	busn -= cfg->bus_start;
> +	if (per_bus_mapping)
> +		base = cfg->win[busn];
> +	else
> +		base = cfg->win[0] + (busn << cfg->ops->bus_shift);
> +	return base + (devfn << devfn_shift) + where;
> +}
> +
> +/* default ECAM ops */
> +struct pci_generic_ecam_ops pci_generic_ecam_default_ops = {

Using both "generic" and "default" seems overkill.  Maybe just:

  struct pci_ecam_ops pci_generic_ecam_ops = { ... ?

> +	.bus_shift	= 20,
> +	.pci_ops		= {
> +		.map_bus	= pci_generic_ecam_map_bus,
> +		.read		= pci_generic_config_read,
> +		.write		= pci_generic_config_write,
> +	}
> +};
> diff --git a/drivers/pci/ecam.h b/drivers/pci/ecam.h
> new file mode 100644
> index 0000000..34c0aba
> --- /dev/null
> +++ b/drivers/pci/ecam.h
> @@ -0,0 +1,61 @@
> +/*
> + * Copyright 2016 Broadcom
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, version 2, as
> + * published by the Free Software Foundation (the "GPL").
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License version 2 (GPLv2) for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * version 2 (GPLv2) along with this source code.
> + */
> +#ifndef DRIVERS_PCI_ECAM_H
> +#define DRIVERS_PCI_ECAM_H
> +
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +
> +/*
> + * struct to hold pci ops and bus shift of the config window
> + * for a PCI controller.
> + */
> +struct pci_config_window;
> +struct pci_generic_ecam_ops {

"struct pci_ecam_ops"

> +	unsigned int			bus_shift;
> +	struct pci_ops			pci_ops;
> +	int				(*init)(struct device *,
> +						struct pci_config_window *);
> +};
> +
> +/*
> + * struct to hold the mappings of a config space window. This
> + * will be allocated with enough entries in win[] to hold all
> + * the mappings for the bus range.
> + */
> +struct pci_config_window {
> +	phys_addr_t			cfgaddr;
> +	u16				domain;
> +	u8				bus_start;
> +	u8				bus_end;
> +	void				*priv;
> +	struct pci_generic_ecam_ops	*ops;
> +	void __iomem			*win[0];
> +};
> +
> +/* create and free for pci_config_window */

Superfluous comment.

> +struct pci_config_window *pci_generic_ecam_create(struct device *dev,
> +				phys_addr_t addr, u8 bus_start, u8 bus_end,
> +				struct pci_generic_ecam_ops *ops);
> +void pci_generic_ecam_free(struct pci_config_window *cfg);

"pci_ecam_create" and "pci_ecam_free"?  I suspect you're going to call
these for flavors of ECAM that are definitely not "generic".

> +/* map_bus when ->sysdata is an instance of pci_config_window */
> +void __iomem *pci_generic_ecam_map_bus(struct pci_bus *bus, unsigned int devfn,
> +				       int where);
> +/* default ECAM ops, bus shift 20, generic read and write */
> +extern struct pci_generic_ecam_ops pci_generic_ecam_default_ops;
> +
> +#endif
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
