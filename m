Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Keerthy <j-keerthy@ti.com>
To: <kishon@ti.com>, <bhelgaas@google.com>
CC: <t-kristo@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <j-keerthy@ti.com>
Subject: [PATCH] pci: dwc: dra7xx: Add shutdown handler to cleanly turn off clocks
Date: Wed, 6 Sep 2017 16:09:11 +0530
Message-ID: <1504694351-32358-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add shutdown handler to cleanly turn off clocks.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/pci/dwc/pci-dra7xx.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index d4e98f3..66d1cfe 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -874,6 +874,19 @@ static int dra7xx_pcie_suspend_noirq(struct device *dev)
 	return 0;
 }
 
+void dra7xx_pcie_shutdown(struct platform_device *pdev)
+{
+	struct dra7xx_pcie *dra7xx = dev_get_drvdata(&pdev->dev);
+	int ret;
+
+	ret = pm_runtime_put_sync(&pdev->dev);
+	if (ret < 0)
+		dev_dbg(&pdev->dev, "pm_runtime_put_sync failed\n");
+
+	pm_runtime_disable(&pdev->dev);
+	dra7xx_pcie_disable_phy(dra7xx);
+}
+
 static int dra7xx_pcie_resume_noirq(struct device *dev)
 {
 	struct dra7xx_pcie *dra7xx = dev_get_drvdata(dev);
@@ -902,5 +915,6 @@ static int dra7xx_pcie_resume_noirq(struct device *dev)
 		.suppress_bind_attrs = true,
 		.pm	= &dra7xx_pcie_pm_ops,
 	},
+	.shutdown = dra7xx_pcie_shutdown,
 };
 builtin_platform_driver_probe(dra7xx_pcie_driver, dra7xx_pcie_probe);
-- 
1.9.1
