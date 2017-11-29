Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:43302 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750783AbdK2SYs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Nov 2017 13:24:48 -0500
Date: Wed, 29 Nov 2017 18:25:15 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Cc: bhelgaas@google.com, kishon@ti.com, linux-pci@vger.kernel.org,
        adouglas@cadence.com, stelford@cadence.com, dgary@cadence.com,
        kgopi@cadence.com, eandrews@cadence.com,
        thomas.petazzoni@free-electrons.com, sureshp@cadence.com,
        nsekhar@ti.com, linux-kernel@vger.kernel.org, robh@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 3/5] PCI: cadence: Add host driver for Cadence PCIe
 controller
Message-ID: <20171129182514.GA1087@red-moon>
References: <cover.1511439189.git.cyrille.pitchen@free-electrons.com>
 <2670f7ddf59e708beb9d32bef1353e15bd4e1ecf.1511439189.git.cyrille.pitchen@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2670f7ddf59e708beb9d32bef1353e15bd4e1ecf.1511439189.git.cyrille.pitchen@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[w/o unintended disclaimer]

On Thu, Nov 23, 2017 at 04:01:48PM +0100, Cyrille Pitchen wrote:
> This patch adds support to the Cadence PCIe controller in host mode.

Bjorn already commented on this, it would be good to add some
of the cover letter details in this log.

> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
> ---
>  drivers/Makefile                        |   1 +
>  drivers/pci/Kconfig                     |   1 +
>  drivers/pci/cadence/Kconfig             |  24 ++
>  drivers/pci/cadence/Makefile            |   2 +
>  drivers/pci/cadence/pcie-cadence-host.c | 425 ++++++++++++++++++++++++++++++++

You should also update the MAINTAINERS file.

>  drivers/pci/cadence/pcie-cadence.c      | 110 +++++++++
>  drivers/pci/cadence/pcie-cadence.h      | 325 ++++++++++++++++++++++++
>  7 files changed, 888 insertions(+)
>  create mode 100644 drivers/pci/cadence/Kconfig
>  create mode 100644 drivers/pci/cadence/Makefile
>  create mode 100644 drivers/pci/cadence/pcie-cadence-host.c
>  create mode 100644 drivers/pci/cadence/pcie-cadence.c
>  create mode 100644 drivers/pci/cadence/pcie-cadence.h
> 
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 1d034b680431..27bdd98784d9 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -18,6 +18,7 @@ obj-y				+= pwm/
>  
>  obj-$(CONFIG_PCI)		+= pci/
>  obj-$(CONFIG_PCI_ENDPOINT)	+= pci/endpoint/
> +obj-$(CONFIG_PCI_CADENCE)	+= pci/cadence/

Already commented on the cover letter.

>  # PCI dwc controller drivers
>  obj-y				+= pci/dwc/
>  
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 90944667ccea..2471b2e36b8b 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -144,6 +144,7 @@ config PCI_HYPERV
>            PCI devices from a PCI backend to support PCI driver domains.
>  
>  source "drivers/pci/hotplug/Kconfig"
> +source "drivers/pci/cadence/Kconfig"
>  source "drivers/pci/dwc/Kconfig"
>  source "drivers/pci/host/Kconfig"
>  source "drivers/pci/endpoint/Kconfig"
> diff --git a/drivers/pci/cadence/Kconfig b/drivers/pci/cadence/Kconfig
> new file mode 100644
> index 000000000000..120306cae2aa
> --- /dev/null
> +++ b/drivers/pci/cadence/Kconfig
> @@ -0,0 +1,24 @@
> +menuconfig PCI_CADENCE
> +	bool "Cadence PCI controllers support"
> +	depends on PCI && HAS_IOMEM
> +	help
> +	  Say Y here if you want to support some Cadence PCI controller.
> +
> +	  When in doubt, say N.
> +
> +if PCI_CADENCE
> +
> +config PCIE_CADENCE
> +	bool
> +
> +config PCIE_CADENCE_HOST
> +	bool "Cadence PCIe host controller"
> +	depends on OF
> +	depends on PCI_MSI_IRQ_DOMAIN

I do not see the reason for this dependency in the code.

> +	select PCIE_CADENCE
> +	help
> +	  Say Y here if you want to support the Cadence PCIe controller in host
> +	  mode. This PCIe controller may be embedded into many different vendors
> +	  SoCs.
> +
> +endif # PCI_CADENCE
> diff --git a/drivers/pci/cadence/Makefile b/drivers/pci/cadence/Makefile
> new file mode 100644
> index 000000000000..d57d192d2595
> --- /dev/null
> +++ b/drivers/pci/cadence/Makefile
> @@ -0,0 +1,2 @@
> +obj-$(CONFIG_PCIE_CADENCE) += pcie-cadence.o
> +obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host.o
> diff --git a/drivers/pci/cadence/pcie-cadence-host.c b/drivers/pci/cadence/pcie-cadence-host.c
> new file mode 100644
> index 000000000000..252471e72a93
> --- /dev/null
> +++ b/drivers/pci/cadence/pcie-cadence-host.c
> @@ -0,0 +1,425 @@
> +/*
> + * Cadence PCIe host controller driver.
> + *
> + * Copyright (c) 2017 Cadence
> + *
> + * Author: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +#include <linux/kernel.h>
> +#include <linux/of_address.h>
> +#include <linux/of_pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +
> +#include "pcie-cadence.h"
> +
> +/**
> + * struct cdns_pcie_rc_data - hardware specific data
> + * @max_regions: maximum number of regions supported by the hardware
> + * @vendor_id: PCI vendor ID
> + * @device_id: PCI device ID
> + * @no_bar_nbits: Number of bits to keep for inbound (PCIe -> CPU) address
> + *                translation (nbits sets into the "no BAR match" register).
> + */
> +struct cdns_pcie_rc_data {
> +	size_t			max_regions;

Reason for it to be size_t ?

> +	u16			vendor_id;
> +	u16			device_id;
> +	u8			no_bar_nbits;
> +};

