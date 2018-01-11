Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:1620 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753876AbeAKGIx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Jan 2018 01:08:53 -0500
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <lorenzo.pieralisi@arm.com>, <cyndis@kapsi.fi>
CC: <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>, <rjw@rjwysocki.net>,
        <tglx@linutronix.de>, <vidyas@nvidia.com>, <kthota@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V6 7/7] PCI: tegra: Add power management support
Date: Thu, 11 Jan 2018 11:38:08 +0530
Message-ID: <1515650888-9459-8-git-send-email-mmaddireddy@nvidia.com>
In-Reply-To: <1515650888-9459-1-git-send-email-mmaddireddy@nvidia.com>
References: <1515650888-9459-1-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Tegra186 powergate driver is implemented as power domain driver, power
partition ungate/gate are registered as power_on/power_off callback
functions. There are no direct functions to power gate/ungate host
controller in Tegra186. Host controller driver should add "power-domains"
property in device tree and implement runtime suspend and resume
callback functons. Power gate and ungate is taken care by power domain
driver when host controller driver calls pm_runtime_put_sync and
pm_runtime_get_sync respectively.

Register suspend_noirq & resume_noirq callback functions to allow PCIe to
come up after resume from RAM. Both runtime and noirq pm ops share same
callback functions.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V2:
* no change in this patch
V3:
* no change in this patch
V4:
* no change in this patch
V5:
* Decoupled from https://patchwork.ozlabs.org/patch/832053/ and
rebased on linux-next
V6:
* no change in this patch

 drivers/pci/host/pci-tegra.c | 181 ++++++++++++++++++++++++++-----------------
 1 file changed, 110 insertions(+), 71 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index cc33fc0fb300..a106eb7ee695 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -1287,31 +1287,25 @@ static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
 		}
 	}
 
-	err = tegra_pcie_power_on(pcie);
-	if (err) {
-		dev_err(dev, "failed to power up: %d\n", err);
-		goto phys_put;
-	}
-
 	pads = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pads");
 	pcie->pads = devm_ioremap_resource(dev, pads);
 	if (IS_ERR(pcie->pads)) {
 		err = PTR_ERR(pcie->pads);
-		goto poweroff;
+		goto phys_put;
 	}
 
 	afi = platform_get_resource_byname(pdev, IORESOURCE_MEM, "afi");
 	pcie->afi = devm_ioremap_resource(dev, afi);
 	if (IS_ERR(pcie->afi)) {
 		err = PTR_ERR(pcie->afi);
-		goto poweroff;
+		goto phys_put;
 	}
 
 	/* request configuration space, but remap later, on demand */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cs");
 	if (!res) {
 		err = -EADDRNOTAVAIL;
-		goto poweroff;
+		goto phys_put;
 	}
 
 	pcie->cs = *res;
@@ -1322,14 +1316,14 @@ static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
 	pcie->cfg = devm_ioremap_resource(dev, &pcie->cs);
 	if (IS_ERR(pcie->cfg)) {
 		err = PTR_ERR(pcie->cfg);
-		goto poweroff;
+		goto phys_put;
 	}
 
 	/* request interrupt */
 	err = platform_get_irq_byname(pdev, "intr");
 	if (err < 0) {
 		dev_err(dev, "failed to get IRQ: %d\n", err);
-		goto poweroff;
+		goto phys_put;
 	}
 
 	pcie->irq = err;
@@ -1337,7 +1331,7 @@ static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
 	err = request_irq(pcie->irq, tegra_pcie_isr, IRQF_SHARED, "PCIE", pcie);
 	if (err) {
 		dev_err(dev, "failed to register IRQ: %d\n", err);
-		goto poweroff;
+		goto phys_put;
 	}
 
 	return 0;
@@ -1345,8 +1339,6 @@ static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
 phys_put:
 	if (soc->program_uphy)
 		tegra_pcie_phys_put(pcie);
-poweroff:
-	tegra_pcie_power_off(pcie);
 	return err;
 }
 
@@ -1357,8 +1349,6 @@ static int tegra_pcie_put_resources(struct tegra_pcie *pcie)
 	if (pcie->irq > 0)
 		free_irq(pcie->irq, pcie);
 
