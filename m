Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35799 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752203AbbGUVfz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jul 2015 17:35:55 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
To: <linux@arm.linux.org.uk>, <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] ARM/PCI: set MPS before pci_bus_add_devices()
Date: Tue, 21 Jul 2015 17:35:19 -0400
Message-ID: <1437514519-18545-1-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The MPS configuration should be done *before* pci_bus_add_devices().
After pci_bus_add_devices(), drivers may be bound to devices, and
the PCI core shouldn't touch device configuration while a driver
owns the device.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Reported-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/arm/kernel/bios32.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index fcbbbb1..17efde7 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -520,7 +520,8 @@ void pci_common_init_dev(struct device *parent, struct hw_pci *hw)
 	list_for_each_entry(sys, &head, node) {
 		struct pci_bus *bus = sys->bus;
 
-		if (!pci_has_flag(PCI_PROBE_ONLY)) {
+		if (bus && !pci_has_flag(PCI_PROBE_ONLY)) {
+			struct pci_bus *child;
 			/*
 			 * Size the bridge windows.
 			 */
@@ -530,25 +531,15 @@ void pci_common_init_dev(struct device *parent, struct hw_pci *hw)
 			 * Assign resources.
 			 */
 			pci_bus_assign_resources(bus);
-		}
 
+			list_for_each_entry(child, &bus->children, node)
+				pcie_bus_configure_settings(child);
+		}
 		/*
 		 * Tell drivers about devices found.
 		 */
 		pci_bus_add_devices(bus);
 	}
-
-	list_for_each_entry(sys, &head, node) {
-		struct pci_bus *bus = sys->bus;
-
-		/* Configure PCI Express settings */
-		if (bus && !pci_has_flag(PCI_PROBE_ONLY)) {
-			struct pci_bus *child;
-
-			list_for_each_entry(child, &bus->children, node)
-				pcie_bus_configure_settings(child);
-		}
-	}
 }
 
 #ifndef CONFIG_PCI_HOST_ITE8152
-- 
1.9.1

