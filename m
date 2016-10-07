Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938918AbcJGQY2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:24:28 -0400
Subject: [PATCH 2/2] PCI: mvebu: Add local struct device pointers
To: Jason Cooper <jason@lakedaemon.net>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:24:24 -0500
Message-ID: <20161007162424.23224.78877.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007162416.23224.35628.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007162416.23224.35628.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use a local "struct device *dev" for brevity and consistency with other
drivers.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-mvebu.c |   17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 9243dcd..db62b71 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -1188,13 +1188,13 @@ static void mvebu_pcie_powerdown(struct mvebu_pcie_port *port)
 
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
+	pcie = devm_kzalloc(dev, sizeof(struct mvebu_pcie), GFP_KERNEL);
 	if (!pcie)
 		return -ENOMEM;
 
@@ -1204,7 +1204,7 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 	/* Get the PCIe memory and I/O aperture */
 	mvebu_mbus_get_pcie_mem_aperture(&pcie->mem);
 	if (resource_size(&pcie->mem) == 0) {
-		dev_err(&pdev->dev, "invalid memory aperture size\n");
+		dev_err(dev, "invalid memory aperture size\n");
 		return -EINVAL;
 	}
 
@@ -1222,15 +1222,13 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 	/* Get the bus range */
 	ret = of_pci_parse_bus_range(np, &pcie->busn);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to parse bus-range property: %d\n",
-			ret);
+		dev_err(dev, "failed to parse bus-range property: %d\n", ret);
 		return ret;
 	}
 
 	num = of_get_available_child_count(pdev->dev.of_node);
 
-	pcie->ports = devm_kcalloc(&pdev->dev, num, sizeof(*pcie->ports),
-				   GFP_KERNEL);
+	pcie->ports = devm_kcalloc(dev, num, sizeof(*pcie->ports), GFP_KERNEL);
 	if (!pcie->ports)
 		return -ENOMEM;
 
@@ -1264,8 +1262,7 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 
 		port->base = mvebu_pcie_map_registers(pdev, child, port);
 		if (IS_ERR(port->base)) {
-			dev_err(&pdev->dev, "%s: cannot map registers\n",
-				port->name);
+			dev_err(dev, "%s: cannot map registers\n", port->name);
 			port->base = NULL;
 			mvebu_pcie_powerdown(port);
 			continue;

