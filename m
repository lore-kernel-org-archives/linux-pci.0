Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:45712 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751550AbdJIJEL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Oct 2017 05:04:11 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: Roger Quadros <rogerq@ti.com>, <linux-omap@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nsekhar@ti.com>
Subject: [PATCH 1/2] PCI: dwc: dra7xx: Create functional dependency between PCIe and PHY
Date: Mon, 9 Oct 2017 14:33:37 +0530
Message-ID: <20171009090338.26033-2-kishon@ti.com>
In-Reply-To: <20171009090338.26033-1-kishon@ti.com>
References: <20171009090338.26033-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI core access configuration space registers in resume_noirq callbacks.
In the case of dra7xx, PIPE3 PHY connected to PCIe controller has to be
enabled before accessing configuration space registers. Since
PIPE3 PHY is enabled by only configuring control module registers, no
aborts has been observed so far (though during noirq stage, interface
clock of PIPE3 PHY is not enabled).

With new TRM updates, PIPE3 PHY has to be initialized (PIPE3 PHY
registers has to be accessed) as well which requires the interface
clock of PIPE3 PHY to be enabled. The interface clock of PIPE3 PHY is
derived from OCP2SCP and hence PCIe PHY is modeled as a child of
OCP2SCP. Since pm_runtime is not enabled during noirq stage,
pm_runtime_get_sync done in phy_init doesn't enable
OCP2SCP clocks resulting in abort when PIPE3 PHY registers are
accessed.

Create a function dependency between PCIe and PHY here to make
sure PCIe is suspended before PCIe PHY/OCP2SCP and resumed after
PCIe PHY/OCP2SCP.

Suggested-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/pci/dwc/pci-dra7xx.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index 34427a6a15af..362607f727ee 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
@@ -594,6 +595,7 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 	int i;
 	int phy_count;
 	struct phy **phy;
+	struct device_link **link;
 	void __iomem *base;
 	struct resource *res;
 	struct dw_pcie *pci;
@@ -649,11 +651,21 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 	if (!phy)
 		return -ENOMEM;
 
+	link = devm_kzalloc(dev, sizeof(*link) * phy_count, GFP_KERNEL);
+	if (!link)
+		return -ENOMEM;
+
 	for (i = 0; i < phy_count; i++) {
 		snprintf(name, sizeof(name), "pcie-phy%d", i);
 		phy[i] = devm_phy_get(dev, name);
 		if (IS_ERR(phy[i]))
 			return PTR_ERR(phy[i]);
+
+		link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
+		if (!link[i]) {
+			ret = -EINVAL;
+			goto err_link;
+		}
 	}
 
 	dra7xx->base = base;
@@ -732,6 +744,10 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 	pm_runtime_disable(dev);
 	dra7xx_pcie_disable_phy(dra7xx);
 
+err_link:
+	while (--i >= 0)
+		device_link_del(link[i]);
+
 	return ret;
 }
 
-- 
2.11.0