I think that this data should come from DT (?) more below.

> +
> +/**
> + * struct cdns_pcie_rc - private data for this PCIe Root Complex driver
> + * @pcie: Cadence PCIe controller
> + * @dev: pointer to PCIe device
> + * @cfg_res: start/end offsets in the physical system memory to map PCI
> + *           configuration space accesses
> + * @bus_range: first/last buses behind the PCIe host controller
> + * @cfg_base: IO mapped window to access the PCI configuration space of a
> + *            single function at a time
> + * @data: pointer to a 'struct cdns_pcie_rc_data'
> + */
> +struct cdns_pcie_rc {
> +	struct cdns_pcie	pcie;
> +	struct device		*dev;
> +	struct resource		*cfg_res;
> +	struct resource		*bus_range;
> +	void __iomem		*cfg_base;
> +	const struct cdns_pcie_rc_data	*data;
> +};
> +
> +static void __iomem *

Please do not split lines like this, storage class and return type
should be in the same line as the name, move parameter(s) to a new
line.

static void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
				      int where)

> +cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn, int where)
> +{
> +	struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
> +	struct cdns_pcie_rc *rc = pci_host_bridge_priv(bridge);
> +	struct cdns_pcie *pcie = &rc->pcie;
> +	unsigned int busn = bus->number;
> +	u32 addr0, desc0;
> +
> +	if (busn < rc->bus_range->start || busn > rc->bus_range->end)
> +		return NULL;

It does not hurt but I wonder whether you really need this check.

> +	if (busn == rc->bus_range->start) {
> +		if (devfn)

I suspect I know why you need this check but I ask you to explain it
anyway if you do not mind please.

> +			return NULL;
> +
> +		return pcie->reg_base + (where & 0xfff);
> +	}
> +
> +	/* Update Output registers for AXI region 0. */
> +	addr0 = CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_NBITS(12) |

Ok, so for every config access you reprogram addr0 to reflect the
correct bus|devfn ID in the PCI bus TLP corresponding to an ECAM address
in CPU physical address space, is my understanding correct ?

> +		CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_DEVFN(devfn) |
> +		CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_BUS(busn);
> +	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_PCI_ADDR0(0), addr0);
> +
> +	/* Configuration Type 0 or Type 1 access. */
> +	desc0 = CDNS_PCIE_AT_OB_REGION_DESC0_HARDCODED_RID |
> +		CDNS_PCIE_AT_OB_REGION_DESC0_DEVFN(0);
> +	/*
> +	 * The bus number was already set once for all in desc1 by
> +	 * cdns_pcie_host_init_address_translation().
> +	 */
> +	if (busn == rc->bus_range->start + 1)
> +		desc0 |= CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_CONF_TYPE0;
> +	else
> +		desc0 |= CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_CONF_TYPE1;

I would like to ask you why you have to do it here and the root port
does not figure it out by itself, I do not have the datasheet so I am
just asking for my own information.

> +	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_DESC0(0), desc0);
> +
> +	return rc->cfg_base + (where & 0xfff);
> +}
> +
> +static struct pci_ops cdns_pcie_host_ops = {
> +	.map_bus	= cdns_pci_map_bus,
> +	.read		= pci_generic_config_read,
> +	.write		= pci_generic_config_write,
> +};
> +
> +static const struct cdns_pcie_rc_data cdns_pcie_rc_data = {
> +	.max_regions	= 32,
> +	.vendor_id	= PCI_VENDOR_ID_CDNS,
> +	.device_id	= 0x0200,
> +	.no_bar_nbits	= 32,
> +};

Should (some of) these parameters be retrieved through a DT binding ?

> +static const struct of_device_id cdns_pcie_host_of_match[] = {
> +	{ .compatible = "cdns,cdns-pcie-host",
> +	  .data = &cdns_pcie_rc_data },
> +
> +	{ },
> +};
> +
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

Nit, I prefer you swap these two as it is done in pci-aardvark.c:

	if (!res_valid) {
		dev_err(dev, "non-prefetchable memory resource required\n");
		return -EINVAL;
	}

	return 0;

but as per previous replies this function can be factorized in
core PCI code - I would not bother unless you are willing to write
the patch series that does the refactoring yourself :)

