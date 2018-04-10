Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v1 2/2] microblaze/PCI: Remove pcibios_claim_one_bus() dead
 code
From: Bjorn Helgaas <helgaas@kernel.org>
To: Michal Simek <monstr@monstr.eu>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 10 Apr 2018 08:25:12 -0500
Message-ID: <152336671276.18958.18175353602437569251.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152336656418.18958.17017091754578447948.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152336656418.18958.17017091754578447948.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

pcibios_claim_one_bus() is defined but never used.  Remove it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/microblaze/include/asm/pci.h |    2 --
 arch/microblaze/pci/pci-common.c  |   37 -------------------------------------
 2 files changed, 39 deletions(-)

diff --git a/arch/microblaze/include/asm/pci.h b/arch/microblaze/include/asm/pci.h
index 4a96480e7716..7cfb90010f16 100644
--- a/arch/microblaze/include/asm/pci.h
+++ b/arch/microblaze/include/asm/pci.h
@@ -67,8 +67,6 @@ extern int pci_mmap_legacy_page_range(struct pci_bus *bus,
  */
 #define PCI_DMA_BUS_IS_PHYS     (1)
 
-extern void pcibios_claim_one_bus(struct pci_bus *b);
-
 extern void pcibios_resource_survey(void);
 
 struct file;
diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index 61494c4379f9..6a4e5b32a90e 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -996,43 +996,6 @@ void __init pcibios_resource_survey(void)
 	pci_assign_unassigned_resources();
 }
 
-/* This is used by the PCI hotplug driver to allocate resource
- * of newly plugged busses. We can try to consolidate with the
- * rest of the code later, for now, keep it as-is as our main
- * resource allocation function doesn't deal with sub-trees yet.
- */
-void pcibios_claim_one_bus(struct pci_bus *bus)
-{
-	struct pci_dev *dev;
-	struct pci_bus *child_bus;
-
-	list_for_each_entry(dev, &bus->devices, bus_list) {
-		int i;
-
-		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-			struct resource *r = &dev->resource[i];
-
-			if (r->parent || !r->start || !r->flags)
-				continue;
-
-			pr_debug("PCI: Claiming %s: ", pci_name(dev));
-			pr_debug("Resource %d: %016llx..%016llx [%x]\n",
-				 i, (unsigned long long)r->start,
-				 (unsigned long long)r->end,
-				 (unsigned int)r->flags);
-
-			if (pci_claim_resource(dev, i) == 0)
-				continue;
-
-			pci_claim_bridge_resource(dev, i);
-		}
-	}
-
-	list_for_each_entry(child_bus, &bus->children, node)
-		pcibios_claim_one_bus(child_bus);
-}
-EXPORT_SYMBOL_GPL(pcibios_claim_one_bus);
-
 static void pcibios_setup_phb_resources(struct pci_controller *hose,
 					struct list_head *resources)
 {
