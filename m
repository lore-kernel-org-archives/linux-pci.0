Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:55577 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751699AbeCOQTJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Mar 2018 12:19:09 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Thierry Reding <thierry.reding@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Stephen Warren <swarren@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: tegra: mark PM functions as __maybe_unused
Date: Thu, 15 Mar 2018 17:18:39 +0100
Message-Id: <20180315161901.772729-1-arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The new PM support causes a warning when CONFIG_PM is disabled:

drivers/pci/host/pci-tegra.c:2482:12: error: 'tegra_pcie_pm_resume' defined but not used [-Werror=unused-function]
 static int tegra_pcie_pm_resume(struct device *dev)
drivers/pci/host/pci-tegra.c:2463:12: error: 'tegra_pcie_pm_suspend' defined but not used [-Werror=unused-function]
 static int tegra_pcie_pm_suspend(struct device *dev)

Marking the functions as __maybe_unused lets the compiler drop them
silently instead.

Fixes: b90b44154023 ("PCI: tegra: Add power management support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/host/pci-tegra.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 39c4af9cf055..389e74be846c 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -2460,7 +2460,7 @@ static int tegra_pcie_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int tegra_pcie_pm_suspend(struct device *dev)
+static int __maybe_unused tegra_pcie_pm_suspend(struct device *dev)
 {
 	struct tegra_pcie *pcie = dev_get_drvdata(dev);
 	struct tegra_pcie_port *port;
@@ -2479,7 +2479,7 @@ static int tegra_pcie_pm_suspend(struct device *dev)
 	return 0;
 }
 
-static int tegra_pcie_pm_resume(struct device *dev)
+static int __maybe_unused tegra_pcie_pm_resume(struct device *dev)
 {
 	struct tegra_pcie *pcie = dev_get_drvdata(dev);
 	int err;
-- 
2.9.0
