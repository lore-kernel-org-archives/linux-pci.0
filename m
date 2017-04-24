Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 24 Apr 2017 17:02:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ryder Lee <ryder.lee@mediatek.com>
Subject: Re: [PATCH 1/2] PCI: mediatek: Add Mediatek PCIe host controller
 support
Message-ID: <20170424220218.GA18659@bhelgaas-glaptop.roam.corp.google.com>
References: <1492935543-18190-1-git-send-email-ryder.lee@mediatek.com>
 <1492935543-18190-2-git-send-email-ryder.lee@mediatek.com>
MIME-Version: 1.0
In-Reply-To: <1492935543-18190-2-git-send-email-ryder.lee@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Ryder,

Looks good, but I have a few questions below.

On Sun, Apr 23, 2017 at 04:19:02PM +0800, Ryder Lee wrote:
> Add support for the Mediatek PCIe controller which can be found
> on MT7623A/N, MT2701 and MT8521p platforms.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/pci/host/Kconfig         |  11 +
>  drivers/pci/host/Makefile        |   1 +
>  drivers/pci/host/pcie-mediatek.c | 611 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 623 insertions(+)
>  create mode 100644 drivers/pci/host/pcie-mediatek.c
> 
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index f7c1d4d..cf13b5d 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -174,6 +174,17 @@ config PCIE_ROCKCHIP
>  	  There is 1 internal PCIe port available to support GEN2 with
>  	  4 slots.
>  
> +config PCIE_MEDIATEK
> +	bool "Mediatek PCIe Controller for MT7623 SoCs families"
> +	depends on (ARM && ARCH_MEDIATEK) || COMPILE_TEST
> +	depends on OF
> +	depends on PCI
> +	select PCIEPORTBUS
> +	help
> +	  Say Y here if you want to enable PCIe controller support on MT7623 A/N
> +	  series SoCs. There is a one root complex with 3 root ports available.
> +	  Each port supports Gen2 lane x1.
> +
>  config VMD
>  	depends on PCI_MSI && X86_64 && SRCU
>  	tristate "Intel Volume Management Device Driver"
> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> index 4d36866..265adff 100644
> --- a/drivers/pci/host/Makefile
> +++ b/drivers/pci/host/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_PCIE_IPROC_BCMA) += pcie-iproc-bcma.o
>  obj-$(CONFIG_PCIE_ALTERA) += pcie-altera.o
>  obj-$(CONFIG_PCIE_ALTERA_MSI) += pcie-altera-msi.o
>  obj-$(CONFIG_PCIE_ROCKCHIP) += pcie-rockchip.o
> +obj-$(CONFIG_PCIE_MEDIATEK) += pcie-mediatek.o
>  obj-$(CONFIG_VMD) += vmd.o
>  
>  # The following drivers are for devices that use the generic ACPI
> diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
> new file mode 100644
> index 0000000..98e84d9
> --- /dev/null
> +++ b/drivers/pci/host/pcie-mediatek.c
> @@ -0,0 +1,611 @@
> +/*
> + * PCIe host controller driver for Mediatek MT7623 SoCs families
> + *
> + * Copyright (c) 2017 MediaTek Inc.
> + * Author: Ryder Lee <ryder.lee@mediatek.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_pci.h>
> +#include <linux/of_platform.h>
> +#include <linux/pci.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/reset.h>
> +
> +/* PCIe shared registers */
> +#define PCIE_SYS_CFG		0x00
> +#define PCIE_INT_ENABLE		0x0c
> +#define PCIE_CFG_ADDR		0x20
> +#define PCIE_CFG_DATA		0x24
> +
> +/* PCIe per port registers */
> +#define PCIE_BAR0_SETUP		0x10
> +#define PCIE_BAR1_SETUP		0x14
> +#define PCIE_BAR0_MEM_BASE	0x18
> +#define PCIE_CLASS		0x34
> +#define PCIE_LINK_STATUS	0x50
> +
> +#define PCIE_PORT_INT_EN(x)	BIT(20 + (x))
> +#define PCIE_PORT_PERST(x)	BIT(1 + (x))
> +#define PCIE_PORT_LINKUP	BIT(0)
> +#define PCIE_BAR_MAP_MAX	GENMASK(31, 16)
> +
> +#define PCIE_BAR_ENABLE		BIT(0)
> +#define PCIE_REVISION_ID	BIT(0)
> +#define PCIE_CLASS_CODE		(0x60400 << 8)
> +#define PCIE_CONF_REG(regn)	(((regn) & GENMASK(7, 2)) | \
> +				((((regn) >> 8) & GENMASK(3, 0)) << 24))
> +#define PCIE_CONF_FUN(fun)	(((fun) << 8) & GENMASK(10, 8))
> +#define PCIE_CONF_DEV(dev)	(((dev) << 11) & GENMASK(15, 11))
> +#define PCIE_CONF_BUS(bus)	(((bus) << 16) & GENMASK(23, 16))
> +#define PCIE_CONF_ADDR(regn, fun, dev, bus) \
> +	(PCIE_CONF_REG(regn) | PCIE_CONF_FUN(fun) | \
> +	 PCIE_CONF_DEV(dev) | PCIE_CONF_BUS(bus))
> +
> +/* Mediatek specific configuration registers */
> +#define PCIE_FTS_NUM		0x70c
> +#define PCIE_FTS_NUM_MASK	GENMASK(15, 8)
> +#define PCIE_FTS_NUM_L0(x)	((x) & 0xff << 8)
> +
> +#define PCIE_FC_CREDIT		0x73c
> +#define PCIE_FC_CREDIT_MASK	(GENMASK(31, 31) | GENMASK(28, 16))
> +#define PCIE_FC_CREDIT_VAL(x)	((x) << 16)
> +
> +/**
> + * struct mtk_pcie_port - PCIe port information
> + * @dev: pointer to root port device
> + * @base: IO mapped register base
> + * @list: port list
> + * @pcie: pointer to PCIe host info
> + * @reset: pointer to RC reset control
> + * @regs: port memory region
> + * @sys_ck: root port clock
> + * @phy: pointer to phy control block
> + * @irq: IRQ number
> + * @lane: lane count
> + * @index: port index
> + */
> +struct mtk_pcie_port {
> +	struct device *dev;
> +	void __iomem *base;
> +	struct list_head list;
> +	struct mtk_pcie *pcie;
> +	struct reset_control *reset;
> +	struct resource regs;
> +	struct clk *sys_ck;
> +	struct phy *phy;
> +	int irq;
> +	u32 lane;
> +	u32 index;
> +};
> +
> +/**
> + * struct mtk_pcie - PCIe host information
> + * @dev: pointer to PCIe device
> + * @base: IO mapped register Base
> + * @free_ck: free-run reference clock
> + * @resources: bus resources
> + * @ports: pointer to PCIe port information
> + */
> +struct mtk_pcie {
> +	struct device *dev;
> +	void __iomem *base;
> +	struct clk *free_ck;
> +	struct list_head resources;
> +	struct list_head ports;
> +};
> +
> +static inline bool mtk_pcie_link_is_up(struct mtk_pcie_port *port)
> +{
> +	return !!(readl_relaxed(port->base + PCIE_LINK_STATUS) &
> +		  PCIE_PORT_LINKUP);
> +}
> +
> +static bool mtk_pcie_valid_device(struct mtk_pcie *pcie,
> +				  struct pci_bus *bus, int devfn)
> +{
> +	struct mtk_pcie_port *port;
> +	struct pci_dev *dev;
> +	struct pci_bus *pbus;
> +
> +	/* if there is no link, then there is no device */
> +	list_for_each_entry(port, &pcie->ports, list) {
> +		if (bus->number == 0 && port->index == PCI_SLOT(devfn) &&
> +		    mtk_pcie_link_is_up(port)) {
> +			return true;
> +		} else if (bus->number != 0) {
> +			pbus = bus;
> +			do {
> +				dev = pbus->self;
> +				if (port->index == PCI_SLOT(dev->devfn) &&
> +				    mtk_pcie_link_is_up(port)) {
> +					return true;
> +				}
> +				pbus = dev->bus;
> +			} while (dev->bus->number != 0);
> +		}
> +	}
> +
> +	return false;
> +}
> +
> +static void mtk_pcie_port_free(struct mtk_pcie_port *port)
> +{
> +	struct mtk_pcie *pcie = port->pcie;
> +	struct device *dev = pcie->dev;
> +
> +	devm_iounmap(dev, port->base);
> +	devm_release_mem_region(dev, port->regs.start,
> +				resource_size(&port->regs));
> +	list_del(&port->list);
> +	devm_kfree(dev, port);
> +}
> +
> +static int mtk_pcie_hw_rd_cfg(struct mtk_pcie *pcie, u32 bus, u32 devfn,
> +			      int where, int size, u32 *val)
> +{
> +	writel(PCIE_CONF_ADDR(where, PCI_FUNC(devfn), PCI_SLOT(devfn), bus),
> +	       pcie->base + PCIE_CFG_ADDR);
> +
> +	*val = 0;
> +
> +	switch (size) {
> +	case 1:
> +		*val = readb(pcie->base + PCIE_CFG_DATA + (where & 3));
> +		break;
> +	case 2:
> +		*val = readw(pcie->base + PCIE_CFG_DATA + (where & 2));
> +		break;
> +	case 4:
> +		*val = readl(pcie->base + PCIE_CFG_DATA);
> +		break;
> +	}
> +
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
> +static int mtk_pcie_hw_wr_cfg(struct mtk_pcie *pcie, u32 bus, u32 devfn,
> +			      int where, int size, u32 val)
> +
> +{
> +	writel(PCIE_CONF_ADDR(where, PCI_FUNC(devfn), PCI_SLOT(devfn), bus),
> +	       pcie->base + PCIE_CFG_ADDR);
> +
> +	switch (size) {
> +	case 1:
> +		writeb(val, pcie->base + PCIE_CFG_DATA + (where & 3));
> +		break;
> +	case 2:
> +		writew(val, pcie->base + PCIE_CFG_DATA + (where & 2));
> +		break;
> +	case 4:
> +		writel(val, pcie->base + PCIE_CFG_DATA);
> +		break;
> +	}
> +
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
> +static int mtk_pcie_read_config(struct pci_bus *bus, u32 devfn,
> +				int where, int size, u32 *val)
> +{
> +	struct mtk_pcie *pcie = bus->sysdata;
> +	u32 bn = bus->number;
> +
> +	if (!mtk_pcie_valid_device(pcie, bus, devfn)) {
> +		*val = 0xffffffff;
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +	}

I know there are some other drivers with the *_valid_device() pattern
in their config accessors, but I don't like it because it's racy.
It's possible for the link to be up for the test above, then go down
before the actual config access below.

Your hardware *should* do something sensible if we try to read config
space when the link is down, and ideally that would be enough that we
don't need this "valid_device()" check.

> +	return mtk_pcie_hw_rd_cfg(pcie, bn, devfn, where, size, val);
> +}
> +
> +static int mtk_pcie_write_config(struct pci_bus *bus, u32 devfn,
> +				 int where, int size, u32 val)
> +{
> +	struct mtk_pcie *pcie = bus->sysdata;
> +	u32 bn = bus->number;
> +
> +	if (!mtk_pcie_valid_device(pcie, bus, devfn))
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +	return mtk_pcie_hw_wr_cfg(pcie, bn, devfn, where, size, val);
> +}
> +
> +static struct pci_ops mtk_pcie_ops = {
> +	.read  = mtk_pcie_read_config,
> +	.write = mtk_pcie_write_config,
> +};
> +
> +static void mtk_pcie_configure_rc(struct mtk_pcie_port *port)
> +{
> +	struct mtk_pcie *pcie = port->pcie;
> +	u32 val;
> +
> +	/* enable interrupt */
> +	val = readl(pcie->base + PCIE_INT_ENABLE);
> +	val |= PCIE_PORT_INT_EN(port->index);
> +	writel(val, pcie->base + PCIE_INT_ENABLE);
> +
> +	/* map to all DDR region. We need to set it before cfg operation. */
> +	writel(PCIE_BAR_MAP_MAX | PCIE_BAR_ENABLE,
> +	       port->base + PCIE_BAR0_SETUP);
> +
> +	/* configure class Code and revision ID */
> +	writel(PCIE_CLASS_CODE | PCIE_REVISION_ID,
> +	       port->base + PCIE_CLASS);
> +
> +	/* configure FC credit */
> +	mtk_pcie_hw_rd_cfg(pcie, 0, (port->index << 3),
> +			   PCIE_FC_CREDIT, 4, &val);
> +	val &= ~PCIE_FC_CREDIT_MASK;
> +	val |= PCIE_FC_CREDIT_VAL(0x806c);
> +	mtk_pcie_hw_wr_cfg(pcie, 0, (port->index << 3),
> +			   PCIE_FC_CREDIT, 4, val);
> +
> +	/* configure RC FTS number to 250 when it leaves L0s */
> +	mtk_pcie_hw_rd_cfg(pcie, 0, (port->index << 3),
> +			   PCIE_FTS_NUM, 4, &val);
> +	val &= ~PCIE_FTS_NUM_MASK;
> +	val |= PCIE_FTS_NUM_L0(0x50);
> +	mtk_pcie_hw_wr_cfg(pcie, 0, (port->index << 3),
> +			   PCIE_FTS_NUM, 4, val);
> +}
> +
> +static void mtk_pcie_assert_ports(struct mtk_pcie_port *port)
> +{
> +	struct mtk_pcie *pcie = port->pcie;
> +	u32 val;
> +
> +	/* assert port PERST_N */
> +	val = readl(pcie->base + PCIE_SYS_CFG);
> +	val |= PCIE_PORT_PERST(port->index);
> +	writel(val, pcie->base + PCIE_SYS_CFG);
> +
> +	/* de-assert port PERST_N */
> +	val = readl(pcie->base + PCIE_SYS_CFG);
> +	val &= ~PCIE_PORT_PERST(port->index);
> +	writel(val, pcie->base + PCIE_SYS_CFG);
> +
> +	/*
> +	 * at least 100ms delay because PCIe v2.0 need more time to
> +	 * train from Gen1 to Gen2
> +	 */
> +	msleep(100);
> +}
> +
> +static int mtk_pcie_enable_ports(struct mtk_pcie *pcie)
> +{
> +	struct device *dev = pcie->dev;
> +	struct mtk_pcie_port *port, *tmp;
> +	int err, linkup = 0;
> +
> +	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
> +		err = clk_prepare_enable(port->sys_ck);
> +		if (err) {
> +			dev_err(dev, "failed to enable port%d clock\n",
> +				port->index);
> +			continue;
> +		}
> +
> +		/* assert RC */
> +		reset_control_assert(port->reset);
> +		/* de-assert RC */
> +		reset_control_deassert(port->reset);
> +
> +		/* power on PHY */
> +		err = phy_power_on(port->phy);
> +		if (err) {
> +			dev_err(dev, "failed to power on port%d phy\n",
> +				port->index);
> +			goto err_phy_on;
> +		}
> +
> +		mtk_pcie_assert_ports(port);
> +
> +		/* if link up, then setup root port configuration space */
> +		if (mtk_pcie_link_is_up(port)) {
> +			mtk_pcie_configure_rc(port);
> +			linkup++;
> +			continue;
> +		}
> +
> +		dev_info(dev, "Port%d link down\n", port->index);
> +
> +		phy_power_off(port->phy);
> +err_phy_on:
> +		clk_disable_unprepare(port->sys_ck);
> +		mtk_pcie_port_free(port);
> +	}
> +
> +	return linkup;
> +}
> +
> +static int mtk_pcie_get_port_resource(struct mtk_pcie_port *port,
> +				      struct device_node *node)
> +{
> +	struct device *dev = port->pcie->dev;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct platform_device *plat_dev;
> +	char name[10];
> +	int err;
> +
> +	err = of_address_to_resource(node, 0, &port->regs);
> +	if (err) {
> +		dev_err(dev, "failed to parse address: %d\n", err);
> +		return err;
> +	}
> +
> +	port->base = devm_ioremap_resource(dev, &port->regs);
> +	if (IS_ERR(port->base)) {
> +		dev_err(dev, "failed to map port%d base\n", port->index);
> +		return PTR_ERR(port->base);
> +	}
> +
> +	plat_dev = of_find_device_by_node(node);
> +	if (!plat_dev) {
> +		plat_dev = of_platform_device_create(
> +					node, NULL,
> +					platform_bus_type.dev_root);
> +		if (!plat_dev)
> +			return -EPROBE_DEFER;
> +	}
> +
> +	port->dev = &plat_dev->dev;
> +
> +	port->irq = platform_get_irq(pdev, port->index);
> +	if (!port->irq) {
> +		dev_err(dev, "failed to get irq\n");
> +		return -ENODEV;
> +	}
> +
> +	port->sys_ck = devm_clk_get(port->dev, "sys_ck");
> +	if (IS_ERR(port->sys_ck)) {
> +		dev_err(port->dev, "failed to get port%d clock\n", port->index);
> +		return PTR_ERR(port->sys_ck);
> +	}
> +
> +	port->reset = devm_reset_control_get(port->dev, "pcie-reset");
> +	if (IS_ERR(port->reset)) {
> +		dev_err(port->dev, "failed to get port%d reset control\n",
> +			port->index);
> +		return PTR_ERR(port->reset);
> +	}
> +
> +	snprintf(name, sizeof(name), "pcie-phy%d", port->index);
> +	port->phy = devm_of_phy_get(port->dev, node, name);
> +	if (IS_ERR(port->phy)) {
> +		dev_err(port->dev, "failed to get port%d phy\n", port->index);
> +		return PTR_ERR(port->phy);
> +	}
> +
> +	return 0;
> +}
> +
> +static int mtk_pcie_parse_and_add_res(struct mtk_pcie *pcie)
> +{
> +	struct device *dev = pcie->dev;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct device_node *node = dev->of_node, *child;
> +	struct resource_entry *win, *tmp;
> +	struct resource *regs;
> +	resource_size_t iobase;
> +	int err;
> +
> +	/* parse shared resources */
> +	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	pcie->base = devm_ioremap_resource(dev, regs);
> +	if (IS_ERR(pcie->base)) {
> +		dev_err(dev, "failed to get PCIe base\n");
> +		return PTR_ERR(pcie->base);
> +	}
> +
> +	pcie->free_ck = devm_clk_get(dev, "free_ck");
> +	if (IS_ERR(pcie->free_ck)) {
> +		dev_err(dev, "failed to get free_ck\n");
> +		return PTR_ERR(pcie->free_ck);
> +	}
> +
> +	err = of_pci_get_host_bridge_resources(node, 0, 0xff, &pcie->resources,
> +					       &iobase);
> +	if (err)
> +		return err;
> +
> +	err = devm_request_pci_bus_resources(dev, &pcie->resources);
> +	if (err)
> +		return err;
> +
> +	resource_list_for_each_entry_safe(win, tmp, &pcie->resources) {
> +		struct resource *res = win->res;
> +
> +		switch (resource_type(res)) {
> +		case IORESOURCE_IO:
> +			err = pci_remap_iospace(res, iobase);
> +			if (err) {
> +				dev_warn(dev, "failed to map resource %pR\n",
> +					 res);
> +				resource_list_destroy_entry(win);
> +			}
> +			break;
> +		}
> +	}
> +
> +	/* parse port resources */
> +	for_each_child_of_node(node, child) {
> +		struct mtk_pcie_port *port;
> +		int index;
> +
> +		err = of_pci_get_devfn(child);
> +		if (err < 0) {
> +			dev_err(pcie->dev, "failed to parse devfn: %d\n", err);

dev_err(dev, ...)

> +			return err;
> +		}
> +
> +		index = PCI_SLOT(err);
> +		if (index < 1) {
> +			dev_err(dev, "invalid port number: %d\n", index);
> +			return -EINVAL;
> +		}
> +
> +		index--;
> +
> +		if (!of_device_is_available(child))
> +			continue;
> +
> +		port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> +		if (!port)
> +			return -ENOMEM;
> +
> +		err = of_property_read_u32(child, "num-lanes", &port->lane);
> +		if (err) {
> +			dev_err(dev, "missing num-lanes property\n");
> +			return err;
> +		}
> +
> +		port->index = index;
> +		port->pcie = pcie;
> +
> +		err = mtk_pcie_get_port_resource(port, child);
> +		if (err)
> +			return err;
> +
> +		INIT_LIST_HEAD(&port->list);
> +		list_add_tail(&port->list, &pcie->ports);
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * This IP lacks interrupt status register to check or map INTx from
> + * different devices at the same time.
> + */
> +static int __init mtk_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
> +{
> +	struct mtk_pcie *pcie = dev->bus->sysdata;
> +	struct mtk_pcie_port *port;
> +
> +	list_for_each_entry(port, &pcie->ports, list)
> +		if (port->index == slot)
> +			return port->irq;
> +
> +	return -1;
> +}
> +
> +static int mtk_pcie_register_ports(struct mtk_pcie *pcie)
> +{
> +	struct pci_bus *bus, *child;
> +
> +	bus = pci_scan_root_bus(pcie->dev, 0, &mtk_pcie_ops, pcie,
> +				&pcie->resources);
> +	if (!bus) {
> +		dev_err(pcie->dev, "failed to create root bus\n");
> +		return -ENOMEM;
> +	}
> +
> +	if (!pci_has_flag(PCI_PROBE_ONLY)) {
> +		pci_fixup_irqs(pci_common_swizzle, mtk_pcie_map_irq);
> +		pci_bus_size_bridges(bus);
> +		pci_bus_assign_resources(bus);
> +
> +		list_for_each_entry(child, &bus->children, node)
> +			pcie_bus_configure_settings(child);

Do you actually need the functionality of PCI_PROBE_ONLY?  We're
trying to get rid of this, so if you don't need it, please omit it.

If you *do* need it, can you include a note about why?

If you do need it, I don't think PCI_PROBE_ONLY should control
pci_fixup_irqs() or pcie_bus_configure_settings().  I know there is
some other similar code that does this, but I think PCI_PROBE_ONLY
should only influence resource assignment, i.e., BARs and bridge
windows.  I don't want it to influence IRQs or the MPS/MRRS settings
done by pcie_bus_configure_settings() if we can avoid it.

> +	}
> +
> +	pci_bus_add_devices(bus);
> +
> +	return 0;
> +}
> +
> +static int mtk_pcie_probe(struct platform_device *pdev)
> +{
> +	struct mtk_pcie *pcie;
> +	int err;
> +
> +	pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
> +	if (!pcie)
> +		return -ENOMEM;
> +
> +	pcie->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, pcie);
> +
> +	/*
> +	 * parse PCI ranges, configuration bus range and
> +	 * request their resources
> +	 */
> +	INIT_LIST_HEAD(&pcie->ports);
> +	INIT_LIST_HEAD(&pcie->resources);
> +
> +	err = mtk_pcie_parse_and_add_res(pcie);
> +	if (err)
> +		goto err_parse;
> +
> +	pm_runtime_enable(pcie->dev);
> +	err = pm_runtime_get_sync(pcie->dev);
> +	if (err)
> +		goto err_pm;
> +
> +	err = clk_prepare_enable(pcie->free_ck);
> +	if (err) {
> +		dev_err(pcie->dev, "failed to enable free_ck\n");
> +		goto err_free_ck;
> +	}
> +
> +	/* power on PCIe ports */
> +	err = mtk_pcie_enable_ports(pcie);
> +	if (!err)
> +		goto err_enable;
> +
> +	/* register PCIe ports */
> +	err = mtk_pcie_register_ports(pcie);
> +	if (err)
> +		goto err_enable;
> +
> +	return 0;
> +
> +err_enable:
> +	clk_disable_unprepare(pcie->free_ck);
> +err_free_ck:
> +	pm_runtime_put_sync(pcie->dev);
> +err_pm:
> +	pm_runtime_disable(pcie->dev);
> +err_parse:
> +	pci_free_resource_list(&pcie->resources);
> +
> +	return err;
> +}
> +
> +static const struct of_device_id mtk_pcie_ids[] = {
> +	{ .compatible = "mediatek,mt7623-pcie"},
> +	{ .compatible = "mediatek,mt2701-pcie"},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, mtk_pcie_ids);
> +
> +static struct platform_driver mtk_pcie_driver = {
> +	.probe = mtk_pcie_probe,
> +	.driver = {
> +		.name = "mtk-pcie",
> +		.of_match_table = mtk_pcie_ids,

Per [1], I think you should have ".suppress_bind_attrs = true," here.
Without it, apparently you can easily crash the system by unbinding
the driver, as in [2].

[1] https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?id=65e0527b933a
[2] https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?id=073d3dbe9a7c

> +	},
> +};
> +
> +builtin_platform_driver(mtk_pcie_driver);
> +
> +MODULE_DESCRIPTION("Mediatek PCIe host driver for MT7623 SoCs families");
> +MODULE_LICENSE("GPL v2");
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
