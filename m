Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: [PATCH v3 06/34] microblaze/PCI: remove unused pci_flags
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>,
	microblaze-uclinux@itee.uq.edu.au
Date: Wed, 07 Mar 2012 15:32:34 -0700
Message-ID: <20120307223234.25669.55717.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
References: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_flags is initialized to zero and never modified (I think this was just
copied from powerpc).  Therefore, "(pci_flags & XX)" is always false and
"!(pci_flags & XX)" is always true, and we can remove all references
to pci_flags.

CC: Michal Simek <monstr@monstr.eu>
CC: microblaze-uclinux@itee.uq.edu.au
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/microblaze/include/asm/pci-bridge.h |    1 -
 arch/microblaze/pci/pci-common.c         |   48 ++++++------------------------
 2 files changed, 9 insertions(+), 40 deletions(-)

diff --git a/arch/microblaze/include/asm/pci-bridge.h b/arch/microblaze/include/asm/pci-bridge.h
index e9834b2..cb5d397 100644
--- a/arch/microblaze/include/asm/pci-bridge.h
+++ b/arch/microblaze/include/asm/pci-bridge.h
@@ -10,7 +10,6 @@
 #include <linux/pci.h>
 #include <linux/list.h>
 #include <linux/ioport.h>
-#include <asm-generic/pci-bridge.h>
 
 struct device_node;
 
diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index 85f2ac1..8a257a7 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -46,9 +46,6 @@ static int global_phb_number;		/* Global phb counter */
 /* ISA Memory physical address */
 resource_size_t isa_mem_base;
 
-/* Default PCI flags is 0 on ppc32, modified at boot on ppc64 */
-unsigned int pci_flags;
-
 static struct dma_map_ops *pci_dma_ops = &dma_direct_ops;
 
 unsigned long isa_io_base;
@@ -833,11 +830,7 @@ int pci_proc_domain(struct pci_bus *bus)
 {
 	struct pci_controller *hose = pci_bus_to_host(bus);
 
-	if (!(pci_flags & PCI_ENABLE_PROC_DOMAINS))
-		return 0;
-	if (pci_flags & PCI_COMPAT_DOMAIN_0)
-		return hose->global_number != 0;
-	return 1;
+	return 0;
 }
 
 void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
@@ -910,13 +903,7 @@ static void __devinit pcibios_fixup_resources(struct pci_dev *dev)
 		struct resource *res = dev->resource + i;
 		if (!res->flags)
 			continue;
-		/* On platforms that have PCI_PROBE_ONLY set, we don't
-		 * consider 0 as an unassigned BAR value. It's technically
-		 * a valid value, but linux doesn't like it... so when we can
-		 * re-assign things, we do so, but if we can't, we keep it
-		 * around and hope for the best...
-		 */
-		if (res->start == 0 && !(pci_flags & PCI_PROBE_ONLY)) {
+		if (res->start == 0) {
 			pr_debug("PCI:%s Resource %d %016llx-%016llx [%x]" \
 							"is unassigned\n",
 				 pci_name(dev), i,
@@ -959,10 +946,6 @@ static int __devinit pcibios_uninitialized_bridge_resource(struct pci_bus *bus,
 	u16 command;
 	int i;
 
-	/* We don't do anything if PCI_PROBE_ONLY is set */
-	if (pci_flags & PCI_PROBE_ONLY)
-		return 0;
-
 	/* Job is a bit different between memory and IO */
 	if (res->flags & IORESOURCE_MEM) {
 		/* If the BAR is non-0 (res != pci_mem_offset) then it's
@@ -1107,9 +1090,6 @@ EXPORT_SYMBOL(pcibios_fixup_bus);
 
 static int skip_isa_ioresource_align(struct pci_dev *dev)
 {
-	if ((pci_flags & PCI_CAN_SKIP_ISA_ALIGN) &&
-	    !(dev->bus->bridge_ctl & PCI_BRIDGE_CTL_ISA))
-		return 1;
 	return 0;
 }
 
@@ -1236,8 +1216,6 @@ void pcibios_allocate_bus_resources(struct pci_bus *bus)
 			 * and as such ensure proper re-allocation
 			 * later.
 			 */
-			if (pci_flags & PCI_REASSIGN_ALL_RSRC)
-				goto clear_resource;
 			pr = pci_find_parent_resource(bus->self, res);
 			if (pr == res) {
 				/* this happens when the generic PCI
@@ -1422,27 +1400,19 @@ void __init pcibios_resource_survey(void)
 	list_for_each_entry(b, &pci_root_buses, node)
 		pcibios_allocate_bus_resources(b);
 
-	if (!(pci_flags & PCI_REASSIGN_ALL_RSRC)) {
-		pcibios_allocate_resources(0);
-		pcibios_allocate_resources(1);
-	}
+	pcibios_allocate_resources(0);
+	pcibios_allocate_resources(1);
 
 	/* Before we start assigning unassigned resource, we try to reserve
 	 * the low IO area and the VGA memory area if they intersect the
 	 * bus available resources to avoid allocating things on top of them
 	 */
-	if (!(pci_flags & PCI_PROBE_ONLY)) {
-		list_for_each_entry(b, &pci_root_buses, node)
-			pcibios_reserve_legacy_regions(b);
-	}
+	list_for_each_entry(b, &pci_root_buses, node)
+		pcibios_reserve_legacy_regions(b);
 
-	/* Now, if the platform didn't decide to blindly trust the firmware,
-	 * we proceed to assigning things that were left unassigned
-	 */
-	if (!(pci_flags & PCI_PROBE_ONLY)) {
-		pr_debug("PCI: Assigning unassigned resources...\n");
-		pci_assign_unassigned_resources();
-	}
+	/* Now proceed to assigning things that were left unassigned */
+	pr_debug("PCI: Assigning unassigned resources...\n");
+	pci_assign_unassigned_resources();
 }
 
 #ifdef CONFIG_HOTPLUG

