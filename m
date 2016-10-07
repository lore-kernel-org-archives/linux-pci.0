Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938860AbcJGQZR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:25:17 -0400
Subject: [PATCH 04/10] PCI: rcar: Add local struct device pointers
To: Simon Horman <horms@verge.net.au>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:25:12 -0500
Message-ID: <20161007162512.23279.56747.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007162446.23279.48813.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007162446.23279.48813.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use a local "struct device *dev" for brevity and consistency with other
drivers.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-rcar.c |   92 +++++++++++++++++++++---------------------
 1 file changed, 47 insertions(+), 45 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index cd777e8..c28ac93 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -395,6 +395,7 @@ static int rcar_pcie_setup(struct list_head *resource, struct rcar_pcie *pci)
 
 static void rcar_pcie_force_speedup(struct rcar_pcie *rcar)
 {
+	struct device *dev = rcar->dev;
 	unsigned int timeout = 1000;
 	u32 macsr;
 
@@ -402,7 +403,7 @@ static void rcar_pcie_force_speedup(struct rcar_pcie *rcar)
 		return;
 
 	if (rcar_readl(rcar, MACCTLR) & SPEED_CHANGE) {
-		dev_err(rcar->dev, "Speed change already in progress\n");
+		dev_err(dev, "Speed change already in progress\n");
 		return;
 	}
 
@@ -431,7 +432,7 @@ static void rcar_pcie_force_speedup(struct rcar_pcie *rcar)
 			rcar_writel(rcar, MACSR, macsr);
 
 			if (macsr & SPCHGFAIL)
-				dev_err(rcar->dev, "Speed change failed\n");
+				dev_err(dev, "Speed change failed\n");
 
 			goto done;
 		}
@@ -439,15 +440,16 @@ static void rcar_pcie_force_speedup(struct rcar_pcie *rcar)
 		msleep(1);
 	};
 
-	dev_err(rcar->dev, "Speed change timed out\n");
+	dev_err(dev, "Speed change timed out\n");
 
 done:
-	dev_info(rcar->dev, "Current link speed is %s GT/s\n",
+	dev_info(dev, "Current link speed is %s GT/s\n",
 		 (macsr & LINK_SPEED) == LINK_SPEED_5_0GTS ? "5" : "2.5");
 }
 
 static int rcar_pcie_enable(struct rcar_pcie *rcar)
 {
+	struct device *dev = rcar->dev;
 	struct pci_bus *bus, *child;
 	LIST_HEAD(res);
 
@@ -459,14 +461,14 @@ static int rcar_pcie_enable(struct rcar_pcie *rcar)
 	pci_add_flags(PCI_REASSIGN_ALL_RSRC | PCI_REASSIGN_ALL_BUS);
 
 	if (IS_ENABLED(CONFIG_PCI_MSI))
-		bus = pci_scan_root_bus_msi(rcar->dev, rcar->root_bus_nr,
+		bus = pci_scan_root_bus_msi(dev, rcar->root_bus_nr,
 				&rcar_pcie_ops, rcar, &res, &rcar->msi.chip);
 	else
-		bus = pci_scan_root_bus(rcar->dev, rcar->root_bus_nr,
+		bus = pci_scan_root_bus(dev, rcar->root_bus_nr,
 				&rcar_pcie_ops, rcar, &res);
 
 	if (!bus) {
-		dev_err(rcar->dev, "Scanning rootbus failed");
+		dev_err(dev, "Scanning rootbus failed");
 		return -ENODEV;
 	}
 
@@ -479,12 +481,12 @@ static int rcar_pcie_enable(struct rcar_pcie *rcar)
 		pcie_bus_configure_settings(child);
 
 	pci_bus_add_devices(bus);
-
 	return 0;
 }
 
 static int phy_wait_for_ack(struct rcar_pcie *rcar)
 {
+	struct device *dev = rcar->dev;
 	unsigned int timeout = 100;
 
 	while (timeout--) {
@@ -494,8 +496,7 @@ static int phy_wait_for_ack(struct rcar_pcie *rcar)
 		udelay(100);
 	}
 
-	dev_err(rcar->dev, "Access to PCIe phy timed out\n");
-
+	dev_err(dev, "Access to PCIe phy timed out\n");
 	return -ETIMEDOUT;
 }
 
@@ -694,6 +695,7 @@ static void rcar_msi_free(struct rcar_msi *chip, unsigned long irq)
 static irqreturn_t rcar_pcie_msi_irq(int irq, void *data)
 {
 	struct rcar_pcie *rcar = data;
+	struct device *dev = rcar->dev;
 	struct rcar_msi *msi = &rcar->msi;
 	unsigned long reg;
 
@@ -715,10 +717,10 @@ static irqreturn_t rcar_pcie_msi_irq(int irq, void *data)
 			if (test_bit(index, msi->used))
 				generic_handle_irq(irq);
 			else
-				dev_info(rcar->dev, "unhandled MSI\n");
+				dev_info(dev, "unhandled MSI\n");
 		} else {
 			/* Unknown MSI, just clear it */
-			dev_dbg(rcar->dev, "unexpected MSI\n");
+			dev_dbg(dev, "unexpected MSI\n");
 		}
 
 		/* see if there's any more pending in this vector */
@@ -841,22 +843,22 @@ static const struct irq_domain_ops msi_domain_ops = {
 
 static int rcar_pcie_enable_msi(struct rcar_pcie *rcar)
 {
-	struct platform_device *pdev = to_platform_device(rcar->dev);
+	struct device *dev = rcar->dev;
 	struct rcar_msi *msi = &rcar->msi;
 	unsigned long base;
 	int err, i;
 
 	mutex_init(&msi->lock);
 
-	msi->chip.dev = rcar->dev;
+	msi->chip.dev = dev;
 	msi->chip.setup_irq = rcar_msi_setup_irq;
 	msi->chip.setup_irqs = rcar_msi_setup_irqs;
 	msi->chip.teardown_irq = rcar_msi_teardown_irq;
 
-	msi->domain = irq_domain_add_linear(rcar->dev->of_node, INT_PCI_MSI_NR,
+	msi->domain = irq_domain_add_linear(dev->of_node, INT_PCI_MSI_NR,
 					    &msi_domain_ops, &msi->chip);
 	if (!msi->domain) {
-		dev_err(&pdev->dev, "failed to create IRQ domain\n");
+		dev_err(dev, "failed to create IRQ domain\n");
 		return -ENOMEM;
 	}
 
@@ -864,19 +866,19 @@ static int rcar_pcie_enable_msi(struct rcar_pcie *rcar)
 		irq_create_mapping(msi->domain, i);
 
 	/* Two irqs are for MSI, but they are also used for non-MSI irqs */
-	err = devm_request_irq(&pdev->dev, msi->irq1, rcar_pcie_msi_irq,
+	err = devm_request_irq(dev, msi->irq1, rcar_pcie_msi_irq,
 			       IRQF_SHARED | IRQF_NO_THREAD,
 			       rcar_msi_irq_chip.name, rcar);
 	if (err < 0) {
-		dev_err(&pdev->dev, "failed to request IRQ: %d\n", err);
+		dev_err(dev, "failed to request IRQ: %d\n", err);
 		goto err;
 	}
 
-	err = devm_request_irq(&pdev->dev, msi->irq2, rcar_pcie_msi_irq,
+	err = devm_request_irq(dev, msi->irq2, rcar_pcie_msi_irq,
 			       IRQF_SHARED | IRQF_NO_THREAD,
 			       rcar_msi_irq_chip.name, rcar);
 	if (err < 0) {
-		dev_err(&pdev->dev, "failed to request IRQ: %d\n", err);
+		dev_err(dev, "failed to request IRQ: %d\n", err);
 		goto err;
 	}
 
@@ -900,29 +902,30 @@ err:
 static int rcar_pcie_get_resources(struct platform_device *pdev,
 				   struct rcar_pcie *rcar)
 {
+	struct device *dev = rcar->dev;
 	struct resource res;
 	int err, i;
 
-	err = of_address_to_resource(pdev->dev.of_node, 0, &res);
+	err = of_address_to_resource(dev->of_node, 0, &res);
 	if (err)
 		return err;
 
-	rcar->base = devm_ioremap_resource(&pdev->dev, &res);
+	rcar->base = devm_ioremap_resource(dev, &res);
 	if (IS_ERR(rcar->base))
 		return PTR_ERR(rcar->base);
 
-	rcar->clk = devm_clk_get(&pdev->dev, "pcie");
+	rcar->clk = devm_clk_get(dev, "pcie");
 	if (IS_ERR(rcar->clk)) {
-		dev_err(rcar->dev, "cannot get platform clock\n");
+		dev_err(dev, "cannot get platform clock\n");
 		return PTR_ERR(rcar->clk);
 	}
 	err = clk_prepare_enable(rcar->clk);
 	if (err)
 		return err;
 
-	rcar->bus_clk = devm_clk_get(&pdev->dev, "pcie_bus");
+	rcar->bus_clk = devm_clk_get(dev, "pcie_bus");
 	if (IS_ERR(rcar->bus_clk)) {
-		dev_err(rcar->dev, "cannot get pcie bus clock\n");
+		dev_err(dev, "cannot get pcie bus clock\n");
 		err = PTR_ERR(rcar->bus_clk);
 		goto fail_clk;
 	}
@@ -930,17 +933,17 @@ static int rcar_pcie_get_resources(struct platform_device *pdev,
 	if (err)
 		goto fail_clk;
 
-	i = irq_of_parse_and_map(pdev->dev.of_node, 0);
+	i = irq_of_parse_and_map(dev->of_node, 0);
 	if (!i) {
-		dev_err(rcar->dev, "cannot get platform resources for msi interrupt\n");
+		dev_err(dev, "cannot get platform resources for msi interrupt\n");
 		err = -ENOENT;
 		goto err_map_reg;
 	}
 	rcar->msi.irq1 = i;
 
-	i = irq_of_parse_and_map(pdev->dev.of_node, 1);
+	i = irq_of_parse_and_map(dev->of_node, 1);
 	if (!i) {
-		dev_err(rcar->dev, "cannot get platform resources for msi interrupt\n");
+		dev_err(dev, "cannot get platform resources for msi interrupt\n");
 		err = -ENOENT;
 		goto err_map_reg;
 	}
@@ -952,7 +955,6 @@ err_map_reg:
 	clk_disable_unprepare(rcar->bus_clk);
 fail_clk:
 	clk_disable_unprepare(rcar->clk);
-
 	return err;
 }
 
@@ -1113,17 +1115,18 @@ out_release_res:
 
 static int rcar_pcie_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct rcar_pcie *rcar;
 	unsigned int data;
 	const struct of_device_id *of_id;
 	int err;
 	int (*hw_init_fn)(struct rcar_pcie *);
 
-	rcar = devm_kzalloc(&pdev->dev, sizeof(*rcar), GFP_KERNEL);
+	rcar = devm_kzalloc(dev, sizeof(*rcar), GFP_KERNEL);
 	if (!rcar)
 		return -ENOMEM;
 
-	rcar->dev = &pdev->dev;
+	rcar->dev = dev;
 	platform_set_drvdata(pdev, rcar);
 
 	INIT_LIST_HEAD(&rcar->resources);
@@ -1132,42 +1135,41 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 
 	err = rcar_pcie_get_resources(pdev, rcar);
 	if (err < 0) {
-		dev_err(&pdev->dev, "failed to request resources: %d\n", err);
+		dev_err(dev, "failed to request resources: %d\n", err);
 		return err;
 	}
 
-	err = rcar_pcie_parse_map_dma_ranges(rcar, pdev->dev.of_node);
+	err = rcar_pcie_parse_map_dma_ranges(rcar, dev->of_node);
 	if (err)
 		return err;
 
-	of_id = of_match_device(rcar_pcie_of_match, rcar->dev);
+	of_id = of_match_device(rcar_pcie_of_match, dev);
 	if (!of_id || !of_id->data)
 		return -EINVAL;
 	hw_init_fn = of_id->data;
 
-	pm_runtime_enable(rcar->dev);
-	err = pm_runtime_get_sync(rcar->dev);
+	pm_runtime_enable(dev);
+	err = pm_runtime_get_sync(dev);
 	if (err < 0) {
-		dev_err(rcar->dev, "pm_runtime_get_sync failed\n");
+		dev_err(dev, "pm_runtime_get_sync failed\n");
 		goto err_pm_disable;
 	}
 
 	/* Failure to get a link might just be that no cards are inserted */
 	err = hw_init_fn(rcar);
 	if (err) {
-		dev_info(&pdev->dev, "PCIe link down\n");
+		dev_info(dev, "PCIe link down\n");
 		err = 0;
 		goto err_pm_put;
 	}
 
 	data = rcar_readl(rcar, MACSR);
-	dev_info(&pdev->dev, "PCIe x%d: link up\n", (data >> 20) & 0x3f);
+	dev_info(dev, "PCIe x%d: link up\n", (data >> 20) & 0x3f);
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		err = rcar_pcie_enable_msi(rcar);
 		if (err < 0) {
-			dev_err(&pdev->dev,
-				"failed to enable MSI support: %d\n",
+			dev_err(dev, "failed to enable MSI support: %d\n",
 				err);
 			goto err_pm_put;
 		}
@@ -1180,10 +1182,10 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	return 0;
 
 err_pm_put:
-	pm_runtime_put(rcar->dev);
+	pm_runtime_put(dev);
 
 err_pm_disable:
-	pm_runtime_disable(rcar->dev);
+	pm_runtime_disable(dev);
 	return err;
 }
 

