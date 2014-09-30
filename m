Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bbn0103.outbound.protection.outlook.com ([157.56.111.103]:55714
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752044AbaI3KHJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 30 Sep 2014 06:07:09 -0400
From: Richard Zhu <r65037@freescale.com>
To: <linux-pci-owner@vger.kernel.org>
CC: <linux-pci@vger.kernel.org>, <shawn.guo@freescale.com>,
	<festevam@gmail.com>, <l.stach@pengutronix.de>,
	<tharvey@gateworks.com>, Richard Zhu <r65037@freescale.com>
Subject: [PATCH v4 02/10] PCI: imx6: add imx6sx pcie support
Date: Tue, 30 Sep 2014 17:36:36 +0800
Message-ID: <1412069804-17162-3-git-send-email-r65037@freescale.com>
In-Reply-To: <1412069804-17162-1-git-send-email-r65037@freescale.com>
References: <1412069804-17162-1-git-send-email-r65037@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

- imx6sx pcie has its own standalone pcie power supply.
In order to turn on the imx6sx pcie power during
initialization. Add the pcie regulator and the gpc regmap
into the imx6sx pcie structure.
- imx6sx pcie has the new added reset mechanism, add the
reset operations into the initialization.
- Register one PM call-back, enter/exit L2 state of the ASPM
during system suspend/resume.
- disp_axi clock is required by pcie inbound axi port actually.
Add one more clock named pcie_inbound_axi for imx6sx pcie.

Signed-off-by: Richard Zhu <r65037@freescale.com>
---
 drivers/pci/host/pci-imx6.c | 163 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 144 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index eac96fb..c74e87d 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -22,8 +22,10 @@
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/resource.h>
 #include <linux/signal.h>
+#include <linux/syscore_ops.h>
 #include <linux/types.h>
 #include <linux/interrupt.h>
 
@@ -35,11 +37,15 @@ struct imx6_pcie {
 	int			reset_gpio;
 	struct clk		*pcie_bus;
 	struct clk		*pcie_phy;
+	struct clk		*pcie_inbound_axi;
 	struct clk		*pcie;
 	struct pcie_port	pp;
 	struct regmap		*iomuxc_gpr;
+	struct regmap		*gpc_ips_reg;
+	struct regulator	*pcie_regulator;
 	void __iomem		*mem_base;
 };
+static struct imx6_pcie *imx6_pcie;
 
 /* PCIe Root Complex registers (memory-mapped) */
 #define PCIE_RC_LCR				0x7c
@@ -77,6 +83,18 @@ struct imx6_pcie {
 #define PHY_RX_OVRD_IN_LO_RX_DATA_EN (1 << 5)
 #define PHY_RX_OVRD_IN_LO_RX_PLL_EN (1 << 3)
 
+/* GPC PCIE PHY bit definitions */
+#define GPC_CNTR			0
+#define GPC_CNTR_PCIE_PHY_PUP_REQ	BIT(7)
+
+static inline bool is_imx6sx_pcie(struct imx6_pcie *imx6_pcie)
+{
+	struct pcie_port *pp = &imx6_pcie->pp;
+	struct device_node *np = pp->dev->of_node;
+
+	return of_device_is_compatible(np, "fsl,imx6sx-pcie");
+}
+
 static int pcie_phy_poll_ack(void __iomem *dbi_base, int exp_val)
 {
 	u32 val;
@@ -275,18 +293,29 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
 		goto err_pcie;
 	}
 
-	/* power up core phy and enable ref clock */
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
-			IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
-	/*
-	 * the async reset input need ref clock to sync internally,
-	 * when the ref clock comes after reset, internal synced
-	 * reset time is too short , cannot meet the requirement.
-	 * add one ~10us delay here.
-	 */
-	udelay(10);
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
-			IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
+	if (is_imx6sx_pcie(imx6_pcie)) {
+		ret = clk_prepare_enable(imx6_pcie->pcie_inbound_axi);
+		if (ret) {
+			dev_err(pp->dev, "unable to enable pcie clock\n");
+			goto err_inbound_axi;
+		}
+
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				IMX6SX_GPR12_PCIE_TEST_PD, 0);
+	} else {
+		/* power up core phy and enable ref clock */
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				IMX6Q_GPR1_PCIE_TEST_PD, 0);
+		/*
+		 * the async reset input need ref clock to sync internally,
+		 * when the ref clock comes after reset, internal synced
+		 * reset time is too short , cannot meet the requirement.
+		 * add one ~10us delay here.
+		 */
+		udelay(10);
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
+	}
 
 	/* allow the clocks to stabilize */
 	usleep_range(200, 500);
