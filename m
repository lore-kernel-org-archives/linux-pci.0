Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:7511 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753768AbdKXPzU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Nov 2017 10:55:20 -0500
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>, <frowand.list@gmail.com>,
        <bhelgaas@google.com>, <rjw@rjwysocki.net>, <tglx@linutronix.de>
CC: <vidyas@nvidia.com>, <kthota@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH 08/10] PCI: tegra: Add loadable kernel module support
Date: Fri, 24 Nov 2017 21:23:18 +0530
Message-ID: <1511538800-8275-9-git-send-email-mmaddireddy@nvidia.com>
In-Reply-To: <1511538800-8275-1-git-send-email-mmaddireddy@nvidia.com>
References: <1511538800-8275-1-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Implement remove call back function for Tegra PCIe driver to add
loadable kernel module support. Change PCI_TEGRA config to tristate to
allow pci-tegra driver to build as a module.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 drivers/pci/host/Kconfig     |  2 +-
 drivers/pci/host/pci-tegra.c | 31 ++++++++++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index b868803792d8..15eb265461b2 100644
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
index 09f52cd569c6..2ff1ac3aefc1 100644
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
@@ -2700,6 +2701,12 @@ static int tegra_pcie_debugfs_init(struct tegra_pcie *pcie)
 	return -ENOMEM;
 }
 
+static void tegra_pcie_debugfs_exit(struct tegra_pcie *pcie)
+{
+	debugfs_remove_recursive(pcie->debugfs);
+	pcie->debugfs = NULL;
+}
+
 static int tegra_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -2714,6 +2721,7 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	pcie = pci_host_bridge_priv(host);
+	platform_set_drvdata(pdev, pcie);
 
 	pcie->soc = of_device_get_match_data(dev);
 	INIT_LIST_HEAD(&pcie->buses);
@@ -2796,6 +2804,25 @@ static int tegra_pcie_probe(struct platform_device *pdev)
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
@@ -2803,5 +2830,7 @@ static struct platform_driver tegra_pcie_driver = {
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