> +}
> +
> +static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
> +{
> +	const struct cdns_pcie_rc_data *data = rc->data;
> +	struct cdns_pcie *pcie = &rc->pcie;
> +	u8 pbn, sbn, subn;
> +	u32 value, ctrl;
> +
> +	/*
> +	 * Set the root complex BAR configuration register:
> +	 * - disable both BAR0 and BAR1.
> +	 * - enable Prefetchable Memory Base and Limit registers in type 1
> +	 *   config space (64 bits).
> +	 * - enable IO Base and Limit registers in type 1 config
> +	 *   space (32 bits).
> +	 */
> +	ctrl = CDNS_PCIE_LM_BAR_CFG_CTRL_DISABLED;
> +	value = CDNS_PCIE_LM_RC_BAR_CFG_BAR0_CTRL(ctrl) |
> +		CDNS_PCIE_LM_RC_BAR_CFG_BAR1_CTRL(ctrl) |
> +		CDNS_PCIE_LM_RC_BAR_CFG_PREFETCH_MEM_ENABLE |
> +		CDNS_PCIE_LM_RC_BAR_CFG_PREFETCH_MEM_64BITS |
> +		CDNS_PCIE_LM_RC_BAR_CFG_IO_ENABLE |
> +		CDNS_PCIE_LM_RC_BAR_CFG_IO_32BITS;
> +	cdns_pcie_writel(pcie, CDNS_PCIE_LM_RC_BAR_CFG, value);
> +
> +	/* Set root port configuration space */
> +	if (data->vendor_id != 0xffff)
> +		cdns_pcie_rp_writew(pcie, PCI_VENDOR_ID, data->vendor_id);
> +	if (data->device_id != 0xffff)
> +		cdns_pcie_rp_writew(pcie, PCI_DEVICE_ID, data->device_id);
> +
> +	cdns_pcie_rp_writeb(pcie, PCI_CLASS_REVISION, 0);
> +	cdns_pcie_rp_writeb(pcie, PCI_CLASS_PROG, 0);
> +	cdns_pcie_rp_writew(pcie, PCI_CLASS_DEVICE, PCI_CLASS_BRIDGE_PCI);
> +
> +	pbn = rc->bus_range->start;
> +	sbn = pbn + 1; /* Single root port. */
> +	subn = rc->bus_range->end;
> +	cdns_pcie_rp_writeb(pcie, PCI_PRIMARY_BUS, pbn);
> +	cdns_pcie_rp_writeb(pcie, PCI_SECONDARY_BUS, sbn);
> +	cdns_pcie_rp_writeb(pcie, PCI_SUBORDINATE_BUS, subn);

Again - I do not have the datasheet for this device therefore I would
kindly ask you how this works; it seems to me that what you are doing
here is done through normal configuration cycles in an ECAM compliant
system to program the RP PRIMARY/SECONDARY/SUBORDINATE bus - I would
like to understand why this code is needed.

> +	return 0;
> +}
> +
> +static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
> +{
> +	struct cdns_pcie *pcie = &rc->pcie;
> +	struct resource *cfg_res = rc->cfg_res;
> +	struct resource *mem_res = pcie->mem_res;
> +	struct resource *bus_range = rc->bus_range;
> +	struct device *dev = rc->dev;
> +	struct device_node *np = dev->of_node;
> +	struct of_pci_range_parser parser;
> +	struct of_pci_range range;
> +	u32 addr0, addr1, desc1;
> +	u64 cpu_addr;
> +	int r, err;
> +
> +	/*
> +	 * Reserve region 0 for PCI configure space accesses:
> +	 * OB_REGION_PCI_ADDR0 and OB_REGION_DESC0 are updated dynamically by
> +	 * cdns_pci_map_bus(), other region registers are set here once for all.
> +	 */
> +	addr1 = 0; /* Should be programmed to zero. */
> +	desc1 = CDNS_PCIE_AT_OB_REGION_DESC1_BUS(bus_range->start);
> +	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_PCI_ADDR1(0), addr1);
> +	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_DESC1(0), desc1);
> +
> +	cpu_addr = cfg_res->start - mem_res->start;
> +	addr0 = CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(12) |
> +		(lower_32_bits(cpu_addr) & GENMASK(31, 8));
> +	addr1 = upper_32_bits(cpu_addr);
> +	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_CPU_ADDR0(0), addr0);
> +	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_CPU_ADDR1(0), addr1);
> +
> +	err = of_pci_range_parser_init(&parser, np);
> +	if (err)
> +		return err;
> +
> +	r = 1;
> +	for_each_of_pci_range(&parser, &range) {
> +		bool is_io;
> +
> +		if (r >= rc->data->max_regions)
> +			break;
> +
> +		if ((range.flags & IORESOURCE_TYPE_BITS) == IORESOURCE_MEM)
> +			is_io = false;
> +		else if ((range.flags & IORESOURCE_TYPE_BITS) == IORESOURCE_IO)
> +			is_io = true;
> +		else
> +			continue;
> +
> +		cdns_pcie_set_outbound_region(pcie, r, is_io,
> +					      range.cpu_addr,
> +					      range.pci_addr,
> +					      range.size);
> +		r++;
> +	}
> +
> +	/*
> +	 * Set Root Port no BAR match Inbound Translation registers:
> +	 * needed for MSI.

And DMA :) if I understand what this is doing correctly, ie setting
the root complex decoding for incoming memory traffic.

> +	 * Root Port BAR0 and BAR1 are disabled, hence no need to set their
> +	 * inbound translation registers.
> +	 */
> +	addr0 = CDNS_PCIE_AT_IB_RP_BAR_ADDR0_NBITS(rc->data->no_bar_nbits);
> +	addr1 = 0;
> +	cdns_pcie_writel(pcie, CDNS_PCIE_AT_IB_RP_BAR_ADDR0(RP_NO_BAR), addr0);
> +	cdns_pcie_writel(pcie, CDNS_PCIE_AT_IB_RP_BAR_ADDR1(RP_NO_BAR), addr1);
> +
> +	return 0;
> +}
> +
> +static int cdns_pcie_host_init(struct device *dev,
> +			       struct list_head *resources,
> +			       struct cdns_pcie_rc *rc)
> +{
> +	struct resource *bus_range = NULL;
> +	int err;
> +
> +	/* Parse our PCI ranges and request their resources */
> +	err = cdns_pcie_parse_request_of_pci_ranges(dev, resources, &bus_range);
> +	if (err)
> +		goto err_out;

I think that the err_out path should be part of:

cdns_pcie_parse_request_of_pci_ranges()

implementation and here you would just return.

> +
> +	if (bus_range->start > bus_range->end) {
> +		err = -EINVAL;
> +		goto err_out;
> +	}

Add a space here; this check seems useless to me anyway.

> +	rc->bus_range = bus_range;
> +	rc->pcie.bus = bus_range->start;
> +
> +	err = cdns_pcie_host_init_root_port(rc);
> +	if (err)
> +		goto err_out;
> +
> +	err = cdns_pcie_host_init_address_translation(rc);
> +	if (err)
> +		goto err_out;
> +
> +	return 0;
> +
> + err_out:
> +	pci_free_resource_list(resources);

See above.

> +	return err;
> +}
> +
> +static int cdns_pcie_host_probe(struct platform_device *pdev)
> +{
> +	const struct of_device_id *of_id;
> +	const char *type;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct pci_bus *bus, *child;
> +	struct pci_host_bridge *bridge;
> +	struct list_head resources;
> +	struct cdns_pcie_rc *rc;
> +	struct cdns_pcie *pcie;
> +	struct resource *res;
> +	int ret;
> +
> +	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rc));
> +	if (!bridge)
> +		return -ENOMEM;
> +
> +	rc = pci_host_bridge_priv(bridge);
> +	rc->dev = dev;
> +	platform_set_drvdata(pdev, rc);

