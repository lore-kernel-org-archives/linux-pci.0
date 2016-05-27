Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:44236 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750957AbcE0MZS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 27 May 2016 08:25:18 -0400
Subject: Re: [PATCH 2/2] pci: Add PCIe driver for Rockchip Soc
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Bjorn Helgaas <bhelgaas@google.com>
References: <1463740105-7061-1-git-send-email-shawn.lin@rock-chips.com>
 <1463740156-7148-1-git-send-email-shawn.lin@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Wenrui Li <wenrui.li@rock-chips.com>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>,
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <57483CAA.8000005@arm.com>
Date: Fri, 27 May 2016 13:25:14 +0100
MIME-Version: 1.0
In-Reply-To: <1463740156-7148-1-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+Lorenzo]

On 20/05/16 11:29, Shawn Lin wrote:
> RK3399 has a PCIe controller which can be used as Root Complex.
> This driver supports a PCIe controller as Root Complex mode.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  drivers/pci/host/Kconfig         |   12 +
>  drivers/pci/host/Makefile        |    1 +
>  drivers/pci/host/pcie-rockchip.c | 1181 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1194 insertions(+)
>  create mode 100644 drivers/pci/host/pcie-rockchip.c
> 
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index 8e4f038..76447a8 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -245,4 +245,16 @@ config PCIE_ARMADA_8K
>  	  Designware hardware and therefore the driver re-uses the
>  	  Designware core functions to implement the driver.
>  
> +config PCIE_ROCKCHIP
> +	bool "Rockchip PCIe controller"
> +	depends on ARM64 && ARCH_ROCKCHIP
> +	depends on OF
> +	select MFD_SYSCON
> +	select PCI_MSI
> +	select PCI_MSI_IRQ_DOMAIN
> +	help
> +	  Say Y here if you want internal PCI support on Rockchip SoC.
> +	  There are 1 internal PCIe port available to support GEN2 with
> +	  4 slots.
> +
>  endmenu
> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> index a6f85e3..fb3871e 100644
> --- a/drivers/pci/host/Makefile
> +++ b/drivers/pci/host/Makefile
> @@ -29,3 +29,4 @@ obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
>  obj-$(CONFIG_PCI_HOST_THUNDER_ECAM) += pci-thunder-ecam.o
>  obj-$(CONFIG_PCI_HOST_THUNDER_PEM) += pci-thunder-pem.o
>  obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
> +obj-$(CONFIG_PCIE_ROCKCHIP) += pcie-rockchip.o
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> new file mode 100644
> index 0000000..4063fd3
> --- /dev/null
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -0,0 +1,1181 @@
> +/*
> + * Rockchip AXI PCIe host controller driver
> + *
> + * Copyright (c) 2016 Rockchip, Inc.
> + *
> + * Author: Shawn Lin <shawn.lin@rock-chips.com>
> + *         Wenrui Li <wenrui.li@rock-chips.com>
> + * Bits taken from Synopsys Designware Host controller driver and
> + * ARM PCI Host generic driver.
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/msi.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/of_pci.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_irq.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +#include <linux/regmap.h>
> +
> +#define REF_CLK_100MHZ			(100 * 1000 * 1000)
> +#define PCIE_CLIENT_BASE		0x0
> +#define PCIE_RC_CONFIG_BASE		0xa00000
> +#define PCIE_CORE_CTRL_MGMT_BASE	0x900000
> +#define PCIE_CORE_AXI_CONF_BASE		0xc00000
> +#define PCIE_CORE_AXI_INBOUND_BASE	0xc00800
> +
> +#define PCIE_CLIENT_BASIC_STATUS0	0x44
> +#define PCIE_CLIENT_BASIC_STATUS1	0x48
> +#define PCIE_CLIENT_INT_MASK		0x4c
> +#define PCIE_CLIENT_INT_STATUS		0x50
> +#define PCIE_CORE_INT_MASK		0x900210
> +#define PCIE_CORE_INT_STATUS		0x90020c
> +
> +/** Size of one AXI Region (not Region 0) */
> +#define	AXI_REGION_SIZE			(0x1 << 20)
> +/** Overall size of AXI area */
> +#define	AXI_OVERALL_SIZE		(64 * (0x1 << 20))
> +/** Size of Region 0, equal to sum of sizes of other regions */
> +#define	AXI_REGION_0_SIZE		(32 * (0x1 << 20))
> +#define OB_REG_SIZE_SHIFT		5
> +#define IB_ROOT_PORT_REG_SIZE_SHIFT	3
> +
> +#define AXI_WRAPPER_IO_WRITE		0x6
> +#define AXI_WRAPPER_MEM_WRITE		0x2
> +#define MAX_AXI_IB_ROOTPORT_REGION_NUM	3
> +#define	MIN_AXI_ADDR_BITS_PASSED	8
> +
> +#define ROCKCHIP_PCIE_RPIFR1_INTR_MASK	GENMASK(8, 5)
> +#define ROCKCHIP_PCIE_RPIFR1_INTR_SHIFT	5
> +#define CLIENT_INTERRUPTS \
> +		(LOC_INT | INTA | INTB | INTC | INTD |\
> +		 CORR_ERR | NFATAL_ERR | FATAL_ERR | DPA_INT | \
> +		 HOT_RESET | MSG_DONE | LEGACY_DONE)
> +#define CORE_INTERRUPTS	\
> +		(PRFPE | CRFPE | RRPE | CRFO | RT | RTR | \
> +		 PE | MTR | UCR | FCE | CT | UTC | MMVC)
> +#define PWR_STCG			BIT(0)
> +#define HOT_PLUG			BIT(1)
> +#define PHY_INT				BIT(2)
> +#define UDMA_INT			BIT(3)
> +#define LOC_INT				BIT(4)
> +#define INTA				BIT(5)
> +#define INTB				BIT(6)
> +#define INTC				BIT(7)
> +#define INTD				BIT(8)
> +#define CORR_ERR			BIT(9)
> +#define NFATAL_ERR			BIT(10)
> +#define FATAL_ERR			BIT(11)
> +#define DPA_INT				BIT(12)
> +#define HOT_RESET			BIT(13)
> +#define MSG_DONE			BIT(14)
> +#define LEGACY_DONE			BIT(15)
> +#define PRFPE				BIT(0)
> +#define CRFPE				BIT(1)
> +#define RRPE				BIT(2)
> +#define PRFO				BIT(3)
> +#define CRFO				BIT(4)
> +#define RT				BIT(5)
> +#define RTR				BIT(6)
> +#define PE				BIT(7)
> +#define MTR				BIT(8)
> +#define UCR				BIT(9)
> +#define FCE				BIT(10)
> +#define CT				BIT(11)
> +#define UTC				BIT(18)
> +#define MMVC				BIT(19)
> +
> +#define PCIE_ECAM_BUS(x)		(((x) & 0xFF) << 20)
> +#define PCIE_ECAM_DEV(x)		(((x) & 0x1F) << 15)
> +#define PCIE_ECAM_FUNC(x)		(((x) & 0x7) << 12)
> +#define PCIE_ECAM_REG(x)		(((x) & 0xFFF) << 0)
> +#define PCIE_ECAM_ADDR(bus, dev, func, reg) \
> +	  (PCIE_ECAM_BUS(bus) | PCIE_ECAM_DEV(dev) | \
> +	   PCIE_ECAM_FUNC(func) | PCIE_ECAM_REG(reg))
> +
> +#define RC_REGION_0_ADDR_TRANS_H	0x00000000
> +#define RC_REGION_0_ADDR_TRANS_L	0x00000000
> +#define RC_REGION_0_PASS_BITS		(25 - 1)
> +#define RC_REGION_1_ADDR_TRANS_H	0x00000000
> +#define RC_REGION_1_ADDR_TRANS_L	0x00400000
> +#define RC_REGION_1_PASS_BITS		(20 - 1)
> +#define MAX_AXI_WRAPPER_REGION_NUM	33
> +#define PCIE_CLIENT_CONF_ENABLE		BIT(0)
> +#define PCIE_CLIENT_CONF_LANE_NUM(x)	((x / 2) << 4)
> +#define PCIE_CLIENT_MODE_RC		BIT(6)
> +#define PCIE_CLIENT_GEN_SEL_2		BIT(7)
> +#define PCIE_CLIENT_GEN_SEL_1		0x0
> +
> +struct rockchip_pcie_port {
> +	void __iomem *reg_base;
> +	void __iomem *apb_base;
> +	struct regmap *grf;
> +	unsigned int pcie_conf;
> +	unsigned int pcie_status;
> +	unsigned int pcie_laneoff;
> +	struct reset_control *phy_rst;
> +	struct reset_control *core_rst;
> +	struct reset_control *mgmt_rst;
> +	struct reset_control *mgmt_sticky_rst;
> +	struct reset_control *pipe_rst;
> +	struct clk *aclk_pcie;
> +	struct clk *aclk_perf_pcie;
> +	struct clk *hclk_pcie;
> +	struct clk *clk_pciephy_ref;
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
> +	u8	root_bus_nr;
> +	int irq;
> +	struct msi_controller *msi;

Don't. struct msi_controller shouldn't be used in new code, and
certainly not for an arm64 system.

But even worse: your SoC seems to use a GICv3 ITS. Great. Which means
you do not need any of that at all.

> +
> +	struct device *dev;
> +	struct irq_domain *irq_domain;
> +};

