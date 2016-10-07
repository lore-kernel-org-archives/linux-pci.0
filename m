Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753234AbcJGQbW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:31:22 -0400
Subject: [PATCH 1/8] PCI: armada: Name private struct pointer "armada8k"
 consistently
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:31:18 -0500
Message-ID: <20161007163118.24582.12385.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use a device-specific name, "armada8k", for struct armada8k_pcie pointers
to hint that this is device-specific information.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-armada8k.c |   37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/host/pcie-armada8k.c b/drivers/pci/host/pcie-armada8k.c
index 0f4f570..f88a790 100644
--- a/drivers/pci/host/pcie-armada8k.c
+++ b/drivers/pci/host/pcie-armada8k.c
@@ -72,12 +72,11 @@ struct armada8k_pcie {
 
 static int armada8k_pcie_link_up(struct pcie_port *pp)
 {
-	struct armada8k_pcie *pcie = to_armada8k_pcie(pp);
+	struct armada8k_pcie *armada8k = to_armada8k_pcie(pp);
 	u32 reg;
 	u32 mask = PCIE_GLB_STS_RDLH_LINK_UP | PCIE_GLB_STS_PHY_LINK_UP;
 
-	reg = readl(pcie->base + PCIE_GLOBAL_STATUS_REG);
-
+	reg = readl(armada8k->base + PCIE_GLOBAL_STATUS_REG);
 	if ((reg & mask) == mask)
 		return 1;
 
@@ -87,8 +86,8 @@ static int armada8k_pcie_link_up(struct pcie_port *pp)
 
 static void armada8k_pcie_establish_link(struct pcie_port *pp)
 {
-	struct armada8k_pcie *pcie = to_armada8k_pcie(pp);
-	void __iomem *base = pcie->base;
+	struct armada8k_pcie *armada8k = to_armada8k_pcie(pp);
+	void __iomem *base = armada8k->base;
 	u32 reg;
 
 	if (!dw_pcie_link_up(pp)) {
@@ -146,8 +145,8 @@ static void armada8k_pcie_host_init(struct pcie_port *pp)
 static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
 {
 	struct pcie_port *pp = arg;
-	struct armada8k_pcie *pcie = to_armada8k_pcie(pp);
-	void __iomem *base = pcie->base;
+	struct armada8k_pcie *armada8k = to_armada8k_pcie(pp);
+	void __iomem *base = armada8k->base;
 	u32 val;
 
 	/*
@@ -199,25 +198,25 @@ static int armada8k_add_pcie_port(struct pcie_port *pp,
 
 static int armada8k_pcie_probe(struct platform_device *pdev)
 {
-	struct armada8k_pcie *pcie;
+	struct armada8k_pcie *armada8k;
 	struct pcie_port *pp;
 	struct device *dev = &pdev->dev;
 	struct resource *base;
 	int ret;
 
-	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
-	if (!pcie)
+	armada8k = devm_kzalloc(dev, sizeof(*armada8k), GFP_KERNEL);
+	if (!armada8k)
 		return -ENOMEM;
 
-	pcie->clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(pcie->clk))
-		return PTR_ERR(pcie->clk);
+	armada8k->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(armada8k->clk))
+		return PTR_ERR(armada8k->clk);
 
-	clk_prepare_enable(pcie->clk);
+	clk_prepare_enable(armada8k->clk);
 
-	pp = &pcie->pp;
+	pp = &armada8k->pp;
 	pp->dev = dev;
-	platform_set_drvdata(pdev, pcie);
+	platform_set_drvdata(pdev, armada8k);
 
 	/* Get the dw-pcie unit configuration/control registers base. */
 	base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ctrl");
@@ -228,7 +227,7 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 		goto fail;
 	}
 
-	pcie->base = pp->dbi_base + PCIE_VENDOR_REGS_OFFSET;
+	armada8k->base = pp->dbi_base + PCIE_VENDOR_REGS_OFFSET;
 
 	ret = armada8k_add_pcie_port(pp, pdev);
 	if (ret)
@@ -237,8 +236,8 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 	return 0;
 
 fail:
-	if (!IS_ERR(pcie->clk))
-		clk_disable_unprepare(pcie->clk);
+	if (!IS_ERR(armada8k->clk))
+		clk_disable_unprepare(armada8k->clk);
 
 	return ret;
 }

