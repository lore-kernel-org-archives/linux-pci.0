Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941016AbcJGQjT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:39:19 -0400
Subject: [PATCH 04/10] PCI: imx6: Pass device-specific struct to internal
 functions
To: Richard Zhu <Richard.Zhu@freescale.com>,
        Lucas Stach <l.stach@pengutronix.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:39:07 -0500
Message-ID: <20161007163907.25776.41722.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007163839.25776.2512.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007163839.25776.2512.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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
index e4bd92b..82195cc 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -228,9 +228,8 @@ static int imx6_pcie_phy_write(struct imx6_pcie *imx6, int addr, int data)
 	return 0;
 }
 
-static void imx6_pcie_reset_phy(struct pcie_port *pp)
+static void imx6_pcie_reset_phy(struct imx6_pcie *imx6)
 {
-	struct imx6_pcie *imx6 = to_imx6_pcie(pp);
 	u32 tmp;
 
 	imx6_pcie_phy_read(imx6, PHY_RX_OVRD_IN_LO, &tmp);
@@ -253,9 +252,8 @@ static int imx6q_pcie_abort_handler(unsigned long addr,
 	return 0;
 }
 
-static int imx6_pcie_assert_core_reset(struct pcie_port *pp)
+static int imx6_pcie_assert_core_reset(struct imx6_pcie *imx6)
 {
-	struct imx6_pcie *imx6 = to_imx6_pcie(pp);
 	u32 val, gpr1, gpr12;
 
 	switch (imx6->variant) {
@@ -347,9 +345,9 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6)
 	return ret;
 }
 
-static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
+static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6)
 {
-	struct imx6_pcie *imx6 = to_imx6_pcie(pp);
+	struct pcie_port *pp = &imx6->pp;
 	int ret;
 
 	ret = clk_prepare_enable(imx6->pcie_phy);
@@ -415,10 +413,8 @@ err_pcie_phy:
 	return ret;
 }
 
-static void imx6_pcie_init_phy(struct pcie_port *pp)
+static void imx6_pcie_init_phy(struct imx6_pcie *imx6)
 {
-	struct imx6_pcie *imx6 = to_imx6_pcie(pp);
-
 	if (imx6->variant == IMX6SX)
 		regmap_update_bits(imx6->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX6SX_GPR12_PCIE_RX_EQ_MASK,
@@ -450,8 +446,10 @@ static void imx6_pcie_init_phy(struct pcie_port *pp)
 			   imx6->tx_swing_low << 25);
 }
 
-static int imx6_pcie_wait_for_link(struct pcie_port *pp)
+static int imx6_pcie_wait_for_link(struct imx6_pcie *imx6)
 {
+	struct pcie_port *pp = &imx6->pp;
+
 	/* check if the link is up or not */
 	if (!dw_pcie_wait_for_link(pp))
 		return 0;
@@ -462,8 +460,9 @@ static int imx6_pcie_wait_for_link(struct pcie_port *pp)
 	return -ETIMEDOUT;
 }
 
