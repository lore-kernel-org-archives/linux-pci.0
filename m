Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: <bhelgaas@google.com>
CC: <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nsekhar@ti.com>, <kishon@ti.com>
Subject: [RFC PATCH 1/2] pci: host: pci-dra7xx: use "num-lanes" property to find phy count
Date: Mon, 28 Sep 2015 18:27:37 +0530
Message-ID: <1443445058-643-2-git-send-email-kishon@ti.com>
In-Reply-To: <1443445058-643-1-git-send-email-kishon@ti.com>
References: <1443445058-643-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

use "num-lanes" property to find phy count instead of the number
phy-names property.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/host/pci-dra7xx.c |   23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
index 199e29a..e15b2e2 100644
--- a/drivers/pci/host/pci-dra7xx.c
+++ b/drivers/pci/host/pci-dra7xx.c
@@ -66,7 +66,7 @@
 struct dra7xx_pcie {
 	void __iomem		*base;
 	struct phy		**phy;
-	int			phy_count;
+	int			lanes;
 	struct device		*dev;
 	struct pcie_port	pp;
 };
@@ -328,7 +328,7 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 	int ret;
 	int irq;
 	int i;
-	int phy_count;
+	u32 lanes;
 	struct phy **phy;
 	void __iomem *base;
 	struct resource *res;
@@ -362,17 +362,16 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 	if (!base)
 		return -ENOMEM;
 
-	phy_count = of_property_count_strings(np, "phy-names");
-	if (phy_count < 0) {
-		dev_err(dev, "unable to find the strings\n");
-		return phy_count;
+	if (of_property_read_u32(np, "num-lanes", &lanes)) {
+		dev_err(dev, "Failed to parse the number of lanes\n");
+		return -EINVAL;
 	}
 
-	phy = devm_kzalloc(dev, sizeof(*phy) * phy_count, GFP_KERNEL);
+	phy = devm_kzalloc(dev, sizeof(*phy) * lanes, GFP_KERNEL);
 	if (!phy)
 		return -ENOMEM;
 
-	for (i = 0; i < phy_count; i++) {
+	for (i = 0; i < lanes; i++) {
 		snprintf(name, sizeof(name), "pcie-phy%d", i);
 		phy[i] = devm_phy_get(dev, name);
 		if (IS_ERR(phy[i]))
@@ -392,7 +391,7 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 	dra7xx->base = base;
 	dra7xx->phy = phy;
 	dra7xx->dev = dev;
-	dra7xx->phy_count = phy_count;
+	dra7xx->lanes = lanes;
 
 	pm_runtime_enable(dev);
 	ret = pm_runtime_get_sync(dev);
@@ -449,7 +448,7 @@ static int __exit dra7xx_pcie_remove(struct platform_device *pdev)
 	struct dra7xx_pcie *dra7xx = platform_get_drvdata(pdev);
 	struct pcie_port *pp = &dra7xx->pp;
 	struct device *dev = &pdev->dev;
-	int count = dra7xx->phy_count;
+	int count = dra7xx->lanes;
 
 	if (pp->irq_domain)
 		irq_domain_remove(pp->irq_domain);
@@ -495,7 +494,7 @@ static int dra7xx_pcie_resume(struct device *dev)
 static int dra7xx_pcie_suspend_noirq(struct device *dev)
 {
 	struct dra7xx_pcie *dra7xx = dev_get_drvdata(dev);
-	int count = dra7xx->phy_count;
+	int count = dra7xx->lanes;
 
 	while (count--) {
 		phy_power_off(dra7xx->phy[count]);
@@ -508,7 +507,7 @@ static int dra7xx_pcie_suspend_noirq(struct device *dev)
 static int dra7xx_pcie_resume_noirq(struct device *dev)
 {
 	struct dra7xx_pcie *dra7xx = dev_get_drvdata(dev);
-	int phy_count = dra7xx->phy_count;
+	int phy_count = dra7xx->lanes;
 	int ret;
 	int i;
 
-- 
1.7.9.5

