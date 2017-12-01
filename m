Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:14889 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751694AbdLAJUp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Dec 2017 04:20:45 -0500
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <cyndis@kapsi.fi>, <thierry.reding@gmail.com>,
        <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>
CC: <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>, <rjw@rjwysocki.net>,
        <tglx@linutronix.de>, <vidyas@nvidia.com>, <kthota@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V3 2/7] PCI: Export pci_find_host_bridge()
Date: Fri, 1 Dec 2017 14:50:02 +0530
Message-ID: <1512120007-28088-3-git-send-email-mmaddireddy@nvidia.com>
In-Reply-To: <1512120007-28088-1-git-send-email-mmaddireddy@nvidia.com>
References: <1512120007-28088-1-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI subsystem pass pci_bus pointer to pci_ops callback functions, Tegra
host driver use pci_find_host_bridge() to get pci_host_bridge from pci_bus.
Export pci_find_host_bridge() to allow Tegra PCIe driver to be compiled as
loadable kernel module.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V2:
* commit message update
V3:
* EXPORT_SYMBOL is changed to EXPORT_SYMBOL_GPL

 drivers/pci/host-bridge.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
index add66236215c..b8c0fcde9bd7 100644
--- a/drivers/pci/host-bridge.c
+++ b/drivers/pci/host-bridge.c
@@ -22,6 +22,7 @@ struct pci_host_bridge *pci_find_host_bridge(struct pci_bus *bus)
 
 	return to_pci_host_bridge(root_bus->bridge);
 }
+EXPORT_SYMBOL_GPL(pci_find_host_bridge);
 
 struct device *pci_get_host_bridge_device(struct pci_dev *dev)
 {
-- 
2.1.4
