Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: [PATCH v2 1/2] PCI: aardvark: Add local struct device pointers
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 12 Oct 2016 07:36:35 -0500
Message-ID: <20161012123635.22186.83708.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012123001.22186.4053.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012123001.22186.4053.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Use a local "struct device *dev" for brevity and consistency with other
drivers.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/pci/host/pci-aardvark.c |   38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
index e4a5b7e..16421d1 100644
--- a/drivers/pci/host/pci-aardvark.c
+++ b/drivers/pci/host/pci-aardvark.c
@@ -230,20 +230,20 @@ static int advk_pcie_link_up(struct advk_pcie *pcie)
 
 static int advk_pcie_wait_for_link(struct advk_pcie *pcie)
 {
+	struct device *dev = &pcie->pdev->dev;
 	int retries;
 
 	/* check if the link is up or not */
 	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
 		if (advk_pcie_link_up(pcie)) {
-			dev_info(&pcie->pdev->dev, "link up\n");
+			dev_info(dev, "link up\n");
 			return 0;
 		}
 
 		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
 	}
 
-	dev_err(&pcie->pdev->dev, "link never came up\n");
-
+	dev_err(dev, "link never came up\n");
 	return -ETIMEDOUT;
 }
 
@@ -376,6 +376,7 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 
 static void advk_pcie_check_pio_status(struct advk_pcie *pcie)
 {
+	struct device *dev = &pcie->pdev->dev;
 	u32 reg;
 	unsigned int status;
 	char *strcomp_status, *str_posted;
@@ -407,12 +408,13 @@ static void advk_pcie_check_pio_status(struct advk_pcie *pcie)
 	else
 		str_posted = "Posted";
 
-	dev_err(&pcie->pdev->dev, "%s PIO Response Status: %s, %#x @ %#x\n",
+	dev_err(dev, "%s PIO Response Status: %s, %#x @ %#x\n",
 		str_posted, strcomp_status, reg, advk_readl(pcie, PIO_ADDR_LS));
 }
 
 static int advk_pcie_wait_pio(struct advk_pcie *pcie)
 {
+	struct device *dev = &pcie->pdev->dev;
 	unsigned long timeout;
 
 	timeout = jiffies + msecs_to_jiffies(PIO_TIMEOUT_MS);
@@ -426,7 +428,7 @@ static int advk_pcie_wait_pio(struct advk_pcie *pcie)
 			return 0;
 	}
 
-	dev_err(&pcie->pdev->dev, "config read/write timed out\n");
+	dev_err(dev, "config read/write timed out\n");
 	return -ETIMEDOUT;
 }
 
@@ -560,10 +562,11 @@ static int advk_pcie_alloc_msi(struct advk_pcie *pcie)
 
 static void advk_pcie_free_msi(struct advk_pcie *pcie, int hwirq)
 {
+	struct device *dev = &pcie->pdev->dev;
+
 	mutex_lock(&pcie->msi_used_lock);
 	if (!test_bit(hwirq, pcie->msi_irq_in_use))
-		dev_err(&pcie->pdev->dev, "trying to free unused MSI#%d\n",
-			hwirq);
+		dev_err(dev, "trying to free unused MSI#%d\n", hwirq);
 	else
 		clear_bit(hwirq, pcie->msi_irq_in_use);
 	mutex_unlock(&pcie->msi_used_lock);
@@ -910,6 +913,7 @@ out_release_res:
 
 static int advk_pcie_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct advk_pcie *pcie;
 	struct resource *res;
 	struct pci_bus *bus, *child;
@@ -917,8 +921,7 @@ static int advk_pcie_probe(struct platform_device *pdev)
 	struct device_node *msi_node;
 	int ret, irq;
 
-	pcie = devm_kzalloc(&pdev->dev, sizeof(struct advk_pcie),
-			    GFP_KERNEL);
+	pcie = devm_kzalloc(dev, sizeof(struct advk_pcie), GFP_KERNEL);
 	if (!pcie)
 		return -ENOMEM;
 
@@ -926,22 +929,22 @@ static int advk_pcie_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, pcie);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pcie->base = devm_ioremap_resource(&pdev->dev, res);
+	pcie->base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(pcie->base))
 		return PTR_ERR(pcie->base);
 
 	irq = platform_get_irq(pdev, 0);
-	ret = devm_request_irq(&pdev->dev, irq, advk_pcie_irq_handler,
+	ret = devm_request_irq(dev, irq, advk_pcie_irq_handler,
 			       IRQF_SHARED | IRQF_NO_THREAD, "advk-pcie",
 			       pcie);
 	if (ret) {
-		dev_err(&pdev->dev, "Failed to register interrupt\n");
+		dev_err(dev, "Failed to register interrupt\n");
 		return ret;
 	}
 
 	ret = advk_pcie_parse_request_of_pci_ranges(pcie);
 	if (ret) {
-		dev_err(&pdev->dev, "Failed to parse resources\n");
+		dev_err(dev, "Failed to parse resources\n");
 		return ret;
 	}
 
@@ -949,24 +952,24 @@ static int advk_pcie_probe(struct platform_device *pdev)
 
 	ret = advk_pcie_init_irq_domain(pcie);
 	if (ret) {
-		dev_err(&pdev->dev, "Failed to initialize irq\n");
+		dev_err(dev, "Failed to initialize irq\n");
 		return ret;
 	}
 
 	ret = advk_pcie_init_msi_irq_domain(pcie);
 	if (ret) {
-		dev_err(&pdev->dev, "Failed to initialize irq\n");
+		dev_err(dev, "Failed to initialize irq\n");
 		advk_pcie_remove_irq_domain(pcie);
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
 				    pcie, &pcie->resources, &pcie->msi);
 	if (!bus) {
 		advk_pcie_remove_msi_irq_domain(pcie);
@@ -980,7 +983,6 @@ static int advk_pcie_probe(struct platform_device *pdev)
 		pcie_bus_configure_settings(child);
 
 	pci_bus_add_devices(bus);
-
 	return 0;
 }
 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