-	tegra_pcie_power_off(pcie);
-
 	if (soc->program_uphy)
 		tegra_pcie_phys_put(pcie);
 
@@ -1536,37 +1526,41 @@ static int tegra_pcie_enable_msi(struct tegra_pcie *pcie)
 	int err;
 	u32 reg;
 
-	mutex_init(&msi->lock);
+	if (!msi->phys) {
+		mutex_init(&msi->lock);
 
-	msi->chip.dev = dev;
-	msi->chip.setup_irq = tegra_msi_setup_irq;
-	msi->chip.teardown_irq = tegra_msi_teardown_irq;
+		msi->chip.dev = dev;
+		msi->chip.setup_irq = tegra_msi_setup_irq;
+		msi->chip.teardown_irq = tegra_msi_teardown_irq;
 
-	msi->domain = irq_domain_add_linear(dev->of_node, INT_PCI_MSI_NR,
-					    &msi_domain_ops, &msi->chip);
-	if (!msi->domain) {
-		dev_err(dev, "failed to create IRQ domain\n");
-		return -ENOMEM;
-	}
+		msi->domain = irq_domain_add_linear(dev->of_node,
+						    INT_PCI_MSI_NR,
+						    &msi_domain_ops,
+						    &msi->chip);
+		if (!msi->domain) {
+			dev_err(dev, "failed to create IRQ domain\n");
+			return -ENOMEM;
+		}
 
-	err = platform_get_irq_byname(pdev, "msi");
-	if (err < 0) {
-		dev_err(dev, "failed to get IRQ: %d\n", err);
-		goto err;
-	}
+		err = platform_get_irq_byname(pdev, "msi");
+		if (err < 0) {
+			dev_err(dev, "failed to get IRQ: %d\n", err);
+			goto err;
+		}
 
-	msi->irq = err;
+		msi->irq = err;
 
-	err = request_irq(msi->irq, tegra_pcie_msi_irq, IRQF_NO_THREAD,
-			  tegra_msi_irq_chip.name, pcie);
-	if (err < 0) {
-		dev_err(dev, "failed to request IRQ: %d\n", err);
-		goto err;
-	}
+		err = request_irq(msi->irq, tegra_pcie_msi_irq, IRQF_NO_THREAD,
+				  tegra_msi_irq_chip.name, pcie);
+		if (err < 0) {
+			dev_err(dev, "failed to request IRQ: %d\n", err);
+			goto err;
+		}
 
-	/* setup AFI/FPCI range */
-	msi->pages = __get_free_pages(GFP_KERNEL, 0);
-	msi->phys = virt_to_phys((void *)msi->pages);
+		/* setup AFI/FPCI range */
+		msi->pages = __get_free_pages(GFP_KERNEL, 0);
+		msi->phys = virt_to_phys((void *)msi->pages);
+	}
 
 	afi_writel(pcie, msi->phys >> soc->msi_base_shift, AFI_MSI_FPCI_BAR_ST);
 	afi_writel(pcie, msi->phys, AFI_MSI_AXI_BAR_ST);
@@ -2129,10 +2123,8 @@ static void tegra_pcie_disable_ports(struct tegra_pcie *pcie)
 {
 	struct tegra_pcie_port *port, *tmp;
 
-	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
+	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
 		tegra_pcie_port_disable(port);
-		tegra_pcie_port_free(port);
-	}
 }
 
 static const struct tegra_pcie_soc tegra20_pcie = {
@@ -2375,26 +2367,16 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	err = tegra_pcie_enable_controller(pcie);
-	if (err)
+	pm_runtime_enable(pcie->dev);
+	err = pm_runtime_get_sync(pcie->dev);
+	if (err) {
+		dev_err(dev, "fail to enable pcie controller: %d\n", err);
 		goto put_resources;
+	}
 
 	err = tegra_pcie_request_resources(pcie);
 	if (err)
-		goto disable_controller;
-
-	/* setup the AFI address translations */
-	tegra_pcie_setup_translations(pcie);
-
-	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		err = tegra_pcie_enable_msi(pcie);
-		if (err < 0) {
-			dev_err(dev, "failed to enable MSI support: %d\n", err);
-			goto free_resources;
-		}
-	}
-
-	tegra_pcie_enable_ports(pcie);
+		goto pm_runtime_put;
 
 	host->busnr = pcie->busn.start;
 	host->dev.parent = &pdev->dev;
