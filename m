Return-Path: <linux-kernel-owner@vger.kernel.org>
From: WingMan Kwok <w-kwok2@ti.com>
To: <robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<kishon@ti.com>, <rogerq@ti.com>, <m-karicheri2@ti.com>,
	<bhelgaas@google.com>, <ssantosh@kernel.org>,
	<linux@arm.linux.org.uk>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: WingMan Kwok <w-kwok2@ti.com>
Subject: [PATCH v2 2/2] PCI: keystone: update to use generic keystone serdes driver
Date: Mon, 19 Oct 2015 14:57:20 -0400
Message-ID: <1445281040-14742-3-git-send-email-w-kwok2@ti.com>
In-Reply-To: <1445281040-14742-1-git-send-email-w-kwok2@ti.com>
References: <1445281040-14742-1-git-send-email-w-kwok2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch updates the Keystone PCI driver to use the
generic Keystone serdes driver for serdes initialization
and configuration.  The generic serdes driver supports
peripherals on Keystone platforms that require serdes.

Signed-off-by: WingMan Kwok <w-kwok2@ti.com>
---
 drivers/pci/host/pci-keystone.c |   24 ++++++++++++++----------
 drivers/pci/host/pci-keystone.h |    1 +
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/host/pci-keystone.c b/drivers/pci/host/pci-keystone.c
index 0aa81bd..4cc8faa 100644
--- a/drivers/pci/host/pci-keystone.c
+++ b/drivers/pci/host/pci-keystone.c
@@ -335,6 +335,7 @@ static int __exit ks_pcie_remove(struct platform_device *pdev)
 {
 	struct keystone_pcie *ks_pcie = platform_get_drvdata(pdev);
 
+	phy_exit(ks_pcie->serdes_phy);
 	clk_disable_unprepare(ks_pcie->clk);
 
 	return 0;
@@ -342,12 +343,12 @@ static int __exit ks_pcie_remove(struct platform_device *pdev)
 
 static int __init ks_pcie_probe(struct platform_device *pdev)
 {
+	struct device_node *node = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
 	struct keystone_pcie *ks_pcie;
 	struct pcie_port *pp;
 	struct resource *res;
 	void __iomem *reg_p;
-	struct phy *phy;
 	int ret = 0;
 
 	ks_pcie = devm_kzalloc(&pdev->dev, sizeof(*ks_pcie),
@@ -357,14 +358,6 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 
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
@@ -385,6 +378,17 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ks_pcie->serdes_phy = devm_of_phy_get(dev, node, NULL);
+	if (IS_ERR(ks_pcie->serdes_phy)) {
+		dev_err(dev, "No %s serdes driver found: %ld\n",
+			node->name, PTR_ERR(ks_pcie->serdes_phy));
+		goto fail_clk;
+	}
+
+	ret = phy_init(ks_pcie->serdes_phy);
+	if (ret < 0)
+		goto fail_clk;
+
 	ret = ks_add_pcie_port(ks_pcie, pdev);
 	if (ret < 0)
 		goto fail_clk;
@@ -392,7 +396,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	return 0;
 fail_clk:
 	clk_disable_unprepare(ks_pcie->clk);
-
+	phy_exit(ks_pcie->serdes_phy);
 	return ret;
 }
 
diff --git a/drivers/pci/host/pci-keystone.h b/drivers/pci/host/pci-keystone.h
index 478d932..1e6d122 100644
--- a/drivers/pci/host/pci-keystone.h
+++ b/drivers/pci/host/pci-keystone.h
@@ -33,6 +33,7 @@ struct keystone_pcie {
 	/* Application register space */
 	void __iomem		*va_app_base;
 	struct resource		app;
+	struct phy		*serdes_phy;
 };
 
 /* Keystone DW specific MSI controller APIs/definitions */
-- 
1.7.9.5

