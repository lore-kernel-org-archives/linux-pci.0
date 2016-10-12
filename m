Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755439AbcJLNM2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:12:28 -0400
Subject: [PATCH v2 4/5] PCI: xilinx-nwl: Add local struct device pointers
To: Michal Simek <michal.simek@xilinx.com>,
        =?utf-8?b?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 08:11:03 -0500
Message-ID: <20161012131103.25793.76035.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012130819.25793.17542.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012130819.25793.17542.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use a local "struct device *dev" for brevity and consistency with other
drivers.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-xilinx-nwl.c |  108 +++++++++++++++++++-----------------
 1 file changed, 56 insertions(+), 52 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
index 67eae41..10d4517 100644
--- a/drivers/pci/host/pcie-xilinx-nwl.c
+++ b/drivers/pci/host/pcie-xilinx-nwl.c
@@ -212,6 +212,7 @@ static bool nwl_phy_link_up(struct nwl_pcie *pcie)
 
 static int nwl_wait_for_link(struct nwl_pcie *pcie)
 {
+	struct device *dev = pcie->dev;
 	int retries;
 
 	/* check if the link is up or not */
@@ -221,7 +222,7 @@ static int nwl_wait_for_link(struct nwl_pcie *pcie)
 		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
 	}
 
-	dev_err(pcie->dev, "PHY link never came up\n");
+	dev_err(dev, "PHY link never came up\n");
 	return -ETIMEDOUT;
 }
 
