Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:35405 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753451Ab2IYI0f (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Sep 2012 04:26:35 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	x86@kernel.org
Subject: [PATCH 04/29] PCI, x86: Separate out rom resource claim
Date: Tue, 25 Sep 2012 01:26:05 -0700
Message-Id: <1348561590-28067-5-git-send-email-yinghai@kernel.org>
In-Reply-To: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
References: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

So could use it with hot-added root bus later.

-v2: remove extra functions.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: x86@kernel.org
---
 arch/x86/pci/i386.c |   52 ++++++++++++++++++++++++++++++++++----------------
 1 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/arch/x86/pci/i386.c b/arch/x86/pci/i386.c
index 84696ed..42dd755 100644
--- a/arch/x86/pci/i386.c
+++ b/arch/x86/pci/i386.c
@@ -298,27 +298,45 @@ static void __init pcibios_allocate_resources(struct pci_bus *bus, int pass)
 	}
 }
 
-static int __init pcibios_assign_resources(void)
+static void __init pcibios_allocate_dev_rom_resource(struct pci_dev *dev)
 {
-	struct pci_dev *dev = NULL;
 	struct resource *r;
 
-	if (!(pci_probe & PCI_ASSIGN_ROMS)) {
-		/*
-		 * Try to use BIOS settings for ROMs, otherwise let
-		 * pci_assign_unassigned_resources() allocate the new
-		 * addresses.
-		 */
-		for_each_pci_dev(dev) {
-			r = &dev->resource[PCI_ROM_RESOURCE];
-			if (!r->flags || !r->start)
-				continue;
-			if (pci_claim_resource(dev, PCI_ROM_RESOURCE) < 0) {
-				r->end -= r->start;
-				r->start = 0;
-			}
-		}
+	/*
+	 * Try to use BIOS settings for ROMs, otherwise let
+	 * pci_assign_unassigned_resources() allocate the new
+	 * addresses.
+	 */
+	r = &dev->resource[PCI_ROM_RESOURCE];
+	if (!r->flags || !r->start)
+		return;
+
+	if (pci_claim_resource(dev, PCI_ROM_RESOURCE) < 0) {
+		r->end -= r->start;
+		r->start = 0;
 	}
+}
+static void __init pcibios_allocate_rom_resources(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+	struct pci_bus *child;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		pcibios_allocate_dev_rom_resource(dev);
+
+		child = dev->subordinate;
+		if (child)
+			pcibios_allocate_rom_resources(child);
+	}
+}
+
+static int __init pcibios_assign_resources(void)
+{
+	struct pci_bus *bus;
+
+	if (!(pci_probe & PCI_ASSIGN_ROMS))
+		list_for_each_entry(bus, &pci_root_buses, node)
+			pcibios_allocate_rom_resources(bus);
 
 	pci_assign_unassigned_resources();
 	pcibios_fw_addr_list_del();
-- 
1.7.7

