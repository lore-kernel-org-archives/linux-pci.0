Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qy0-f202.google.com ([209.85.216.202]:48145 "EHLO
	mail-qy0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753155Ab2A3Q55 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 30 Jan 2012 11:57:57 -0500
Received: by mail-qy0-f202.google.com with SMTP id d17so399024qcs.1
        for <linux-pci@vger.kernel.org>; Mon, 30 Jan 2012 08:57:57 -0800 (PST)
Subject: [RFC PATCH v1 09/18] ia64/PCI: get rid of device resource fixups
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arch@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
	Jack Steiner <steiner@sgi.com>
Date: Mon, 30 Jan 2012 09:57:55 -0700
Message-ID: <20120130165755.3231.58980.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120130165430.3231.97740.stgit@bhelgaas.mtv.corp.google.com>
References: <20120130165430.3231.97740.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Tell the PCI core about host bridge address translation so it can take
care of bus-to-resource conversion for us.

CC: Tony Luck <tony.luck@intel.com>
CC: Jack Steiner <steiner@sgi.com>
---
 arch/ia64/include/asm/pci.h   |    6 +---
 arch/ia64/pci/pci.c           |   55 +----------------------------------------
 arch/ia64/sn/kernel/io_init.c |    4 ++-
 3 files changed, 6 insertions(+), 59 deletions(-)

diff --git a/arch/ia64/include/asm/pci.h b/arch/ia64/include/asm/pci.h
index 279b38a..519bb5c 100644
--- a/arch/ia64/include/asm/pci.h
+++ b/arch/ia64/include/asm/pci.h
@@ -108,11 +108,7 @@ static inline int pci_proc_domain(struct pci_bus *bus)
 	return (pci_domain_nr(bus) != 0);
 }
 
-extern void pcibios_resource_to_bus(struct pci_dev *dev,
-		struct pci_bus_region *region, struct resource *res);
-
-extern void pcibios_bus_to_resource(struct pci_dev *dev,
-		struct resource *res, struct pci_bus_region *region);
+#define ARCH_HAS_GENERIC_PCI_OFFSETS
 
 static inline struct resource *
 pcibios_select_root(struct pci_dev *pdev, struct resource *res)
diff --git a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
index f82f5d4..d1ce320 100644
--- a/arch/ia64/pci/pci.c
+++ b/arch/ia64/pci/pci.c
@@ -320,7 +320,8 @@ static __devinit acpi_status add_window(struct acpi_resource *res, void *data)
 	 * Ignore these tiny memory ranges */
 	if (!((window->resource.flags & IORESOURCE_MEM) &&
 	      (window->resource.end - window->resource.start < 16)))
-		pci_add_resource(&info->resources, &window->resource);
+		pci_add_resource_offset(&info->resources, &window->resource,
+					window->offset);
 
 	return AE_OK;
 }
@@ -395,54 +396,6 @@ out1:
 	return NULL;
 }
 
-void pcibios_resource_to_bus(struct pci_dev *dev,
-		struct pci_bus_region *region, struct resource *res)
-{
-	struct pci_controller *controller = PCI_CONTROLLER(dev);
-	unsigned long offset = 0;
-	int i;
-
-	for (i = 0; i < controller->windows; i++) {
-		struct pci_window *window = &controller->window[i];
-		if (!(window->resource.flags & res->flags))
-			continue;
-		if (window->resource.start > res->start)
-			continue;
-		if (window->resource.end < res->end)
-			continue;
-		offset = window->offset;
-		break;
-	}
-
-	region->start = res->start - offset;
-	region->end = res->end - offset;
-}
-EXPORT_SYMBOL(pcibios_resource_to_bus);
-
-void pcibios_bus_to_resource(struct pci_dev *dev,
-		struct resource *res, struct pci_bus_region *region)
-{
-	struct pci_controller *controller = PCI_CONTROLLER(dev);
-	unsigned long offset = 0;
-	int i;
-
-	for (i = 0; i < controller->windows; i++) {
-		struct pci_window *window = &controller->window[i];
-		if (!(window->resource.flags & res->flags))
-			continue;
-		if (window->resource.start - window->offset > region->start)
-			continue;
-		if (window->resource.end - window->offset < region->end)
-			continue;
-		offset = window->offset;
-		break;
-	}
-
-	res->start = region->start + offset;
-	res->end = region->end + offset;
-}
-EXPORT_SYMBOL(pcibios_bus_to_resource);
-
 static int __devinit is_valid_resource(struct pci_dev *dev, int idx)
 {
 	unsigned int i, type_mask = IORESOURCE_IO | IORESOURCE_MEM;
@@ -464,15 +417,11 @@ static int __devinit is_valid_resource(struct pci_dev *dev, int idx)
 static void __devinit
 pcibios_fixup_resources(struct pci_dev *dev, int start, int limit)
 {
-	struct pci_bus_region region;
 	int i;
 
 	for (i = start; i < limit; i++) {
 		if (!dev->resource[i].flags)
 			continue;
-		region.start = dev->resource[i].start;
-		region.end = dev->resource[i].end;
-		pcibios_bus_to_resource(dev, &dev->resource[i], &region);
 		if ((is_valid_resource(dev, i)))
 			pci_claim_resource(dev, i);
 	}
diff --git a/arch/ia64/sn/kernel/io_init.c b/arch/ia64/sn/kernel/io_init.c
index c99c2ca..238e2c5 100644
--- a/arch/ia64/sn/kernel/io_init.c
+++ b/arch/ia64/sn/kernel/io_init.c
@@ -320,7 +320,9 @@ sn_pci_controller_fixup(int segment, int busnum, struct pci_bus *bus)
 				   prom_bussoft_ptr->bs_legacy_io,
 				   prom_bussoft_ptr->bs_legacy_mem);
 	for (i = 0; i < controller->windows; i++)
-		pci_add_resource(&resources, &controller->window[i].resource);
+		pci_add_resource_offset(&resources,
+					&controller->window[i].resource,
+					controller->window[i].offset);
 	bus = pci_scan_root_bus(NULL, busnum, &pci_root_ops, controller,
 				&resources);
  	if (bus == NULL)

