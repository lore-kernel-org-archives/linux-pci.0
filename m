Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:51330 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423396AbcFHJVb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 8 Jun 2016 05:21:31 -0400
Subject: Re: [PATCH v2 2/2] PCI: Rockchip: Add Rockchip PCIe controller
 support
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Bjorn Helgaas <bhelgaas@google.com>
References: <1465373154-882-1-git-send-email-shawn.lin@rock-chips.com>
Cc: linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
	Heiko Stuebner <heiko@sntech.de>,
	Doug Anderson <dianders@chromium.org>,
	Wenrui Li <wenrui.li@rock-chips.com>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <5757E397.40401@arm.com>
Date: Wed, 8 Jun 2016 10:21:27 +0100
MIME-Version: 1.0
In-Reply-To: <1465373154-882-1-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 08/06/16 09:05, Shawn Lin wrote:
> This patch adds Rockchip PCIe controller support found
> on RK3399 Soc platform.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> ---
> 
> Changes in v2:
> - remove phy related stuff and call phy API
> - add new head file and define lots of macro to make
>   the code more readable
> - remove lots msi related code suggested by Marc
> - add IO window address translation
> - init_port and parse_dt reconstruction suggested by Bharat
> - improve wr_own_conf suggested by Arnd
> - make pcie as an interrupt controller and fix wrong int handler
>   suggested by Marc
> - remove PCI_PROBE_ONLY suggested by Lorenzo
> 
>  drivers/pci/host/Kconfig         |   11 +
>  drivers/pci/host/Makefile        |    1 +
>  drivers/pci/host/pcie-rockchip.c | 1049 ++++++++++++++++++++++++++++++++++++++
>  drivers/pci/host/pcie-rockchip.h |  209 ++++++++
>  4 files changed, 1270 insertions(+)
>  create mode 100644 drivers/pci/host/pcie-rockchip.c
>  create mode 100644 drivers/pci/host/pcie-rockchip.h
> 
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index 5d2374e..251f4ac 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -245,4 +245,15 @@ config PCIE_ARMADA_8K
>  	  Designware hardware and therefore the driver re-uses the
>  	  Designware core functions to implement the driver.
>  
> +config PCIE_ROCKCHIP
> +	bool "Rockchip PCIe controller"
> +	depends on ARM64 && ARCH_ROCKCHIP
> +	depends on OF
> +	select MFD_SYSCON
> +	select PCI_MSI_IRQ_DOMAIN if PCI_MSI
> +	help
> +	  Say Y here if you want internal PCI support on Rockchip SoC.
> +	  There are 1 internal PCIe port available to support GEN2 with
> +	  4 slots.
> +
>  endmenu
> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> index 9c8698e..c52985c 100644
> --- a/drivers/pci/host/Makefile
> +++ b/drivers/pci/host/Makefile
> @@ -29,3 +29,4 @@ obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
>  obj-$(CONFIG_PCI_HOST_THUNDER_ECAM) += pci-thunder-ecam.o
>  obj-$(CONFIG_PCI_HOST_THUNDER_PEM) += pci-thunder-pem.o
>  obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
> +obj-$(CONFIG_PCIE_ROCKCHIP) += pcie-rockchip.o
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> new file mode 100644
> index 0000000..f491213
> --- /dev/null
> +++ b/drivers/pci/host/pcie-rockchip.c

[...]

