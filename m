Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: [RFC PATCH v1 10/18] microblaze/PCI: get rid of device resource fixups
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>
Date: Mon, 30 Jan 2012 09:58:00 -0700
Message-ID: <20120130165800.3231.42814.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120130165430.3231.97740.stgit@bhelgaas.mtv.corp.google.com>
References: <20120130165430.3231.97740.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Tell the PCI core about host bridge address translation so it can take
care of bus-to-resource conversion for us.

N.B. We might need to tweak the I/O range and offset to account for the
32-bit mask previously used in pcibios_resource_to_bus().  I don't
know the details of this mapping.  If anybody can help me test and
fix this, please let me know.

CC: Michal Simek <monstr@monstr.eu>
---
 arch/microblaze/include/asm/pci.h |    8 +---
 arch/microblaze/pci/pci-common.c  |   69 ++-----------------------------------
 2 files changed, 4 insertions(+), 73 deletions(-)

diff --git a/arch/microblaze/include/asm/pci.h b/arch/microblaze/include/asm/pci.h
index 0331376..8db01f7 100644
--- a/arch/microblaze/include/asm/pci.h
+++ b/arch/microblaze/include/asm/pci.h
@@ -94,13 +94,7 @@ extern int pci_mmap_legacy_page_range(struct pci_bus *bus,
  */
 #define PCI_DMA_BUS_IS_PHYS     (1)
 
-extern void pcibios_resource_to_bus(struct pci_dev *dev,
-			struct pci_bus_region *region,
-			struct resource *res);
-
-extern void pcibios_bus_to_resource(struct pci_dev *dev,
-			struct resource *res,
-			struct pci_bus_region *region);
+#define ARCH_HAS_GENERIC_PCI_OFFSETS
 
 static inline struct resource *pcibios_select_root(struct pci_dev *pdev,
 			struct resource *res)
diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index 85f2ac1..a9fa875 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -840,59 +840,6 @@ int pci_proc_domain(struct pci_bus *bus)
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
 /* This header fixup will do the resource fixup for all devices as they are
  * probed, but not for bridge ranges
  */
@@ -929,18 +876,11 @@ static void __devinit pcibios_fixup_resources(struct pci_dev *dev)
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
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pcibios_fixup_resources);
@@ -1037,9 +977,6 @@ static void __devinit pcibios_fixup_bridge(struct pci_bus *bus)
 			 (unsigned long long)res->end,
 			 (unsigned int)res->flags);
 
-		/* Perform fixup */
-		fixup_resource(res, dev);
-
 		/* Try to detect uninitialized P2P bridge resources,
 		 * and clear them out so they get re-assigned later
 		 */
@@ -1535,7 +1472,7 @@ static void __devinit pcibios_setup_phb_resources(struct pci_controller *hose, s
 		res->end = res->start + IO_SPACE_LIMIT;
 		res->flags = IORESOURCE_IO;
 	}
-	pci_add_resource(resources, res);
+	pci_add_resource_offset(resources, res, hose->io_base_virt - _IO_BASE);
 
 	pr_debug("PCI: PHB IO resource    = %016llx-%016llx [%lx]\n",
 		 (unsigned long long)res->start,
@@ -1558,7 +1495,7 @@ static void __devinit pcibios_setup_phb_resources(struct pci_controller *hose, s
 			res->flags = IORESOURCE_MEM;
 
 		}
-		pci_add_resource(resources, res);
+		pci_add_resource_offset(resources, res, hose->pci_mem_offset);
 
 		pr_debug("PCI: PHB MEM resource %d = %016llx-%016llx [%lx]\n",
 			i, (unsigned long long)res->start,

