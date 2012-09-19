Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:19538 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756881Ab2ISSzS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Sep 2012 14:55:18 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>, x86 <x86@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 10/40] x86, PCI: Separate rom resource claim out
Date: Wed, 19 Sep 2012 11:54:24 -0700
Message-Id: <1348080894-23412-11-git-send-email-yinghai@kernel.org>
In-Reply-To: <1348080894-23412-1-git-send-email-yinghai@kernel.org>
References: <CAE9FiQWFcVNKMnV1qaHchwCXfZuMpyxf_f7GQy3FZid9YuLD3w@mail.gmail.com>
 <1348080894-23412-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

So could use it with hot-added root bus.

-v2: remove extra functions.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
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