@@ -2405,7 +2387,7 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 	err = pci_scan_root_bus_bridge(host);
 	if (err < 0) {
 		dev_err(dev, "failed to register host: %d\n", err);
-		goto disable_ports;
+		goto free_resources;
 	}
 
 	pci_bus_size_bridges(host->bus);
@@ -2424,14 +2406,13 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 
 	return 0;
 
-disable_ports:
-	tegra_pcie_disable_ports(pcie);
-	if (IS_ENABLED(CONFIG_PCI_MSI))
-		tegra_pcie_disable_msi(pcie);
 free_resources:
 	tegra_pcie_free_resources(pcie);
-disable_controller:
-	tegra_pcie_disable_controller(pcie);
+pm_runtime_put:
+	if (IS_ENABLED(CONFIG_PCI_MSI))
+		tegra_pcie_disable_msi(pcie);
+	pm_runtime_put_sync(pcie->dev);
+	pm_runtime_disable(pcie->dev);
 put_resources:
 	tegra_pcie_put_resources(pcie);
 	return err;
@@ -2447,23 +2428,81 @@ static int tegra_pcie_remove(struct platform_device *pdev)
 		tegra_pcie_debugfs_exit(pcie);
 	pci_stop_root_bus(host->bus);
 	pci_remove_root_bus(host->bus);
-	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
-		tegra_pcie_pme_turnoff(port);
-	tegra_pcie_disable_ports(pcie);
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		tegra_pcie_disable_msi(pcie);
 	tegra_pcie_free_resources(pcie);
-	tegra_pcie_disable_controller(pcie);
+	pm_runtime_put_sync(pcie->dev);
+	pm_runtime_disable(pcie->dev);
 	tegra_pcie_put_resources(pcie);
+	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
+		tegra_pcie_port_free(port);
+
+	return 0;
+}
+
+static int tegra_pcie_pm_suspend(struct device *dev)
+{
+	struct tegra_pcie *pcie = dev_get_drvdata(dev);
+	struct tegra_pcie_port *port, *tmp;
+
+	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
+		tegra_pcie_pme_turnoff(port);
+	tegra_pcie_disable_ports(pcie);
+	tegra_pcie_disable_controller(pcie);
+	tegra_pcie_power_off(pcie);
+
+	return 0;
+}
+
+static int tegra_pcie_pm_resume(struct device *dev)
+{
+	struct tegra_pcie *pcie = dev_get_drvdata(dev);
+	int err;
+
+	err = tegra_pcie_power_on(pcie);
+	if (err) {
+		dev_err(dev, "tegra pcie power on fail: %d\n", err);
+		return err;
+	}
+	err = tegra_pcie_enable_controller(pcie);
+	if (err) {
+		dev_err(dev, "tegra pcie controller enable fail: %d\n", err);
+		goto poweroff;
+	}
+	tegra_pcie_setup_translations(pcie);
+
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		err = tegra_pcie_enable_msi(pcie);
+		if (err < 0) {
+			dev_err(dev, "failed to enable MSI support: %d\n", err);
+			goto disable_controller;
+		}
+	}
+
+	tegra_pcie_enable_ports(pcie);
 
 	return 0;
+
+disable_controller:
+	tegra_pcie_disable_controller(pcie);
+poweroff:
+	tegra_pcie_power_off(pcie);
+
+	return err;
 }
 
+static const struct dev_pm_ops tegra_pcie_pm_ops = {
+	SET_RUNTIME_PM_OPS(tegra_pcie_pm_suspend, tegra_pcie_pm_resume, NULL)
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(tegra_pcie_pm_suspend,
+				      tegra_pcie_pm_resume)
+};
+
 static struct platform_driver tegra_pcie_driver = {
 	.driver = {
 		.name = "tegra-pcie",
 		.of_match_table = tegra_pcie_of_match,
 		.suppress_bind_attrs = true,
+		.pm = &tegra_pcie_pm_ops,
 	},
 	.probe = tegra_pcie_probe,
 	.remove = tegra_pcie_remove,
-- 
2.1.4