I do not think it is needed.

> +	pcie = &rc->pcie;
> +	pcie->is_rc = true;
> +
> +	of_id = of_match_node(cdns_pcie_host_of_match, np);
> +	rc->data = (const struct cdns_pcie_rc_data *)of_id->data;
> +
> +	type = of_get_property(np, "device_type", NULL);
> +	if (!type || strcmp(type, "pci")) {
> +		dev_err(dev, "invalid \"device_type\" %s\n", type);
> +		return -EINVAL;
> +	}
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "reg");
> +	pcie->reg_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(pcie->reg_base)) {
> +		dev_err(dev, "missing \"reg\"\n");
> +		return PTR_ERR(pcie->reg_base);
> +	}
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
> +	rc->cfg_base = devm_ioremap_resource(dev, res);

devm_pci_remap_cfg_resource() please.

> +	if (IS_ERR(rc->cfg_base)) {
> +		dev_err(dev, "missing \"cfg\"\n");
> +		return PTR_ERR(rc->cfg_base);
> +	}
> +	rc->cfg_res = res;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mem");
> +	if (!res) {
> +		dev_err(dev, "missing \"mem\"\n");
> +		return -EINVAL;
> +	}
> +	pcie->mem_res = res;
> +
> +	pm_runtime_enable(dev);
> +	ret = pm_runtime_get_sync(dev);
> +	if (ret < 0) {
> +		dev_err(dev, "pm_runtime_get_sync() failed\n");
> +		goto err_get_sync;
> +	}
> +
> +	INIT_LIST_HEAD(&resources);
> +	ret = cdns_pcie_host_init(dev, &resources, rc);
> +	if (ret)
> +		goto err_init;
> +
> +	list_splice_init(&resources, &bridge->windows);
> +	bridge->dev.parent = dev;
> +	bridge->busnr = pcie->bus;
> +	bridge->ops = &cdns_pcie_host_ops;
> +	bridge->map_irq = of_irq_parse_and_map_pci;
> +	bridge->swizzle_irq = pci_common_swizzle;
> +
> +	ret = pci_scan_root_bus_bridge(bridge);
> +	if (ret < 0) {
> +		dev_err(dev, "Scanning root bridge failed");
> +		goto err_init;
> +	}
> +
> +	bus = bridge->bus;
> +	pci_bus_size_bridges(bus);
> +	pci_bus_assign_resources(bus);
> +
> +	list_for_each_entry(child, &bus->children, node)
> +		pcie_bus_configure_settings(child);
> +
> +	pci_bus_add_devices(bus);
> +
> +	return 0;
> +
> + err_init:
> +	pm_runtime_put_sync(dev);
> +
> + err_get_sync:
> +	pm_runtime_disable(dev);
> +
> +	return ret;
> +}
> +
> +static struct platform_driver cdns_pcie_host_driver = {
> +	.driver = {
> +		.name = "cdns-pcie-host",
> +		.of_match_table = cdns_pcie_host_of_match,
> +	},
> +	.probe = cdns_pcie_host_probe,
> +};
> +builtin_platform_driver(cdns_pcie_host_driver);
> diff --git a/drivers/pci/cadence/pcie-cadence.c b/drivers/pci/cadence/pcie-cadence.c
> new file mode 100644
> index 000000000000..5c10879d5e96
> --- /dev/null
> +++ b/drivers/pci/cadence/pcie-cadence.c
> @@ -0,0 +1,110 @@
> +/*
> + * Cadence PCIe controller driver.
> + *
> + * Copyright (c) 2017 Cadence
> + *
> + * Author: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/kernel.h>
> +
> +#include "pcie-cadence.h"
> +
> +void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u32 r, bool is_io,
> +				   u64 cpu_addr, u64 pci_addr, size_t size)
> +{
> +	/*
> +	 * roundup_pow_of_two() returns an unsigned long, which is not suited
> +	 * for 64bit values.
> +	 */
> +	u64 sz = 1ULL << fls64(size - 1);
> +	int nbits = ilog2(sz);
> +	u32 addr0, addr1, desc0, desc1;
> +
> +	if (nbits < 8)
> +		nbits = 8;
> +
> +	/* Set the PCI address */
> +	addr0 = CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_NBITS(nbits) |
> +		(lower_32_bits(pci_addr) & GENMASK(31, 8));
> +	addr1 = upper_32_bits(pci_addr);
> +
> +	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_PCI_ADDR0(r), addr0);
> +	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_PCI_ADDR1(r), addr1);
> +
> +	/* Set the PCIe header descriptor */
> +	if (is_io)
> +		desc0 = CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_IO;
> +	else
> +		desc0 = CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_MEM;
> +	desc1 = 0;
> +
> +	if (pcie->is_rc) {
> +		desc0 |= CDNS_PCIE_AT_OB_REGION_DESC0_HARDCODED_RID |
> +			 CDNS_PCIE_AT_OB_REGION_DESC0_DEVFN(0);
> +		desc1 |= CDNS_PCIE_AT_OB_REGION_DESC1_BUS(pcie->bus);
> +	}
> +
> +	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_DESC0(r), desc0);
> +	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_DESC1(r), desc1);
> +
> +	/* Set the CPU address */
> +	cpu_addr -= pcie->mem_res->start;
> +	addr0 = CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(nbits) |
> +		(lower_32_bits(cpu_addr) & GENMASK(31, 8));
> +	addr1 = upper_32_bits(cpu_addr);
> +
> +	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_CPU_ADDR0(r), addr0);
> +	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_CPU_ADDR1(r), addr1);
> +}
> +
> +void cdns_pcie_set_outbound_region_for_normal_msg(struct cdns_pcie *pcie, u32 r,
> +						  u64 cpu_addr)

