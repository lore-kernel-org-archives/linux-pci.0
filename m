Return-Path: <SRS0=q0B1=N6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBF2C43441
	for <linux-pci@archiver.kernel.org>; Mon, 19 Nov 2018 16:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A542086A
	for <linux-pci@archiver.kernel.org>; Mon, 19 Nov 2018 16:17:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48A542086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729888AbeKTClb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:41:31 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60630 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729825AbeKTClb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Nov 2018 21:41:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D49FC80D;
        Mon, 19 Nov 2018 08:17:27 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C00E03F5B7;
        Mon, 19 Nov 2018 08:17:25 -0800 (PST)
Date:   Mon, 19 Nov 2018 16:17:20 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: Re: [RESEND PATCH v3 2/2] PCI: uniphier: Add UniPhier PCIe host
 controller support
Message-ID: <20181119161653.GA32232@e107981-ln.cambridge.arm.com>
References: <1539667641-26024-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1539667641-26024-3-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539667641-26024-3-git-send-email-hayashi.kunihiko@socionext.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 16, 2018 at 02:27:21PM +0900, Kunihiko Hayashi wrote:
> This introduces specific glue layer for UniPhier platform to support
> PCIe host controller that is based on the DesignWare PCIe core, and
> this driver supports Root Complex (host) mode.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  drivers/pci/controller/dwc/Kconfig         |   9 +
>  drivers/pci/controller/dwc/Makefile        |   1 +
>  drivers/pci/controller/dwc/pcie-uniphier.c | 433 +++++++++++++++++++++++++++++

The driver needs a MAINTAINERS entry too.

>  3 files changed, 443 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-uniphier.c
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 91b0194..d8fdb02 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -193,4 +193,13 @@ config PCIE_HISI_STB
>  	help
>            Say Y here if you want PCIe controller support on HiSilicon STB SoCs
>  
> +config PCIE_UNIPHIER
> +	bool "Socionext UniPhier PCIe controllers"
> +	depends on OF && (ARCH_UNIPHIER || COMPILE_TEST)
> +	depends on PCI_MSI_IRQ_DOMAIN
> +	select PCIE_DW_HOST
> +	help
> +	  Say Y here if you want PCIe controller support on UniPhier SoCs.
> +	  This driver supports LD20 and PXs3 SoCs.
> +
>  endmenu
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> index 5d2ce72..cbde733 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
>  obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
>  obj-$(CONFIG_PCIE_KIRIN) += pcie-kirin.o
>  obj-$(CONFIG_PCIE_HISI_STB) += pcie-histb.o
> +obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
>  
>  # The following drivers are for devices that use the generic ACPI
>  # pci_root.c driver but don't support standard ECAM config access.
> diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
> new file mode 100644
> index 0000000..2689449
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-uniphier.c
> @@ -0,0 +1,433 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCIe host controller driver for UniPhier SoCs
> + * Copyright 2018 Socionext Inc.
> + * Author: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/iopoll.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/module.h>
> +#include <linux/of_irq.h>
> +#include <linux/pci.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +
> +#include "pcie-designware.h"
> +
> +#define PCL_PINCTRL0			0x002c
> +#define PCL_PERST_PLDN_REGEN		BIT(12)
> +#define PCL_PERST_NOE_REGEN		BIT(11)
> +#define PCL_PERST_OUT_REGEN		BIT(8)
> +#define PCL_PERST_PLDN_REGVAL		BIT(4)
> +#define PCL_PERST_NOE_REGVAL		BIT(3)
> +#define PCL_PERST_OUT_REGVAL		BIT(0)
> +
> +#define PCL_PIPEMON			0x0044
> +#define PCL_PCLK_ALIVE			BIT(15)
> +
> +#define PCL_APP_READY_CTRL		0x8008
> +#define PCL_APP_LTSSM_ENABLE		BIT(0)
> +
> +#define PCL_APP_PM0			0x8078
> +#define PCL_SYS_AUX_PWR_DET		BIT(8)
> +
> +#define PCL_RCV_INT			0x8108
> +#define PCL_RCV_INT_ALL_ENABLE		GENMASK(20, 17)
> +#define PCL_CFG_BW_MGT_STATUS		BIT(4)
> +#define PCL_CFG_LINK_AUTO_BW_STATUS	BIT(3)
> +#define PCL_CFG_AER_RC_ERR_MSI_STATUS	BIT(2)
> +#define PCL_CFG_PME_MSI_STATUS		BIT(1)
> +
> +#define PCL_RCV_INTX			0x810c
> +#define PCL_RCV_INTX_ALL_ENABLE		GENMASK(19, 16)
> +#define PCL_RCV_INTX_ALL_STATUS		GENMASK(3, 0)
> +
> +#define PCL_STATUS_LINK			0x8140
> +#define PCL_RDLH_LINK_UP		BIT(1)
> +#define PCL_XMLH_LINK_UP		BIT(0)
> +
> +struct uniphier_pcie_priv {
> +	void __iomem *base;
> +	struct dw_pcie pci;
> +	struct clk *clk;
> +	struct reset_control *rst;
> +	struct phy *phy;
> +	struct irq_domain *legacy_irq_domain;
> +};
> +
> +#define to_uniphier_pcie(x)	dev_get_drvdata((x)->dev)
> +
> +static void uniphier_pcie_ltssm_enable(struct uniphier_pcie_priv *priv)
> +{
> +	u32 val;
> +
> +	val = readl(priv->base + PCL_APP_READY_CTRL);
> +	val |= PCL_APP_LTSSM_ENABLE;
> +	writel(val, priv->base + PCL_APP_READY_CTRL);
> +}
> +
> +static void uniphier_pcie_ltssm_disable(struct uniphier_pcie_priv *priv)
> +{
> +	u32 val;
> +
> +	val = readl(priv->base + PCL_APP_READY_CTRL);
> +	val &= ~PCL_APP_LTSSM_ENABLE;
> +	writel(val, priv->base + PCL_APP_READY_CTRL);
> +}

