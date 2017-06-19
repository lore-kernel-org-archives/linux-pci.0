Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:30472 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754001AbdFSKAR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jun 2017 06:00:17 -0400
From: Ryder Lee <ryder.lee@mediatek.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 1/3] PCI: mediatek: modify controller powerup logic
Date: Mon, 19 Jun 2017 17:59:58 +0800
Message-ID: <1497866400-41844-2-git-send-email-ryder.lee@mediatek.com>
In-Reply-To: <1497866400-41844-1-git-send-email-ryder.lee@mediatek.com>
References: <1497866400-41844-1-git-send-email-ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The current powerup logic may lead to unbalanced pm_runtime_enable() if
the earlier probe failed due to -EPROBE_DEFER. Hence we do a little flow
adjustment to avoid that:

Parse standard PCI resources firstly, then check properties for each port,
power on controller finally.

Also, this patch removes unused registers and renames funtions properly.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/pci/host/pcie-mediatek.c | 51 +++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
index 3baafa8..165d82d 100644
--- a/drivers/pci/host/pcie-mediatek.c
+++ b/drivers/pci/host/pcie-mediatek.c
@@ -34,8 +34,6 @@
 
 /* PCIe per port registers */
 #define PCIE_BAR0_SETUP		0x10
-#define PCIE_BAR1_SETUP		0x14
-#define PCIE_BAR0_MEM_BASE	0x18
 #define PCIE_CLASS		0x34
 #define PCIE_LINK_STATUS	0x50
 
@@ -224,7 +222,7 @@ static void mtk_pcie_assert_ports(struct mtk_pcie_port *port)
 	msleep(100);
 }
 
-static int mtk_pcie_enable_ports(struct mtk_pcie_port *port)
+static void mtk_pcie_enable_ports(struct mtk_pcie_port *port)
 {
 	struct device *dev = port->pcie->dev;
 	int err;
@@ -249,7 +247,7 @@ static int mtk_pcie_enable_ports(struct mtk_pcie_port *port)
 	/* if link up, then setup root port configuration space */
 	if (mtk_pcie_link_is_up(port)) {
 		mtk_pcie_configure_rc(port);
-		return 0;
+		return;
 	}
 
 	dev_info(dev, "Port%d link down\n", port->index);
@@ -257,13 +255,13 @@ static int mtk_pcie_enable_ports(struct mtk_pcie_port *port)
 	phy_power_off(port->phy);
 err_phy_on:
 	clk_disable_unprepare(port->sys_ck);
-	mtk_pcie_port_free(port);
 err_sys_clk:
-	return err;
+	mtk_pcie_port_free(port);
+
+	return;
 }
 
 static int mtk_pcie_parse_ports(struct mtk_pcie *pcie,
-				struct mtk_pcie_port **p,
 				struct device_node *node,
 				int index)
 {
@@ -274,12 +272,10 @@ static int mtk_pcie_parse_ports(struct mtk_pcie *pcie,
 	char name[10];
 	int err;
 
-	*p = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
-	if (!*p)
+	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
+	if (!port)
 		return -ENOMEM;
 
-	port = *p;
-
 	err = of_property_read_u32(node, "num-lanes", &port->lane);
 	if (err) {
 		dev_err(dev, "missing num-lanes property\n");
@@ -323,7 +319,7 @@ static int mtk_pcie_parse_ports(struct mtk_pcie *pcie,
 	return 0;
 }
 
-static int mtk_pcie_handle_shared_resource(struct mtk_pcie *pcie)
+static int mtk_pcie_subsys_powerup(struct mtk_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
 	struct platform_device *pdev = to_platform_device(dev);
@@ -366,20 +362,16 @@ static int mtk_pcie_handle_shared_resource(struct mtk_pcie *pcie)
 	return err;
 }
 
-static int mtk_pcie_parse_and_add_res(struct mtk_pcie *pcie)
+static int mtk_pcie_setup(struct mtk_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
 	struct device_node *node = dev->of_node, *child;
 	struct of_pci_range_parser parser;
 	struct of_pci_range range;
 	struct resource res;
+	struct mtk_pcie_port *port, *tmp;
 	int err;
 
-	/* parse shared resources */
-	err = mtk_pcie_handle_shared_resource(pcie);
-	if (err)
-		return err;
-
 	if (of_pci_range_parser_init(&parser, node)) {
 		dev_err(dev, "missing \"ranges\" property\n");
 		return -EINVAL;
@@ -423,8 +415,7 @@ static int mtk_pcie_parse_and_add_res(struct mtk_pcie *pcie)
 		pcie->busn.flags = IORESOURCE_BUS;
 	}
 
-	for_each_child_of_node(node, child) {
-		struct mtk_pcie_port *port;
+	for_each_available_child_of_node(node, child) {
 		int index;
 
 		err = of_pci_get_devfn(child);
@@ -435,19 +426,19 @@ static int mtk_pcie_parse_and_add_res(struct mtk_pcie *pcie)
 
 		index = PCI_SLOT(err);
 
-		if (!of_device_is_available(child))
-			continue;
-
-		err = mtk_pcie_parse_ports(pcie, &port, child, index);
-		if (err)
-			return err;
-
-		/* enable each port, and then check link status */
-		err = mtk_pcie_enable_ports(port);
+		err = mtk_pcie_parse_ports(pcie, child, index);
 		if (err)
 			return err;
 	}
 
+	err = mtk_pcie_subsys_powerup(pcie);
+	if (err)
+		return err;
+
+	/* enable each port, and then check link status */
+	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
+		mtk_pcie_enable_ports(port);
+
 	return 0;
 }
 
@@ -516,7 +507,7 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, pcie);
 	INIT_LIST_HEAD(&pcie->ports);
 
-	err = mtk_pcie_parse_and_add_res(pcie);
+	err = mtk_pcie_setup(pcie);
 	if (err)
 		return err;
 
-- 
1.9.1
