Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:24705 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965366AbdAKMHW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2017 07:07:22 -0500
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <nsekhar@ti.com>, <kishon@ti.com>
Subject: [PATCH 5/5] PCI: dwc: dra7xx: Group phy API invocations
Date: Wed, 11 Jan 2017 17:36:55 +0530
Message-ID: <1484136415-20798-6-git-send-email-kishon@ti.com>
In-Reply-To: <1484136415-20798-1-git-send-email-kishon@ti.com>
References: <1484136415-20798-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

No functional change. Phy APIs like phy_init/phy_power_on is
being invoked from multiple places. Group all the phy APIs in
dra7xx_pcie_enable_phy() and dra7xx_pcie_disable_phy() and use
these functions for enabling or disabling the phy.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/dwc/pci-dra7xx.c |   92 +++++++++++++++++++++++-------------------
 1 file changed, 51 insertions(+), 41 deletions(-)

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index af330d7..ec5617a 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -324,6 +324,45 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
 	return 0;
 }
 
+static void dra7xx_pcie_disable_phy(struct dra7xx_pcie *dra7xx)
+{
+	int phy_count = dra7xx->phy_count;
+
+	while (phy_count--) {
+		phy_power_off(dra7xx->phy[phy_count]);
+		phy_exit(dra7xx->phy[phy_count]);
+	}
+}
+
+static int dra7xx_pcie_enable_phy(struct dra7xx_pcie *dra7xx)
+{
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
 static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 {
 	u32 reg;
@@ -382,22 +421,18 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 		phy[i] = devm_phy_get(dev, name);
 		if (IS_ERR(phy[i]))
 			return PTR_ERR(phy[i]);
-
-		ret = phy_init(phy[i]);
-		if (ret < 0)
-			goto err_phy;
-
-		ret = phy_power_on(phy[i]);
-		if (ret < 0) {
-			phy_exit(phy[i]);
-			goto err_phy;
-		}
 	}
 
 	dra7xx->base = base;
 	dra7xx->phy = phy;
 	dra7xx->phy_count = phy_count;
 
+	ret = dra7xx_pcie_enable_phy(dra7xx);
+	if (ret) {
+		dev_err(dev, "failed to enable phy\n");
+		return ret;
+	}
+
 	pm_runtime_enable(dev);
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0) {
@@ -432,12 +467,7 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 
 err_get_sync:
 	pm_runtime_disable(dev);
-
-err_phy:
-	while (--i >= 0) {
-		phy_power_off(phy[i]);
-		phy_exit(phy[i]);
-	}
+	dra7xx_pcie_disable_phy(dra7xx);
 
 	return ret;
 }
@@ -474,12 +504,8 @@ static int dra7xx_pcie_resume(struct device *dev)
 static int dra7xx_pcie_suspend_noirq(struct device *dev)
 {
 	struct dra7xx_pcie *dra7xx = dev_get_drvdata(dev);
-	int count = dra7xx->phy_count;
 
-	while (count--) {
-		phy_power_off(dra7xx->phy[count]);
-		phy_exit(dra7xx->phy[count]);
-	}
+	dra7xx_pcie_disable_phy(dra7xx);
 
 	return 0;
 }
@@ -487,31 +513,15 @@ static int dra7xx_pcie_suspend_noirq(struct device *dev)
 static int dra7xx_pcie_resume_noirq(struct device *dev)
 {
 	struct dra7xx_pcie *dra7xx = dev_get_drvdata(dev);
-	int phy_count = dra7xx->phy_count;
 	int ret;
-	int i;
-
-	for (i = 0; i < phy_count; i++) {
-		ret = phy_init(dra7xx->phy[i]);
-		if (ret < 0)
-			goto err_phy;
 
-		ret = phy_power_on(dra7xx->phy[i]);
-		if (ret < 0) {
-			phy_exit(dra7xx->phy[i]);
-			goto err_phy;
-		}
+	ret = dra7xx_pcie_enable_phy(dra7xx);
+	if (ret) {
+		dev_err(dev, "failed to enable phy\n");
+		return ret;
 	}
 
 	return 0;
-
-err_phy:
-	while (--i >= 0) {
-		phy_power_off(dra7xx->phy[i]);
-		phy_exit(dra7xx->phy[i]);
-	}
-
-	return ret;
 }
 #endif
 
-- 
1.7.9.5