A single function with an "enable" parameter would do.

> +static void uniphier_pcie_init_rc(struct uniphier_pcie_priv *priv)
> +{
> +	u32 val;
> +
> +	/* use auxiliary power detection */
> +	val = readl(priv->base + PCL_APP_PM0);
> +	val |= PCL_SYS_AUX_PWR_DET;
> +	writel(val, priv->base + PCL_APP_PM0);
> +
> +	/* assert PERST# */
> +	val = readl(priv->base + PCL_PINCTRL0);
> +	val &= ~(PCL_PERST_NOE_REGVAL | PCL_PERST_OUT_REGVAL
> +		 | PCL_PERST_PLDN_REGVAL);
> +	val |= PCL_PERST_NOE_REGEN | PCL_PERST_OUT_REGEN
> +		| PCL_PERST_PLDN_REGEN;
> +	writel(val, priv->base + PCL_PINCTRL0);
> +
> +	uniphier_pcie_ltssm_disable(priv);
> +
> +	usleep_range(100000, 200000);
> +
> +	/* deassert PERST# */
> +	val = readl(priv->base + PCL_PINCTRL0);
> +	val |= PCL_PERST_OUT_REGVAL | PCL_PERST_OUT_REGEN;
> +	writel(val, priv->base + PCL_PINCTRL0);
> +}
> +
> +static int uniphier_pcie_wait_rc(struct uniphier_pcie_priv *priv)
> +{
> +	u32 status;
> +	int ret;
> +
> +	/* wait PIPE clock */
> +	ret = readl_poll_timeout(priv->base + PCL_PIPEMON, status,
> +				 status & PCL_PCLK_ALIVE, 100000, 1000000);
> +	if (ret) {
> +		dev_err(priv->pci.dev,
> +			"Failed to initialize controller in RC mode\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int uniphier_pcie_link_up(struct dw_pcie *pci)

This function returns a bool value, make it return a bool.

> +{
> +	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
> +	u32 val, mask;
> +
> +	val = readl(priv->base + PCL_STATUS_LINK);
> +	mask = PCL_RDLH_LINK_UP | PCL_XMLH_LINK_UP;
> +
> +	return (val & mask) == mask;
> +}
> +
> +static int uniphier_pcie_establish_link(struct dw_pcie *pci)
> +{
> +	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
> +	int ret;
> +
> +	if (dw_pcie_link_up(pci))
> +		return 0;
> +
> +	uniphier_pcie_ltssm_enable(priv);
> +
> +	ret = dw_pcie_wait_for_link(pci);

dw_pcie_wait_for_link() already prints an error, I do not see
what this additional warning is adding.

> +	if (ret == -ETIMEDOUT)
> +		dev_warn(pci->dev, "Link not up\n");


> +
> +	return ret;
> +}
> +
> +static void uniphier_pcie_stop_link(struct dw_pcie *pci)
> +{
> +	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
> +
> +	uniphier_pcie_ltssm_disable(priv);
> +}
> +
> +static int uniphier_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
> +				  irq_hw_number_t hwirq)
> +{
> +	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
> +	irq_set_chip_data(irq, domain->host_data);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops uniphier_intx_domain_ops = {
> +	.map = uniphier_pcie_intx_map,
> +	.xlate = pci_irqd_intx_xlate,
> +};

- You should define a proper IRQ chip implementation
- INTX are level interrupts, so handle_level_irq() is the flow handler
- Using pci_irqd_intx_xlate() is wrong, please update the DT bindings
  as I explained

Take a look at pci-ftpci100.c and use that approach to implement INTX
handling.

> +static void uniphier_pcie_irq_enable(struct uniphier_pcie_priv *priv)
> +{
> +	writel(PCL_RCV_INT_ALL_ENABLE, priv->base + PCL_RCV_INT);
> +	writel(PCL_RCV_INTX_ALL_ENABLE, priv->base + PCL_RCV_INTX);
> +}
> +
> +static void uniphier_pcie_irq_disable(struct uniphier_pcie_priv *priv)
> +{
> +	writel(0, priv->base + PCL_RCV_INT);
> +	writel(0, priv->base + PCL_RCV_INTX);
> +}
> +
> +static void uniphier_pcie_irq_handler(struct irq_desc *desc)
> +{
> +	struct pcie_port *pp = irq_desc_get_handler_data(desc);
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	unsigned long reg;
> +	u32 val, bit, virq;
> +
> +	/* INT for debug */
> +	val = readl(priv->base + PCL_RCV_INT);
> +
> +	if (val & PCL_CFG_BW_MGT_STATUS)
> +		dev_dbg(pci->dev, "Link Bandwidth Management Event\n");
> +	if (val & PCL_CFG_LINK_AUTO_BW_STATUS)
> +		dev_dbg(pci->dev, "Link Autonomous Bandwidth Event\n");
> +	if (val & PCL_CFG_AER_RC_ERR_MSI_STATUS)
> +		dev_dbg(pci->dev, "Root Error\n");
> +	if (val & PCL_CFG_PME_MSI_STATUS)
> +		dev_dbg(pci->dev, "PME Interrupt\n");
> +
> +	writel(val, priv->base + PCL_RCV_INT);

What's writing to PCL_RCV_INT needed for ?

> +	/* INTx */
> +	chained_irq_enter(chip, desc);
> +
> +	val = readl(priv->base + PCL_RCV_INTX);
> +	reg = FIELD_GET(PCL_RCV_INTX_ALL_STATUS, val);
> +
> +	for_each_set_bit(bit, &reg, PCI_NUM_INTX) {
> +		virq = irq_linear_revmap(priv->legacy_irq_domain, bit);
> +		generic_handle_irq(virq);
> +	}
> +
> +	writel(val, priv->base + PCL_RCV_INTX);
> +
> +	chained_irq_exit(chip, desc);
> +}
> +
> +static int uniphier_pcie_config_legacy_irq(struct pcie_port *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
> +	struct device_node *np = pci->dev->of_node;
> +	struct device_node *np_intc;
> +
> +	np_intc = of_get_child_by_name(np, "legacy-interrupt-controller");
> +	if (!np_intc) {
> +		dev_err(pci->dev, "Failed to get legacy-interrupt-controller node\n");
> +		return -EINVAL;
> +	}
> +
> +	pp->irq = irq_of_parse_and_map(np_intc, 0);
> +	if (!pp->irq) {
> +		dev_err(pci->dev, "Failed to get an IRQ entry in legacy-interrupt-controller\n");
> +		return -EINVAL;
> +	}
> +	irq_set_chained_handler_and_data(pp->irq, uniphier_pcie_irq_handler,
> +					 pp);
> +
> +	priv->legacy_irq_domain = irq_domain_add_linear(np_intc, PCI_NUM_INTX,
> +						&uniphier_intx_domain_ops, pp);
> +	if (!priv->legacy_irq_domain) {
> +		dev_err(pci->dev, "Failed to get INTx domain\n");
> +		return -ENODEV;
> +	}

	priv->legacy_irq_domain = irq_domain_add_linear(np_intc, PCI_NUM_INTX,
						&uniphier_intx_domain_ops, pp);
	if (!priv->legacy_irq_domain) {
		dev_err(pci->dev, "Failed to get INTx domain\n");
		return -ENODEV;
	}

First add IRQs to the domain, then

	irq_set_chained_handler_and_data(pp->irq, uniphier_pcie_irq_handler,
					 pp);

set up the cascaded handler.

Lorenzo

> +	return 0;
> +}
> +
> +static int uniphier_pcie_host_init(struct pcie_port *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
> +	int ret;
> +
> +	ret = uniphier_pcie_config_legacy_irq(pp);
> +	if (ret)
> +		return ret;
> +
> +	uniphier_pcie_irq_enable(priv);
> +
> +	dw_pcie_setup_rc(pp);
> +	ret = uniphier_pcie_establish_link(pci);
> +	if (ret)
> +		return ret;
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI))
> +		dw_pcie_msi_init(pp);
> +
> +	return 0;
> +}
> +
> +static const struct dw_pcie_host_ops uniphier_pcie_host_ops = {
> +	.host_init = uniphier_pcie_host_init,
> +};
> +
> +static int uniphier_add_pcie_port(struct uniphier_pcie_priv *priv,
> +				  struct platform_device *pdev)
> +{
> +	struct dw_pcie *pci = &priv->pci;
> +	struct pcie_port *pp = &pci->pp;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	pp->ops = &uniphier_pcie_host_ops;
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		pp->msi_irq = platform_get_irq_byname(pdev, "msi");
> +		if (pp->msi_irq < 0)
> +			return pp->msi_irq;
> +	}
> +
> +	ret = dw_pcie_host_init(pp);
> +	if (ret) {
> +		dev_err(dev, "Failed to initialize host (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int uniphier_pcie_host_enable(struct uniphier_pcie_priv *priv)
> +{
> +	int ret;
> +
> +	ret = clk_prepare_enable(priv->clk);
> +	if (ret)
> +		return ret;
> +
> +	ret = reset_control_deassert(priv->rst);
> +	if (ret)
> +		goto out_clk_disable;
> +
> +	uniphier_pcie_init_rc(priv);
> +
> +	ret = phy_init(priv->phy);
> +	if (ret)
> +		goto out_rst_assert;
> +
> +	ret = uniphier_pcie_wait_rc(priv);
> +	if (ret)
> +		goto out_phy_exit;
> +
> +	return 0;
> +
> +out_phy_exit:
> +	phy_exit(priv->phy);
> +out_rst_assert:
> +	reset_control_assert(priv->rst);
> +out_clk_disable:
> +	clk_disable_unprepare(priv->clk);
> +
> +	return ret;
> +}
> +
> +static void uniphier_pcie_host_disable(struct uniphier_pcie_priv *priv)
> +{
> +	uniphier_pcie_irq_disable(priv);
> +	phy_exit(priv->phy);
> +	reset_control_assert(priv->rst);
> +	clk_disable_unprepare(priv->clk);
> +}
> +
> +static const struct dw_pcie_ops dw_pcie_ops = {
> +	.start_link = uniphier_pcie_establish_link,
> +	.stop_link = uniphier_pcie_stop_link,
> +	.link_up = uniphier_pcie_link_up,
> +};
> +
> +static int uniphier_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct uniphier_pcie_priv *priv;
> +	struct resource *res;
> +	int ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->pci.dev = dev;
> +	priv->pci.ops = &dw_pcie_ops;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
> +	priv->pci.dbi_base = devm_pci_remap_cfg_resource(dev, res);
> +	if (IS_ERR(priv->pci.dbi_base))
> +		return PTR_ERR(priv->pci.dbi_base);
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "link");
> +	priv->base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	priv->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(priv->clk))
> +		return PTR_ERR(priv->clk);
> +
> +	priv->rst = devm_reset_control_get_shared(dev, NULL);
> +	if (IS_ERR(priv->rst))
> +		return PTR_ERR(priv->rst);
> +
> +	priv->phy = devm_phy_optional_get(dev, "pcie-phy");
> +	if (IS_ERR(priv->phy))
> +		return PTR_ERR(priv->phy);
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	ret = uniphier_pcie_host_enable(priv);
> +	if (ret)
> +		return ret;
> +
> +	return uniphier_add_pcie_port(priv, pdev);
> +}
> +
> +static int uniphier_pcie_remove(struct platform_device *pdev)
> +{
> +	struct uniphier_pcie_priv *priv = platform_get_drvdata(pdev);
> +
> +	uniphier_pcie_host_disable(priv);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id uniphier_pcie_match[] = {
> +	{ .compatible = "socionext,uniphier-pcie", },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, uniphier_pcie_match);
> +
> +static struct platform_driver uniphier_pcie_driver = {
> +	.probe  = uniphier_pcie_probe,
> +	.remove = uniphier_pcie_remove,
> +	.driver = {
> +		.name = "uniphier-pcie",
> +		.of_match_table = uniphier_pcie_match,
> +	},
> +};
> +builtin_platform_driver(uniphier_pcie_driver);
> +
> +MODULE_AUTHOR("Kunihiko Hayashi <hayashi.kunihiko@socionext.com>");
> +MODULE_DESCRIPTION("UniPhier PCIe host controller driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.7.4
> 
