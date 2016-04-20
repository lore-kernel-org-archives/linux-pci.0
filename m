Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:35700 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752700AbcDTPpw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 Apr 2016 11:45:52 -0400
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	gary.bisson@boundarydevices.com
Subject: [PATCH v3 2/3] PCI: imx6: Implement reset sequence for i.MX6+
Date: Wed, 20 Apr 2016 08:45:30 -0700
Message-Id: <1461167131-26025-2-git-send-email-andrew.smirnov@gmail.com>
In-Reply-To: <1461167131-26025-1-git-send-email-andrew.smirnov@gmail.com>
References: <1461167131-26025-1-git-send-email-andrew.smirnov@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I.MX6+ has a dedicated bit for reseting PCIe core, which should be used
instead of a regular reset sequence since using the latter will hang the
SoC.

This commit is based on c34068d48273e24d392d9a49a38be807954420ed from
http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---

Changes since v2:
	- Removed default clause in all introduced switch statements
	- Switched to using of_device_get_match_data instead of
          explicit of_device_is_compatible checks
	- Added a mention of the new DT compatibility string in the documentation

Changes since v1:

	- Patchset is rebased against
          https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/host-imx6
	- DTS files changes moved into a separate patch

 .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |  2 +-
 drivers/pci/host/pci-imx6.c                        | 23 ++++++++++++++++++++--
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h        |  1 +
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
index 0561e88..4210fe1 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
@@ -4,7 +4,7 @@ This PCIe host controller is based on the Synopsis Designware PCIe IP
 and thus inherits all the common properties defined in designware-pcie.txt.
 
 Required properties:
-- compatible: "fsl,imx6q-pcie", "fsl,imx6sx-pcie"
+- compatible: "fsl,imx6q-pcie", "fsl,imx6sx-pcie", "fsl,imx6qp-pcie"
 - reg: base address and length of the PCIe controller
 - interrupts: A list of interrupt outputs of the controller. Must contain an
   entry for each entry in the interrupt-names property.
diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index a77e7fd..a47d993 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -34,7 +34,8 @@
 
 enum imx6_pcie_variants {
 	IMX6Q,
-	IMX6SX
+	IMX6SX,
+	IMX6QP,
 };
 
 struct imx6_pcie {
@@ -254,6 +255,11 @@ static int imx6_pcie_assert_core_reset(struct pcie_port *pp)
 				   IMX6SX_GPR5_PCIE_BTNRST_RESET,
 				   IMX6SX_GPR5_PCIE_BTNRST_RESET);
 		break;
+	case IMX6QP:
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				   IMX6Q_GPR1_PCIE_SW_RST,
+				   IMX6Q_GPR1_PCIE_SW_RST);
+		break;
 	case IMX6Q:
 		/*
 		 * If the bootloader already enabled the link we need some special
@@ -306,6 +312,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
 		break;
+	case IMX6QP: 		/* FALLTHROUGH */
 	case IMX6Q:
 		/* power up core phy and enable ref clock */
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
@@ -364,9 +371,20 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
 		gpiod_set_value_cansleep(imx6_pcie->reset_gpio, 1);
 	}
 
-	if (imx6_pcie->variant == IMX6SX)
+	switch (imx6_pcie->variant) {
+	case IMX6SX:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
 				   IMX6SX_GPR5_PCIE_BTNRST_RESET, 0);
+		break;
+	case IMX6QP:
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				   IMX6Q_GPR1_PCIE_SW_RST, 0);
+
+		usleep_range(200, 500);
+		break;
+	case IMX6Q:		/* Nothing to do */
+		break;
+	}
 
 	return 0;
 
@@ -691,6 +709,7 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
 static const struct of_device_id imx6_pcie_of_match[] = {
 	{ .compatible = "fsl,imx6q-pcie",  .data = (void *)IMX6Q,  },
 	{ .compatible = "fsl,imx6sx-pcie", .data = (void *)IMX6SX, },
+	{ .compatible = "fsl,imx6qp-pcie", .data = (void *)IMX6QP, },
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

