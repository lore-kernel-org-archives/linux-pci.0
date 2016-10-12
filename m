Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933306AbcJLNVa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:21:30 -0400
Subject: [PATCH v2 1/2] PCI: mvebu: Add local struct device pointers
To: Jason Cooper <jason@lakedaemon.net>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 07:55:58 -0500
Message-ID: <20161012125558.24580.25020.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012125403.24580.74990.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012125403.24580.74990.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use a local "struct device *dev" for brevity and consistency with other
drivers.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-mvebu.c |   21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 307f81d..2515200 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -1190,13 +1190,13 @@ static void mvebu_pcie_powerdown(struct mvebu_pcie_port *port)
 
 static int mvebu_pcie_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct mvebu_pcie *pcie;
-	struct device_node *np = pdev->dev.of_node;
+	struct device_node *np = dev->of_node;
 	struct device_node *child;
 	int num, i, ret;
 
-	pcie = devm_kzalloc(&pdev->dev, sizeof(struct mvebu_pcie),
-			    GFP_KERNEL);
+	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
 	if (!pcie)
 		return -ENOMEM;
 
@@ -1206,7 +1206,7 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 	/* Get the PCIe memory and I/O aperture */
 	mvebu_mbus_get_pcie_mem_aperture(&pcie->mem);
 	if (resource_size(&pcie->mem) == 0) {
-		dev_err(&pdev->dev, "invalid memory aperture size\n");
+		dev_err(dev, "invalid memory aperture size\n");
 		return -EINVAL;
 	}
 
@@ -1224,20 +1224,18 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 	/* Get the bus range */
 	ret = of_pci_parse_bus_range(np, &pcie->busn);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to parse bus-range property: %d\n",
-			ret);
+		dev_err(dev, "failed to parse bus-range property: %d\n", ret);
 		return ret;
 	}
 
-	num = of_get_available_child_count(pdev->dev.of_node);
+	num = of_get_available_child_count(dev->of_node);
 
-	pcie->ports = devm_kcalloc(&pdev->dev, num, sizeof(*pcie->ports),
-				   GFP_KERNEL);
+	pcie->ports = devm_kcalloc(dev, num, sizeof(*pcie->ports), GFP_KERNEL);
 	if (!pcie->ports)
 		return -ENOMEM;
 
 	i = 0;
-	for_each_available_child_of_node(pdev->dev.of_node, child) {
+	for_each_available_child_of_node(dev->of_node, child) {
 		struct mvebu_pcie_port *port = &pcie->ports[i];
 
 		ret = mvebu_pcie_parse_port(pcie, port, child);
@@ -1266,8 +1264,7 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 
 		port->base = mvebu_pcie_map_registers(pdev, child, port);
 		if (IS_ERR(port->base)) {
-			dev_err(&pdev->dev, "%s: cannot map registers\n",
-				port->name);
+			dev_err(dev, "%s: cannot map registers\n", port->name);
 			port->base = NULL;
 			mvebu_pcie_powerdown(port);
 			continue;

