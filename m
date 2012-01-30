Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: [RFC PATCH v1 14/18] powerpc/PCI: get rid of device resource fixups
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arch@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 30 Jan 2012 09:58:21 -0700
Message-ID: <20120130165820.3231.9878.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120130165430.3231.97740.stgit@bhelgaas.mtv.corp.google.com>
References: <20120130165430.3231.97740.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Tell the PCI core about host bridge address translation so it can take
care of bus-to-resource conversion for us.

N.B. powerpc used a 32-bit mask when converting IO addresses.  If we
figure out the right offset, I think simple addition should do the
same thing, but I might not have it exactly right yet.

CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/pci.h   |    8 ----
 arch/powerpc/kernel/pci-common.c |   79 ++------------------------------------
 2 files changed, 6 insertions(+), 81 deletions(-)

diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index f54b3d2..839178b 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -154,13 +154,7 @@ extern int pci_mmap_legacy_page_range(struct pci_bus *bus,
 
 #endif /* CONFIG_PPC64 */
 
-extern void pcibios_resource_to_bus(struct pci_dev *dev,
-			struct pci_bus_region *region,
-			struct resource *res);
-
-extern void pcibios_bus_to_resource(struct pci_dev *dev,
-			struct resource *res,
-			struct pci_bus_region *region);
+#define ARCH_HAS_GENERIC_PCI_OFFSETS
 
 extern void pcibios_claim_one_bus(struct pci_bus *b);
 
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index cce98d7..f0084c9 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -849,60 +849,6 @@ int pci_proc_domain(struct pci_bus *bus)
 	return 1;
 }
 
-void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
-			     struct resource *res)
-{
-	resource_size_t offset = 0, mask = (resource_size_t)-1;
-	struct pci_controller *hose = pci_bus_to_host(dev->bus);
-
-	if (!hose)
-		return;
-	if (res->flags & IORESOURCE_IO) {
-		offset = (unsigned long)hose->io_base_virt - _IO_BASE;
-		mask = 0xffffffffu;
-	} else if (res->flags & IORESOURCE_MEM)
-		offset = hose->pci_mem_offset;
-
-	region->start = (res->start - offset) & mask;
-	region->end = (res->end - offset) & mask;
-}
-EXPORT_SYMBOL(pcibios_resource_to_bus);
-
-void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
-			     struct pci_bus_region *region)
-{
-	resource_size_t offset = 0, mask = (resource_size_t)-1;
-	struct pci_controller *hose = pci_bus_to_host(dev->bus);
-
-	if (!hose)
-		return;
-	if (res->flags & IORESOURCE_IO) {
-		offset = (unsigned long)hose->io_base_virt - _IO_BASE;
-		mask = 0xffffffffu;
-	} else if (res->flags & IORESOURCE_MEM)
-		offset = hose->pci_mem_offset;
-	res->start = (region->start + offset) & mask;
-	res->end = (region->end + offset) & mask;
-}
-EXPORT_SYMBOL(pcibios_bus_to_resource);
-
-/* Fixup a bus resource into a linux resource */
-static void __devinit fixup_resource(struct resource *res, struct pci_dev *dev)
-{
-	struct pci_controller *hose = pci_bus_to_host(dev->bus);
-	resource_size_t offset = 0, mask = (resource_size_t)-1;
-
-	if (res->flags & IORESOURCE_IO) {
-		offset = (unsigned long)hose->io_base_virt - _IO_BASE;
-		mask = 0xffffffffu;
-	} else if (res->flags & IORESOURCE_MEM)
-		offset = hose->pci_mem_offset;
-
-	res->start = (res->start + offset) & mask;
-	res->end = (res->end + offset) & mask;
-}
-
-
 /* This header fixup will do the resource fixup for all devices as they are
  * probed, but not for bridge ranges
  */
@@ -942,18 +888,11 @@ static void __devinit pcibios_fixup_resources(struct pci_dev *dev)
 			continue;
 		}
 
-		pr_debug("PCI:%s Resource %d %016llx-%016llx [%x] fixup...\n",
+		pr_debug("PCI:%s Resource %d %016llx-%016llx [%x]\n",
 			 pci_name(dev), i,
 			 (unsigned long long)res->start,\
 			 (unsigned long long)res->end,
 			 (unsigned int)res->flags);
-
-		fixup_resource(res, dev);
-
-		pr_debug("PCI:%s            %016llx-%016llx\n",
-			 pci_name(dev),
-			 (unsigned long long)res->start,
-			 (unsigned long long)res->end);
 	}
 
 	/* Call machine specific resource fixup */
@@ -1055,27 +994,18 @@ static void __devinit pcibios_fixup_bridge(struct pci_bus *bus)
 			continue;
 		}
 
-		pr_debug("PCI:%s Bus rsrc %d %016llx-%016llx [%x] fixup...\n",
+		pr_debug("PCI:%s Bus rsrc %d %016llx-%016llx [%x]\n",
 			 pci_name(dev), i,
 			 (unsigned long long)res->start,\
 			 (unsigned long long)res->end,
 			 (unsigned int)res->flags);
 
-		/* Perform fixup */
-		fixup_resource(res, dev);
-
 		/* Try to detect uninitialized P2P bridge resources,
 		 * and clear them out so they get re-assigned later
 		 */
 		if (pcibios_uninitialized_bridge_resource(bus, res)) {
 			res->flags = 0;
 			pr_debug("PCI:%s            (unassigned)\n", pci_name(dev));
-		} else {
-
-			pr_debug("PCI:%s            %016llx-%016llx\n",
-				 pci_name(dev),
-				 (unsigned long long)res->start,
-				 (unsigned long long)res->end);
 		}
 	}
 }
@@ -1589,7 +1519,8 @@ static void __devinit pcibios_setup_phb_resources(struct pci_controller *hose, s
 		 (unsigned long long)res->start,
 		 (unsigned long long)res->end,
 		 (unsigned long)res->flags);
-	pci_add_resource(resources, res);
+	pci_add_resource_offset(resources, res,
+			(resource_size_t) hose->io_base_virt - _IO_BASE);
 
 	/* Hookup PHB Memory resources */
 	for (i = 0; i < 3; ++i) {
@@ -1612,7 +1543,7 @@ static void __devinit pcibios_setup_phb_resources(struct pci_controller *hose, s
 			 (unsigned long long)res->start,
 			 (unsigned long long)res->end,
 			 (unsigned long)res->flags);
-		pci_add_resource(resources, res);
+		pci_add_resource_offset(resources, res, hose->pci_mem_offset);
 	}
 
 	pr_debug("PCI: PHB MEM offset     = %016llx\n",

