Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57141 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753051AbbJMSGC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 13 Oct 2015 14:06:02 -0400
From: WingMan Kwok <w-kwok2@ti.com>
To: <robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<kishon@ti.com>, <rogerq@ti.com>, <m-karicheri2@ti.com>,
	<bhelgaas@google.com>, <ssantosh@kernel.org>,
	<linux@arm.linux.org.uk>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: WingMan Kwok <w-kwok2@ti.com>
Subject: [PATCH 2/3] PCI: keystone: update to use generic keystone serdes driver
Date: Tue, 13 Oct 2015 14:04:23 -0400
Message-ID: <1444759464-32299-3-git-send-email-w-kwok2@ti.com>
In-Reply-To: <1444759464-32299-1-git-send-email-w-kwok2@ti.com>
References: <1444759464-32299-1-git-send-email-w-kwok2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch updates the Keystone PCI driver to use the
generic Keystone serdes driver for serdes initialization
and configuration.  The generic serdes driver supports
peripherals on Keystone platforms that require serdes.

Signed-off-by: WingMan Kwok <w-kwok2@ti.com>
---
 drivers/pci/host/pci-keystone.c |   54 ++++++++++++++++++++++++++++++++-------
 drivers/pci/host/pci-keystone.h |    2 ++
 2 files changed, 47 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/host/pci-keystone.c b/drivers/pci/host/pci-keystone.c
index 0aa81bd..b4de05b 100644
--- a/drivers/pci/host/pci-keystone.c
+++ b/drivers/pci/host/pci-keystone.c
@@ -335,6 +335,7 @@ static int __exit ks_pcie_remove(struct platform_device *pdev)
 {
 	struct keystone_pcie *ks_pcie = platform_get_drvdata(pdev);
 
+	phy_exit(ks_pcie->serdes_phy);
 	clk_disable_unprepare(ks_pcie->clk);
 
 	return 0;
@@ -342,6 +343,8 @@ static int __exit ks_pcie_remove(struct platform_device *pdev)
 
 static int __init ks_pcie_probe(struct platform_device *pdev)
 {
+	struct device_node *node = pdev->dev.of_node;
+	struct device_node *serdeses_np, *child;
 	struct device *dev = &pdev->dev;
 	struct keystone_pcie *ks_pcie;
 	struct pcie_port *pp;
@@ -349,6 +352,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	void __iomem *reg_p;
 	struct phy *phy;
 	int ret = 0;
+	u32 phy_num;
 
 	ks_pcie = devm_kzalloc(&pdev->dev, sizeof(*ks_pcie),
 				GFP_KERNEL);
@@ -357,14 +361,6 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 
 	pp = &ks_pcie->pp;
 
-	/* initialize SerDes Phy if present */
-	phy = devm_phy_get(dev, "pcie-phy");
-	if (!IS_ERR_OR_NULL(phy)) {
-		ret = phy_init(phy);
-		if (ret < 0)
-			return ret;
-	}
-
 	/* index 2 is to read PCI DEVICE_ID */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
 	reg_p = devm_ioremap_resource(dev, res);
@@ -385,6 +381,46 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	serdeses_np = of_get_child_by_name(node, "serdeses");
+	if (serdeses_np) {
+		for_each_available_child_of_node(serdeses_np, child) {
+			ret = of_property_read_u32(child, "reg", &phy_num);
+			if (ret) {
+				dev_err(dev, "Failed to parse device tree\n");
+				of_node_put(child);
+				of_node_put(serdeses_np);
+				goto fail_clk;
+			}
+
+			if (phy_num >= MAX_NUM_PCI_SERDES) {
+				dev_err(dev, "Invalid phy number: %u\n",
+					phy_num);
+				of_node_put(child);
+				of_node_put(serdeses_np);
+				ret = -EINVAL;
+				goto fail_clk;
+			}
+
+			phy = devm_of_phy_get(dev, child, NULL);
+			of_node_put(child);
+			ks_pcie->serdes_phy = phy;
+			if (IS_ERR(phy)) {
+				dev_err(dev, "No %s serdes driver found: %ld\n",
+					node->name, PTR_ERR(phy));
+				of_node_put(serdeses_np);
+				ret = PTR_ERR(phy);
+				goto fail_clk;
+			}
+
+			ret = phy_init(phy);
+			if (ret < 0) {
+				of_node_put(serdeses_np);
+				goto fail_clk;
+			}
+		}
+		of_node_put(serdeses_np);
+	}
+
 	ret = ks_add_pcie_port(ks_pcie, pdev);
 	if (ret < 0)
 		goto fail_clk;
@@ -392,7 +428,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	return 0;
 fail_clk:
 	clk_disable_unprepare(ks_pcie->clk);
-
+	phy_exit(ks_pcie->serdes_phy);
 	return ret;
 }
 
diff --git a/drivers/pci/host/pci-keystone.h b/drivers/pci/host/pci-keystone.h
index 478d932..21662ba 100644
--- a/drivers/pci/host/pci-keystone.h
+++ b/drivers/pci/host/pci-keystone.h
@@ -15,6 +15,7 @@
 #define MAX_LEGACY_IRQS			4
 #define MAX_MSI_HOST_IRQS		8
 #define MAX_LEGACY_HOST_IRQS		4
+#define MAX_NUM_PCI_SERDES		1
 
 struct keystone_pcie {
 	struct	clk		*clk;
@@ -33,6 +34,7 @@ struct keystone_pcie {
 	/* Application register space */
 	void __iomem		*va_app_base;
 	struct resource		app;
+	struct phy		*serdes_phy;
 };
 
 /* Keystone DW specific MSI controller APIs/definitions */
-- 
1.7.9.5

