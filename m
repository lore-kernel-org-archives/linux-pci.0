Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:6438 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752064AbeAIJUY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jan 2018 04:20:24 -0500
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <lorenzo.pieralisi@arm.com>, <cyndis@kapsi.fi>
CC: <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>, <rjw@rjwysocki.net>,
        <tglx@linutronix.de>, <vidyas@nvidia.com>, <kthota@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V5 2/7] PCI: tegra: Use bus->sysdata to store and get host private data
Date: Tue, 9 Jan 2018 14:49:32 +0530
Message-ID: <1515489577-2197-3-git-send-email-mmaddireddy@nvidia.com>
In-Reply-To: <1515489577-2197-1-git-send-email-mmaddireddy@nvidia.com>
References: <1515489577-2197-1-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Tegra host driver is using pci_find_host_bridge() to get private data,
however pci_find_host_bridge() is causing module build failure because
it is not exported. pci_find_host_bridge() can be avoided by using
bus->sysdata to store and get private data.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
V4:
* new patch in V4
V5:
* Rebase on top of linux-next

 drivers/pci/host/pci-tegra.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index e126341fcb36..d790a26ad87e 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -379,8 +379,7 @@ static void __iomem *tegra_pcie_map_bus(struct pci_bus *bus,
 					unsigned int devfn,
 					int where)
 {
-	struct pci_host_bridge *host = pci_find_host_bridge(bus);
-	struct tegra_pcie *pcie = pci_host_bridge_priv(host);
+	struct tegra_pcie *pcie = bus->sysdata;
 	void __iomem *addr = NULL;
 
 	if (bus->number == 0) {
@@ -573,8 +572,7 @@ static int tegra_pcie_request_resources(struct tegra_pcie *pcie)
 
 static int tegra_pcie_map_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
 {
-	struct pci_host_bridge *host = pci_find_host_bridge(pdev->bus);
-	struct tegra_pcie *pcie = pci_host_bridge_priv(host);
+	struct tegra_pcie *pcie = pdev->bus->sysdata;
 	int irq;
 
 	tegra_cpuidle_pcie_irqs_in_use();
@@ -2258,6 +2256,7 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	pcie = pci_host_bridge_priv(host);
+	host->sysdata = pcie;
 
 	pcie->soc = of_device_get_match_data(dev);
 	INIT_LIST_HEAD(&pcie->ports);
-- 
2.1.4
