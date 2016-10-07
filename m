Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964844AbcJGQe5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:34:57 -0400
Subject: [PATCH 7/9] PCI: dra7xx: Add local struct device pointers
To: Kishon Vijay Abraham I <kishon@ti.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-omap@vger.kernel.org
Date: Fri, 07 Oct 2016 11:34:53 -0500
Message-ID: <20161007163453.24926.57978.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007163350.24926.17545.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007163350.24926.17545.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use a local "struct device *dev" for brevity and consistency with other
drivers.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-dra7xx.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
index 5572613..87c89178 100644
--- a/drivers/pci/host/pci-dra7xx.c
+++ b/drivers/pci/host/pci-dra7xx.c
@@ -93,10 +93,11 @@ static int dra7xx_pcie_link_up(struct pcie_port *pp)
 static int dra7xx_pcie_establish_link(struct dra7xx_pcie *dra7xx)
 {
 	struct pcie_port *pp = &dra7xx->pp;
+	struct device *dev = pp->dev;
 	u32 reg;
 
 	if (dw_pcie_link_up(pp)) {
-		dev_err(pp->dev, "link is already up\n");
+		dev_err(dev, "link is already up\n");
 		return 0;
 	}
 
@@ -265,10 +266,10 @@ static irqreturn_t dra7xx_pcie_irq_handler(int irq, void *arg)
 static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
 				       struct platform_device *pdev)
 {
-	int ret;
+	struct device *dev = &pdev->dev;
 	struct pcie_port *pp;
 	struct resource *res;
-	struct device *dev = &pdev->dev;
+	int ret;
 
 	pp = &dra7xx->pp;
 	pp->dev = dev;
@@ -280,12 +281,11 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
 		return -EINVAL;
 	}
 
-	ret = devm_request_irq(&pdev->dev, pp->irq,
-			       dra7xx_pcie_msi_irq_handler,
+	ret = devm_request_irq(dev, pp->irq, dra7xx_pcie_msi_irq_handler,
 			       IRQF_SHARED | IRQF_NO_THREAD,
 			       "dra7-pcie-msi",	pp);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to request irq\n");
+		dev_err(dev, "failed to request irq\n");
 		return ret;
 	}
 
@@ -311,6 +311,9 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
 
 static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct dra7xx_pcie *dra7xx;
 	u32 reg;
 	int ret;
 	int irq;
@@ -319,9 +322,6 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 	struct phy **phy;
 	void __iomem *base;
 	struct resource *res;
-	struct dra7xx_pcie *dra7xx;
-	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
 	char name[10];
 	int gpio_sel;
 	enum of_gpio_flags flags;
@@ -394,7 +394,7 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 		ret = devm_gpio_request_one(dev, gpio_sel, gpio_flags,
 					    "pcie_reset");
 		if (ret) {
-			dev_err(&pdev->dev, "gpio%d request failed, ret %d\n",
+			dev_err(dev, "gpio%d request failed, ret %d\n",
 				gpio_sel, ret);
 			goto err_gpio;
 		}

