Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f74.google.com ([209.85.215.74]:48179 "EHLO
	mail-lpp01m010-f74.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030794Ab2CGWeP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 Mar 2012 17:34:15 -0500
Received: by laai8 with SMTP id i8so246764laa.1
        for <linux-pci@vger.kernel.org>; Wed, 07 Mar 2012 14:34:13 -0800 (PST)
Subject: [PATCH v3 25/34] mn10300/PCI: get rid of device resource fixups
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
	David Howells <dhowells@redhat.com>
Date: Wed, 07 Mar 2012 15:34:12 -0700
Message-ID: <20120307223412.25669.13638.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
References: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Tell the PCI core about host bridge address translation so it can take
care of bus-to-resource conversion for us.

CC: David Howells <dhowells@redhat.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/mn10300/include/asm/pci.h  |   16 +---------
 arch/mn10300/unit-asb2305/pci.c |   62 ++++++---------------------------------
 2 files changed, 10 insertions(+), 68 deletions(-)

diff --git a/arch/mn10300/include/asm/pci.h b/arch/mn10300/include/asm/pci.h
index 6095a28..dfe1581 100644
--- a/arch/mn10300/include/asm/pci.h
+++ b/arch/mn10300/include/asm/pci.h
@@ -85,21 +85,7 @@ extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
 /* implement the pci_ DMA API in terms of the generic device dma_ one */
 #include <asm-generic/pci-dma-compat.h>
 
-/**
- * pcibios_resource_to_bus - convert resource to PCI bus address
- * @dev: device which owns this resource
- * @region: converted bus-centric region (start,end)
- * @res: resource to convert
- *
- * Convert a resource to a PCI device bus address or bus window.
- */
-extern void pcibios_resource_to_bus(struct pci_dev *dev,
-				    struct pci_bus_region *region,
-				    struct resource *res);
-
-extern void pcibios_bus_to_resource(struct pci_dev *dev,
-				    struct resource *res,
-				    struct pci_bus_region *region);
+#define ARCH_HAS_GENERIC_PCI_OFFSETS
 
 static inline struct resource *
 pcibios_select_root(struct pci_dev *pdev, struct resource *res)
diff --git a/arch/mn10300/unit-asb2305/pci.c b/arch/mn10300/unit-asb2305/pci.c
index a7c5f08..6dce9fc 100644
--- a/arch/mn10300/unit-asb2305/pci.c
+++ b/arch/mn10300/unit-asb2305/pci.c
@@ -32,8 +32,7 @@ struct pci_ops *pci_root_ops;
  * insert specific PCI bus resources instead of using the platform-level bus
  * resources directly for the PCI root bus.
  *
- * These are configured and inserted by pcibios_init() and are attached to the
- * root bus by pcibios_fixup_bus().
+ * These are configured and inserted by pcibios_init().
  */
 static struct resource pci_ioport_resource = {
 	.name	= "PCI IO",
@@ -78,52 +77,6 @@ static inline int __query(const struct pci_bus *bus, unsigned int devfn)
 }
 
 /*
- * translate Linuxcentric addresses to PCI bus addresses
- */
-void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
-			     struct resource *res)
-{
-	if (res->flags & IORESOURCE_IO) {
-		region->start = (res->start & 0x00ffffff);
-		region->end   = (res->end   & 0x00ffffff);
-	}
-
-	if (res->flags & IORESOURCE_MEM) {
-		region->start = (res->start & 0x03ffffff) | MEM_PAGING_REG;
-		region->end   = (res->end   & 0x03ffffff) | MEM_PAGING_REG;
-	}
-
-#if 0
-	printk(KERN_DEBUG "RES->BUS: %lx-%lx => %lx-%lx\n",
-	       res->start, res->end, region->start, region->end);
-#endif
-}
-EXPORT_SYMBOL(pcibios_resource_to_bus);
-
-/*
- * translate PCI bus addresses to Linuxcentric addresses
- */
-void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
-			     struct pci_bus_region *region)
-{
-	if (res->flags & IORESOURCE_IO) {
-		res->start = (region->start & 0x00ffffff) | 0xbe000000;
-		res->end   = (region->end   & 0x00ffffff) | 0xbe000000;
-	}
-
-	if (res->flags & IORESOURCE_MEM) {
-		res->start = (region->start & 0x03ffffff) | 0xb8000000;
-		res->end   = (region->end   & 0x03ffffff) | 0xb8000000;
-	}
-
-#if 0
-	printk(KERN_INFO "BUS->RES: %lx-%lx => %lx-%lx\n",
-	       region->start, region->end, res->start, res->end);
-#endif
-}
-EXPORT_SYMBOL(pcibios_bus_to_resource);
-
-/*
  *
  */
 static int pci_ampci_read_config_byte(struct pci_bus *bus, unsigned int devfn,
@@ -364,9 +317,6 @@ static void __devinit pcibios_fixup_device_resources(struct pci_dev *dev)
 		if (!dev->resource[i].flags)
 			continue;
 
-		region.start = dev->resource[i].start;
-		region.end = dev->resource[i].end;
-		pcibios_bus_to_resource(dev, &dev->resource[i], &region);
 		if (is_valid_resource(dev, i))
 			pci_claim_resource(dev, i);
 	}
@@ -397,6 +347,7 @@ void __devinit pcibios_fixup_bus(struct pci_bus *bus)
  */
 static int __init pcibios_init(void)
 {
+	resource_size_t io_offset, mem_offset;
 	LIST_HEAD(resources);
 
 	ioport_resource.start	= 0xA0000000;
@@ -420,8 +371,13 @@ static int __init pcibios_init(void)
 	printk(KERN_INFO "PCI: Probing PCI hardware [mempage %08x]\n",
 	       MEM_PAGING_REG);
 
-	pci_add_resource(&resources, &pci_ioport_resource);
-	pci_add_resource(&resources, &pci_iomem_resource);
+	io_offset = pci_ioport_resource.start -
+	    (pci_ioport_resource.start & 0x00ffffff);
+	mem_offset = pci_iomem_resource.start -
+	    ((pci_iomem_resource.start & 0x03ffffff) | MEM_PAGING_REG);
+
+	pci_add_resource_offset(&resources, &pci_ioport_resource, io_offset);
+	pci_add_resource_offset(&resources, &pci_iomem_resource, mem_offset);
 	pci_root_bus = pci_scan_root_bus(NULL, 0, &pci_direct_ampci, NULL,
 					 &resources);
 

