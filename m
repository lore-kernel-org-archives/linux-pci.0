Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34884 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752895AbcDMPvx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2016 11:51:53 -0400
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Andrey Smirnov <asmirnov@spaceflightindustries.com>,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	gary.bisson@boundarydevices.com
Subject: [PATCH] PCI: imx6: Implement reset sequence for i.MX6+
Date: Wed, 13 Apr 2016 08:51:25 -0700
Message-Id: <1460562685-15168-1-git-send-email-asmirnov@spaceflightindustries.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I.MX6+ has a dedicated bit for reseting PCIe core, which should be used
instead of a regular reset sequence since using the latter will hang the
SoC.

This commit is based on c34068d48273e24d392d9a49a38be807954420ed from
http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git

Signed-off-by: Andrey Smirnov <asmirnov@spaceflightindustries.com>
---
 arch/arm/boot/dts/imx6qp.dtsi               |  3 ++
 drivers/pci/host/pci-imx6.c                 | 82 +++++++++++++++++++----------
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h |  1 +
 3 files changed, 58 insertions(+), 28 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qp.dtsi b/arch/arm/boot/dts/imx6qp.dtsi
index 1ada714..886dbf2 100644
--- a/arch/arm/boot/dts/imx6qp.dtsi
+++ b/arch/arm/boot/dts/imx6qp.dtsi
@@ -82,5 +82,8 @@
 				      "ldb_di0", "ldb_di1", "prg";
 		};
 
+		pcie: pcie@0x01000000 {
+			compatible = "fsl,imx6qp-pcie", "snps,dw-pcie";
+		};
 	};
 };
diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index eb5a275..99f5cac 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -85,6 +85,14 @@ struct imx6_pcie {
 #define PHY_RX_OVRD_IN_LO_RX_DATA_EN (1 << 5)
 #define PHY_RX_OVRD_IN_LO_RX_PLL_EN (1 << 3)
 
+static inline bool is_imx6qp_pcie(struct imx6_pcie *imx6_pcie)
+{
+	struct pcie_port *pp = &imx6_pcie->pp;
+	struct device_node *np = pp->dev->of_node;
+
+	return of_device_is_compatible(np, "fsl,imx6qp-pcie");
+}
+
 static int pcie_phy_poll_ack(void __iomem *dbi_base, int exp_val)
 {
 	u32 val;
@@ -236,35 +244,44 @@ static int imx6_pcie_assert_core_reset(struct pcie_port *pp)
 	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
 	u32 val, gpr1, gpr12;
 
-	/*
-	 * If the bootloader already enabled the link we need some special
-	 * handling to get the core back into a state where it is safe to
-	 * touch it for configuration.  As there is no dedicated reset signal
-	 * wired up for MX6QDL, we need to manually force LTSSM into "detect"
-	 * state before completely disabling LTSSM, which is a prerequisite
-	 * for core configuration.
-	 *
-	 * If both LTSSM_ENABLE and REF_SSP_ENABLE are active we have a strong
-	 * indication that the bootloader activated the link.
-	 */
-	regmap_read(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1, &gpr1);
-	regmap_read(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, &gpr12);
-
-	if ((gpr1 & IMX6Q_GPR1_PCIE_REF_CLK_EN) &&
-	    (gpr12 & IMX6Q_GPR12_PCIE_CTL_2)) {
-		val = readl(pp->dbi_base + PCIE_PL_PFLR);
-		val &= ~PCIE_PL_PFLR_LINK_STATE_MASK;
-		val |= PCIE_PL_PFLR_FORCE_LINK;
-		writel(val, pp->dbi_base + PCIE_PL_PFLR);
-
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
-	}
+	if (is_imx6qp_pcie(imx6_pcie)) {
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				   IMX6Q_GPR1_PCIE_SW_RST,
+				   IMX6Q_GPR1_PCIE_SW_RST);
+	} else {
+		/*
+		 * If the bootloader already enabled the link we need
+		 * some special handling to get the core back into a
+		 * state where it is safe to touch it for
+		 * configuration.  As there is no dedicated reset
+		 * signal wired up for MX6QDL, we need to manually
+		 * force LTSSM into "detect" state before completely
+		 * disabling LTSSM, which is a prerequisite for core
+		 * configuration.
+		 *
+		 * If both LTSSM_ENABLE and REF_SSP_ENABLE are active
+		 * we have a strong indication that the bootloader
+		 * activated the link.
+		 */
+		regmap_read(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1, &gpr1);
+		regmap_read(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, &gpr12);
+
+		if ((gpr1 & IMX6Q_GPR1_PCIE_REF_CLK_EN) &&
+		    (gpr12 & IMX6Q_GPR12_PCIE_CTL_2)) {
+			val = readl(pp->dbi_base + PCIE_PL_PFLR);
+			val &= ~PCIE_PL_PFLR_LINK_STATE_MASK;
+			val |= PCIE_PL_PFLR_FORCE_LINK;
+			writel(val, pp->dbi_base + PCIE_PL_PFLR);
+
+			regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+					   IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
+		}
 
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
-			IMX6Q_GPR1_PCIE_TEST_PD, 1 << 18);
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
-			IMX6Q_GPR1_PCIE_REF_CLK_EN, 0 << 16);
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				   IMX6Q_GPR1_PCIE_TEST_PD, 1 << 18);
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 0 << 16);
+	}
 
 	return 0;
 }
@@ -314,6 +331,14 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
 		msleep(100);
 		gpiod_set_value_cansleep(imx6_pcie->reset_gpio, 1);
 	}
+
+	if (is_imx6qp_pcie(imx6_pcie)) {
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				   IMX6Q_GPR1_PCIE_SW_RST, 0);
+
+		usleep_range(200, 500);
+	}
+
 	return 0;
 
 err_pcie:
@@ -616,6 +641,7 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
 
 static const struct of_device_id imx6_pcie_of_match[] = {
 	{ .compatible = "fsl,imx6q-pcie", },
+	{ .compatible = "fsl,imx6qp-pcie", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, imx6_pcie_of_match);
diff --git a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
index 238c8db..5b08e3c 100644
--- a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
+++ b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
@@ -95,6 +95,7 @@
 #define IMX6Q_GPR0_DMAREQ_MUX_SEL0_IOMUX	BIT(0)
 
 #define IMX6Q_GPR1_PCIE_REQ_MASK		(0x3 << 30)
+#define IMX6Q_GPR1_PCIE_SW_RST			BIT(29)
 #define IMX6Q_GPR1_PCIE_EXIT_L1			BIT(28)
 #define IMX6Q_GPR1_PCIE_RDY_L23			BIT(27)
 #define IMX6Q_GPR1_PCIE_ENTER_L1		BIT(26)
-- 
2.5.5

