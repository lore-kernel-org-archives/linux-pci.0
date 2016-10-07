Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936430AbcJGQde (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:33:34 -0400
Subject: [PATCH 7/8] PCI: artpec6: Add local struct device pointers
To: Jesper Nilsson <jesper.nilsson@axis.com>,
        Niklas Cassel <niklas.cassel@axis.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@axis.com
Date: Fri, 07 Oct 2016 11:33:24 -0500
Message-ID: <20161007163324.24751.68214.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007163233.24751.17505.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007163233.24751.17505.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use a local "struct device *dev" for brevity and consistency with other
drivers.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-artpec6.c |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/host/pcie-artpec6.c b/drivers/pci/host/pcie-artpec6.c
index c3dd571..e3f828f 100644
--- a/drivers/pci/host/pcie-artpec6.c
+++ b/drivers/pci/host/pcie-artpec6.c
@@ -197,21 +197,22 @@ static int artpec6_add_pcie_port(struct artpec6_pcie *artpec6,
 				 struct platform_device *pdev)
 {
 	struct pcie_port *pp = &artpec6->pp;
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
 				       "artpec6-pcie-msi", artpec6);
 		if (ret) {
-			dev_err(&pdev->dev, "failed to request MSI irq\n");
+			dev_err(dev, "failed to request MSI irq\n");
 			return ret;
 		}
 	}
@@ -221,7 +222,7 @@ static int artpec6_add_pcie_port(struct artpec6_pcie *artpec6,
 
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to initialize host\n");
+		dev_err(dev, "failed to initialize host\n");
 		return ret;
 	}
 
@@ -230,26 +231,27 @@ static int artpec6_add_pcie_port(struct artpec6_pcie *artpec6,
 
 static int artpec6_pcie_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct artpec6_pcie *artpec6;
 	struct pcie_port *pp;
 	struct resource *dbi_base;
 	struct resource *phy_base;
 	int ret;
 
-	artpec6 = devm_kzalloc(&pdev->dev, sizeof(*artpec6), GFP_KERNEL);
+	artpec6 = devm_kzalloc(dev, sizeof(*artpec6), GFP_KERNEL);
 	if (!artpec6)
 		return -ENOMEM;
 
 	pp = &artpec6->pp;
-	pp->dev = &pdev->dev;
+	pp->dev = dev;
 
 	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
-	pp->dbi_base = devm_ioremap_resource(&pdev->dev, dbi_base);
+	pp->dbi_base = devm_ioremap_resource(dev, dbi_base);
 	if (IS_ERR(pp->dbi_base))
 		return PTR_ERR(pp->dbi_base);
 
 	phy_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "phy");
-	artpec6->phy_base = devm_ioremap_resource(&pdev->dev, phy_base);
+	artpec6->phy_base = devm_ioremap_resource(dev, phy_base);
 	if (IS_ERR(artpec6->phy_base))
 		return PTR_ERR(artpec6->phy_base);
 

