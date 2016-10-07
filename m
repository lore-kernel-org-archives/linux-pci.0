Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932268AbcJGQV1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:21:27 -0400
Subject: [PATCH 4/5] PCI: aardvark: Add local struct device pointers
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date: Fri, 07 Oct 2016 11:21:23 -0500
Message-ID: <20161007162122.22668.25538.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007162053.22668.91420.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007162053.22668.91420.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use a local "struct device *dev" for brevity and consistency with other
drivers.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-aardvark.c |   36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
index af6312a..b255a08 100644
--- a/drivers/pci/host/pci-aardvark.c
+++ b/drivers/pci/host/pci-aardvark.c
@@ -230,19 +230,20 @@ static int advk_pcie_link_up(struct advk_pcie *advk)
 
 static int advk_pcie_wait_for_link(struct advk_pcie *advk)
 {
+	struct device *dev = &advk->pdev->dev;
 	int retries;
 
 	/* check if the link is up or not */
 	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
 		if (advk_pcie_link_up(advk)) {
-			dev_info(&advk->pdev->dev, "link up\n");
+			dev_info(dev, "link up\n");
 			return 0;
 		}
 
 		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
 	}
 
-	dev_err(&advk->pdev->dev, "link never came up\n");
+	dev_err(dev, "link never came up\n");
 
 	return -ETIMEDOUT;
 }
@@ -376,6 +377,7 @@ static void advk_pcie_setup_hw(struct advk_pcie *advk)
 
 static void advk_pcie_check_pio_status(struct advk_pcie *advk)
 {
+	struct device *dev = &advk->pdev->dev;
 	u32 reg;
 	unsigned int status;
 	char *strcomp_status, *str_posted;
@@ -407,12 +409,13 @@ static void advk_pcie_check_pio_status(struct advk_pcie *advk)
 	else
 		str_posted = "Posted";
 
-	dev_err(&advk->pdev->dev, "%s PIO Response Status: %s, %#x @ %#x\n",
+	dev_err(dev, "%s PIO Response Status: %s, %#x @ %#x\n",
 		str_posted, strcomp_status, reg, advk_readl(advk, PIO_ADDR_LS));
 }
 
 static int advk_pcie_wait_pio(struct advk_pcie *advk)
 {
+	struct device *dev = &advk->pdev->dev;
 	unsigned long timeout;
 
 	timeout = jiffies + msecs_to_jiffies(PIO_TIMEOUT_MS);
@@ -426,7 +429,7 @@ static int advk_pcie_wait_pio(struct advk_pcie *advk)
 			return 0;
 	}
 
-	dev_err(&advk->pdev->dev, "config read/write timed out\n");
+	dev_err(dev, "config read/write timed out\n");
 	return -ETIMEDOUT;
 }
 
@@ -560,10 +563,11 @@ static int advk_pcie_alloc_msi(struct advk_pcie *advk)
 
 static void advk_pcie_free_msi(struct advk_pcie *advk, int hwirq)
 {
+	struct device *dev = &advk->pdev->dev;
+
 	mutex_lock(&advk->msi_used_lock);
 	if (!test_bit(hwirq, advk->msi_irq_in_use))
-		dev_err(&advk->pdev->dev, "trying to free unused MSI#%d\n",
-			hwirq);
+		dev_err(dev, "trying to free unused MSI#%d\n", hwirq);
 	else
 		clear_bit(hwirq, advk->msi_irq_in_use);
 	mutex_unlock(&advk->msi_used_lock);
@@ -905,6 +909,7 @@ out_release_res:
 
 static int advk_pcie_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct advk_pcie *advk;
 	struct resource *res;
 	struct pci_bus *bus, *child;
@@ -912,8 +917,7 @@ static int advk_pcie_probe(struct platform_device *pdev)
 	struct device_node *msi_node;
 	int ret, irq;
 
-	advk = devm_kzalloc(&pdev->dev, sizeof(struct advk_pcie),
-			    GFP_KERNEL);
+	advk = devm_kzalloc(dev, sizeof(struct advk_pcie), GFP_KERNEL);
 	if (!advk)
 		return -ENOMEM;
 
@@ -921,22 +925,22 @@ static int advk_pcie_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, advk);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	advk->base = devm_ioremap_resource(&pdev->dev, res);
+	advk->base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(advk->base))
 		return PTR_ERR(advk->base);
 
 	irq = platform_get_irq(pdev, 0);
-	ret = devm_request_irq(&pdev->dev, irq, advk_pcie_irq_handler,
+	ret = devm_request_irq(dev, irq, advk_pcie_irq_handler,
 			       IRQF_SHARED | IRQF_NO_THREAD, "advk-pcie",
 			       advk);
 	if (ret) {
-		dev_err(&pdev->dev, "Failed to register interrupt\n");
+		dev_err(dev, "Failed to register interrupt\n");
 		return ret;
 	}
 
 	ret = advk_pcie_parse_request_of_pci_ranges(advk);
 	if (ret) {
-		dev_err(&pdev->dev, "Failed to parse resources\n");
+		dev_err(dev, "Failed to parse resources\n");
 		return ret;
 	}
 
@@ -944,24 +948,24 @@ static int advk_pcie_probe(struct platform_device *pdev)
 
 	ret = advk_pcie_init_irq_domain(advk);
 	if (ret) {
-		dev_err(&pdev->dev, "Failed to initialize irq\n");
+		dev_err(dev, "Failed to initialize irq\n");
 		return ret;
 	}
 
 	ret = advk_pcie_init_msi_irq_domain(advk);
 	if (ret) {
-		dev_err(&pdev->dev, "Failed to initialize irq\n");
+		dev_err(dev, "Failed to initialize irq\n");
 		advk_pcie_remove_irq_domain(advk);
 		return ret;
 	}
 
-	msi_node = of_parse_phandle(pdev->dev.of_node, "msi-parent", 0);
+	msi_node = of_parse_phandle(dev->of_node, "msi-parent", 0);
 	if (msi_node)
 		msi = of_pci_find_msi_chip_by_node(msi_node);
 	else
 		msi = NULL;
 
-	bus = pci_scan_root_bus_msi(&pdev->dev, 0, &advk_pcie_ops,
+	bus = pci_scan_root_bus_msi(dev, 0, &advk_pcie_ops,
 				    advk, &advk->resources, &advk->msi);
 	if (!bus) {
 		advk_pcie_remove_msi_irq_domain(advk);

