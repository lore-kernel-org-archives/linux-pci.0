Return-Path: <SRS0=2mbU=OH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A8AC43441
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 04:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 739332081B
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 04:04:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 739332081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbeK1PEo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 28 Nov 2018 10:04:44 -0500
Received: from mx.socionext.com ([202.248.49.38]:37688 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbeK1PEn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Nov 2018 10:04:43 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 28 Nov 2018 13:04:30 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id B27AC60062;
        Wed, 28 Nov 2018 13:04:30 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 28 Nov 2018 13:04:30 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 325911A1235;
        Wed, 28 Nov 2018 13:04:30 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v4 2/2] PCI: uniphier: Add UniPhier PCIe host controller support
Date:   Wed, 28 Nov 2018 13:04:26 +0900
Message-Id: <1543377866-16634-3-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543377866-16634-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1543377866-16634-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This introduces specific glue layer for UniPhier platform to support
PCIe host controller that is based on the DesignWare PCIe core, and
this driver supports Root Complex (host) mode.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 MAINTAINERS                                |   7 +
 drivers/pci/controller/dwc/Kconfig         |  10 +
 drivers/pci/controller/dwc/Makefile        |   1 +
 drivers/pci/controller/dwc/pcie-uniphier.c | 471 +++++++++++++++++++++++++++++
 4 files changed, 489 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-uniphier.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 23725d4..c0e15ec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11653,6 +11653,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/pci/v3-v360epc-pci.txt
 F:	drivers/pci/controller/pci-v3-semi.c
 
+PCIE DRIVER FOR SOCIONEXT UNIPHIER
+M:	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/uniphier-pcie.txt
+F:	drivers/pci/controller/dwc/pcie-uniphier.c
+
 PCIE DRIVER FOR ST SPEAR13XX
 M:	Pratyush Anand <pratyush.anand@gmail.com>
 L:	linux-pci@vger.kernel.org
diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 91b0194..9550688 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -193,4 +193,14 @@ config PCIE_HISI_STB
 	help
           Say Y here if you want PCIe controller support on HiSilicon STB SoCs
 
+config PCIE_UNIPHIER
+	bool "Socionext UniPhier PCIe controllers"
+	depends on ARCH_UNIPHIER || COMPILE_TEST
+	depends on OF && HAS_IOMEM
+	depends on PCI_MSI_IRQ_DOMAIN
+	select PCIE_DW_HOST
+	help
+	  Say Y here if you want PCIe controller support on UniPhier SoCs.
+	  This driver supports LD20 and PXs3 SoCs.
+
 endmenu
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index fcf91ea..688a0ec 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
 obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
 obj-$(CONFIG_PCIE_KIRIN) += pcie-kirin.o
 obj-$(CONFIG_PCIE_HISI_STB) += pcie-histb.o
+obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
 
 # The following drivers are for devices that use the generic ACPI
 # pci_root.c driver but don't support standard ECAM config access.
diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
new file mode 100644
index 0000000..e93bde4
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-uniphier.c
@@ -0,0 +1,471 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCIe host controller driver for UniPhier SoCs
+ * Copyright 2018 Socionext Inc.
+ * Author: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/module.h>
+#include <linux/of_irq.h>
+#include <linux/pci.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+
+#include "pcie-designware.h"
+
+#define PCL_PINCTRL0			0x002c
+#define PCL_PERST_PLDN_REGEN		BIT(12)
+#define PCL_PERST_NOE_REGEN		BIT(11)
+#define PCL_PERST_OUT_REGEN		BIT(8)
+#define PCL_PERST_PLDN_REGVAL		BIT(4)
+#define PCL_PERST_NOE_REGVAL		BIT(3)
+#define PCL_PERST_OUT_REGVAL		BIT(0)
+
+#define PCL_PIPEMON			0x0044
+#define PCL_PCLK_ALIVE			BIT(15)
+
+#define PCL_APP_READY_CTRL		0x8008
+#define PCL_APP_LTSSM_ENABLE		BIT(0)
+
+#define PCL_APP_PM0			0x8078
+#define PCL_SYS_AUX_PWR_DET		BIT(8)
+
+#define PCL_RCV_INT			0x8108
+#define PCL_RCV_INT_ALL_ENABLE		GENMASK(20, 17)
+#define PCL_CFG_BW_MGT_STATUS		BIT(4)
+#define PCL_CFG_LINK_AUTO_BW_STATUS	BIT(3)
+#define PCL_CFG_AER_RC_ERR_MSI_STATUS	BIT(2)
+#define PCL_CFG_PME_MSI_STATUS		BIT(1)
+
+#define PCL_RCV_INTX			0x810c
+#define PCL_RCV_INTX_ALL_ENABLE		GENMASK(19, 16)
+#define PCL_RCV_INTX_ALL_MASK		GENMASK(11, 8)
+#define PCL_RCV_INTX_MASK_SHIFT		8
+#define PCL_RCV_INTX_ALL_STATUS		GENMASK(3, 0)
+#define PCL_RCV_INTX_STATUS_SHIFT	0
+
+#define PCL_STATUS_LINK			0x8140
+#define PCL_RDLH_LINK_UP		BIT(1)
+#define PCL_XMLH_LINK_UP		BIT(0)
+
+struct uniphier_pcie_priv {
+	void __iomem *base;
+	struct dw_pcie pci;
+	struct clk *clk;
+	struct reset_control *rst;
+	struct phy *phy;
+	struct irq_domain *legacy_irq_domain;
+};
+
+#define to_uniphier_pcie(x)	dev_get_drvdata((x)->dev)
+
+static void uniphier_pcie_ltssm_enable(struct uniphier_pcie_priv *priv,
+				       bool enable)
+{
+	u32 val;
+
+	val = readl(priv->base + PCL_APP_READY_CTRL);
+	if (enable)
+		val |= PCL_APP_LTSSM_ENABLE;
+	else
+		val &= ~PCL_APP_LTSSM_ENABLE;
+	writel(val, priv->base + PCL_APP_READY_CTRL);
+}
+
+static void uniphier_pcie_init_rc(struct uniphier_pcie_priv *priv)
+{
+	u32 val;
+
+	/* use auxiliary power detection */
+	val = readl(priv->base + PCL_APP_PM0);
+	val |= PCL_SYS_AUX_PWR_DET;
+	writel(val, priv->base + PCL_APP_PM0);
+
+	/* assert PERST# */
+	val = readl(priv->base + PCL_PINCTRL0);
+	val &= ~(PCL_PERST_NOE_REGVAL | PCL_PERST_OUT_REGVAL
+		 | PCL_PERST_PLDN_REGVAL);
+	val |= PCL_PERST_NOE_REGEN | PCL_PERST_OUT_REGEN
+		| PCL_PERST_PLDN_REGEN;
+	writel(val, priv->base + PCL_PINCTRL0);
+
+	uniphier_pcie_ltssm_enable(priv, false);
+
+	usleep_range(100000, 200000);
+
+	/* deassert PERST# */
+	val = readl(priv->base + PCL_PINCTRL0);
+	val |= PCL_PERST_OUT_REGVAL | PCL_PERST_OUT_REGEN;
+	writel(val, priv->base + PCL_PINCTRL0);
+}
+
+static int uniphier_pcie_wait_rc(struct uniphier_pcie_priv *priv)
+{
+	u32 status;
+	int ret;
+
+	/* wait PIPE clock */
+	ret = readl_poll_timeout(priv->base + PCL_PIPEMON, status,
+				 status & PCL_PCLK_ALIVE, 100000, 1000000);
+	if (ret) {
+		dev_err(priv->pci.dev,
+			"Failed to initialize controller in RC mode\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int uniphier_pcie_link_up(struct dw_pcie *pci)
+{
+	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
+	u32 val, mask;
+
+	val = readl(priv->base + PCL_STATUS_LINK);
+	mask = PCL_RDLH_LINK_UP | PCL_XMLH_LINK_UP;
+
+	return (val & mask) == mask;
+}
+
+static int uniphier_pcie_establish_link(struct dw_pcie *pci)
+{
+	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
+
+	if (dw_pcie_link_up(pci))
+		return 0;
+
+	uniphier_pcie_ltssm_enable(priv, true);
+
+	return dw_pcie_wait_for_link(pci);
+}
+
+static void uniphier_pcie_stop_link(struct dw_pcie *pci)
+{
+	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
+
+	uniphier_pcie_ltssm_enable(priv, false);
+}
+
+static void uniphier_pcie_irq_enable(struct uniphier_pcie_priv *priv)
+{
+	writel(PCL_RCV_INT_ALL_ENABLE, priv->base + PCL_RCV_INT);
+	writel(PCL_RCV_INTX_ALL_ENABLE, priv->base + PCL_RCV_INTX);
+}
+
+static void uniphier_pcie_irq_disable(struct uniphier_pcie_priv *priv)
+{
+	writel(0, priv->base + PCL_RCV_INT);
+	writel(0, priv->base + PCL_RCV_INTX);
+}
+
+static void uniphier_pcie_irq_ack(struct irq_data *d)
+{
+	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
+	u32 val;
+
+	val = readl(priv->base + PCL_RCV_INTX);
+	val &= ~PCL_RCV_INTX_ALL_STATUS;
+	val |= BIT(irqd_to_hwirq(d) + PCL_RCV_INTX_STATUS_SHIFT);
+	writel(val, priv->base + PCL_RCV_INTX);
+}
+
+static void uniphier_pcie_irq_mask(struct irq_data *d)
+{
+	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
+	u32 val;
+
+	val = readl(priv->base + PCL_RCV_INTX);
+	val &= ~PCL_RCV_INTX_ALL_STATUS;
+	val |= BIT(irqd_to_hwirq(d) + PCL_RCV_INTX_MASK_SHIFT);
+	writel(val, priv->base + PCL_RCV_INTX);
+}
+
+static void uniphier_pcie_irq_unmask(struct irq_data *d)
+{
+	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
+	u32 val;
+
+	val = readl(priv->base + PCL_RCV_INTX);
+	val &= ~PCL_RCV_INTX_ALL_STATUS;
+	val &= ~BIT(irqd_to_hwirq(d) + PCL_RCV_INTX_MASK_SHIFT);
+	writel(val, priv->base + PCL_RCV_INTX);
+}
+
+static struct irq_chip uniphier_pcie_irq_chip = {
+	.name = "PCI",
+	.irq_ack = uniphier_pcie_irq_ack,
+	.irq_mask = uniphier_pcie_irq_mask,
+	.irq_unmask = uniphier_pcie_irq_unmask,
+};
+
+static int uniphier_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
+				  irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &uniphier_pcie_irq_chip,
+				 handle_level_irq);
+	irq_set_chip_data(irq, domain->host_data);
+
+	return 0;
+}
+
+static const struct irq_domain_ops uniphier_intx_domain_ops = {
+	.map = uniphier_pcie_intx_map,
+};
+
+static void uniphier_pcie_irq_handler(struct irq_desc *desc)
+{
+	struct pcie_port *pp = irq_desc_get_handler_data(desc);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	unsigned long reg;
+	u32 val, bit, virq;
+
+	/* INT for debug */
+	val = readl(priv->base + PCL_RCV_INT);
+
+	if (val & PCL_CFG_BW_MGT_STATUS)
+		dev_dbg(pci->dev, "Link Bandwidth Management Event\n");
+	if (val & PCL_CFG_LINK_AUTO_BW_STATUS)
+		dev_dbg(pci->dev, "Link Autonomous Bandwidth Event\n");
+	if (val & PCL_CFG_AER_RC_ERR_MSI_STATUS)
+		dev_dbg(pci->dev, "Root Error\n");
+	if (val & PCL_CFG_PME_MSI_STATUS)
+		dev_dbg(pci->dev, "PME Interrupt\n");
+
+	writel(val, priv->base + PCL_RCV_INT);
+
+	/* INTx */
+	chained_irq_enter(chip, desc);
+
+	val = readl(priv->base + PCL_RCV_INTX);
+	reg = FIELD_GET(PCL_RCV_INTX_ALL_STATUS, val);
+
+	for_each_set_bit(bit, &reg, PCI_NUM_INTX) {
+		virq = irq_linear_revmap(priv->legacy_irq_domain, bit);
+		generic_handle_irq(virq);
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static int uniphier_pcie_config_legacy_irq(struct pcie_port *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
+	struct device_node *np = pci->dev->of_node;
+	struct device_node *np_intc;
+
+	np_intc = of_get_child_by_name(np, "legacy-interrupt-controller");
+	if (!np_intc) {
+		dev_err(pci->dev, "Failed to get legacy-interrupt-controller node\n");
+		return -EINVAL;
+	}
+
+	pp->irq = irq_of_parse_and_map(np_intc, 0);
+	if (!pp->irq) {
+		dev_err(pci->dev, "Failed to get an IRQ entry in legacy-interrupt-controller\n");
+		return -EINVAL;
+	}
+
+	priv->legacy_irq_domain = irq_domain_add_linear(np_intc, PCI_NUM_INTX,
+						&uniphier_intx_domain_ops, pp);
+	if (!priv->legacy_irq_domain) {
+		dev_err(pci->dev, "Failed to get INTx domain\n");
+		return -ENODEV;
+	}
+
+	irq_set_chained_handler_and_data(pp->irq, uniphier_pcie_irq_handler,
+					 pp);
+
+	return 0;
+}
+
+static int uniphier_pcie_host_init(struct pcie_port *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
+	int ret;
+
+	ret = uniphier_pcie_config_legacy_irq(pp);
+	if (ret)
+		return ret;
+
+	uniphier_pcie_irq_enable(priv);
+
+	dw_pcie_setup_rc(pp);
+	ret = uniphier_pcie_establish_link(pci);
+	if (ret)
+		return ret;
+
+	if (IS_ENABLED(CONFIG_PCI_MSI))
+		dw_pcie_msi_init(pp);
+
+	return 0;
+}
+
+static const struct dw_pcie_host_ops uniphier_pcie_host_ops = {
+	.host_init = uniphier_pcie_host_init,
+};
+
+static int uniphier_add_pcie_port(struct uniphier_pcie_priv *priv,
+				  struct platform_device *pdev)
+{
+	struct dw_pcie *pci = &priv->pci;
+	struct pcie_port *pp = &pci->pp;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	pp->ops = &uniphier_pcie_host_ops;
+
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		pp->msi_irq = platform_get_irq_byname(pdev, "msi");
+		if (pp->msi_irq < 0)
+			return pp->msi_irq;
+	}
+
+	ret = dw_pcie_host_init(pp);
+	if (ret) {
+		dev_err(dev, "Failed to initialize host (%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int uniphier_pcie_host_enable(struct uniphier_pcie_priv *priv)
+{
+	int ret;
+
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return ret;
+
+	ret = reset_control_deassert(priv->rst);
+	if (ret)
+		goto out_clk_disable;
+
+	uniphier_pcie_init_rc(priv);
+
+	ret = phy_init(priv->phy);
+	if (ret)
+		goto out_rst_assert;
+
+	ret = uniphier_pcie_wait_rc(priv);
+	if (ret)
+		goto out_phy_exit;
+
+	return 0;
+
+out_phy_exit:
+	phy_exit(priv->phy);
+out_rst_assert:
+	reset_control_assert(priv->rst);
+out_clk_disable:
+	clk_disable_unprepare(priv->clk);
+
+	return ret;
+}
+
+static void uniphier_pcie_host_disable(struct uniphier_pcie_priv *priv)
+{
+	uniphier_pcie_irq_disable(priv);
+	phy_exit(priv->phy);
+	reset_control_assert(priv->rst);
+	clk_disable_unprepare(priv->clk);
+}
+
+static const struct dw_pcie_ops dw_pcie_ops = {
+	.start_link = uniphier_pcie_establish_link,
+	.stop_link = uniphier_pcie_stop_link,
+	.link_up = uniphier_pcie_link_up,
+};
+
+static int uniphier_pcie_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct uniphier_pcie_priv *priv;
+	struct resource *res;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->pci.dev = dev;
+	priv->pci.ops = &dw_pcie_ops;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
+	priv->pci.dbi_base = devm_pci_remap_cfg_resource(dev, res);
+	if (IS_ERR(priv->pci.dbi_base))
+		return PTR_ERR(priv->pci.dbi_base);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "link");
+	priv->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	priv->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(priv->clk))
+		return PTR_ERR(priv->clk);
+
+	priv->rst = devm_reset_control_get_shared(dev, NULL);
+	if (IS_ERR(priv->rst))
+		return PTR_ERR(priv->rst);
+
+	priv->phy = devm_phy_optional_get(dev, "pcie-phy");
+	if (IS_ERR(priv->phy))
+		return PTR_ERR(priv->phy);
+
+	platform_set_drvdata(pdev, priv);
+
+	ret = uniphier_pcie_host_enable(priv);
+	if (ret)
+		return ret;
+
+	return uniphier_add_pcie_port(priv, pdev);
+}
+
+static int uniphier_pcie_remove(struct platform_device *pdev)
+{
+	struct uniphier_pcie_priv *priv = platform_get_drvdata(pdev);
+
+	uniphier_pcie_host_disable(priv);
+
+	return 0;
+}
+
+static const struct of_device_id uniphier_pcie_match[] = {
+	{ .compatible = "socionext,uniphier-pcie", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, uniphier_pcie_match);
+
+static struct platform_driver uniphier_pcie_driver = {
+	.probe  = uniphier_pcie_probe,
+	.remove = uniphier_pcie_remove,
+	.driver = {
+		.name = "uniphier-pcie",
+		.of_match_table = uniphier_pcie_match,
+	},
+};
+builtin_platform_driver(uniphier_pcie_driver);
+
+MODULE_AUTHOR("Kunihiko Hayashi <hayashi.kunihiko@socionext.com>");
+MODULE_DESCRIPTION("UniPhier PCIe host controller driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