[...]


> +static void rockchip_pcie_msi_enable(struct rockchip_pcie_port *pp)
> +{
> +	struct device_node *msi_node;
> +
> +	msi_node = of_parse_phandle(pp->dev->of_node,
> +				    "msi-parent", 0);
> +	if (!msi_node)
> +		return;
> +
> +	pp->msi = of_pci_find_msi_chip_by_node(msi_node);

How funny. The ITS is never registered there (actually, nobody seems to
register anything there anymore), so this will always return NULL. This
whole function is thus completely useless.

> +	of_node_put(msi_node);
> +
> +	if (pp->msi)
> +		pp->msi->dev = pp->dev;
> +}
> +
> +static void rockchip_pcie_enable_interrupts(struct rockchip_pcie_port *pp)
> +{
> +	pcie_write(pp, (CLIENT_INTERRUPTS << 16) &
> +		   (~CLIENT_INTERRUPTS), PCIE_CLIENT_INT_MASK);
> +	pcie_write(pp, CORE_INTERRUPTS, PCIE_CORE_INT_MASK);
> +}
> +
> +static int rockchip_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
> +				  irq_hw_number_t hwirq)
> +{
> +	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
> +	irq_set_chip_data(irq, domain->host_data);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops intx_domain_ops = {
> +	.map = rockchip_pcie_intx_map,
> +};
> +
> +static int rockchip_pcie_init_irq_domain(struct rockchip_pcie_port *pp)
> +{
> +	struct device *dev = pp->dev;
> +	struct device_node *node = dev->of_node;
> +	struct device_node *pcie_intc_node =  of_get_next_child(node, NULL);

That's really ugly, as it depends on the layout of your DT.

> +
> +	if (!pcie_intc_node) {
> +		dev_err(dev, "No PCIe Intc node found\n");
> +		return PTR_ERR(pcie_intc_node);
> +	}
> +	pp->irq_domain = irq_domain_add_linear(pcie_intc_node, 4,
> +					       &intx_domain_ops, pp);

Why can't you just register your host controller as the interrupt
controller? You don't need an intermediate node for that.

> +	if (!pp->irq_domain) {
> +		dev_err(dev, "Failed to get a INTx IRQ domain\n");
> +		return PTR_ERR(pp->irq_domain);
> +	}
> +
> +	return 0;
> +}
> +
> +static irqreturn_t rockchip_pcie_subsys_irq_handler(int irq, void *arg)
> +{
> +	struct rockchip_pcie_port *pp = arg;
> +	u32 reg;
> +	u32 sub_reg;
> +
> +	reg = pcie_read(pp, PCIE_CLIENT_INT_STATUS);
> +	if (reg & LOC_INT) {
> +		dev_dbg(pp->dev, "local interrupt recived\n");
> +		sub_reg = pcie_read(pp, PCIE_CORE_INT_STATUS);
> +		if (sub_reg & PRFPE)
> +			dev_dbg(pp->dev, "Parity error detected while reading from the PNP Receive FIFO RAM\n");
> +
> +		if (sub_reg & CRFPE)
> +			dev_dbg(pp->dev, "Parity error detected while reading from the Completion Receive FIFO RAM\n");
> +
> +		if (sub_reg & RRPE)
> +			dev_dbg(pp->dev, "Parity error detected while reading from Replay Buffer RAM\n");
> +
> +		if (sub_reg & PRFO)
> +			dev_dbg(pp->dev, "Overflow occurred in the PNP Receive FIFO\n");
> +
> +		if (sub_reg & CRFO)
> +			dev_dbg(pp->dev, "Overflow occurred in the Completion Receive FIFO\n");
> +
> +		if (sub_reg & RT)
> +			dev_dbg(pp->dev, "Replay timer timed out\n");
> +
> +		if (sub_reg & RTR)
> +			dev_dbg(pp->dev, "Replay timer rolled over after 4 transmissions of the same TLP\n");
> +
> +		if (sub_reg & PE)
> +			dev_dbg(pp->dev, "Phy error detected on receive side\n");
> +
> +		if (sub_reg & MTR)
> +			dev_dbg(pp->dev, "Malformed TLP received from the link\n");
> +
> +		if (sub_reg & UCR)
> +			dev_dbg(pp->dev, "Malformed TLP received from the link\n");
> +
> +		if (sub_reg & FCE)
> +			dev_dbg(pp->dev, "An error was observed in the flow control advertisements from the other side\n");
> +
> +		if (sub_reg & CT)
> +			dev_dbg(pp->dev, "A request timed out waiting for completion\n");
> +
> +		if (sub_reg & UTC)
> +			dev_dbg(pp->dev, "Unmapped TC error\n");
> +
> +		if (sub_reg & MMVC)
> +			dev_dbg(pp->dev, "MSI mask register changes\n");
> +
> +		pcie_write(pp, sub_reg, PCIE_CORE_INT_STATUS);
> +	}
> +
> +	pcie_write(pp, reg, PCIE_CLIENT_INT_STATUS);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t rockchip_pcie_client_irq_handler(int irq, void *arg)
> +{
> +	struct rockchip_pcie_port *pp = arg;
> +	u32 reg;
> +
> +	reg = pcie_read(pp, PCIE_CLIENT_INT_STATUS);
> +	if (reg & LEGACY_DONE)
> +		dev_dbg(pp->dev, "legacy done interrupt recived\n");
> +
> +	if (reg & MSG_DONE)
> +		dev_dbg(pp->dev, "message done interrupt recived\n");
> +
> +	if (reg & HOT_RESET)
> +		dev_dbg(pp->dev, "hot reset interrupt recived\n");
> +
> +	if (reg & DPA_INT)
> +		dev_dbg(pp->dev, "dpa interrupt recived\n");
> +
> +	if (reg & FATAL_ERR)
> +		dev_dbg(pp->dev, "fatal error interrupt recived\n");
> +
> +	if (reg & DPA_INT)
> +		dev_dbg(pp->dev, "no fatal error interrupt recived\n");
> +
> +	if (reg & CORR_ERR)
> +		dev_dbg(pp->dev, "correctable error interrupt recived\n");
> +
> +	pcie_write(pp, reg, PCIE_CLIENT_INT_STATUS);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t rockchip_pcie_legacy_int_handler(int irq, void *arg)
> +{
> +	struct rockchip_pcie_port *pp = arg;
> +	u32 reg;
> +
> +	reg = pcie_read(pp, PCIE_CLIENT_INT_STATUS);
> +	reg = (reg & ROCKCHIP_PCIE_RPIFR1_INTR_MASK) >>
> +	       ROCKCHIP_PCIE_RPIFR1_INTR_SHIFT;
> +	generic_handle_irq(irq_find_mapping(pp->irq_domain, ffs(reg)));

NAK. What you have here is a chained interrupt controller, please
implement it as such.

> +
> +	pcie_write(pp, reg, PCIE_CLIENT_INT_STATUS);
> +	return IRQ_HANDLED;
> +}
> +
> +static int rockchip_pcie_prog_ob_atu(struct rockchip_pcie_port *pp,
> +				     int region_no,
> +				     int type, u8 num_pass_bits,
> +				     u32 lower_addr, u32 upper_addr)
> +{
> +	u32 ob_addr_0 = 0;
> +	u32 ob_addr_1 = 0;
> +	u32 ob_desc_0 = 0;
> +	u32 ob_desc_1 = 0;
> +	void __iomem *aw_base;
> +
> +	if (!pp)
> +		return -EINVAL;
> +	if (region_no >= MAX_AXI_WRAPPER_REGION_NUM)
> +		return -EINVAL;
> +	if ((num_pass_bits + 1) < 8)
> +		return -EINVAL;
> +	if (num_pass_bits > 63)
> +		return -EINVAL;
> +	if (region_no == 0) {
> +		if (AXI_REGION_0_SIZE < (2ULL << num_pass_bits))
> +		return -EINVAL;
> +	}
> +	if (region_no != 0) {
> +		if (AXI_REGION_SIZE < (2ULL << num_pass_bits))
> +		return -EINVAL;
> +	}
> +	aw_base = pp->apb_base + PCIE_CORE_AXI_CONF_BASE;
> +	aw_base += (region_no << OB_REG_SIZE_SHIFT);
> +
> +	ob_addr_0 = (ob_addr_0 &
> +		     ~0x0000003fU) | (num_pass_bits &
> +		     0x0000003fU);
> +	ob_addr_0 = (ob_addr_0 &
> +		     ~0xffffff00U) | (lower_addr & 0xffffff00U);
> +	ob_addr_1 = upper_addr;
> +	ob_desc_0 = (1 << 23 | type);
> +
> +	writel(ob_addr_0, aw_base);
> +	writel(ob_addr_1, aw_base + 0x4);
> +	writel(ob_desc_0, aw_base + 0x8);
> +	writel(ob_desc_1, aw_base + 0xc);
> +
> +	return 0;
> +}
> +
> +static int rockchip_pcie_prog_ib_atu(struct rockchip_pcie_port *pp,
> +				     int region_no,
> +				     u8 num_pass_bits,
> +				     u32 lower_addr,
> +				     u32 upper_addr)
> +{
> +	u32 ib_addr_0 = 0;
> +	u32 ib_addr_1 = 0;
> +	void __iomem *aw_base;
> +
> +	if (!pp)
> +		return -EINVAL;
> +	if (region_no > MAX_AXI_IB_ROOTPORT_REGION_NUM)
> +		return -EINVAL;
> +	if ((num_pass_bits + 1) < MIN_AXI_ADDR_BITS_PASSED)
> +		return -EINVAL;
> +	if (num_pass_bits > 63)
> +		return -EINVAL;
> +	aw_base = pp->apb_base + PCIE_CORE_AXI_INBOUND_BASE;
> +	aw_base += (region_no << IB_ROOT_PORT_REG_SIZE_SHIFT);
> +	ib_addr_0 = (ib_addr_0 &
> +		     ~0x0000003fU) | (num_pass_bits &
> +		     0x0000003fU);
> +
> +	ib_addr_0 = (ib_addr_0 & ~0xffffff00U) |
> +		     ((lower_addr << 8) & 0xffffff00U);
> +	ib_addr_1 = upper_addr;
> +	writel(ib_addr_0, aw_base);
> +	writel(ib_addr_1, aw_base + 0x4);
> +
> +	return 0;
> +}
> +
> +static int rockchip_pcie_probe(struct platform_device *pdev)
> +{
> +	struct rockchip_pcie_port *port;
> +	struct device *dev = &pdev->dev;
> +	struct pci_bus *bus, *child;
> +	struct resource_entry *win;
> +	int reg_no;
> +	int err = 0;
> +	int irq;
> +	LIST_HEAD(res);
> +
> +	if (!dev->of_node)
> +		return -ENODEV;
> +
> +	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> +	if (!port)
> +		return -ENOMEM;
> +
> +	irq = platform_get_irq_byname(pdev, "pcie-sys");
> +	if (irq < 0) {
> +		dev_err(dev, "missing pcie_sys IRQ resource\n");
> +		return -EINVAL;
> +	}
> +	err = devm_request_irq(dev, irq, rockchip_pcie_subsys_irq_handler,
> +			       IRQF_SHARED, "pcie-sys", port);
> +	if (err) {
> +		dev_err(dev, "failed to request pcie subsystem irq\n");
> +		return err;
> +	}
> +
> +	port->irq = platform_get_irq_byname(pdev, "pcie-legacy");
> +	if (port->irq < 0) {
> +		dev_err(dev, "missing pcie_legacy IRQ resource\n");
> +		return -EINVAL;
> +	}
> +	err = devm_request_irq(dev, port->irq,
> +			       rockchip_pcie_legacy_int_handler,
> +			       IRQF_SHARED,
> +			       "pcie-legacy",
> +			       port);
> +	if (err) {
> +		dev_err(&pdev->dev, "failed to request pcie-legacy irq\n");
> +		return err;
> +	}
> +
> +	irq = platform_get_irq_byname(pdev, "pcie-client");
> +	if (irq < 0) {
> +		dev_err(dev, "missing pcie-client IRQ resource\n");
> +		return -EINVAL;
> +	}
> +	err = devm_request_irq(dev, irq, rockchip_pcie_client_irq_handler,
> +			       IRQF_SHARED, "pcie-client", port);
> +	if (err) {
> +		dev_err(dev, "failed to request pcie client irq\n");
> +		return err;
> +	}
> +
> +	port->dev = dev;
> +	err = rockchip_pcie_parse_dt(port);
> +	if (err) {
> +		dev_err(dev, "Parsing DT failed\n");
> +		return err;
> +	}
> +
> +	err = rockchip_pcie_init_port(port);
> +	if (err)
> +		return err;
> +
> +	platform_set_drvdata(pdev, port);
> +
> +	rockchip_pcie_enable_interrupts(port);
> +	if (!IS_ENABLED(CONFIG_PCI_MSI)) {
> +		err = rockchip_pcie_init_irq_domain(port);
> +		if (err < 0)
> +			return err;
> +	}
> +
> +	err = of_pci_get_host_bridge_resources(dev->of_node, 0, 0xff,
> +					       &res, &port->io_base);
> +	if (err)
> +		return err;
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
> +	pcie_write(port, 0x6040000, PCIE_RC_CONFIG_BASE + 0x8);
> +	pcie_write(port, 0x0, PCIE_CORE_CTRL_MGMT_BASE + 0x300);
> +
> +	pcie_write(port, (RC_REGION_0_ADDR_TRANS_L + RC_REGION_0_PASS_BITS),
> +		   PCIE_CORE_AXI_CONF_BASE);
> +	pcie_write(port, RC_REGION_0_ADDR_TRANS_H,
> +		   PCIE_CORE_AXI_CONF_BASE + 0x4);
> +	pcie_write(port, 0x0080000a, PCIE_CORE_AXI_CONF_BASE + 0x8);
> +	pcie_write(port, 0x00000000, PCIE_CORE_AXI_CONF_BASE + 0xc);
> +
> +	for (reg_no = 0; reg_no < (port->mem_size >> 20); reg_no++) {
> +		err = rockchip_pcie_prog_ob_atu(port, reg_no + 1,
> +						AXI_WRAPPER_MEM_WRITE,
> +						20 - 1,
> +						port->mem_bus_addr +
> +							(reg_no << 20),
> +						0);
> +		if (err) {
> +			dev_err(dev, "Program RC outbound atu failed\n");
> +			return err;
> +		}
> +	}
> +
> +	err = rockchip_pcie_prog_ib_atu(port, 2, 32 - 1, 0x0, 0);
> +	if (err) {
> +		dev_err(dev, "Program RC inbound atu failed\n");
> +		return err;
> +	}
> +
> +	rockchip_pcie_msi_enable(port);
> +
> +	port->root_bus_nr = port->busn->start;
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		bus = pci_scan_root_bus_msi(port->dev, port->root_bus_nr,
> +					    &rockchip_pcie_ops, port, &res,
> +					    port->msi);

You don't need this. The infrastructure will do the right thing for you.

> +	} else {
> +		bus = pci_scan_root_bus(&pdev->dev, 0,
> +					&rockchip_pcie_ops, port, &res);
> +	}
> +	if (!bus)
> +		return -ENOMEM;
> +
> +	if (!pci_has_flag(PCI_PROBE_ONLY)) {

Why do you have catter for the PCI_PROBE_ONLY case? Nobody should ever
use that for properly implemented HW.

> +		pci_bus_size_bridges(bus);
> +		pci_bus_assign_resources(bus);
> +		list_for_each_entry(child, &bus->children, node)
> +			pcie_bus_configure_settings(child);
> +	}
> +
> +	pci_bus_add_devices(bus);
> +
> +	return err;
> +}
> +
> +static int rockchip_pcie_remove(struct platform_device *pdev)
> +{
> +	struct rockchip_pcie_port *port = platform_get_drvdata(pdev);
> +
> +	clk_disable_unprepare(port->hclk_pcie);
> +	clk_disable_unprepare(port->aclk_perf_pcie);
> +	clk_disable_unprepare(port->aclk_pcie);
> +	clk_disable_unprepare(port->clk_pciephy_ref);
> +
> +	return 0;
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
> +	},
> +	.probe = rockchip_pcie_probe,
> +	.remove = rockchip_pcie_remove,
> +};
> +module_platform_driver(rockchip_pcie_driver);
> +
> +MODULE_AUTHOR("Rockchip Inc");
> +MODULE_DESCRIPTION("Rockchip AXI PCIe driver");
> +MODULE_LICENSE("GPL v2");
> 

This definitely requires some rework for both the interrupt and MSI
parts. I'll leave Lorenzo to comment on the PCI side of things.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