@@ -277,6 +278,7 @@ static struct pci_ops nwl_pcie_ops = {
 static irqreturn_t nwl_pcie_misc_handler(int irq, void *data)
 {
 	struct nwl_pcie *pcie = data;
+	struct device *dev = pcie->dev;
 	u32 misc_stat;
 
 	/* Checking for misc interrupts */
@@ -286,45 +288,43 @@ static irqreturn_t nwl_pcie_misc_handler(int irq, void *data)
 		return IRQ_NONE;
 
 	if (misc_stat & MSGF_MISC_SR_RXMSG_OVER)
-		dev_err(pcie->dev, "Received Message FIFO Overflow\n");
+		dev_err(dev, "Received Message FIFO Overflow\n");
 
 	if (misc_stat & MSGF_MISC_SR_SLAVE_ERR)
-		dev_err(pcie->dev, "Slave error\n");
+		dev_err(dev, "Slave error\n");
 
 	if (misc_stat & MSGF_MISC_SR_MASTER_ERR)
-		dev_err(pcie->dev, "Master error\n");
+		dev_err(dev, "Master error\n");
 
 	if (misc_stat & MSGF_MISC_SR_I_ADDR_ERR)
-		dev_err(pcie->dev,
-			"In Misc Ingress address translation error\n");
+		dev_err(dev, "In Misc Ingress address translation error\n");
 
 	if (misc_stat & MSGF_MISC_SR_E_ADDR_ERR)
-		dev_err(pcie->dev,
-			"In Misc Egress address translation error\n");
+		dev_err(dev, "In Misc Egress address translation error\n");
 
 	if (misc_stat & MSGF_MISC_SR_FATAL_AER)
-		dev_err(pcie->dev, "Fatal Error in AER Capability\n");
+		dev_err(dev, "Fatal Error in AER Capability\n");
 
 	if (misc_stat & MSGF_MISC_SR_NON_FATAL_AER)
-		dev_err(pcie->dev, "Non-Fatal Error in AER Capability\n");
+		dev_err(dev, "Non-Fatal Error in AER Capability\n");
 
 	if (misc_stat & MSGF_MISC_SR_CORR_AER)
-		dev_err(pcie->dev, "Correctable Error in AER Capability\n");
+		dev_err(dev, "Correctable Error in AER Capability\n");
 
 	if (misc_stat & MSGF_MISC_SR_UR_DETECT)
-		dev_err(pcie->dev, "Unsupported request Detected\n");
+		dev_err(dev, "Unsupported request Detected\n");
 
 	if (misc_stat & MSGF_MISC_SR_NON_FATAL_DEV)
-		dev_err(pcie->dev, "Non-Fatal Error Detected\n");
+		dev_err(dev, "Non-Fatal Error Detected\n");
 
 	if (misc_stat & MSGF_MISC_SR_FATAL_DEV)
-		dev_err(pcie->dev, "Fatal Error Detected\n");
+		dev_err(dev, "Fatal Error Detected\n");
 
 	if (misc_stat & MSGF_MSIC_SR_LINK_AUTO_BWIDTH)
-		dev_info(pcie->dev, "Link Autonomous Bandwidth Management Status bit set\n");
+		dev_info(dev, "Link Autonomous Bandwidth Management Status bit set\n");
 
 	if (misc_stat & MSGF_MSIC_SR_LINK_BWIDTH)
-		dev_info(pcie->dev, "Link Bandwidth Management Status bit set\n");
+		dev_info(dev, "Link Bandwidth Management Status bit set\n");
 
 	/* Clear misc interrupt status */
 	nwl_bridge_writel(pcie, misc_stat, MSGF_MISC_STATUS);
@@ -494,20 +494,21 @@ static const struct irq_domain_ops dev_msi_domain_ops = {
 static int nwl_pcie_init_msi_irq_domain(struct nwl_pcie *pcie)
 {
 #ifdef CONFIG_PCI_MSI
-	struct fwnode_handle *fwnode = of_node_to_fwnode(pcie->dev->of_node);
+	struct device *dev = pcie->dev;
+	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
 	struct nwl_msi *msi = &pcie->msi;
 
 	msi->dev_domain = irq_domain_add_linear(NULL, INT_PCI_MSI_NR,
 						&dev_msi_domain_ops, pcie);
 	if (!msi->dev_domain) {
-		dev_err(pcie->dev, "failed to create dev IRQ domain\n");
+		dev_err(dev, "failed to create dev IRQ domain\n");
 		return -ENOMEM;
 	}
 	msi->msi_domain = pci_msi_create_irq_domain(fwnode,
 						    &nwl_msi_domain_info,
 						    msi->dev_domain);
 	if (!msi->msi_domain) {
-		dev_err(pcie->dev, "failed to create msi IRQ domain\n");
+		dev_err(dev, "failed to create msi IRQ domain\n");
 		irq_domain_remove(msi->dev_domain);
 		return -ENOMEM;
 	}
@@ -517,12 +518,13 @@ static int nwl_pcie_init_msi_irq_domain(struct nwl_pcie *pcie)
 
 static int nwl_pcie_init_irq_domain(struct nwl_pcie *pcie)
 {
-	struct device_node *node = pcie->dev->of_node;
+	struct device *dev = pcie->dev;
+	struct device_node *node = dev->of_node;
 	struct device_node *legacy_intc_node;
 
 	legacy_intc_node = of_get_next_child(node, NULL);
 	if (!legacy_intc_node) {
-		dev_err(pcie->dev, "No legacy intc node found\n");
+		dev_err(dev, "No legacy intc node found\n");
 		return -EINVAL;
 	}
 
@@ -532,7 +534,7 @@ static int nwl_pcie_init_irq_domain(struct nwl_pcie *pcie)
 							pcie);
 
 	if (!pcie->legacy_irq_domain) {
-		dev_err(pcie->dev, "failed to create IRQ domain\n");
+		dev_err(dev, "failed to create IRQ domain\n");
 		return -ENOMEM;
 	}
 
@@ -542,7 +544,8 @@ static int nwl_pcie_init_irq_domain(struct nwl_pcie *pcie)
 
 static int nwl_pcie_enable_msi(struct nwl_pcie *pcie, struct pci_bus *bus)
 {
-	struct platform_device *pdev = to_platform_device(pcie->dev);
+	struct device *dev = pcie->dev;
+	struct platform_device *pdev = to_platform_device(dev);
 	struct nwl_msi *msi = &pcie->msi;
 	unsigned long base;
 	int ret;
@@ -557,7 +560,7 @@ static int nwl_pcie_enable_msi(struct nwl_pcie *pcie, struct pci_bus *bus)
 	/* Get msi_1 IRQ number */
 	msi->irq_msi1 = platform_get_irq_byname(pdev, "msi1");
 	if (msi->irq_msi1 < 0) {
-		dev_err(&pdev->dev, "failed to get IRQ#%d\n", msi->irq_msi1);
+		dev_err(dev, "failed to get IRQ#%d\n", msi->irq_msi1);
 		ret = -EINVAL;
 		goto err;
 	}
@@ -568,7 +571,7 @@ static int nwl_pcie_enable_msi(struct nwl_pcie *pcie, struct pci_bus *bus)
 	/* Get msi_0 IRQ number */
 	msi->irq_msi0 = platform_get_irq_byname(pdev, "msi0");
 	if (msi->irq_msi0 < 0) {
-		dev_err(&pdev->dev, "failed to get IRQ#%d\n", msi->irq_msi0);
+		dev_err(dev, "failed to get IRQ#%d\n", msi->irq_msi0);
 		ret = -EINVAL;
 		goto err;
 	}
@@ -579,7 +582,7 @@ static int nwl_pcie_enable_msi(struct nwl_pcie *pcie, struct pci_bus *bus)
 	/* Check for msii_present bit */
 	ret = nwl_bridge_readl(pcie, I_MSII_CAPABILITIES) & MSII_PRESENT;
 	if (!ret) {
-		dev_err(pcie->dev, "MSI not present\n");
+		dev_err(dev, "MSI not present\n");
 		ret = -EIO;
 		goto err;
 	}
@@ -628,13 +631,14 @@ err:
 
 static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
 {
-	struct platform_device *pdev = to_platform_device(pcie->dev);
+	struct device *dev = pcie->dev;
+	struct platform_device *pdev = to_platform_device(dev);
 	u32 breg_val, ecam_val, first_busno = 0;
 	int err;
 
 	breg_val = nwl_bridge_readl(pcie, E_BREG_CAPABILITIES) & BREG_PRESENT;
 	if (!breg_val) {
-		dev_err(pcie->dev, "BREG is not present\n");
+		dev_err(dev, "BREG is not present\n");
 		return breg_val;
 	}
 
@@ -665,7 +669,7 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
 
 	ecam_val = nwl_bridge_readl(pcie, E_ECAM_CAPABILITIES) & E_ECAM_PRESENT;
 	if (!ecam_val) {
-		dev_err(pcie->dev, "ECAM is not present\n");
+		dev_err(dev, "ECAM is not present\n");
 		return ecam_val;
 	}
 
@@ -692,23 +696,23 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
 	writel(ecam_val, (pcie->ecam_base + PCI_PRIMARY_BUS));
 
 	if (nwl_pcie_link_up(pcie))
-		dev_info(pcie->dev, "Link is UP\n");
+		dev_info(dev, "Link is UP\n");
 	else
-		dev_info(pcie->dev, "Link is DOWN\n");
+		dev_info(dev, "Link is DOWN\n");
 
 	/* Get misc IRQ number */
 	pcie->irq_misc = platform_get_irq_byname(pdev, "misc");
 	if (pcie->irq_misc < 0) {
-		dev_err(&pdev->dev, "failed to get misc IRQ %d\n",
+		dev_err(dev, "failed to get misc IRQ %d\n",
 			pcie->irq_misc);
 		return -EINVAL;
 	}
 
-	err = devm_request_irq(pcie->dev, pcie->irq_misc,
+	err = devm_request_irq(dev, pcie->irq_misc,
 			       nwl_pcie_misc_handler, IRQF_SHARED,
 			       "nwl_pcie:misc", pcie);
 	if (err) {
-		dev_err(pcie->dev, "fail to register misc IRQ#%d\n",
+		dev_err(dev, "fail to register misc IRQ#%d\n",
 			pcie->irq_misc);
 		return err;
 	}
@@ -744,31 +748,32 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
 static int nwl_pcie_parse_dt(struct nwl_pcie *pcie,
 			     struct platform_device *pdev)
 {
-	struct device_node *node = pcie->dev->of_node;
+	struct device *dev = pcie->dev;
+	struct device_node *node = dev->of_node;
 	struct resource *res;
 	const char *type;
 
 	/* Check for device type */
 	type = of_get_property(node, "device_type", NULL);
 	if (!type || strcmp(type, "pci")) {
-		dev_err(pcie->dev, "invalid \"device_type\" %s\n", type);
+		dev_err(dev, "invalid \"device_type\" %s\n", type);
 		return -EINVAL;
 	}
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "breg");
-	pcie->breg_base = devm_ioremap_resource(pcie->dev, res);
+	pcie->breg_base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(pcie->breg_base))
 		return PTR_ERR(pcie->breg_base);
 	pcie->phys_breg_base = res->start;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pcireg");
-	pcie->pcireg_base = devm_ioremap_resource(pcie->dev, res);
+	pcie->pcireg_base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(pcie->pcireg_base))
 		return PTR_ERR(pcie->pcireg_base);
 	pcie->phys_pcie_reg_base = res->start;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
-	pcie->ecam_base = devm_ioremap_resource(pcie->dev, res);
+	pcie->ecam_base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(pcie->ecam_base))
 		return PTR_ERR(pcie->ecam_base);
 	pcie->phys_ecam_base = res->start;
@@ -776,8 +781,7 @@ static int nwl_pcie_parse_dt(struct nwl_pcie *pcie,
 	/* Get intx IRQ number */
 	pcie->irq_intx = platform_get_irq_byname(pdev, "intx");
 	if (pcie->irq_intx < 0) {
-		dev_err(&pdev->dev, "failed to get intx IRQ %d\n",
-			pcie->irq_intx);
+		dev_err(dev, "failed to get intx IRQ %d\n", pcie->irq_intx);
 		return -EINVAL;
 	}
 
@@ -794,7 +798,8 @@ static const struct of_device_id nwl_pcie_of_match[] = {
 
 static int nwl_pcie_probe(struct platform_device *pdev)
 {
-	struct device_node *node = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
 	struct nwl_pcie *pcie;
 	struct pci_bus *bus;
 	struct pci_bus *child;
@@ -802,42 +807,42 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 	resource_size_t iobase = 0;
 	LIST_HEAD(res);
 
-	pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
+	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
 	if (!pcie)
 		return -ENOMEM;
 
-	pcie->dev = &pdev->dev;
+	pcie->dev = dev;
 	pcie->ecam_value = NWL_ECAM_VALUE_DEFAULT;
 
 	err = nwl_pcie_parse_dt(pcie, pdev);
 	if (err) {
-		dev_err(pcie->dev, "Parsing DT failed\n");
+		dev_err(dev, "Parsing DT failed\n");
 		return err;
 	}
 
 	err = nwl_pcie_bridge_init(pcie);
 	if (err) {
-		dev_err(pcie->dev, "HW Initialization failed\n");
+		dev_err(dev, "HW Initialization failed\n");
 		return err;
 	}
 
 	err = of_pci_get_host_bridge_resources(node, 0, 0xff, &res, &iobase);
 	if (err) {
-		dev_err(pcie->dev, "Getting bridge resources failed\n");
+		dev_err(dev, "Getting bridge resources failed\n");
 		return err;
 	}
 
-	err = devm_request_pci_bus_resources(pcie->dev, &res);
+	err = devm_request_pci_bus_resources(dev, &res);
 	if (err)
 		goto error;
 
 	err = nwl_pcie_init_irq_domain(pcie);
 	if (err) {
-		dev_err(pcie->dev, "Failed creating IRQ Domain\n");
+		dev_err(dev, "Failed creating IRQ Domain\n");
 		goto error;
 	}
 
-	bus = pci_create_root_bus(&pdev->dev, pcie->root_busno,
+	bus = pci_create_root_bus(dev, pcie->root_busno,
 				  &nwl_pcie_ops, pcie, &res);
 	if (!bus) {
 		err = -ENOMEM;
@@ -847,8 +852,7 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		err = nwl_pcie_enable_msi(pcie, bus);
 		if (err < 0) {
-			dev_err(&pdev->dev,
-				"failed to enable MSI support: %d\n", err);
+			dev_err(dev, "failed to enable MSI support: %d\n", err);
 			goto error;
 		}
 	}

