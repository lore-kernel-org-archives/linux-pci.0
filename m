Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755101AbcJLNsR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:48:17 -0400
Subject: [PATCH v2 5/8] PCI: imx6: Pass device-specific struct to internal
 functions
To: Richard Zhu <Richard.Zhu@freescale.com>,
        Lucas Stach <l.stach@pengutronix.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 08:48:12 -0500
Message-ID: <20161012134812.28919.58209.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012134335.28919.64137.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012134335.28919.64137.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Only interfaces used from outside the driver, e.g., those called by the
DesignWare core, need to accept pointers to the generic struct pcie_port.
Internal interfaces can accept pointers to the device-specific struct,
which makes them more straightforward.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-imx6.c |   57 +++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 8a6a8d5..7dfe400 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -221,9 +221,8 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 	return 0;
 }
 
-static void imx6_pcie_reset_phy(struct pcie_port *pp)
+static void imx6_pcie_reset_phy(struct imx6_pcie *imx6_pcie)
 {
-	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
 	u32 tmp;
 
 	pcie_phy_read(imx6_pcie, PHY_RX_OVRD_IN_LO, &tmp);
@@ -246,9 +245,9 @@ static int imx6q_pcie_abort_handler(unsigned long addr,
 	return 0;
 }
 
-static int imx6_pcie_assert_core_reset(struct pcie_port *pp)
+static int imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 {
-	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
+	struct pcie_port *pp = &imx6_pcie->pp;
 	u32 val, gpr1, gpr12;
 
 	switch (imx6_pcie->variant) {
@@ -341,9 +340,9 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 	return ret;
 }
 
-static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
+static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 {
-	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
+	struct pcie_port *pp = &imx6_pcie->pp;
 	struct device *dev = pp->dev;
 	int ret;
 
@@ -410,10 +409,8 @@ err_pcie_phy:
 	return ret;
 }
 
-static void imx6_pcie_init_phy(struct pcie_port *pp)
+static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 {
-	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
-
 	if (imx6_pcie->variant == IMX6SX)
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX6SX_GPR12_PCIE_RX_EQ_MASK,
@@ -445,8 +442,9 @@ static void imx6_pcie_init_phy(struct pcie_port *pp)
 			   imx6_pcie->tx_swing_low << 25);
 }
 
-static int imx6_pcie_wait_for_link(struct pcie_port *pp)
+static int imx6_pcie_wait_for_link(struct imx6_pcie *imx6_pcie)
 {
+	struct pcie_port *pp = &imx6_pcie->pp;
 	struct device *dev = pp->dev;
 
 	/* check if the link is up or not */
@@ -459,8 +457,9 @@ static int imx6_pcie_wait_for_link(struct pcie_port *pp)
 	return -ETIMEDOUT;
 }
 
-static int imx6_pcie_wait_for_speed_change(struct pcie_port *pp)
+static int imx6_pcie_wait_for_speed_change(struct imx6_pcie *imx6_pcie)
 {
+	struct pcie_port *pp = &imx6_pcie->pp;
 	struct device *dev = pp->dev;
 	u32 tmp;
 	unsigned int retries;
@@ -479,14 +478,15 @@ static int imx6_pcie_wait_for_speed_change(struct pcie_port *pp)
 
 static irqreturn_t imx6_pcie_msi_handler(int irq, void *arg)
 {
-	struct pcie_port *pp = arg;
+	struct imx6_pcie *imx6_pcie = arg;
+	struct pcie_port *pp = &imx6_pcie->pp;
 
 	return dw_handle_msi_irq(pp);
 }
 
-static int imx6_pcie_establish_link(struct pcie_port *pp)
+static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 {
-	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
+	struct pcie_port *pp = &imx6_pcie->pp;
 	struct device *dev = pp->dev;
 	u32 tmp;
 	int ret;
@@ -505,7 +505,7 @@ static int imx6_pcie_establish_link(struct pcie_port *pp)
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 			IMX6Q_GPR12_PCIE_CTL_2, 1 << 10);
 
-	ret = imx6_pcie_wait_for_link(pp);
+	ret = imx6_pcie_wait_for_link(imx6_pcie);
 	if (ret) {
 		dev_info(dev, "Link never came up\n");
 		goto err_reset_phy;
@@ -529,14 +529,14 @@ static int imx6_pcie_establish_link(struct pcie_port *pp)
 	tmp |= PORT_LOGIC_SPEED_CHANGE;
 	writel(tmp, pp->dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
 
-	ret = imx6_pcie_wait_for_speed_change(pp);
+	ret = imx6_pcie_wait_for_speed_change(imx6_pcie);
 	if (ret) {
 		dev_err(dev, "Failed to bring link up!\n");
 		goto err_reset_phy;
 	}
 
 	/* Make sure link training is finished as well! */
-	ret = imx6_pcie_wait_for_link(pp);
+	ret = imx6_pcie_wait_for_link(imx6_pcie);
 	if (ret) {
 		dev_err(dev, "Failed to bring link up!\n");
 		goto err_reset_phy;
@@ -557,15 +557,13 @@ err_reset_phy:
 
 static void imx6_pcie_host_init(struct pcie_port *pp)
 {
-	imx6_pcie_assert_core_reset(pp);
-
-	imx6_pcie_init_phy(pp);
-
-	imx6_pcie_deassert_core_reset(pp);
+	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
 
+	imx6_pcie_assert_core_reset(imx6_pcie);
+	imx6_pcie_init_phy(imx6_pcie);
+	imx6_pcie_deassert_core_reset(imx6_pcie);
 	dw_pcie_setup_rc(pp);
-
-	imx6_pcie_establish_link(pp);
+	imx6_pcie_establish_link(imx6_pcie);
 
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		dw_pcie_msi_init(pp);
@@ -582,9 +580,10 @@ static struct pcie_host_ops imx6_pcie_host_ops = {
 	.host_init = imx6_pcie_host_init,
 };
 
-static int __init imx6_add_pcie_port(struct pcie_port *pp,
-			struct platform_device *pdev)
+static int __init imx6_add_pcie_port(struct imx6_pcie *imx6_pcie,
+				     struct platform_device *pdev)
 {
+	struct pcie_port *pp = &imx6_pcie->pp;
 	struct device *dev = pp->dev;
 	int ret;
 
@@ -598,7 +597,7 @@ static int __init imx6_add_pcie_port(struct pcie_port *pp,
 		ret = devm_request_irq(dev, pp->msi_irq,
 				       imx6_pcie_msi_handler,
 				       IRQF_SHARED | IRQF_NO_THREAD,
-				       "mx6-pcie-msi", pp);
+				       "mx6-pcie-msi", imx6_pcie);
 		if (ret) {
 			dev_err(dev, "failed to request MSI irq\n");
 			return ret;
@@ -725,7 +724,7 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		imx6_pcie->link_gen = 1;
 
-	ret = imx6_add_pcie_port(pp, pdev);
+	ret = imx6_add_pcie_port(imx6_pcie, pdev);
 	if (ret < 0)
 		return ret;
 
@@ -738,7 +737,7 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
 	struct imx6_pcie *imx6_pcie = platform_get_drvdata(pdev);
 
 	/* bring down link, so bootloader gets clean state in case of reboot */
-	imx6_pcie_assert_core_reset(&imx6_pcie->pp);
+	imx6_pcie_assert_core_reset(imx6_pcie);
 }
 
 static const struct of_device_id imx6_pcie_of_match[] = {