-static int imx6_pcie_wait_for_speed_change(struct pcie_port *pp)
+static int imx6_pcie_wait_for_speed_change(struct imx6_pcie *imx6)
 {
+	struct pcie_port *pp = &imx6->pp;
 	u32 tmp;
 	unsigned int retries;
 
@@ -481,14 +480,15 @@ static int imx6_pcie_wait_for_speed_change(struct pcie_port *pp)
 
 static irqreturn_t imx6_pcie_msi_handler(int irq, void *arg)
 {
-	struct pcie_port *pp = arg;
+	struct imx6_pcie *imx6 = arg;
+	struct pcie_port *pp = &imx6->pp;
 
 	return dw_handle_msi_irq(pp);
 }
 
-static int imx6_pcie_establish_link(struct pcie_port *pp)
+static int imx6_pcie_establish_link(struct imx6_pcie *imx6)
 {
-	struct imx6_pcie *imx6 = to_imx6_pcie(pp);
+	struct pcie_port *pp = &imx6->pp;
 	u32 tmp;
 	int ret;
 
@@ -506,7 +506,7 @@ static int imx6_pcie_establish_link(struct pcie_port *pp)
 	regmap_update_bits(imx6->iomuxc_gpr, IOMUXC_GPR12,
 			IMX6Q_GPR12_PCIE_CTL_2, 1 << 10);
 
-	ret = imx6_pcie_wait_for_link(pp);
+	ret = imx6_pcie_wait_for_link(imx6);
 	if (ret) {
 		dev_info(pp->dev, "Link never came up\n");
 		goto err_reset_phy;
@@ -530,14 +530,14 @@ static int imx6_pcie_establish_link(struct pcie_port *pp)
 	tmp |= PORT_LOGIC_SPEED_CHANGE;
 	imx6_pcie_writel(imx6, tmp, PCIE_LINK_WIDTH_SPEED_CONTROL);
 
-	ret = imx6_pcie_wait_for_speed_change(pp);
+	ret = imx6_pcie_wait_for_speed_change(imx6);
 	if (ret) {
 		dev_err(pp->dev, "Failed to bring link up!\n");
 		goto err_reset_phy;
 	}
 
 	/* Make sure link training is finished as well! */
-	ret = imx6_pcie_wait_for_link(pp);
+	ret = imx6_pcie_wait_for_link(imx6);
 	if (ret) {
 		dev_err(pp->dev, "Failed to bring link up!\n");
 		goto err_reset_phy;
@@ -558,15 +558,13 @@ err_reset_phy:
 
 static void imx6_pcie_host_init(struct pcie_port *pp)
 {
-	imx6_pcie_assert_core_reset(pp);
-
-	imx6_pcie_init_phy(pp);
-
-	imx6_pcie_deassert_core_reset(pp);
+	struct imx6_pcie *imx6 = to_imx6_pcie(pp);
 
+	imx6_pcie_assert_core_reset(imx6);
+	imx6_pcie_init_phy(imx6);
+	imx6_pcie_deassert_core_reset(imx6);
 	dw_pcie_setup_rc(pp);
-
-	imx6_pcie_establish_link(pp);
+	imx6_pcie_establish_link(imx6);
 
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		dw_pcie_msi_init(pp);
@@ -585,9 +583,10 @@ static struct pcie_host_ops imx6_pcie_host_ops = {
 	.host_init = imx6_pcie_host_init,
 };
 
-static int __init imx6_add_pcie_port(struct pcie_port *pp,
-			struct platform_device *pdev)
+static int __init imx6_add_pcie_port(struct imx6_pcie *imx6,
+				     struct platform_device *pdev)
 {
+	struct pcie_port *pp = &imx6->pp;
 	int ret;
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
@@ -600,7 +599,7 @@ static int __init imx6_add_pcie_port(struct pcie_port *pp,
 		ret = devm_request_irq(&pdev->dev, pp->msi_irq,
 				       imx6_pcie_msi_handler,
 				       IRQF_SHARED | IRQF_NO_THREAD,
-				       "mx6-pcie-msi", pp);
+				       "mx6-pcie-msi", imx6);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to request MSI irq\n");
 			return ret;
@@ -730,7 +729,7 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		imx6->link_gen = 1;
 
-	ret = imx6_add_pcie_port(pp, pdev);
+	ret = imx6_add_pcie_port(imx6, pdev);
 	if (ret < 0)
 		return ret;
 
@@ -743,7 +742,7 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
 	struct imx6_pcie *imx6 = platform_get_drvdata(pdev);
 
 	/* bring down link, so bootloader gets clean state in case of reboot */
-	imx6_pcie_assert_core_reset(&imx6->pp);
+	imx6_pcie_assert_core_reset(imx6);
 }
 
 static const struct of_device_id imx6_pcie_of_match[] = {

