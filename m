Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:7529 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753612AbdKXPzd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Nov 2017 10:55:33 -0500
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>, <frowand.list@gmail.com>,
        <bhelgaas@google.com>, <rjw@rjwysocki.net>, <tglx@linutronix.de>
CC: <vidyas@nvidia.com>, <kthota@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH 10/10] PCI: tegra: Add power management support
Date: Fri, 24 Nov 2017 21:23:20 +0530
Message-ID: <1511538800-8275-11-git-send-email-mmaddireddy@nvidia.com>
In-Reply-To: <1511538800-8275-1-git-send-email-mmaddireddy@nvidia.com>
References: <1511538800-8275-1-git-send-email-mmaddireddy@nvidia.com>
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
 drivers/pci/host/pci-tegra.c | 174 ++++++++++++++++++++++++++-----------------
 1 file changed, 106 insertions(+), 68 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index af999c650941..e443b3ebc4b5 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -1404,31 +1404,25 @@ static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
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
 
 	axi_addr = pcie->soc->use_4k_conf_space ?
@@ -1436,21 +1430,21 @@ static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
 	pcie->cs = devm_request_mem_region(dev, axi_addr, SZ_4K, res->name);
 	if (!pcie->cs) {
 		err = -EADDRNOTAVAIL;
-		goto poweroff;
+		goto phys_put;
 	}
 
 	pcie->cfg_va_base = devm_ioremap(dev, pcie->cs->start, SZ_4K);
 	if (!pcie->cfg_va_base) {
 		dev_err(pcie->dev, "failed to ioremap config space\n");
 		err = -EADDRNOTAVAIL;
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
@@ -1458,13 +1452,11 @@ static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
 	err = request_irq(pcie->irq, tegra_pcie_isr, IRQF_SHARED, "PCIE", pcie);
 	if (err) {
 		dev_err(dev, "failed to register IRQ: %d\n", err);
-		goto poweroff;
+		goto phys_put;
 	}
 
 	return 0;
 
-poweroff:
-	tegra_pcie_power_off(pcie);
 phys_put:
 	if (soc->program_uphy)
 		tegra_pcie_phys_put(pcie);
@@ -1478,8 +1470,6 @@ static int tegra_pcie_put_resources(struct tegra_pcie *pcie)
 	if (pcie->irq > 0)
 		free_irq(pcie->irq, pcie);
 
-	tegra_pcie_power_off(pcie);
-
 	if (soc->program_uphy)
 		tegra_pcie_phys_put(pcie);
 
@@ -1702,37 +1692,41 @@ static int tegra_pcie_enable_msi(struct tegra_pcie *pcie)
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
@@ -2811,26 +2805,16 @@ static int tegra_pcie_probe(struct platform_device *pdev)
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
 
 	pci_add_flags(PCI_REASSIGN_ALL_RSRC | PCI_REASSIGN_ALL_BUS);
 	host->busnr = pcie->busn.start;
@@ -2842,7 +2826,7 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 	err = pci_scan_root_bus_bridge(host);
 	if (err < 0) {
 		dev_err(dev, "failed to register host: %d\n", err);
-		goto disable_msi;
+		goto free_resources;
 	}
 
 	pci_bus_size_bridges(host->bus);
@@ -2864,14 +2848,13 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 
 	return 0;
 
-disable_msi:
-	if (IS_ENABLED(CONFIG_PCI_MSI))
-		tegra_pcie_disable_msi(pcie);
-	tegra_pcie_disable_ports(pcie);
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
@@ -2881,7 +2864,6 @@ static int tegra_pcie_remove(struct platform_device *pdev)
 {
 	struct tegra_pcie *pcie = platform_get_drvdata(pdev);
 	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
-	struct tegra_pcie_port *port, *tmp;
 
 	if (IS_ENABLED(CONFIG_DEBUG_FS))
 		tegra_pcie_debugfs_exit(pcie);
@@ -2889,21 +2871,77 @@ static int tegra_pcie_remove(struct platform_device *pdev)
 	pci_remove_root_bus(host->bus);
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		tegra_pcie_disable_msi(pcie);
+	tegra_pcie_free_resources(pcie);
+	pm_runtime_put_sync(pcie->dev);
+	pm_runtime_disable(pcie->dev);
+	tegra_pcie_put_resources(pcie);
+
+	return 0;
+}
+
+static int tegra_pcie_pm_suspend(struct device *dev)
+{
+	struct tegra_pcie *pcie = dev_get_drvdata(dev);
+	struct tegra_pcie_port *port, *tmp;
+
 	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
 		tegra_pcie_pme_turnoff(port);
 	tegra_pcie_disable_ports(pcie);
-	tegra_pcie_free_resources(pcie);
 	tegra_pcie_disable_controller(pcie);
-	tegra_pcie_put_resources(pcie);
+	tegra_pcie_power_off(pcie);
 
 	return 0;
 }
 
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
+
+	return 0;
+
+disable_controller:
+	tegra_pcie_disable_controller(pcie);
+poweroff:
+	tegra_pcie_power_off(pcie);
+
+	return err;
+}
+
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