Not used in this patch, you should split it out.

> +{
> +	u32 addr0, addr1, desc0, desc1;
> +
> +	desc0 = CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_NORMAL_MSG;
> +	desc1 = 0;
> +	if (pcie->is_rc) {
> +		desc0 |= CDNS_PCIE_AT_OB_REGION_DESC0_HARDCODED_RID |
> +			 CDNS_PCIE_AT_OB_REGION_DESC0_DEVFN(0);
> +		desc1 |= CDNS_PCIE_AT_OB_REGION_DESC1_BUS(pcie->bus);
> +	}
> +
> +	/* Set the CPU address */
> +	cpu_addr -= pcie->mem_res->start;
> +	addr0 = CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(17) |
> +		(lower_32_bits(cpu_addr) & GENMASK(31, 8));
> +	addr1 = upper_32_bits(cpu_addr);
> +
> +	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_PCI_ADDR0(r), 0);
> +	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_PCI_ADDR1(r), 0);
> +	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_DESC0(r), desc0);
> +	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_DESC1(r), desc1);
> +	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_CPU_ADDR0(r), addr0);
> +	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_CPU_ADDR1(r), addr1);
> +}
> +
> +void cdns_pcie_reset_outbound_region(struct cdns_pcie *pcie, u32 r)
> +{
> +	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_PCI_ADDR0(r), 0);
> +	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_PCI_ADDR1(r), 0);
> +
> +	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_DESC0(r), 0);
> +	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_DESC1(r), 0);
> +
> +	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_CPU_ADDR0(r), 0);
> +	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_CPU_ADDR1(r), 0);
> +}
> diff --git a/drivers/pci/cadence/pcie-cadence.h b/drivers/pci/cadence/pcie-cadence.h
> new file mode 100644
> index 000000000000..195e23b7d4fe
> --- /dev/null
> +++ b/drivers/pci/cadence/pcie-cadence.h
> @@ -0,0 +1,325 @@
> +/*
> + * Cadence PCIe controller driver.
> + *
> + * Copyright (c) 2017 Cadence
> + *
> + * Author: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef _PCIE_CADENCE_H
> +#define _PCIE_CADENCE_H
> +
> +#include <linux/kernel.h>
> +#include <linux/pci.h>
> +
> +/*
> + * Local Management Registers
> + */
> +#define CDNS_PCIE_LM_BASE	0x00100000
> +
> +/* Vendor ID Register */
> +#define CDNS_PCIE_LM_ID		(CDNS_PCIE_LM_BASE + 0x0044)
> +#define  CDNS_PCIE_LM_ID_VENDOR_MASK	GENMASK(15, 0)
> +#define  CDNS_PCIE_LM_ID_VENDOR_SHIFT	0
> +#define  CDNS_PCIE_LM_ID_VENDOR(vid) \
> +	(((vid) << CDNS_PCIE_LM_ID_VENDOR_SHIFT) & CDNS_PCIE_LM_ID_VENDOR_MASK)
> +#define  CDNS_PCIE_LM_ID_SUBSYS_MASK	GENMASK(31, 16)
> +#define  CDNS_PCIE_LM_ID_SUBSYS_SHIFT	16
> +#define  CDNS_PCIE_LM_ID_SUBSYS(sub) \
> +	(((sub) << CDNS_PCIE_LM_ID_SUBSYS_SHIFT) & CDNS_PCIE_LM_ID_SUBSYS_MASK)
> +
> +/* Root Port Requestor ID Register */
> +#define CDNS_PCIE_LM_RP_RID	(CDNS_PCIE_LM_BASE + 0x0228)
> +#define  CDNS_PCIE_LM_RP_RID_MASK	GENMASK(15, 0)
> +#define  CDNS_PCIE_LM_RP_RID_SHIFT	0
> +#define  CDNS_PCIE_LM_RP_RID_(rid) \
> +	(((rid) << CDNS_PCIE_LM_RP_RID_SHIFT) & CDNS_PCIE_LM_RP_RID_MASK)
> +
> +/* Endpoint Bus and Device Number Register */
> +#define CDNS_PCIE_LM_EP_ID	(CDNS_PCIE_LM_BASE + 0x022c)
> +#define  CDNS_PCIE_LM_EP_ID_DEV_MASK	GENMASK(4, 0)
> +#define  CDNS_PCIE_LM_EP_ID_DEV_SHIFT	0
> +#define  CDNS_PCIE_LM_EP_ID_BUS_MASK	GENMASK(15, 8)
> +#define  CDNS_PCIE_LM_EP_ID_BUS_SHIFT	8
> +
> +/* Endpoint Function f BAR b Configuration Registers */
> +#define CDNS_PCIE_LM_EP_FUNC_BAR_CFG0(fn) \
> +	(CDNS_PCIE_LM_BASE + 0x0240 + (fn) * 0x0008)
> +#define CDNS_PCIE_LM_EP_FUNC_BAR_CFG1(fn) \
> +	(CDNS_PCIE_LM_BASE + 0x0244 + (fn) * 0x0008)
> +#define  CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(b) \
> +	(GENMASK(4, 0) << ((b) * 8))
> +#define  CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_APERTURE(b, a) \
> +	(((a) << ((b) * 8)) & CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(b))
> +#define  CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b) \
> +	(GENMASK(7, 5) << ((b) * 8))
> +#define  CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL(b, c) \
> +	(((c) << ((b) * 8 + 5)) & CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b))
> +
> +/* Endpoint Function Configuration Register */
> +#define CDNS_PCIE_LM_EP_FUNC_CFG	(CDNS_PCIE_LM_BASE + 0x02c0)

