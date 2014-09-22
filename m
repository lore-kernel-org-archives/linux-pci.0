Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0144.outbound.protection.outlook.com ([65.55.169.144]:5184
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752688AbaIVLMw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 22 Sep 2014 07:12:52 -0400
From: Richard Zhu <r65037@freescale.com>
To: <linux-pci-owner@vger.kernel.org>
CC: <linux-pci@vger.kernel.org>, <shawn.guo@freescale.com>,
	<festevam@gmail.com>, <l.stach@pengutronix.de>,
	Richard Zhu <r65037@freescale.com>
Subject: [PATCH v1 4/4] PCI: imx6: add imx6sx pcie support
Date: Mon, 22 Sep 2014 18:45:05 +0800
Message-ID: <1411382705-15301-5-git-send-email-r65037@freescale.com>
In-Reply-To: <1411382705-15301-1-git-send-email-r65037@freescale.com>
References: <1411382705-15301-1-git-send-email-r65037@freescale.com>
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

Signed-off-by: Richard Zhu <r65037@freescale.com>
---
 drivers/pci/host/pci-imx6.c | 166 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 148 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index bc4222b..070f43a 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -18,12 +18,16 @@
 #include <linux/mfd/syscon.h>
 #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
 #include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/resource.h>
 #include <linux/signal.h>
+#include <linux/syscore_ops.h>
 #include <linux/types.h>
 #include <linux/interrupt.h>
 
@@ -31,15 +35,30 @@
 
 #define to_imx6_pcie(x)	container_of(x, struct imx6_pcie, pp)
 
+/* The pcie who have standalone power domain */
+#define PCIE_PHY_HAS_PWR_DOMAIN		BIT(0)
+
+struct imx_pcie_data {
+	unsigned int flags;
+};
+
+static const struct imx_pcie_data imx6sx_pcie_data = {
+	.flags = PCIE_PHY_HAS_PWR_DOMAIN,
+};
+
 struct imx6_pcie {
 	int			reset_gpio;
+	const struct		imx_pcie_data *data;
 	struct clk		*pcie_bus;
 	struct clk		*pcie_phy;
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
@@ -77,6 +96,11 @@ struct imx6_pcie {
 #define PHY_RX_OVRD_IN_LO_RX_DATA_EN (1 << 5)
 #define PHY_RX_OVRD_IN_LO_RX_PLL_EN (1 << 3)
 
+static inline bool is_imx6sx_pcie(struct imx6_pcie *imx6_pcie)
+{
+	return imx6_pcie->data == &imx6sx_pcie_data;
+}
+
 static int pcie_phy_poll_ack(void __iomem *dbi_base, int exp_val)
 {
 	u32 val;
@@ -275,11 +299,17 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
 		goto err_pcie;
 	}
 
-	/* power up core phy and enable ref clock */
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
-			IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
-			IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
+	if (is_imx6sx_pcie(imx6_pcie)) {
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				IMX6SX_GPR12_PCIE_TEST_PD,
+				IMX6SX_GPR12_PCIE_TEST_PD_CLR);
+	} else {
+		/* power up core phy and enable ref clock */
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
+	}
 
 	/* allow the clocks to stabilize */
 	usleep_range(200, 500);
@@ -290,6 +320,18 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
 		msleep(100);
 		gpio_set_value(imx6_pcie->reset_gpio, 1);
 	}
+
+	/*
+	 * iMX6SX PCIe has the stand-alone power domain.
+	 * refer to the initialization for iMX6SX PCIe,
+	 * release the PCIe PHY reset here,
+	 * before LTSSM enable is set.
+	 */
+	if (is_imx6sx_pcie(imx6_pcie))
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
+				IMX6SX_GPR5_PCIE_BTNRST,
+				IMX6SX_GPR5_PCIE_BTNRST_CLR);
+
 	return 0;
 
 err_pcie:
@@ -304,15 +346,38 @@ err_pcie_phy:
 static void imx6_pcie_init_phy(struct pcie_port *pp)
 {
 	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
+	int ret;
+
+	/*
+	 * iMX6SX PCIe has the stand-alone power domain
+	 * add the initialization here for iMX6SX PCIe.
+	 */
+	if (is_imx6sx_pcie(imx6_pcie)) {
+		/* Force PCIe PHY reset */
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
+				IMX6SX_GPR5_PCIE_BTNRST,
+				IMX6SX_GPR5_PCIE_BTNRST);
+
+		regmap_update_bits(imx6_pcie->gpc_ips_reg, 0, 1 << 7, 1 << 7);
+		/* Power up PCIe PHY, ANATOP_REG_CORE offset 0x140, bit13-9 */
+		regulator_set_voltage(imx6_pcie->pcie_regulator,
+				1100000, 1100000);
+		ret = regulator_enable(imx6_pcie->pcie_regulator);
+		if (ret)
+			dev_info(pp->dev, "failed to enable pcie regulator.\n");
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				IMX6SX_GPR12_RX_EQ_MASK, IMX6SX_GPR12_RX_EQ_2);
+	}
 
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-			IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
+			IMX6Q_GPR12_PCIE_CTL_2,
+			IMX6Q_GPR12_PCIE_CTL_2_CLR);
 
 	/* configure constant input signal to the pcie ctrl and phy */
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 			IMX6Q_GPR12_DEVICE_TYPE, PCI_EXP_TYPE_ROOT_PORT << 12);
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-			IMX6Q_GPR12_LOS_LEVEL, 9 << 4);
+			IMX6Q_GPR12_LOS_LEVEL, IMX6Q_GPR12_LOS_LEVEL_9);
 
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
 			IMX6Q_GPR8_TX_DEEMPH_GEN1, 0 << 0);
