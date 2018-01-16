Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:60456 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751507AbeAPLQ0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Jan 2018 06:16:26 -0500
Subject: Re: [PATCH v3 6/6] PCI: cadence: Add host driver for Cadence PCIe
 controller
To: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>
References: <cover.1515621150.git.cyrille.pitchen@free-electrons.com>
 <990730f5c1156b3bb15f56fa877719941f219016.1515621150.git.cyrille.pitchen@free-electrons.com>
CC: <adouglas@cadence.com>, <stelford@cadence.com>,
        <dgary@cadence.com>, <kgopi@cadence.com>, <eandrews@cadence.com>,
        <thomas.petazzoni@free-electrons.com>, <sureshp@cadence.com>,
        <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <robh@kernel.org>, <devicetree@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <e3d88d5b-e770-d2e5-20b2-62551d5f4f8f@ti.com>
Date: Tue, 16 Jan 2018 16:46:12 +0530
MIME-Version: 1.0
In-Reply-To: <990730f5c1156b3bb15f56fa877719941f219016.1515621150.git.cyrille.pitchen@free-electrons.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Cyrille,

On Thursday 11 January 2018 04:17 AM, Cyrille Pitchen wrote:
> This patch adds support to the Cadence PCIe controller in host mode.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
> ---
>  MAINTAINERS                             |   7 +
>  drivers/pci/Kconfig                     |   1 +
>  drivers/pci/Makefile                    |   1 +
>  drivers/pci/cadence/Kconfig             |  16 ++
>  drivers/pci/cadence/Makefile            |   3 +
>  drivers/pci/cadence/pcie-cadence-host.c | 336 ++++++++++++++++++++++++++++++++
>  drivers/pci/cadence/pcie-cadence.c      |  68 +++++++
>  drivers/pci/cadence/pcie-cadence.h      | 196 +++++++++++++++++++
>  8 files changed, 628 insertions(+)
>  create mode 100644 drivers/pci/cadence/Kconfig
>  create mode 100644 drivers/pci/cadence/Makefile
>  create mode 100644 drivers/pci/cadence/pcie-cadence-host.c
>  create mode 100644 drivers/pci/cadence/pcie-cadence.c
>  create mode 100644 drivers/pci/cadence/pcie-cadence.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 13945646b95d..cc24c74a946e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10402,6 +10402,13 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/pci/pci-armada8k.txt
>  F:	drivers/pci/dwc/pcie-armada8k.c
>  
> +PCI DRIVER FOR CADENCE PCIE IP
> +M:	Alan Douglas <adouglas@cadence.com>
> +L:	linux-pci@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/pci/cdns,*.txt
> +F:	drivers/pci/cadence/pcie-cadence*
> +
>  PCI DRIVER FOR FREESCALE LAYERSCAPE
>  M:	Minghuan Lian <minghuan.Lian@freescale.com>
>  M:	Mingkai Hu <mingkai.hu@freescale.com>
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 7eeb969ab86a..dee90cc1dcaf 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -136,6 +136,7 @@ config PCI_HYPERV
>            PCI devices from a PCI backend to support PCI driver domains.
>  
>  source "drivers/pci/hotplug/Kconfig"
> +source "drivers/pci/cadence/Kconfig"
>  source "drivers/pci/dwc/Kconfig"
>  source "drivers/pci/host/Kconfig"
>  source "drivers/pci/endpoint/Kconfig"
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index ddb5aa6640d7..941970936840 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -56,5 +56,6 @@ obj-y += switch/
>  obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
>  
>  # Endpoint library must be initialized before its users
> +obj-$(CONFIG_PCIE_CADENCE)	+= cadence/
>  # pcie-hisi.o quirks are needed even without CONFIG_PCIE_DW
>  obj-y				+= dwc/
> diff --git a/drivers/pci/cadence/Kconfig b/drivers/pci/cadence/Kconfig
> new file mode 100644
> index 000000000000..0123d384a628
> --- /dev/null
> +++ b/drivers/pci/cadence/Kconfig
> @@ -0,0 +1,16 @@
> +menu "Cadence PCIe controllers support"
> +
> +config PCIE_CADENCE
> +	bool
> +
> +config PCIE_CADENCE_HOST
> +	bool "Cadence PCIe host controller"
> +	depends on OF
> +	select IRQ_DOMAIN
> +	select PCIE_CADENCE
> +	help
> +	  Say Y here if you want to support the Cadence PCIe controller in host
> +	  mode. This PCIe controller may be embedded into many different vendors
> +	  SoCs.
> +
> +endmenu
> diff --git a/drivers/pci/cadence/Makefile b/drivers/pci/cadence/Makefile
> new file mode 100644
> index 000000000000..589601a8ff89
> --- /dev/null
> +++ b/drivers/pci/cadence/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_PCIE_CADENCE) += pcie-cadence.o
> +obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host.o
> diff --git a/drivers/pci/cadence/pcie-cadence-host.c b/drivers/pci/cadence/pcie-cadence-host.c
> new file mode 100644
> index 000000000000..26caf8963e3c
> --- /dev/null
> +++ b/drivers/pci/cadence/pcie-cadence-host.c
> @@ -0,0 +1,336 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2017 Cadence
> +// Cadence PCIe host controller driver.
> +// Author: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
> +
> +#include <linux/kernel.h>
> +#include <linux/of_address.h>
> +#include <linux/of_pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +
> +#include "pcie-cadence.h"
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
> + * @max_regions: maximum number of regions supported by the hardware
> + * @no_bar_nbits: Number of bits to keep for inbound (PCIe -> CPU) address
> + *                translation (nbits sets into the "no BAR match" register)
> + * @vendor_id: PCI vendor ID
> + * @device_id: PCI device ID
> + */
> +struct cdns_pcie_rc {
> +	struct cdns_pcie	pcie;
> +	struct device		*dev;
> +	struct resource		*cfg_res;
> +	struct resource		*bus_range;
> +	void __iomem		*cfg_base;
> +	u32			max_regions;
> +	u32			no_bar_nbits;
> +	u16			vendor_id;
> +	u16			device_id;
> +};
> +
> +static void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
> +				      int where)
> +{
> +	struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
> +	struct cdns_pcie_rc *rc = pci_host_bridge_priv(bridge);
> +	struct cdns_pcie *pcie = &rc->pcie;
> +	unsigned int busn = bus->number;
> +	u32 addr0, desc0;
> +
> +	if (busn == rc->bus_range->start) {
> +		/*
> +		 * Only the root port (devfn == 0) is connected to this bus.
> +		 * All other PCI devices are behind some bridge hence on another
> +		 * bus.
> +		 */
> +		if (devfn)
> +			return NULL;
> +
> +		return pcie->reg_base + (where & 0xfff);
> +	}
> +
> +	/* Update Output registers for AXI region 0. */
> +	addr0 = CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_NBITS(12) |
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
> +static const struct of_device_id cdns_pcie_host_of_match[] = {
> +	{ .compatible = "cdns,cdns-pcie-host" },
> +
> +	{ },
> +};
> +
> +static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
> +{
> +	struct cdns_pcie *pcie = &rc->pcie;
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
> +	if (rc->vendor_id != 0xffff)
> +		cdns_pcie_rp_writew(pcie, PCI_VENDOR_ID, rc->vendor_id);
> +	if (rc->device_id != 0xffff)
> +		cdns_pcie_rp_writew(pcie, PCI_DEVICE_ID, rc->device_id);
> +
> +	cdns_pcie_rp_writeb(pcie, PCI_CLASS_REVISION, 0);
> +	cdns_pcie_rp_writeb(pcie, PCI_CLASS_PROG, 0);
> +	cdns_pcie_rp_writew(pcie, PCI_CLASS_DEVICE, PCI_CLASS_BRIDGE_PCI);
> +
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
> +		if (r >= rc->max_regions)
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
> +	 * needed for MSI and DMA.
> +	 * Root Port BAR0 and BAR1 are disabled, hence no need to set their
> +	 * inbound translation registers.
> +	 */
> +	addr0 = CDNS_PCIE_AT_IB_RP_BAR_ADDR0_NBITS(rc->no_bar_nbits);
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
> +	err = pci_parse_request_of_pci_ranges(dev, resources, &bus_range);
> +	if (err)
> +		return err;
> +
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
> +	return err;
> +}
> +
> +static int cdns_pcie_host_probe(struct platform_device *pdev)
> +{
> +	const char *type;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
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
> +
> +	pcie = &rc->pcie;
> +	pcie->is_rc = true;
> +
> +	rc->max_regions = 32;
> +	of_property_read_u32(np, "cdns,max-outbound-regions", &rc->max_regions);
> +
> +	rc->no_bar_nbits = 32;
> +	of_property_read_u32(np, "cdns,no-bar-match-nbits", &rc->no_bar_nbits);
> +
> +	rc->vendor_id = 0xffff;
> +	of_property_read_u16(np, "vendor-id", &rc->vendor_id);
> +
> +	rc->device_id = 0xffff;
> +	of_property_read_u16(np, "device-id", &rc->device_id);
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
> +	rc->cfg_base = devm_pci_remap_cfg_resource(dev, res);
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
> +	ret = pci_host_probe(bridge);
> +	if (ret < 0)
> +		goto err_host_probe;
> +
> +	return 0;
> +
> + err_host_probe:
> +	pci_free_resource_list(&resources);
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

In the case of DWC, designware core is modeled as a library which has API's to
be invoked by various platform specific glue drivers.

But with the cadence approach we'll have two separate drivers: the cadence core
driver and the platform specific glue drivers. Is this approach chosen for a
specific reason?

Thanks
Kishon