@@ -297,8 +326,19 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
 		msleep(100);
 		gpio_set_value(imx6_pcie->reset_gpio, 1);
 	}
+
+	/*
+	 * Release the PCIe PHY reset here, that we have set in
+	 * imx6_pcie_init_phy() now
+	 */
+	if (is_imx6sx_pcie(imx6_pcie))
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
+				IMX6SX_GPR5_PCIE_BTNRST, 0);
+
 	return 0;
 
+err_inbound_axi:
+	clk_disable_unprepare(imx6_pcie->pcie);
 err_pcie:
 	clk_disable_unprepare(imx6_pcie->pcie_bus);
 err_pcie_bus:
@@ -311,6 +351,26 @@ err_pcie_phy:
 static void imx6_pcie_init_phy(struct pcie_port *pp)
 {
 	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
+	int ret;
+
+	/* Power up the separate domain available on i.MX6SX */
+	if (is_imx6sx_pcie(imx6_pcie)) {
+		/* Force PCIe PHY reset */
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
+				IMX6SX_GPR5_PCIE_BTNRST,
+				IMX6SX_GPR5_PCIE_BTNRST);
+
+		regmap_update_bits(imx6_pcie->gpc_ips_reg, GPC_CNTR,
+				GPC_CNTR_PCIE_PHY_PUP_REQ,
+				GPC_CNTR_PCIE_PHY_PUP_REQ);
+		regulator_set_voltage(imx6_pcie->pcie_regulator,
+				1100000, 1100000);
+		ret = regulator_enable(imx6_pcie->pcie_regulator);
+		if (ret)
+			dev_info(pp->dev, "failed to enable pcie regulator.\n");
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				IMX6SX_GPR12_RX_EQ_MASK, IMX6SX_GPR12_RX_EQ_2);
+	}
 
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 			IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
@@ -319,7 +379,7 @@ static void imx6_pcie_init_phy(struct pcie_port *pp)
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 			IMX6Q_GPR12_DEVICE_TYPE, PCI_EXP_TYPE_ROOT_PORT << 12);
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-			IMX6Q_GPR12_LOS_LEVEL, 9 << 4);
+			IMX6Q_GPR12_LOS_LEVEL, IMX6Q_GPR12_LOS_LEVEL_9);
 
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
 			IMX6Q_GPR8_TX_DEEMPH_GEN1, 0 << 0);
@@ -377,7 +437,8 @@ static int imx6_pcie_start_link(struct pcie_port *pp)
 
 	/* Start LTSSM. */
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-			IMX6Q_GPR12_PCIE_CTL_2, 1 << 10);
+			IMX6Q_GPR12_PCIE_CTL_2,
+			IMX6Q_GPR12_PCIE_CTL_2);
 
 	ret = imx6_pcie_wait_for_link(pp);
 	if (ret)
