Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752041AbcJLNga (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:36:30 -0400
Subject: [PATCH v2 1/7] PCI: artpec6: Add local struct device pointers
To: Jesper Nilsson <jesper.nilsson@axis.com>,
        Niklas Cassel <niklas.cassel@axis.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@axis.com
Date: Wed, 12 Oct 2016 08:29:03 -0500
Message-ID: <20161012132903.27228.92485.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012132616.27228.4618.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012132616.27228.4618.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use a local "struct device *dev" for brevity and consistency with other
drivers.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>
---
 drivers/pci/host/pcie-artpec6.c |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/host/pcie-artpec6.c b/drivers/pci/host/pcie-artpec6.c
index 39bf1a6..ef2f04f 100644
--- a/drivers/pci/host/pcie-artpec6.c
+++ b/drivers/pci/host/pcie-artpec6.c
@@ -194,21 +194,22 @@ static irqreturn_t artpec6_pcie_msi_handler(int irq, void *arg)
 static int artpec6_add_pcie_port(struct pcie_port *pp,
 				 struct platform_device *pdev)
 {
+	struct device *dev = pp->dev;
 	int ret;
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		pp->msi_irq = platform_get_irq_byname(pdev, "msi");
 		if (pp->msi_irq <= 0) {
-			dev_err(&pdev->dev, "failed to get MSI irq\n");
+			dev_err(dev, "failed to get MSI irq\n");
 			return -ENODEV;
 		}
 
-		ret = devm_request_irq(&pdev->dev, pp->msi_irq,
+		ret = devm_request_irq(dev, pp->msi_irq,
 				       artpec6_pcie_msi_handler,
 				       IRQF_SHARED | IRQF_NO_THREAD,
 				       "artpec6-pcie-msi", pp);
 		if (ret) {
-			dev_err(&pdev->dev, "failed to request MSI irq\n");
+			dev_err(dev, "failed to request MSI irq\n");
 			return ret;
 		}
 	}
@@ -218,7 +219,7 @@ static int artpec6_add_pcie_port(struct pcie_port *pp,
 
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to initialize host\n");
+		dev_err(dev, "failed to initialize host\n");
 		return ret;
 	}
 
@@ -227,32 +228,32 @@ static int artpec6_add_pcie_port(struct pcie_port *pp,
 
 static int artpec6_pcie_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct artpec6_pcie *artpec6_pcie;
 	struct pcie_port *pp;
 	struct resource *dbi_base;
 	struct resource *phy_base;
 	int ret;
 
-	artpec6_pcie = devm_kzalloc(&pdev->dev, sizeof(*artpec6_pcie),
-				    GFP_KERNEL);
+	artpec6_pcie = devm_kzalloc(dev, sizeof(*artpec6_pcie), GFP_KERNEL);
 	if (!artpec6_pcie)
 		return -ENOMEM;
 
 	pp = &artpec6_pcie->pp;
-	pp->dev = &pdev->dev;
+	pp->dev = dev;
 
 	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
-	pp->dbi_base = devm_ioremap_resource(&pdev->dev, dbi_base);
+	pp->dbi_base = devm_ioremap_resource(dev, dbi_base);
 	if (IS_ERR(pp->dbi_base))
 		return PTR_ERR(pp->dbi_base);
 
 	phy_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "phy");
-	artpec6_pcie->phy_base = devm_ioremap_resource(&pdev->dev, phy_base);
+	artpec6_pcie->phy_base = devm_ioremap_resource(dev, phy_base);
 	if (IS_ERR(artpec6_pcie->phy_base))
 		return PTR_ERR(artpec6_pcie->phy_base);
 
 	artpec6_pcie->regmap =
-		syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
+		syscon_regmap_lookup_by_phandle(dev->of_node,
 						"axis,syscon-pcie");
 	if (IS_ERR(artpec6_pcie->regmap))
 		return PTR_ERR(artpec6_pcie->regmap);

