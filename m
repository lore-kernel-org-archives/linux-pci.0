Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:36129 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751252AbcLZLty (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Dec 2016 06:49:54 -0500
Subject: Re: [RFC PATCH 4/6] PCI: exynos5433: Add new exynos pci host
 controller for Exynos5433
To: Jaehoon Chung <jh80.chung@samsung.com>, <linux-pci@vger.kernel.org>
References: <20161226052029.10552-1-jh80.chung@samsung.com>
 <CGME20161226052031epcas1p4d238d16e55984dcf905daf1ad132ccca@epcas1p4.samsung.com>
 <20161226052029.10552-5-jh80.chung@samsung.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>, <kgene@kernel.org>,
        <krzk@kernel.org>, <javier@osg.samsung.com>, <kishon@ti.com>,
        <will.deacon@arm.com>, <catalin.marinas@arm.com>,
        <cpgs@samsung.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <62af9734-4e16-d5e7-10f0-f4d2ac6fa9ff@synopsys.com>
Date: Mon, 26 Dec 2016 11:49:48 +0000
MIME-Version: 1.0
In-Reply-To: <20161226052029.10552-5-jh80.chung@samsung.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Hello Jaehoon,

Às 5:20 AM de 12/26/2016, Jaehoon Chung escreveu:
> Exynos5433 supports the PCIe.
> This patch adds new pci-exynos5433.c file for Exynos ARM64.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  drivers/pci/host/Kconfig          |   9 +
>  drivers/pci/host/Makefile         |   1 +
>  drivers/pci/host/pci-exynos5433.c | 338 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 348 insertions(+)
>  create mode 100644 drivers/pci/host/pci-exynos5433.c
> 
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index d7e7c0a..3d77d0b 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -60,6 +60,15 @@ config PCI_EXYNOS
>  	select PCIEPORTBUS
>  	select PCIE_DW
>  
> +config PCI_EXYNOS5433
> +	bool "Samsung Exynos5433 PCIe controller"
> +	depends on ARCH_EXYNOS && ARM64
> +	depends on PCI_MSI_IRQ_DOMAIN
> +	select PCIEPORTBUS
> +	select PCIE_DW
> +	help
> +	  If you want support for Exynos5433 PCIe host controller, say Y.
> +
>  config PCI_IMX6
>  	bool "Freescale i.MX6 PCIe controller"
>  	depends on SOC_IMX6Q
> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> index 084cb49..2168de2 100644
> --- a/drivers/pci/host/Makefile
> +++ b/drivers/pci/host/Makefile
> @@ -2,6 +2,7 @@ obj-$(CONFIG_PCIE_DW) += pcie-designware.o
>  obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
>  obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
>  obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
> +obj-$(CONFIG_PCI_EXYNOS5433) += pci-exynos5433.o
>  obj-$(CONFIG_PCI_IMX6) += pci-imx6.o
>  obj-$(CONFIG_PCI_HYPERV) += pci-hyperv.o
>  obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
> diff --git a/drivers/pci/host/pci-exynos5433.c b/drivers/pci/host/pci-exynos5433.c
> new file mode 100644
> index 0000000..ff254ca
> --- /dev/null
> +++ b/drivers/pci/host/pci-exynos5433.c
> @@ -0,0 +1,338 @@
> +/*
> + * PCIe host controller driver for Samsung EXYNOS5433 SoCs
> + *
> + * Copyright (C) 2016 Samsung Electronics Co., Ltd.
> + *		https://urldefense.proofpoint.com/v2/url?u=http-3A__www.samsung.com&d=DgIBAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=s2fO0hii0OGNOv9qQy_HRXy-xAJUD1NNoEcc3io_kx0&m=fUwnZks1U2AwaOxMkLdSnE700sfQXpB3WAg_EJw7NaE&s=IwRYD8maTuXG57Q0qlAmFNh3_TSfUTE27xq8p13FFKI&e= 
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/gpio.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_gpio.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/resource.h>
> +#include <linux/signal.h>
> +#include <linux/types.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/phy/phy.h>
> +
> +#include "pcie-designware.h"
> +
> +#define to_exynos_pcie(x)	container_of(x, struct exynos_pcie, pp)
> +
> +/* Pcie structure for Exynos specific data */
> +struct exynos_pcie {
> +	void __iomem		*elbi_base;
> +	struct clk		*clk;
> +	struct clk		*bus_clk;
> +	struct pcie_port	pp;
> +	struct phy		*phy;
> +};
> +
> +/* PCIe ELBI registers */
> +#define PCIE_IRQ_PULSE			0x000
> +#define IRQ_INTA_ASSERT			BIT(0)
> +#define IRQ_INTB_ASSERT			BIT(2)
> +#define IRQ_INTC_ASSERT			BIT(4)
> +#define IRQ_INTD_ASSERT			BIT(6)
> +#define IRQ_INTX_ASSERT	(IRQ_INTA_ASSERT | IRQ_INTB_ASSERT | \
> +			IRQ_INTC_ASSERT | IRQ_INTD_ASSERT)
> +#define PCIE_IRQ_EN_PULSE		0x00c
> +#define PCIE_IRQ_EN_LEVEL		0x010
> +#define PCIE_SW_WAKE			0x018
> +#define PCIE_BUS_EN			BIT(1)
> +#define PCIE_APP_LTSSM_ENABLE		0x02c
> +#define PCIE_ELBI_LTSSM_ENABLE		0x1
> +#define PCIE_ELBI_DEBUG_L		0x074
> +#define PCIE_ELBI_XMLH_LINK_UP		BIT(4)
> +#define PCIE_ELBI_SLV_AWMISC		0x11c
> +#define PCIE_ELBI_SLV_ARMISC		0x120
> +#define PCIE_ELBI_SLV_DBI_ENABLE	BIT(21)
> +
> +/* DBI register */
> +#define PCIE_MISC_CONTROL_1_OFF		0x8BC
> +#define DBI_RO_WR_EN			BIT(0)
> +
> +static inline void exynos_pcie_writel(void __iomem *base, u32 val, u32 offset)
> +{
> +	writel(val, base + offset);
> +}
> +
> +static inline u32 exynos_pcie_readl(void __iomem *base, u32 offset)
> +{
> +	return readl(base + offset);
> +}
> +
> +static void exynos_pcie_clear_irq_pulse(struct exynos_pcie *ep)
> +{
> +	u32 val;
> +
> +	val = exynos_pcie_readl(ep->elbi_base, PCIE_IRQ_PULSE);
> +	val &= ~IRQ_INTX_ASSERT;
> +	exynos_pcie_writel(ep->elbi_base, val, PCIE_IRQ_PULSE);
> +}
> +
> +static void exynos_pcie_enable_irq_pulse(struct exynos_pcie *ep)
> +{
> +	exynos_pcie_writel(ep->elbi_base, IRQ_INTX_ASSERT, PCIE_IRQ_EN_PULSE);
> +
> +	/* Clear PCIE_IRQ_EN_LEVEL register */
> +	exynos_pcie_writel(ep->elbi_base, 0, PCIE_IRQ_EN_LEVEL);
> +}
> +
> +static irqreturn_t exynos_pcie_irq_handler(int irq, void *arg)
> +{
> +	struct pcie_port *pp = arg;
> +	struct exynos_pcie *ep = to_exynos_pcie(pp);
> +
> +	exynos_pcie_clear_irq_pulse(ep);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void exynos_pcie_sideband_dbi_w_mode(struct exynos_pcie *ep, bool on)
> +{
> +	u32 val;
> +
> +	val = exynos_pcie_readl(ep->elbi_base, PCIE_ELBI_SLV_AWMISC);
> +	if (on)
> +		val |= PCIE_ELBI_SLV_DBI_ENABLE;
> +	else
> +		val &= ~PCIE_ELBI_SLV_DBI_ENABLE;
> +	exynos_pcie_writel(ep->elbi_base, val, PCIE_ELBI_SLV_AWMISC);
> +}
> +
> +static void exynos_pcie_sideband_dbi_r_mode(struct exynos_pcie *ep, bool on)
> +{
> +	u32 val;
> +
> +	val = exynos_pcie_readl(ep->elbi_base, PCIE_ELBI_SLV_ARMISC);
> +	if (on)
> +		val |= PCIE_ELBI_SLV_DBI_ENABLE;
> +	else
> +		val &= ~PCIE_ELBI_SLV_DBI_ENABLE;
> +	exynos_pcie_writel(ep->elbi_base, val, PCIE_ELBI_SLV_ARMISC);
> +}
> +
> +static int exynos_pcie_establish_link(struct exynos_pcie *ep)
> +{
> +	struct pcie_port *pp = &ep->pp;
> +	u32 val;
> +
> +	if (dw_pcie_link_up(pp)) {
> +		dev_info(pp->dev, "Link already up\n");
> +		return 0;
> +	}
> +
> +	phy_power_on(ep->phy);
> +
> +	/* Exynos Pcie assert PHY reset  and init */
> +	phy_init(ep->phy);
> +
> +	val = exynos_pcie_readl(ep->elbi_base, PCIE_SW_WAKE);
> +	val &= ~PCIE_BUS_EN;
> +	exynos_pcie_writel(ep->elbi_base, val, PCIE_SW_WAKE);
> +
> +	/*
> +	 * Enable DBI_RO_WR_EN bit.
> +	 * - When set to 1, some RO and HWinit bits are wriatble from
> +	 *   the local application through the DBI.
> +	 */
> +	dw_pcie_writel_rc(pp, PCIE_MISC_CONTROL_1_OFF, DBI_RO_WR_EN);
> +
> +	/* Setup root complex */
> +	dw_pcie_setup_rc(pp);
> +
> +	/* assert LTSSM enable */
> +	exynos_pcie_writel(ep->elbi_base, PCIE_ELBI_LTSSM_ENABLE,
> +			PCIE_APP_LTSSM_ENABLE);
> +
> +	return dw_pcie_wait_for_link(pp);
> +}
> +
> +
> +static int exynos_pcie_link_up(struct pcie_port *pp)
> +{
> +	struct exynos_pcie *ep = to_exynos_pcie(pp);
> +	u32 val;
> +
> +	/* Check the Receive Transaction Layer Handler */
> +	val = exynos_pcie_readl(ep->elbi_base, PCIE_ELBI_DEBUG_L);
> +
> +	return (val & PCIE_ELBI_XMLH_LINK_UP);
> +}
> +
> +static void exynos_pcie_host_init(struct pcie_port *pp)
> +{
> +	struct exynos_pcie *ep = to_exynos_pcie(pp);
> +
> +	exynos_pcie_enable_irq_pulse(ep);
> +	exynos_pcie_establish_link(ep);
> +}

Your *_host_init callback should return to pci-designware its error/success
status. There is a recent patch that added this capability to all vendor
specific drivers that use pcie-designware. Please check it out and follow the
same approach:
https://patchwork.kernel.org/patch/9464223/

Thanks,
Joao

> +
> +static u32 exynos_pcie_readl_rc(struct pcie_port *pp, u32 reg)
> +{
> +	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
> +	u32 val;
> +
> +	exynos_pcie_sideband_dbi_r_mode(exynos_pcie, true);
> +	val = readl(pp->dbi_base + reg);
> +	exynos_pcie_sideband_dbi_r_mode(exynos_pcie, false);
> +	return val;
> +}
> +
> +static void exynos_pcie_writel_rc(struct pcie_port *pp, u32 reg, u32 val)
> +{
> +	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
> +
> +	exynos_pcie_sideband_dbi_w_mode(exynos_pcie, true);
> +	writel(val, pp->dbi_base + reg);
> +	exynos_pcie_sideband_dbi_w_mode(exynos_pcie, false);
> +}
> +
> +static int exynos_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
> +				u32 *val)
> +{
> +	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
> +	int ret;
> +
> +	exynos_pcie_sideband_dbi_r_mode(exynos_pcie, true);
> +	ret = dw_pcie_cfg_read(pp->dbi_base + where, size, val);
> +	exynos_pcie_sideband_dbi_r_mode(exynos_pcie, false);
> +	return ret;
> +}
> +
> +static int exynos_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
> +				u32 val)
> +{
> +	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
> +	int ret;
> +
> +	exynos_pcie_sideband_dbi_w_mode(exynos_pcie, true);
> +	ret = dw_pcie_cfg_write(pp->dbi_base + where, size, val);
> +	exynos_pcie_sideband_dbi_w_mode(exynos_pcie, false);
> +	return ret;
> +}
> +
> +static struct pcie_host_ops exynos_pcie_host_ops = {
> +	.readl_rc = exynos_pcie_readl_rc,
> +	.writel_rc = exynos_pcie_writel_rc,
> +	.rd_own_conf = exynos_pcie_rd_own_conf,
> +	.wr_own_conf = exynos_pcie_wr_own_conf,
> +	.host_init = exynos_pcie_host_init,
> +	.link_up = exynos_pcie_link_up,
> +};
> +
> +static int __init exynos_pcie_probe(struct platform_device *pdev)
> +{
> +	struct exynos_pcie *exynos_pcie;
> +	struct pcie_port *pp;
> +	struct resource *res;
> +	int ret;
> +
> +	exynos_pcie = devm_kzalloc(&pdev->dev, sizeof(*exynos_pcie),
> +			GFP_KERNEL);
> +	if (!exynos_pcie)
> +		return -ENOMEM;
> +
> +	pp = &exynos_pcie->pp;
> +	pp->dev = &pdev->dev;
> +
> +	exynos_pcie->clk = devm_clk_get(&pdev->dev, "pcie");
> +	if (IS_ERR(exynos_pcie->clk)) {
> +		dev_err(&pdev->dev, "Failed to get pcie rc clock\n");
> +		return PTR_ERR(exynos_pcie->clk);
> +	}
> +	ret = clk_prepare_enable(exynos_pcie->clk);
> +	if (ret)
> +		return ret;
> +
> +	exynos_pcie->bus_clk = devm_clk_get(&pdev->dev, "pcie_bus");
> +	if (IS_ERR(exynos_pcie->bus_clk)) {
> +		dev_err(&pdev->dev, "Failed to get pcie bus clock\n");
> +		ret = PTR_ERR(exynos_pcie->bus_clk);
> +		goto fail_clk;
> +	}
> +	ret = clk_prepare_enable(exynos_pcie->bus_clk);
> +	if (ret)
> +		goto fail_clk;
> +
> +	/* External Local Bus interface(ELBI) Register */
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "elbi");
> +	exynos_pcie->elbi_base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(exynos_pcie->elbi_base)) {
> +		ret = PTR_ERR(exynos_pcie->elbi_base);
> +		goto fail_bus_clk;
> +	}
> +
> +	/* Data Bus Interface(DBI) Register */
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
> +	pp->dbi_base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(pp->dbi_base)) {
> +		ret = PTR_ERR(pp->dbi_base);
> +		goto fail_bus_clk;
> +	}
> +
> +	exynos_pcie->phy = devm_phy_get(&pdev->dev, "pcie-phy");
> +	if (IS_ERR(exynos_pcie->phy)) {
> +		if (PTR_ERR(exynos_pcie->phy) != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "Can't find the pcie-phy\n");
> +		return PTR_ERR(exynos_pcie->phy);
> +	}
> +
> +	pp->irq = platform_get_irq_byname(pdev, "intr");
> +	if (!pp->irq) {
> +		dev_err(&pdev->dev, "failed to get irq\n");
> +		ret = -ENODEV;
> +		goto fail_bus_clk;
> +	}
> +	ret = devm_request_irq(&pdev->dev, pp->irq, exynos_pcie_irq_handler,
> +				IRQF_SHARED, "exynos-pcie", exynos_pcie);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to request irq\n");
> +		goto fail_bus_clk;
> +	}
> +
> +	pp->root_bus_nr = -1;
> +	pp->ops = &exynos_pcie_host_ops;
> +
> +	ret = dw_pcie_host_init(pp);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to initialize host\n");
> +		goto fail_bus_clk;
> +	}
> +
> +	platform_set_drvdata(pdev, exynos_pcie);
> +
> +	return 0;
> +
> +fail_bus_clk:
> +	clk_disable_unprepare(exynos_pcie->bus_clk);
> +fail_clk:
> +	clk_disable_unprepare(exynos_pcie->clk);
> +	return ret;
> +}
> +
> +static const struct of_device_id exynos_pcie_of_match[] = {
> +	{ .compatible = "samsung,exynos5433-pcie", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, exynos_pcie_of_match);
> +
> +static struct platform_driver exynos_pcie_driver = {
> +	.probe		= exynos_pcie_probe,
> +	.driver		= {
> +		.name		= "exynos5433-pcie",
> +		.of_match_table = exynos_pcie_of_match,
> +	},
> +};
> +builtin_platform_driver(exynos_pcie_driver);
> 