> +static int rockchip_pcie_probe(struct platform_device *pdev)
> +{
> +	struct rockchip_pcie_port *port;
> +	struct device *dev = &pdev->dev;
> +	struct pci_bus *bus, *child;
> +	struct resource_entry *win;
> +	int reg_no;
> +	int err = 0;
> +	int offset = 0;
> +
> +	LIST_HEAD(res);
> +
> +	if (!dev->of_node)
> +		return -ENODEV;
> +
> +	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> +	if (!port)
> +		return -ENOMEM;
> +
> +	port->dev = dev;
> +
> +	err = rockchip_pcie_parse_dt(port);
> +	if (err)
> +		return err;
> +
> +	err = clk_prepare_enable(port->aclk_pcie);
> +	if (err) {
> +		dev_err(dev, "Unable to enable aclk_pcie clock.\n");
> +		goto err_aclk_pcie;
> +	}
> +
> +	err = clk_prepare_enable(port->aclk_perf_pcie);
> +	if (err) {
> +		dev_err(dev, "Unable to enable aclk_perf_pcie clock.\n");
> +		goto err_aclk_perf_pcie;
> +	}
> +
> +	err = clk_prepare_enable(port->hclk_pcie);
> +	if (err) {
> +		dev_err(dev, "Unable to enable hclk_pcie clock.\n");
> +		goto err_hclk_pcie;
> +	}
> +
> +	err = clk_prepare_enable(port->clk_pcie_pm);
> +	if (err) {
> +		dev_err(dev, "Unable to enable hclk_pcie clock.\n");
> +		goto err_pcie_pm;
> +	}
> +
> +	err = rockchip_pcie_set_vpcie(port);
> +	if (err) {
> +		dev_err(port->dev, "Fail to set vpcie regulator.\n");
> +		goto err_set_vpcie;
> +	}
> +
> +	err = rockchip_pcie_init_port(port);
> +	if (err)
> +		goto err_vpcie;
> +
> +	platform_set_drvdata(pdev, port);
> +
> +	rockchip_pcie_enable_interrupts(port);
> +	if (!IS_ENABLED(CONFIG_PCI_MSI)) {
> +		err = rockchip_pcie_init_irq_domain(port);
> +		if (err < 0)
> +			goto err_vpcie;

Why are you excluding wired interrupts if you have PCI_MSI configured?
MSI allocation can fail, and wired interrupts become handy....

> +	}
> +
> +	err = of_pci_get_host_bridge_resources(dev->of_node, 0, 0xff,
> +					       &res, &port->io_base);
> +	if (err)
> +		goto err_vpcie;
> +
> +	/* Get the I/O and memory ranges from DT */
> +	resource_list_for_each_entry(win, &res) {
> +		switch (resource_type(win->res)) {
> +		case IORESOURCE_IO:
> +			port->io = win->res;
> +			port->io->name = "I/O";
> +			port->io_size = resource_size(port->io);
> +			port->io_bus_addr = port->io->start - win->offset;
> +			err = pci_remap_iospace(port->io, port->io_base);
> +			if (err) {
> +				dev_warn(port->dev, "error %d: failed to map resource %pR\n",
> +					 err, port->io);
> +				continue;
> +			}
> +			break;
> +		case IORESOURCE_MEM:
> +			port->mem = win->res;
> +			port->mem->name = "MEM";
> +			port->mem_size = resource_size(port->mem);
> +			port->mem_bus_addr = port->mem->start - win->offset;
> +			break;
> +		case 0:
> +			port->cfg = win->res;
> +			break;
> +		case IORESOURCE_BUS:
> +			port->busn = win->res;
> +			break;
> +		default:
> +			continue;
> +		}
> +	}
> +
> +	for (reg_no = 0; reg_no < (port->mem_size >> 20); reg_no++) {
> +		err = rockchip_pcie_prog_ob_atu(port, reg_no + 1,
> +						AXI_WRAPPER_MEM_WRITE,
> +						20 - 1,
> +						port->mem_bus_addr +
> +							(reg_no << 20),
> +						0);
> +		if (err) {
> +			dev_err(dev, "Program RC mem outbound atu failed\n");
> +			goto err_vpcie;
> +		}
> +	}
> +
> +	err = rockchip_pcie_prog_ib_atu(port, 2, 32 - 1, 0x0, 0);
> +	if (err) {
> +		dev_err(dev, "Program RC mem inbound atu failed\n");
> +		goto err_vpcie;
> +	}
> +
> +	offset = (port->mem_size >> 20);
> +
> +	for (reg_no = 0; reg_no < (port->io_size >> 20); reg_no++) {
> +		err = rockchip_pcie_prog_ob_atu(port,
> +						reg_no + 1 + offset,
> +						AXI_WRAPPER_IO_WRITE,
> +						20 - 1,
> +						port->io_bus_addr +
> +							(reg_no << 20),
> +						0);
> +		if (err) {
> +			dev_err(dev, "Program RC io outbound atu failed\n");
> +			goto err_vpcie;
> +		}
> +	}
> +
> +	port->root_bus_nr = port->busn->start;
> +
> +	bus = pci_scan_root_bus(&pdev->dev, 0,
> +				&rockchip_pcie_ops, port, &res);
> +
> +	if (!bus) {
> +		err = -ENOMEM;
> +		goto err_vpcie;
> +	}
> +
> +	pci_bus_size_bridges(bus);
> +	pci_bus_assign_resources(bus);
> +	list_for_each_entry(child, &bus->children, node)
> +	pcie_bus_configure_settings(child);
> +
> +	pci_bus_add_devices(bus);
> +
> +	return err;
> +
> +err_vpcie:
> +	if (!IS_ERR(port->vpcie3v3))
> +		regulator_disable(port->vpcie3v3);
> +	if (!IS_ERR(port->vpcie1v8))
> +		regulator_disable(port->vpcie1v8);
> +	if (!IS_ERR(port->vpcie0v9))
> +		regulator_disable(port->vpcie0v9);
> +err_set_vpcie:
> +	clk_disable_unprepare(port->clk_pcie_pm);
> +err_pcie_pm:
> +	clk_disable_unprepare(port->hclk_pcie);
> +err_hclk_pcie:
> +	clk_disable_unprepare(port->aclk_perf_pcie);
> +err_aclk_perf_pcie:
> +	clk_disable_unprepare(port->aclk_pcie);
> +err_aclk_pcie:
> +	return err;
> +}
> +
> +static const struct of_device_id rockchip_pcie_of_match[] = {
> +	{ .compatible = "rockchip,rk3399-pcie", },
> +	{}
> +};
> +
> +static struct platform_driver rockchip_pcie_driver = {
> +	.driver = {
> +		.name = "rockchip-pcie",
> +		.of_match_table = rockchip_pcie_of_match,
> +		.suppress_bind_attrs = true,

Why are you removing the bind/unbind attributes?

> +	},
> +	.probe = rockchip_pcie_probe,
> +};
> +module_platform_driver(rockchip_pcie_driver);
> +
> +MODULE_AUTHOR("Rockchip Inc");
> +MODULE_DESCRIPTION("Rockchip AXI PCIe driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/pci/host/pcie-rockchip.h b/drivers/pci/host/pcie-rockchip.h
> new file mode 100644
> index 0000000..738747c
> --- /dev/null
> +++ b/drivers/pci/host/pcie-rockchip.h
> @@ -0,0 +1,209 @@
> +/*
> + * Rockchip AXI PCIe host controller driver
> + *
> + * Copyright (c) 2016 Rockchip, Inc.
> + *
> + * Author: Shawn Lin <shawn.lin@rock-chips.com>
> + *            Wenrui Li <wenrui.li@rock-chips.com>
> + *
> + * Bits taken from Synopsys Designware Host controller driver and
> + * ARM PCI Host generic driver.
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +#ifndef _PCIE_ROCKCHIP_H
> +#define _PCIE_ROCKCHIP_H
> +
> +#define PCIE_CLIENT_BASE		0x0
> +#define PCIE_RC_CONFIG_NORMAL_BASE      0x800000
> +#define PCIE_RC_CONFIG_BASE		0xa00000
> +#define PCIE_CORE_LINK_CTRL_STATUS      0x8000d0
> +#define PCIE_CORE_CTRL_MGMT_BASE	0x900000
> +#define PCIE_CORE_AXI_CONF_BASE		0xc00000
> +#define PCIE_CORE_AXI_INBOUND_BASE	0xc00800
> +
> +#define PCIE_CLIENT_BASIC_STATUS0	0x44
> +#define PCIE_CLIENT_BASIC_STATUS1	0x48
> +#define PCIE_CLIENT_INT_MASK		0x4c
> +#define PCIE_CLIENT_INT_STATUS		0x50
> +#define PCIE_RC_CONFIG_RID_CCR          0x8
> +#define PCIR_RC_CONFIG_LCS              0xd0
> +#define PCIE_RC_BAR_CONF                0x300
> +#define PCIE_CORE_OB_REGION_ADDR1       0x4
> +#define PCIE_CORE_OB_REGION_DESC0       0x8
> +#define PCIE_CORE_OB_REGION_DESC1       0xc
> +#define PCIE_RP_IB_ADDR_TRANS           0x4
> +#define PCIE_CORE_INT_MASK		0x900210
> +#define PCIE_CORE_INT_STATUS		0x90020c
> +
> +/* Size of one AXI Region (not Region 0) */
> +#define	AXI_REGION_SIZE			BIT(20)
> +/* Size of Region 0, equal to sum of sizes of other regions */
> +#define	AXI_REGION_0_SIZE              (32 * (0x1 << 20))
> +#define OB_REG_SIZE_SHIFT               5
> +#define IB_ROOT_PORT_REG_SIZE_SHIFT     3
> +
> +#define AXI_WRAPPER_IO_WRITE            0x6
> +#define AXI_WRAPPER_MEM_WRITE           0x2
> +#define MAX_AXI_IB_ROOTPORT_REGION_NUM  3
> +#define	MIN_AXI_ADDR_BITS_PASSED        8
> +#define ROCKCHIP_VENDOR_ID              0x1d87
> +
> +#define PCIE_ECAM_BUS(x)		(((x) & 0xFF) << 20)
> +#define PCIE_ECAM_DEV(x)		(((x) & 0x1F) << 15)
> +#define PCIE_ECAM_FUNC(x)		(((x) & 0x7) << 12)
> +#define PCIE_ECAM_REG(x)		(((x) & 0xFFF) << 0)
> +#define PCIE_ECAM_ADDR(bus, dev, func, reg) \
> +	  (PCIE_ECAM_BUS(bus) | PCIE_ECAM_DEV(dev) | \
> +	   PCIE_ECAM_FUNC(func) | PCIE_ECAM_REG(reg))
> +
> +/*
> +  * The higher 16-bit of this register is used for write protection
> +  * only if BIT(x + 16) set to 1 the BIT(x) can be written.
> +  */
> +#define HIWORD_UPDATE(val, mask, shift) \
> +	((val) << (shift) | (mask) << ((shift) + 16))
> +
> +#define RC_REGION_0_ADDR_TRANS_H	0x00000000
> +#define RC_REGION_0_ADDR_TRANS_L	0x00000000
> +#define RC_REGION_0_PASS_BITS		(25 - 1)
> +#define RC_REGION_1_ADDR_TRANS_H	0x00000000
> +#define RC_REGION_1_ADDR_TRANS_L	0x00400000
> +#define RC_REGION_1_PASS_BITS		(20 - 1)
> +#define MAX_AXI_WRAPPER_REGION_NUM	33
> +#define PCIE_CORE_LCSR_RETAIN_LINK      BIT(5)
> +#define PCIE_CLIENT_CONF_ENABLE         1
> +#define PCIE_CLIENT_LINK_TRAIN_ENABLE   1
> +#define PCIE_CLIENT_ARI_ENABLE          1
> +#define PCIE_CLIENT_CONF_LANE_NUM(x)    (x / 2)
> +#define PCIE_CLIENT_MODE_RC             1
> +#define PCIE_CLIENT_GEN_SEL_2           1
> +#define PCIE_CLIENT_GEN_SEL_1           0
> +#define PCIE_CLIENT_CONF_ENABLE_SHIFT   0
> +#define PCIE_CLIENT_CONF_ENABLE_MASK    0x1
> +#define PCIE_CLIENT_LINK_TRAIN_SHIFT    1
> +#define PCIE_CLIENT_LINK_TRAIN_MASK     0x1
> +#define PCIE_CLIENT_ARI_ENABLE_SHIFT    3
> +#define PCIE_CLIENT_ARI_ENABLE_MASK     0x1
> +#define PCIE_CLIENT_CONF_LANE_NUM_SHIFT 4
> +#define PCIE_CLIENT_CONF_LANE_NUM_MASK  0x3
> +#define PCIE_CLIENT_MODE_SHIFT          6
> +#define PCIE_CLIENT_MODE_MASK           0x1
> +#define PCIE_CLIENT_GEN_SEL_SHIFT       7
> +#define PCIE_CLIENT_GEN_SEL_MASK        0x1
> +#define PCIE_CLIENT_LINK_STATUS_UP      0x3
> +#define PCIE_CLIENT_LINK_STATUS_SHIFT   20
> +#define PCIE_CLIENT_LINK_STATUS_MASK    0x3
> +#define PCIE_CORE_PL_CONF_SPEED_25G     0x0
> +#define PCIE_CORE_PL_CONF_SPEED_50G     0x1
> +#define PCIE_CORE_PL_CONF_SPEED_80G     0x2
> +#define PCIE_CORE_PL_CONF_SPEED_SHIFT   3
> +#define PCIE_CORE_PL_CONF_SPEED_MASK    0x3
> +#define PCIE_CORE_PL_CONF_LANE_SHIFT    1
> +#define PCIE_CORE_PL_CONF_LANE_MASK     0x3
> +#define PCIE_CORE_RC_CONF_SCC_SHIFT     16
> +
> +/* PCIE_CLIENT_INT_STATUS */
> +#define PCIE_CLIENT_INT_LEGACY_DONE     BIT(15)
> +#define PCIE_CLIENT_INT_MSG             BIT(14)
> +#define PCIE_CLIENT_INT_HOT_RST         BIT(13)
> +#define PCIE_CLIENT_INT_DPA             BIT(12)
> +#define PCIE_CLIENT_INT_FATAL_ERR       BIT(11)
> +#define PCIE_CLIENT_INT_NFATAL_ERR      BIT(10)
> +#define PCIE_CLIENT_INT_CORR_ERR        BIT(9)
> +#define PCIE_CLIENT_INT_INTD            BIT(8)
> +#define PCIE_CLIENT_INT_INTC            BIT(7)
> +#define PCIE_CLIENT_INT_INTB            BIT(6)
> +#define PCIE_CLIENT_INT_INTA            BIT(5)
> +#define PCIE_CLIENT_INT_LOCAL           BIT(4)
> +#define PCIE_CLIENT_INT_UDMA            BIT(3)
> +#define PCIE_CLIENT_INT_PHY             BIT(2)
> +#define PCIE_CLIENT_INT_HOT_PLUG        BIT(1)
> +#define PCIE_CLIENT_INT_PWR_STCG        BIT(0)
> +#define PCIE_CORE_INT_PRFPE             BIT(0)
> +#define PCIE_CORE_INT_CRFPE             BIT(1)
> +#define PCIE_CORE_INT_RRPE              BIT(2)
> +#define PCIE_CORE_INT_PRFO              BIT(3)
> +#define PCIE_CORE_INT_CRFO              BIT(4)
> +#define PCIE_CORE_INT_RT                BIT(5)
> +#define PCIE_CORE_INT_RTR               BIT(6)
> +#define PCIE_CORE_INT_PE                BIT(7)
> +#define PCIE_CORE_INT_MTR               BIT(8)
> +#define PCIE_CORE_INT_UCR               BIT(9)
> +#define PCIE_CORE_INT_FCE               BIT(10)
> +#define PCIE_CORE_INT_CT                BIT(11)
> +#define PCIE_CORE_INT_UTC               BIT(18)
> +#define PCIE_CORE_INT_MMVC              BIT(19)
> +
> +#define ROCKCHIP_PCIE_RPIFR1_INTR_MASK	GENMASK(8, 5)
> +#define ROCKCHIP_PCIE_RPIFR1_INTR_SHIFT	5
> +
> +#define PCIE_CORE_INT \
> +		(PCIE_CORE_INT_PRFPE | PCIE_CORE_INT_CRFPE | \
> +		 PCIE_CORE_INT_RRPE | PCIE_CORE_INT_CRFO | \
> +		 PCIE_CORE_INT_RT | PCIE_CORE_INT_RTR | \
> +		 PCIE_CORE_INT_PE | PCIE_CORE_INT_MTR | \
> +		 PCIE_CORE_INT_UCR | PCIE_CORE_INT_FCE | \
> +		 PCIE_CORE_INT_CT | PCIE_CORE_INT_UTC | \
> +		 PCIE_CORE_INT_MMVC)
> +
> +#define PCIE_CLIENT_INT_SUBSYSTEM \
> +	(PCIE_CLIENT_INT_PWR_STCG | PCIE_CLIENT_INT_HOT_PLUG | \
> +	PCIE_CLIENT_INT_PHY | PCIE_CLIENT_INT_UDMA | \
> +	PCIE_CLIENT_INT_LOCAL)
> +
> +#define PCIE_CLIENT_INT_LEGACY \
> +	(PCIE_CLIENT_INT_INTA | PCIE_CLIENT_INT_INTB | \
> +	PCIE_CLIENT_INT_INTC | PCIE_CLIENT_INT_INTD)
> +
> +#define PCIE_CLIENT_INT_CLI \
> +	(PCIE_CLIENT_INT_CORR_ERR | PCIE_CLIENT_INT_NFATAL_ERR | \
> +	PCIE_CLIENT_INT_FATAL_ERR | PCIE_CLIENT_INT_DPA | \
> +	PCIE_CLIENT_INT_HOT_RST | PCIE_CLIENT_INT_MSG | \
> +	PCIE_CLIENT_INT_LEGACY_DONE | PCIE_CLIENT_INT_LEGACY)
> +
> +struct rockchip_pcie_port {
> +	void __iomem *reg_base;
> +	void __iomem *apb_base;
> +	struct phy           *phy;
> +	struct reset_control *core_rst;
> +	struct reset_control *mgmt_rst;
> +	struct reset_control *mgmt_sticky_rst;
> +	struct reset_control *pipe_rst;
> +	struct clk *aclk_pcie;
> +	struct clk *aclk_perf_pcie;
> +	struct clk *hclk_pcie;
> +	struct clk *clk_pcie_pm;
> +	struct regulator *vpcie3v3; /* 3.3V power supply */
> +	struct regulator *vpcie1v8; /* 1.8V power supply */
> +	struct regulator *vpcie0v9; /* 0.9V power supply */
> +#define VPCIE_3V3    3300000
> +#define VPCIE_1V8    1800000
> +#define VPCIE_0V9    900000
> +	struct gpio_desc *ep_gpio;
> +	u32 lanes;
> +	resource_size_t		io_base;
> +	struct resource		*cfg;
> +	struct resource		*io;
> +	struct resource		*mem;
> +	struct resource		*busn;
> +	phys_addr_t		io_bus_addr;
> +	u32			io_size;
> +	phys_addr_t		mem_bus_addr;
> +	u32			mem_size;

Most of these fields are set at probe time, and at most used once *in
the same function*. Some are assigned and never used... For those that
are actually used, please move them to local variables.

> +	u8	root_bus_nr;
> +	int irq;

This field is populated on init, and then never used. Same comment.

> +	struct msi_controller *msi;

What is that used for? I though we agreed it served no purpose?

> +
> +	struct device *dev;
> +	struct irq_domain *irq_domain;
> +};
> +
> +static irqreturn_t rockchip_pcie_subsys_irq_handler(int irq, void *arg);
> +static irqreturn_t rockchip_pcie_client_irq_handler(int irq, void *arg);
> +static void rockchip_pcie_legacy_int_handler(struct irq_desc *desc);
> +
> +#endif
> 

This include file serves no purpose on its own (nobody is going to
include it). Please consider merging it with the C code.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
