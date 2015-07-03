Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<pratyush.anand@gmail.com>, <linux-omap@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kishon@ti.com>
CC: <nsekhar@ti.com>
Subject: [PATCH 3/3] PCI: host: pci-dra7xx: add pm support to pci dra7xx
Date: Fri, 3 Jul 2015 16:33:45 +0530
Message-ID: <1435921425-15121-4-git-send-email-kishon@ti.com>
In-Reply-To: <1435921425-15121-1-git-send-email-kishon@ti.com>
References: <1435921425-15121-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add PM support to pci-dra7xx so that PCI clocks can be disabled
during suspend and enabled back during resume without affecting
PCI functionality.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/host/pci-dra7xx.c |   74 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
index d8b6d66..1f5c039 100644
--- a/drivers/pci/host/pci-dra7xx.c
+++ b/drivers/pci/host/pci-dra7xx.c
@@ -433,6 +433,79 @@ static int __exit dra7xx_pcie_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int dra7xx_pcie_suspend(struct device *dev)
+{
+	struct dra7xx_pcie *dra7xx = dev_get_drvdata(dev);
+	struct pcie_port *pp = &dra7xx->pp;
+
+	dw_pcie_suspend_rc(pp);
+
+	return 0;
+}
+
+static int dra7xx_pcie_resume(struct device *dev)
+{
+	struct dra7xx_pcie *dra7xx = dev_get_drvdata(dev);
+	struct pcie_port *pp = &dra7xx->pp;
+
+	dw_pcie_resume_rc(pp);
+
+	return 0;
+}
+static int dra7xx_pcie_suspend_noirq(struct device *dev)
+{
+	struct dra7xx_pcie *dra7xx = dev_get_drvdata(dev);
+	int count = dra7xx->phy_count;
+
+	while (count--) {
+		phy_power_off(dra7xx->phy[count]);
+		phy_exit(dra7xx->phy[count]);
+	}
+
+	return 0;
+}
+static int dra7xx_pcie_resume_noirq(struct device *dev)
+{
+	struct dra7xx_pcie *dra7xx = dev_get_drvdata(dev);
+	int phy_count = dra7xx->phy_count;
+	int ret;
+	int i;
+
+	for (i = 0; i < phy_count; i++) {
+		ret = phy_init(dra7xx->phy[i]);
+		if (ret < 0)
+			goto err_phy;
+
+		ret = phy_power_on(dra7xx->phy[i]);
+		if (ret < 0) {
+			phy_exit(dra7xx->phy[i]);
+			goto err_phy;
+		}
+	}
+
+	return 0;
+
+err_phy:
+	while (--i >= 0) {
+		phy_power_off(dra7xx->phy[i]);
+		phy_exit(dra7xx->phy[i]);
+	}
+
+	return ret;
+}
+
+static const struct dev_pm_ops dra7xx_pcie_pm_ops = {
+	.suspend_noirq = dra7xx_pcie_suspend_noirq,
+	.suspend = dra7xx_pcie_suspend,
+	.resume_noirq = dra7xx_pcie_resume_noirq,
+	.resume = dra7xx_pcie_resume,
+};
+#define DEV_PM_OPS	(&dra7xx_pcie_pm_ops)
+#else
+#define DEV_PM_OPS	NULL
+#endif
+
 static const struct of_device_id of_dra7xx_pcie_match[] = {
 	{ .compatible = "ti,dra7-pcie", },
 	{},
@@ -444,6 +517,7 @@ static struct platform_driver dra7xx_pcie_driver = {
 	.driver = {
 		.name	= "dra7-pcie",
 		.of_match_table = of_dra7xx_pcie_match,
+		.pm	= DEV_PM_OPS,
 	},
 };
 
-- 
1.7.9.5

