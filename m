Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Niklas Cassel <niklas.cassel@axis.com>
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Cassel <niklass@axis.com>, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/17] PCI: dwc: dra7xx: Assign pp->ops in dra7xx_add_pcie_port() rather than in probe
Date: Mon, 30 Oct 2017 13:42:11 +0100
Message-Id: <20171030124221.20690-9-niklas.cassel@axis.com>
In-Reply-To: <20171030124221.20690-1-niklas.cassel@axis.com>
References: <20171030124221.20690-1-niklas.cassel@axis.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This matches how other drivers like exynos, imx7, keystone, armada8k,
artpec6, designware-plat, hisi, kirin and spear13xx does it.

This is probably a remainder since when dev and ops were assigned as
members to pp. Since we now assign them as members to struct dw_pcie,
the pp->ops assignment should definitely be in dra7xx_add_pcie_port().

This is also needed to be able to compile host/ep mode specific code
independently.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
V2:
* New patch in this series.

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
