Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:38372 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754872AbcA2L1n (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 29 Jan 2016 06:27:43 -0500
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Jingoo Han <jingoohan1@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Zhou Wang <wangzhou1@hisilicon.com>
Subject: [PATCH 2/2] drivers: pci: host: designware: remove PCI_PROBE_ONLY handling
Date: Fri, 29 Jan 2016 11:29:32 +0000
Message-Id: <1454066972-3609-2-git-send-email-lorenzo.pieralisi@arm.com>
In-Reply-To: <1454066972-3609-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1454066972-3609-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCIe designware host driver is not used in system configurations
requiring the PCI_PROBE_ONLY flag to be set to prevent resources
assignment, therefore the driver code handling the flag can be
removed from the kernel.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Pratyush Anand <pratyush.anand@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/pci/host/pcie-designware.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 2171682..a445083 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -551,13 +551,11 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
 #endif
 
-	if (!pci_has_flag(PCI_PROBE_ONLY)) {
-		pci_bus_size_bridges(bus);
-		pci_bus_assign_resources(bus);
+	pci_bus_size_bridges(bus);
+	pci_bus_assign_resources(bus);
 
-		list_for_each_entry(child, &bus->children, node)
-			pcie_bus_configure_settings(child);
-	}
+	list_for_each_entry(child, &bus->children, node)
+		pcie_bus_configure_settings(child);
 
 	pci_bus_add_devices(bus);
 	return 0;
-- 
2.5.1