@@ -370,7 +435,8 @@ static int imx6_pcie_start_link(struct pcie_port *pp)
 
 	/* Start LTSSM. */
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-			IMX6Q_GPR12_PCIE_CTL_2, 1 << 10);
+			IMX6Q_GPR12_PCIE_CTL_2,
+			IMX6Q_GPR12_PCIE_CTL_2);
 
 	ret = imx6_pcie_wait_for_link(pp);
 	if (ret)
@@ -546,10 +612,66 @@ static int __init imx6_add_pcie_port(struct pcie_port *pp,
 	return 0;
 }
 
+static const struct of_device_id imx6_pcie_of_match[] = {
+	{ .compatible = "fsl,imx6q-pcie", },
+	{ .compatible = "fsl,imx6sx-pcie", .data = &imx6sx_pcie_data},
+	{},
+};
+MODULE_DEVICE_TABLE(of, imx6_pcie_of_match);
+
+#ifdef CONFIG_PM_SLEEP
+static int pci_imx_suspend(void)
+{
+	int rc = 0;
+
+	if (is_imx6sx_pcie(imx6_pcie)) {
+		/* PM_TURN_OFF */
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				BIT(16), 1 << 16);
+		udelay(10);
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				BIT(16), 0 << 16);
+	}
+
+	return rc;
+}
+
+static void pci_imx_resume(void)
+{
+	struct pcie_port *pp = &imx6_pcie->pp;
+
+	if (is_imx6sx_pcie(imx6_pcie)) {
+		/* reset iMX6SX PCIe */
+		regmap_update_bits(imx6_pcie->iomuxc_gpr,
+				IOMUXC_GPR5, BIT(18), 1 << 18);
+
+		regmap_update_bits(imx6_pcie->iomuxc_gpr,
+				IOMUXC_GPR5, BIT(18), 0 << 18);
+
+		/*
+		 * controller maybe turn off, re-configure again
+		 * Set the CLASS_REV of RC CFG header to
+		 * PCI_CLASS_BRIDGE_PCI
+		 */
+		writel(readl(pp->dbi_base + PCI_CLASS_REVISION)
+			| (PCI_CLASS_BRIDGE_PCI << 16),
+			pp->dbi_base + PCI_CLASS_REVISION);
+
+		dw_pcie_setup_rc(pp);
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
+	const struct of_device_id *of_id =
+			of_match_device(imx6_pcie_of_match, &pdev->dev);
 	struct device_node *np = pdev->dev.of_node;
 	struct resource *dbi_base;
 	int ret;
@@ -560,6 +682,7 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 
 	pp = &imx6_pcie->pp;
 	pp->dev = &pdev->dev;
+	imx6_pcie->data = of_id->data;
 
 	/* Added for PCI abort handling */
 	hook_fault_code(16 + 6, imx6q_pcie_abort_handler, SIGBUS, 0,
@@ -603,9 +726,19 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(imx6_pcie->pcie);
 	}
 
-	/* Grab GPR config register range */
-	imx6_pcie->iomuxc_gpr =
-		 syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
+	if (is_imx6sx_pcie(imx6_pcie)) {
+		imx6_pcie->pcie_regulator = devm_regulator_get(pp->dev, "pcie");
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
@@ -616,6 +749,9 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 		return ret;
 
 	platform_set_drvdata(pdev, imx6_pcie);
+#ifdef CONFIG_PM_SLEEP
+	register_syscore_ops(&pci_imx_syscore_ops);
+#endif
 	return 0;
 }
 
@@ -627,12 +763,6 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
 	imx6_pcie_assert_core_reset(&imx6_pcie->pp);
 }
 
-static const struct of_device_id imx6_pcie_of_match[] = {
-	{ .compatible = "fsl,imx6q-pcie", },
-	{},
-};
-MODULE_DEVICE_TABLE(of, imx6_pcie_of_match);
-
 static struct platform_driver imx6_pcie_driver = {
 	.driver = {
 		.name	= "imx6q-pcie",
-- 
1.9.1

