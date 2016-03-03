Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48526 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757410AbcCCQyl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 3 Mar 2016 11:54:41 -0500
Subject: [PATCH v1 06/12] ia64/PCI: Use temporary struct resource * to avoid
 repetition
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>,
	Tony Luck <tony.luck@intel.com>,
	DRI <dri-devel@lists.freedesktop.org>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
	linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Bruno =?utf-8?q?Pr=C3=A9mont?= <bonbons@linux-vserver.org>,
	Daniel Stone <daniel@fooishbar.org>,
	Alex Deucher <alexdeucher@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ville =?utf-8?b?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Date: Thu, 03 Mar 2016 10:54:37 -0600
Message-ID: <20160303165437.3025.37048.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160303164533.3025.82439.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160303164533.3025.82439.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use a temporary struct resource pointer to avoid needless repetition of
"dev->resource[idx]".  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/ia64/sn/kernel/io_acpi_init.c |   10 +++++----
 arch/ia64/sn/kernel/io_init.c      |   39 ++++++++++++++++--------------------
 2 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/arch/ia64/sn/kernel/io_acpi_init.c b/arch/ia64/sn/kernel/io_acpi_init.c
index 0640739..815c291 100644
--- a/arch/ia64/sn/kernel/io_acpi_init.c
+++ b/arch/ia64/sn/kernel/io_acpi_init.c
@@ -429,6 +429,7 @@ sn_acpi_slot_fixup(struct pci_dev *dev)
 	void __iomem *addr;
 	struct pcidev_info *pcidev_info = NULL;
 	struct sn_irq_info *sn_irq_info = NULL;
+	struct resource *res;
 	size_t image_size, size;
 
 	if (sn_acpi_get_pcidev_info(dev, &pcidev_info, &sn_irq_info)) {
@@ -446,14 +447,13 @@ sn_acpi_slot_fixup(struct pci_dev *dev)
 		addr = ioremap(pcidev_info->pdi_pio_mapped_addr[PCI_ROM_RESOURCE],
 			       size);
 		image_size = pci_get_rom_size(dev, addr, size);
-		dev->resource[PCI_ROM_RESOURCE].start = (unsigned long) addr;
-		dev->resource[PCI_ROM_RESOURCE].end =
-					(unsigned long) addr + image_size - 1;
-		dev->resource[PCI_ROM_RESOURCE].flags |= IORESOURCE_ROM_BIOS_COPY;
+		res = &dev->resource[PCI_ROM_RESOURCE];
+		res->start = (unsigned long) addr;
+		res->end = (unsigned long) addr + image_size - 1;
+		res->flags |= IORESOURCE_ROM_BIOS_COPY;
 	}
 	sn_pci_fixup_slot(dev, pcidev_info, sn_irq_info);
 }
-
 EXPORT_SYMBOL(sn_acpi_slot_fixup);
 
 
diff --git a/arch/ia64/sn/kernel/io_init.c b/arch/ia64/sn/kernel/io_init.c
index 1be65eb..40c0263 100644
--- a/arch/ia64/sn/kernel/io_init.c
+++ b/arch/ia64/sn/kernel/io_init.c
@@ -150,7 +150,8 @@ void
 sn_io_slot_fixup(struct pci_dev *dev)
 {
 	int idx;
-	unsigned long addr, end, size, start;
+	struct resource *res;
+	unsigned long addr, size;
 	struct pcidev_info *pcidev_info;
 	struct sn_irq_info *sn_irq_info;
 	int status;
@@ -175,33 +176,31 @@ sn_io_slot_fixup(struct pci_dev *dev)
 
 	/* Copy over PIO Mapped Addresses */
 	for (idx = 0; idx <= PCI_ROM_RESOURCE; idx++) {
-
-		if (!pcidev_info->pdi_pio_mapped_addr[idx]) {
+		if (!pcidev_info->pdi_pio_mapped_addr[idx])
 			continue;
-		}
 
-		start = dev->resource[idx].start;
-		end = dev->resource[idx].end;
-		size = end - start;
-		if (size == 0) {
+		res = &dev->resource[idx];
+
+		size = res->end - res->start;
+		if (size == 0)
 			continue;
-		}
+
 		addr = pcidev_info->pdi_pio_mapped_addr[idx];
 		addr = ((addr << 4) >> 4) | __IA64_UNCACHED_OFFSET;
-		dev->resource[idx].start = addr;
-		dev->resource[idx].end = addr + size;
+		res->start = addr;
+		res->end = addr + size;
 
 		/*
 		 * if it's already in the device structure, remove it before
 		 * inserting
 		 */
-		if (dev->resource[idx].parent && dev->resource[idx].parent->child)
-			release_resource(&dev->resource[idx]);
+		if (res->parent && res->parent->child)
+			release_resource(res);
 
-		if (dev->resource[idx].flags & IORESOURCE_IO)
-			insert_resource(&ioport_resource, &dev->resource[idx]);
+		if (res->flags & IORESOURCE_IO)
+			insert_resource(&ioport_resource, res);
 		else
-			insert_resource(&iomem_resource, &dev->resource[idx]);
+			insert_resource(&iomem_resource, res);
 		/*
 		 * If ROM, set the actual ROM image size, and mark as
 		 * shadowed in PROM.
@@ -213,17 +212,13 @@ sn_io_slot_fixup(struct pci_dev *dev)
 			rom = ioremap(pci_resource_start(dev, PCI_ROM_RESOURCE),
 				      size + 1);
 			image_size = pci_get_rom_size(dev, rom, size + 1);
-			dev->resource[PCI_ROM_RESOURCE].end =
-				dev->resource[PCI_ROM_RESOURCE].start +
-				image_size - 1;
-			dev->resource[PCI_ROM_RESOURCE].flags |=
-						 IORESOURCE_ROM_BIOS_COPY;
+			res->end = res->start + image_size - 1;
+			res->flags |= IORESOURCE_ROM_BIOS_COPY;
 		}
 	}
 
 	sn_pci_fixup_slot(dev, pcidev_info, sn_irq_info);
 }
-
 EXPORT_SYMBOL(sn_io_slot_fixup);
 
 /*