@@ -553,9 +614,50 @@ static int __init imx6_add_pcie_port(struct pcie_port *pp,
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int pci_imx_suspend(void)
+{
+	if (is_imx6sx_pcie(imx6_pcie)) {
+		/* PM_TURN_OFF */
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				IMX6SX_GPR12_PCIE_PM_TURN_OFF,
+				IMX6SX_GPR12_PCIE_PM_TURN_OFF);
+		udelay(10);
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				IMX6SX_GPR12_PCIE_PM_TURN_OFF, 0);
+	}
+
+	return 0;
+}
+
+static void pci_imx_resume(void)
+{
+	struct pcie_port *pp = &imx6_pcie->pp;
+
+	if (is_imx6sx_pcie(imx6_pcie)) {
+		/* Reset iMX6SX PCIe */
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
+				IMX6SX_GPR5_PCIE_PERST, IMX6SX_GPR5_PCIE_PERST);
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
+				IMX6SX_GPR5_PCIE_PERST, 0);
+		/*
+		 * controller maybe turn off, re-configure again
+		 */
+		dw_pcie_setup_rc(pp);
+
+		if (IS_ENABLED(CONFIG_PCI_MSI))
+			dw_pcie_msi_cfg_restore(pp);
+	}
+}
+
+static struct syscore_ops pci_imx_syscore_ops = {
+	.suspend = pci_imx_suspend,
+	.resume = pci_imx_resume,
+};
+#endif
+
 static int __init imx6_pcie_probe(struct platform_device *pdev)
 {
-	struct imx6_pcie *imx6_pcie;
 	struct pcie_port *pp;
 	struct device_node *np = pdev->dev.of_node;
 	struct resource *dbi_base;
@@ -572,7 +674,7 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 	hook_fault_code(16 + 6, imx6q_pcie_abort_handler, SIGBUS, 0,
 		"imprecise external abort");
 
-	dbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rc_dbi");
 	pp->dbi_base = devm_ioremap_resource(&pdev->dev, dbi_base);
 	if (IS_ERR(pp->dbi_base))
 		return PTR_ERR(pp->dbi_base);
@@ -610,9 +712,28 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(imx6_pcie->pcie);
 	}
 
-	/* Grab GPR config register range */
-	imx6_pcie->iomuxc_gpr =
-		 syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
+	if (is_imx6sx_pcie(imx6_pcie)) {
+		imx6_pcie->pcie_inbound_axi = devm_clk_get(&pdev->dev,
+				"pcie_inbound_axi");
+		if (IS_ERR(imx6_pcie->pcie_inbound_axi)) {
+			dev_err(&pdev->dev,
+				"pcie clock source missing or invalid\n");
+			return PTR_ERR(imx6_pcie->pcie_inbound_axi);
+		}
+
+		imx6_pcie->pcie_regulator = devm_regulator_get(pp->dev,
+				"pcie-phy");
+
+		imx6_pcie->iomuxc_gpr =
+			 syscon_regmap_lookup_by_compatible
+			 ("fsl,imx6sx-iomuxc-gpr");
+		imx6_pcie->gpc_ips_reg =
+			 syscon_regmap_lookup_by_compatible("fsl,imx6sx-gpc");
+	} else {
+		imx6_pcie->iomuxc_gpr =
+			syscon_regmap_lookup_by_compatible
+			("fsl,imx6q-iomuxc-gpr");
+	}
 	if (IS_ERR(imx6_pcie->iomuxc_gpr)) {
 		dev_err(&pdev->dev, "unable to find iomuxc registers\n");
 		return PTR_ERR(imx6_pcie->iomuxc_gpr);
@@ -623,6 +744,9 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 		return ret;
 
 	platform_set_drvdata(pdev, imx6_pcie);
+#ifdef CONFIG_PM_SLEEP
+	register_syscore_ops(&pci_imx_syscore_ops);
+#endif
 	return 0;
 }
 
@@ -636,6 +760,7 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
 
 static const struct of_device_id imx6_pcie_of_match[] = {
 	{ .compatible = "fsl,imx6q-pcie", },
+	{ .compatible = "fsl,imx6sx-pcie", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, imx6_pcie_of_match);
-- 
1.9.1

