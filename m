Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:40224 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932239AbdIFN4U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Sep 2017 09:56:20 -0400
From: Keerthy <j-keerthy@ti.com>
To: <kishon@ti.com>, <bhelgaas@google.com>
CC: <t-kristo@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <j-keerthy@ti.com>
Subject: [PATCH v2] pci: dwc: dra7xx: Add shutdown handler to cleanly turn off clocks
Date: Wed, 6 Sep 2017 19:26:06 +0530
Message-ID: <1504706166-2854-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add shutdown handler to cleanly turn off clocks.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
---

Changes in v2:

  * used a local dev pointer instead of dereferencing dev at multiple places.
  * dra7xx_pcie_stop_link before disabling clks in the shutdown path.

 drivers/pci/dwc/pci-dra7xx.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index 0f9adf2..0d8307a 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -779,6 +779,22 @@ static int dra7xx_pcie_suspend_noirq(struct device *dev)
 	return 0;
 }
 
+void dra7xx_pcie_shutdown(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct dra7xx_pcie *dra7xx = dev_get_drvdata(dev);
+	int ret;
+
+	dra7xx_pcie_stop_link(dra7xx->pci);
+
+	ret = pm_runtime_put_sync(dev);
+	if (ret < 0)
+		dev_dbg(dev, "pm_runtime_put_sync failed\n");
+
+	pm_runtime_disable(dev);
+	dra7xx_pcie_disable_phy(dra7xx);
+}
+
 static int dra7xx_pcie_resume_noirq(struct device *dev)
 {
 	struct dra7xx_pcie *dra7xx = dev_get_drvdata(dev);
@@ -807,5 +823,6 @@ static int dra7xx_pcie_resume_noirq(struct device *dev)
 		.suppress_bind_attrs = true,
 		.pm	= &dra7xx_pcie_pm_ops,
 	},
+	.shutdown = dra7xx_pcie_shutdown,
 };
 builtin_platform_driver_probe(dra7xx_pcie_driver, dra7xx_pcie_probe);
-- 
1.9.1