All endpoint defines should be moved to the patch that needs them.

> +
> +/* Root Complex BAR Configuration Register */
> +#define CDNS_PCIE_LM_RC_BAR_CFG	(CDNS_PCIE_LM_BASE + 0x0300)
> +#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR0_APERTURE_MASK	GENMASK(5, 0)
> +#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR0_APERTURE(a) \
> +	(((a) << 0) & CDNS_PCIE_LM_RC_BAR_CFG_BAR0_APERTURE_MASK)
> +#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR0_CTRL_MASK		GENMASK(8, 6)
> +#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR0_CTRL(c) \
> +	(((c) << 6) & CDNS_PCIE_LM_RC_BAR_CFG_BAR0_CTRL_MASK)
> +#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR1_APERTURE_MASK	GENMASK(13, 9)
> +#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR1_APERTURE(a) \
> +	(((a) << 9) & CDNS_PCIE_LM_RC_BAR_CFG_BAR1_APERTURE_MASK)
> +#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR1_CTRL_MASK		GENMASK(16, 14)
> +#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR1_CTRL(c) \
> +	(((c) << 14) & CDNS_PCIE_LM_RC_BAR_CFG_BAR1_CTRL_MASK)
> +#define  CDNS_PCIE_LM_RC_BAR_CFG_PREFETCH_MEM_ENABLE	BIT(17)
> +#define  CDNS_PCIE_LM_RC_BAR_CFG_PREFETCH_MEM_32BITS	0
> +#define  CDNS_PCIE_LM_RC_BAR_CFG_PREFETCH_MEM_64BITS	BIT(18)
> +#define  CDNS_PCIE_LM_RC_BAR_CFG_IO_ENABLE		BIT(19)
> +#define  CDNS_PCIE_LM_RC_BAR_CFG_IO_16BITS		0
> +#define  CDNS_PCIE_LM_RC_BAR_CFG_IO_32BITS		BIT(20)
> +#define  CDNS_PCIE_LM_RC_BAR_CFG_CHECK_ENABLE		BIT(31)
> +
> +/* BAR control values applicable to both Endpoint Function and Root Complex */
> +#define  CDNS_PCIE_LM_BAR_CFG_CTRL_DISABLED		0x0
> +#define  CDNS_PCIE_LM_BAR_CFG_CTRL_IO_32BITS		0x1
> +#define  CDNS_PCIE_LM_BAR_CFG_CTRL_MEM_32BITS		0x4
> +#define  CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_32BITS	0x5
> +#define  CDNS_PCIE_LM_BAR_CFG_CTRL_MEM_64BITS		0x6
> +#define  CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS	0x7
> +
> +
> +/*
> + * Endpoint Function Registers (PCI configuration space for endpoint functions)
> + */
> +#define CDNS_PCIE_EP_FUNC_BASE(fn)	(((fn) << 12) & GENMASK(19, 12))
> +
> +#define CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET	0x90
> +
> +/*
> + * Root Port Registers (PCI configuration space for the root port function)
> + */
> +#define CDNS_PCIE_RP_BASE	0x00200000
> +
> +
> +/*
> + * Address Translation Registers
> + */
> +#define CDNS_PCIE_AT_BASE	0x00400000
> +
> +/* Region r Outbound AXI to PCIe Address Translation Register 0 */
> +#define CDNS_PCIE_AT_OB_REGION_PCI_ADDR0(r) \
> +	(CDNS_PCIE_AT_BASE + 0x0000 + ((r) & 0x1f) * 0x0020)
> +#define  CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_NBITS_MASK	GENMASK(5, 0)
> +#define  CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_NBITS(nbits) \
> +	(((nbits) - 1) & CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_NBITS_MASK)
> +#define  CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_DEVFN_MASK	GENMASK(19, 12)
> +#define  CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_DEVFN(devfn) \
> +	(((devfn) << 12) & CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_DEVFN_MASK)
> +#define  CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_BUS_MASK	GENMASK(27, 20)
> +#define  CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_BUS(bus) \
> +	(((bus) << 20) & CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_BUS_MASK)
> +
> +/* Region r Outbound AXI to PCIe Address Translation Register 1 */
> +#define CDNS_PCIE_AT_OB_REGION_PCI_ADDR1(r) \
> +	(CDNS_PCIE_AT_BASE + 0x0004 + ((r) & 0x1f) * 0x0020)
> +
> +/* Region r Outbound PCIe Descriptor Register 0 */
> +#define CDNS_PCIE_AT_OB_REGION_DESC0(r) \
> +	(CDNS_PCIE_AT_BASE + 0x0008 + ((r) & 0x1f) * 0x0020)
> +#define  CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_MASK		GENMASK(3, 0)
> +#define  CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_MEM		0x2
> +#define  CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_IO		0x6
> +#define  CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_CONF_TYPE0	0xa
> +#define  CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_CONF_TYPE1	0xb
> +#define  CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_NORMAL_MSG	0xc
> +#define  CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_VENDOR_MSG	0xd
> +/* Bit 23 MUST be set in RC mode. */
> +#define  CDNS_PCIE_AT_OB_REGION_DESC0_HARDCODED_RID	BIT(23)
> +#define  CDNS_PCIE_AT_OB_REGION_DESC0_DEVFN_MASK	GENMASK(31, 24)
> +#define  CDNS_PCIE_AT_OB_REGION_DESC0_DEVFN(devfn) \
> +	(((devfn) << 24) & CDNS_PCIE_AT_OB_REGION_DESC0_DEVFN_MASK)
> +
> +/* Region r Outbound PCIe Descriptor Register 1 */
> +#define CDNS_PCIE_AT_OB_REGION_DESC1(r)	\
> +	(CDNS_PCIE_AT_BASE + 0x000c + ((r) & 0x1f) * 0x0020)
> +#define  CDNS_PCIE_AT_OB_REGION_DESC1_BUS_MASK	GENMASK(7, 0)
> +#define  CDNS_PCIE_AT_OB_REGION_DESC1_BUS(bus) \
> +	((bus) & CDNS_PCIE_AT_OB_REGION_DESC1_BUS_MASK)
> +
> +/* Region r AXI Region Base Address Register 0 */
> +#define CDNS_PCIE_AT_OB_REGION_CPU_ADDR0(r) \
> +	(CDNS_PCIE_AT_BASE + 0x0018 + ((r) & 0x1f) * 0x0020)
> +#define  CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS_MASK	GENMASK(5, 0)
> +#define  CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(nbits) \
> +	(((nbits) - 1) & CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS_MASK)
> +
> +/* Region r AXI Region Base Address Register 1 */
> +#define CDNS_PCIE_AT_OB_REGION_CPU_ADDR1(r) \
> +	(CDNS_PCIE_AT_BASE + 0x001c + ((r) & 0x1f) * 0x0020)
> +
> +/* Root Port BAR Inbound PCIe to AXI Address Translation Register */
> +#define CDNS_PCIE_AT_IB_RP_BAR_ADDR0(bar) \
> +	(CDNS_PCIE_AT_BASE + 0x0800 + (bar) * 0x0008)
> +#define  CDNS_PCIE_AT_IB_RP_BAR_ADDR0_NBITS_MASK	GENMASK(5, 0)
> +#define  CDNS_PCIE_AT_IB_RP_BAR_ADDR0_NBITS(nbits) \
> +	(((nbits) - 1) & CDNS_PCIE_AT_IB_RP_BAR_ADDR0_NBITS_MASK)
> +#define CDNS_PCIE_AT_IB_RP_BAR_ADDR1(bar) \
> +	(CDNS_PCIE_AT_BASE + 0x0804 + (bar) * 0x0008)
> +
> +enum cdns_pcie_rp_bar {
> +	RP_BAR0,
> +	RP_BAR1,
> +	RP_NO_BAR
> +};
> +
> +/* Endpoint Function BAR Inbound PCIe to AXI Address Translation Register */
> +#define CDNS_PCIE_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar) \
> +	(CDNS_PCIE_AT_BASE + 0x0840 + (fn) * 0x0040 + (bar) * 0x0008)
> +#define CDNS_PCIE_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar) \
> +	(CDNS_PCIE_AT_BASE + 0x0844 + (fn) * 0x0040 + (bar) * 0x0008)
> +
> +/* Normal/Vendor specific message access: offset inside some outbound region */
> +#define CDNS_PCIE_NORMAL_MSG_ROUTING_MASK	GENMASK(7, 5)
> +#define CDNS_PCIE_NORMAL_MSG_ROUTING(route) \
> +	(((route) << 5) & CDNS_PCIE_NORMAL_MSG_ROUTING_MASK)
> +#define CDNS_PCIE_NORMAL_MSG_CODE_MASK		GENMASK(15, 8)
> +#define CDNS_PCIE_NORMAL_MSG_CODE(code) \
> +	(((code) << 8) & CDNS_PCIE_NORMAL_MSG_CODE_MASK)
> +#define CDNS_PCIE_MSG_NO_DATA			BIT(16)
> +
> +enum cdns_pcie_msg_code {
> +	MSG_CODE_ASSERT_INTA	= 0x20,
> +	MSG_CODE_ASSERT_INTB	= 0x21,
> +	MSG_CODE_ASSERT_INTC	= 0x22,
> +	MSG_CODE_ASSERT_INTD	= 0x23,
> +	MSG_CODE_DEASSERT_INTA	= 0x24,
> +	MSG_CODE_DEASSERT_INTB	= 0x25,
> +	MSG_CODE_DEASSERT_INTC	= 0x26,
> +	MSG_CODE_DEASSERT_INTD	= 0x27,
> +};
> +
> +enum cdns_pcie_msg_routing {
> +	/* Route to Root Complex */
> +	MSG_ROUTING_TO_RC,
> +
> +	/* Use Address Routing */
> +	MSG_ROUTING_BY_ADDR,
> +
> +	/* Use ID Routing */
> +	MSG_ROUTING_BY_ID,
> +
> +	/* Route as Broadcast Message from Root Complex */
> +	MSG_ROUTING_BCAST,
> +
> +	/* Local message; terminate at receiver (INTx messages) */
> +	MSG_ROUTING_LOCAL,
> +
> +	/* Gather & route to Root Complex (PME_TO_Ack message) */
> +	MSG_ROUTING_GATHER,
> +};
> +
> +/**
> + * struct cdns_pcie - private data for Cadence PCIe controller drivers
> + * @reg_base: IO mapped register base
> + * @mem_res: start/end offsets in the physical system memory to map PCI accesses
> + * @is_rc: tell whether the PCIe controller mode is Root Complex or Endpoint.
> + * @bus: In Root Complex mode, the bus number
> + */
> +struct cdns_pcie {
> +	void __iomem		*reg_base;
> +	struct resource		*mem_res;
> +	bool			is_rc;
> +	u8			bus;
> +};
> +
> +/* Register access */
> +static inline void cdns_pcie_writeb(struct cdns_pcie *pcie, u32 reg, u8 value)
> +{
> +	writeb(value, pcie->reg_base + reg);
> +}
> +
> +static inline void cdns_pcie_writew(struct cdns_pcie *pcie, u32 reg, u16 value)
> +{
> +	writew(value, pcie->reg_base + reg);
> +}
> +
> +static inline void cdns_pcie_writel(struct cdns_pcie *pcie, u32 reg, u32 value)
> +{
> +	writel(value, pcie->reg_base + reg);
> +}
> +
> +static inline u32 cdns_pcie_readl(struct cdns_pcie *pcie, u32 reg)
> +{
> +	return readl(pcie->reg_base + reg);
> +}
> +
> +/* Root Port register access */
> +static inline void cdns_pcie_rp_writeb(struct cdns_pcie *pcie,
> +				       u32 reg, u8 value)
> +{
> +	writeb(value, pcie->reg_base + CDNS_PCIE_RP_BASE + reg);
> +}
> +
> +static inline void cdns_pcie_rp_writew(struct cdns_pcie *pcie,
> +				       u32 reg, u16 value)
> +{
> +	writew(value, pcie->reg_base + CDNS_PCIE_RP_BASE + reg);
> +}
> +
> +/* Endpoint Function register access */
> +static inline void cdns_pcie_ep_fn_writeb(struct cdns_pcie *pcie, u8 fn,
> +					  u32 reg, u8 value)
> +{
> +	writeb(value, pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg);
> +}
> +
> +static inline void cdns_pcie_ep_fn_writew(struct cdns_pcie *pcie, u8 fn,
> +					  u32 reg, u16 value)
> +{
> +	writew(value, pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg);
> +}
> +
> +static inline void cdns_pcie_ep_fn_writel(struct cdns_pcie *pcie, u8 fn,
> +					  u32 reg, u16 value)
> +{
> +	writel(value, pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg);
> +}
> +
> +static inline u8 cdns_pcie_ep_fn_readb(struct cdns_pcie *pcie, u8 fn, u32 reg)
> +{
> +	return readb(pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg);
> +}
> +
> +static inline u16 cdns_pcie_ep_fn_readw(struct cdns_pcie *pcie, u8 fn, u32 reg)
> +{
> +	return readw(pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg);
> +}
> +
> +static inline u32 cdns_pcie_ep_fn_readl(struct cdns_pcie *pcie, u8 fn, u32 reg)
> +{
> +	return readl(pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg);
> +}

Same comments for all endpoint related functions and defines above.

Thanks,
Lorenzo

> +void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u32 r, bool is_io,
> +				   u64 cpu_addr, u64 pci_addr, size_t size);
> +
> +void cdns_pcie_set_outbound_region_for_normal_msg(struct cdns_pcie *pcie, u32 r,
> +						  u64 cpu_addr);
> +
> +void cdns_pcie_reset_outbound_region(struct cdns_pcie *pcie, u32 r);
> +
> +#endif /* _PCIE_CADENCE_H */
> -- 
> 2.11.0
> 
