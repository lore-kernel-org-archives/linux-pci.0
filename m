Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:15937 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752303AbdLHI7B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Dec 2017 03:59:01 -0500
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <cyndis@kapsi.fi>, <thierry.reding@gmail.com>,
        <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>
CC: <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>, <rjw@rjwysocki.net>,
        <tglx@linutronix.de>, <vidyas@nvidia.com>, <kthota@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V4 5/7] PCI: tegra: Add loadable kernel module support
Date: Fri, 8 Dec 2017 14:28:11 +0530
Message-ID: <1512723493-865-6-git-send-email-mmaddireddy@nvidia.com>
In-Reply-To: <1512723493-865-1-git-send-email-mmaddireddy@nvidia.com>
References: <1512723493-865-1-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Implement remove callback function for Tegra PCIe driver to add
loadable kernel module support. Change PCI_TEGRA config to tristate to
allow pci-tegra driver to be build as a module.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V2:
* no change in this patch
V3:
* use tegra_pcie_debugfs_exit() helper function in tegra_pcie_debugfs_init()
V4:
* no change in this patch

 drivers/pci/host/Kconfig     |  2 +-
 drivers/pci/host/pci-tegra.c | 34 +++++++++++++++++++++++++++++++---
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 38d12980db0f..6fd2a5937804 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -34,7 +34,7 @@ config PCI_FTPCI100
 	default ARCH_GEMINI
 
 config PCI_TEGRA
-	bool "NVIDIA Tegra PCIe controller"
+	tristate "NVIDIA Tegra PCIe controller"
 	depends on ARCH_TEGRA
 	help
 	  Say Y here if you want support for the PCIe host controller found
diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 596dbe06d911..06d62122b269 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -35,6 +35,7 @@
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/module.h>
 #include <linux/msi.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
@@ -2594,6 +2595,12 @@ static const struct file_operations tegra_pcie_ports_ops = {
 	.release = seq_release,
 };
 
+static void tegra_pcie_debugfs_exit(struct tegra_pcie *pcie)
+{
+	debugfs_remove_recursive(pcie->debugfs);
+	pcie->debugfs = NULL;
+}
+
 static int tegra_pcie_debugfs_init(struct tegra_pcie *pcie)
 {
 	struct dentry *file;
@@ -2610,8 +2617,7 @@ static int tegra_pcie_debugfs_init(struct tegra_pcie *pcie)
 	return 0;
 
 remove:
-	debugfs_remove_recursive(pcie->debugfs);
-	pcie->debugfs = NULL;
+	tegra_pcie_debugfs_exit(pcie);
 	return -ENOMEM;
 }
 
@@ -2630,6 +2636,7 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 
 	pcie = pci_host_bridge_priv(host);
 	host->sysdata = pcie;
+	platform_set_drvdata(pdev, pcie);
 
 	pcie->soc = of_device_get_match_data(dev);
 	INIT_LIST_HEAD(&pcie->buses);
@@ -2711,6 +2718,25 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 	return err;
 }
 
+static int tegra_pcie_remove(struct platform_device *pdev)
+{
+	struct tegra_pcie *pcie = platform_get_drvdata(pdev);
+	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
+
+	if (IS_ENABLED(CONFIG_DEBUG_FS))
+		tegra_pcie_debugfs_exit(pcie);
+	pci_stop_root_bus(host->bus);
+	pci_remove_root_bus(host->bus);
+	if (IS_ENABLED(CONFIG_PCI_MSI))
+		tegra_pcie_disable_msi(pcie);
+	tegra_pcie_disable_ports(pcie);
+	tegra_pcie_free_resources(pcie);
+	tegra_pcie_disable_controller(pcie);
+	tegra_pcie_put_resources(pcie);
+
+	return 0;
+}
+
 static struct platform_driver tegra_pcie_driver = {
 	.driver = {
 		.name = "tegra-pcie",
@@ -2718,5 +2744,7 @@ static struct platform_driver tegra_pcie_driver = {
 		.suppress_bind_attrs = true,
 	},
 	.probe = tegra_pcie_probe,
+	.remove = tegra_pcie_remove,
 };
-builtin_platform_driver(tegra_pcie_driver);
+module_platform_driver(tegra_pcie_driver);
+MODULE_LICENSE("GPL");
-- 
2.1.4
