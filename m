Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:51585 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756080AbdKCNsO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Nov 2017 09:48:14 -0400
From: Niklas Cassel <niklas.cassel@axis.com>
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Cassel <niklass@axis.com>, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 08/17] PCI: dwc: dra7xx: Assign pp->ops in dra7xx_add_pcie_port() rather than in probe
Date: Fri,  3 Nov 2017 14:47:12 +0100
Message-Id: <20171103134722.5532-9-niklas.cassel@axis.com>
In-Reply-To: <20171103134722.5532-1-niklas.cassel@axis.com>
References: <20171103134722.5532-1-niklas.cassel@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Assign pp->ops in *_add_pcie_port() to match how it is done in other
drivers like exynos, imx7, keystone, armada8k, artpec6, designware-plat,
hisi, kirin and spear13xx.

This is probably a remainder since when dev and ops were assigned as
members to pp. Since we now assign them as members to struct dw_pcie,
the pp->ops assignment should definitely be in dra7xx_add_pcie_port().

This is done so that the compiler (in a later commit) can remove more
code when enabling only one of the two supported modes (host/ep) in
the dra7xx driver.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/dwc/pci-dra7xx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index a743545da4d4..009f6aeeee1c 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -460,6 +460,8 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
 	if (!pci->dbi_base)
 		return -ENOMEM;
 
+	pp->ops = &dra7xx_pcie_host_ops;
+
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
 		dev_err(dev, "failed to initialize host\n");
@@ -588,7 +590,6 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 	void __iomem *base;
 	struct resource *res;
 	struct dw_pcie *pci;
-	struct pcie_port *pp;
 	struct dra7xx_pcie *dra7xx;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
@@ -616,9 +617,6 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
 
-	pp = &pci->pp;
-	pp->ops = &dra7xx_pcie_host_ops;
-
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(dev, "missing IRQ resource: %d\n", irq);
-- 
2.14.2
