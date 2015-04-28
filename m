Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from [119.145.14.65] ([119.145.14.65]:2618 "EHLO
	szxga02-in.huawei.com" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S932279AbbD1HFt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 Apr 2015 03:05:49 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <dja@axtens.net>,
	Arnd Bergmann <arnd@arndb.de>,
	<linux-arm-kernel@lists.infradead.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	<linux-tegra@vger.kernel.org>
Subject: [PATCH Part1 v11 2/5] PCI: tegra: Remove redundant tegra_pcie_scan_bus()
Date: Tue, 28 Apr 2015 15:01:36 +0800
Message-ID: <1430204499-19571-3-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1430204499-19571-1-git-send-email-wangyijing@huawei.com>
References: <1430204499-19571-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now pci_scan_root_bus() is almost similar to
pci_create_root_bus() + pci_scan_child_bus().
So we could use common pci_scan_root_bus() in
pci_common_init_dev() to scan pci busses.
tegra_pcie_scan_bus() is redundant, remove it.

Tested-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Yijing Wang <wangyijing@huawei.com>
Acked-by: Thierry Reding <treding@nvidia.com>
CC: Thierry Reding <thierry.reding@gmail.com>
CC: linux-tegra@vger.kernel.org
---
 drivers/pci/host/pci-tegra.c |   16 ----------------
 1 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 00e9272..10c0571 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -630,21 +630,6 @@ static int tegra_pcie_map_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
 	return irq;
 }
 
-static struct pci_bus *tegra_pcie_scan_bus(int nr, struct pci_sys_data *sys)
-{
-	struct tegra_pcie *pcie = sys_to_pcie(sys);
-	struct pci_bus *bus;
-
-	bus = pci_create_root_bus(pcie->dev, sys->busnr, &tegra_pcie_ops, sys,
-				  &sys->resources);
-	if (!bus)
-		return NULL;
-
-	pci_scan_child_bus(bus);
-
-	return bus;
-}
-
 static irqreturn_t tegra_pcie_isr(int irq, void *arg)
 {
 	const char *err_msg[] = {
@@ -1831,7 +1816,6 @@ static int tegra_pcie_enable(struct tegra_pcie *pcie)
 	hw.private_data = (void **)&pcie;
 	hw.setup = tegra_pcie_setup;
 	hw.map_irq = tegra_pcie_map_irq;
-	hw.scan = tegra_pcie_scan_bus;
 	hw.ops = &tegra_pcie_ops;
 
 	pci_common_init_dev(pcie->dev, &hw);
-- 
1.7.1

