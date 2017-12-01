Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Vignesh R <vigneshr@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Chris Welch <Chris.Welch@viavisolutions.com>
CC: Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Vignesh R <vigneshr@ti.com>
Subject: [PATCH 1/4] pci: dwc: pci-dra7xx: Enable errata i870 for both EP and RC mode
Date: Fri, 1 Dec 2017 11:43:08 +0530
Message-ID: <20171201061311.16691-2-vigneshr@ti.com>
In-Reply-To: <20171201061311.16691-1-vigneshr@ti.com>
References: <20171201061311.16691-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Errata i870 is applicable in both EP and RC mode. Therefore rename
function dra7xx_pcie_ep_unaligned_memaccess(), that implements errata
workaround, to dra7xx_pcie_unaligned_memaccess() and call it from a
common place. So, that errata workaround is applied for both modes of
operation.

Reported-by: Chris Welch <Chris.Welch@viavisolutions.com>
Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/pci/dwc/pci-dra7xx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index e77a4ceed74c..53f721d1cc40 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -546,7 +546,7 @@ static const struct of_device_id of_dra7xx_pcie_match[] = {
 };
 
 /*
- * dra7xx_pcie_ep_unaligned_memaccess: workaround for AM572x/AM571x Errata i870
+ * dra7xx_pcie_unaligned_memaccess: workaround for AM572x/AM571x Errata i870
  * @dra7xx: the dra7xx device where the workaround should be applied
  *
  * Access to the PCIe slave port that are not 32-bit aligned will result
@@ -556,7 +556,7 @@ static const struct of_device_id of_dra7xx_pcie_match[] = {
  *
  * To avoid this issue set PCIE_SS1_AXI2OCP_LEGACY_MODE_ENABLE to 1.
  */
-static int dra7xx_pcie_ep_unaligned_memaccess(struct device *dev)
+static int dra7xx_pcie_unaligned_memaccess(struct device *dev)
 {
 	int ret;
 	struct device_node *np = dev->of_node;
@@ -703,6 +703,10 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 	if (dra7xx->link_gen < 0 || dra7xx->link_gen > 2)
 		dra7xx->link_gen = 2;
 
+	ret = dra7xx_pcie_unaligned_memaccess(dev);
+	if (ret)
+		goto err_gpio;
+
 	switch (mode) {
 	case DW_PCIE_RC_TYPE:
 		dra7xx_pcie_writel(dra7xx, PCIECTRL_TI_CONF_DEVICE_TYPE,
@@ -715,10 +719,6 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 		dra7xx_pcie_writel(dra7xx, PCIECTRL_TI_CONF_DEVICE_TYPE,
 				   DEVICE_TYPE_EP);
 
-		ret = dra7xx_pcie_ep_unaligned_memaccess(dev);
-		if (ret)
-			goto err_gpio;
-
 		ret = dra7xx_add_pcie_ep(dra7xx, pdev);
 		if (ret < 0)
 			goto err_gpio;
-- 
2.15.0
