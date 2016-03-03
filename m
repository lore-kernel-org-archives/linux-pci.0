Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v1 08/12] ia64/PCI: Keep CPU physical (not virtual)
 addresses in shadow ROM resource
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
Date: Thu, 03 Mar 2016 10:54:52 -0600
Message-ID: <20160303165452.3025.73760.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160303164533.3025.82439.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160303164533.3025.82439.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

A struct resource contains CPU physical addresses, not virtual addresses.
But sn_acpi_slot_fixup() and sn_io_slot_fixup() stored the virtual address
of a shadow ROM copy in the resource.  To compensate, pci_map_rom() had a
special case that returned the resource address directly rather than
calling ioremap() on it.

When we're using a shadow copy in RAM or PROM, disable the ROM BAR and
release the address space it was consuming.

Store the CPU physical (not virtual) address in the shadow ROM resource,
and mark the resource as IORESOURCE_ROM_SHADOW so we use the normal
pci_map_rom() path that ioremaps the copy.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/ia64/sn/kernel/io_acpi_init.c |   18 +++++++++++-------
 arch/ia64/sn/kernel/io_init.c      |   17 +++++------------
 2 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/arch/ia64/sn/kernel/io_acpi_init.c b/arch/ia64/sn/kernel/io_acpi_init.c
index 815c291..231234c 100644
--- a/arch/ia64/sn/kernel/io_acpi_init.c
+++ b/arch/ia64/sn/kernel/io_acpi_init.c
@@ -430,7 +430,7 @@ sn_acpi_slot_fixup(struct pci_dev *dev)
 	struct pcidev_info *pcidev_info = NULL;
 	struct sn_irq_info *sn_irq_info = NULL;
 	struct resource *res;
-	size_t image_size, size;
+	size_t size;
 
 	if (sn_acpi_get_pcidev_info(dev, &pcidev_info, &sn_irq_info)) {
 		panic("%s:  Failure obtaining pcidev_info for %s\n",
@@ -444,13 +444,17 @@ sn_acpi_slot_fixup(struct pci_dev *dev)
 		 * of the shadowed copy, and the actual length of the ROM image.
 		 */
 		size = pci_resource_len(dev, PCI_ROM_RESOURCE);
-		addr = ioremap(pcidev_info->pdi_pio_mapped_addr[PCI_ROM_RESOURCE],
-			       size);
-		image_size = pci_get_rom_size(dev, addr, size);
+
 		res = &dev->resource[PCI_ROM_RESOURCE];
-		res->start = (unsigned long) addr;
-		res->end = (unsigned long) addr + image_size - 1;
-		res->flags |= IORESOURCE_ROM_BIOS_COPY;
+
+		pci_disable_rom(dev);
+		if (res->parent)
+			release_resource(res);
+
+		res->start = pcidev_info->pdi_pio_mapped_addr[PCI_ROM_RESOURCE];
+		res->end = res->start + size - 1;
+		res->flags = IORESOURCE_MEM | IORESOURCE_ROM_SHADOW |
+			     IORESOURCE_PCI_FIXED;
 	}
 	sn_pci_fixup_slot(dev, pcidev_info, sn_irq_info);
 }
diff --git a/arch/ia64/sn/kernel/io_init.c b/arch/ia64/sn/kernel/io_init.c
index 0227e20..c15a41e 100644
--- a/arch/ia64/sn/kernel/io_init.c
+++ b/arch/ia64/sn/kernel/io_init.c
@@ -185,8 +185,7 @@ sn_io_slot_fixup(struct pci_dev *dev)
 		if (size == 0)
 			continue;
 
-		res->start = ioremap(pcidev_info->pdi_pio_mapped_addr[idx],
-				     size + 1);
+		res->start = pcidev_info->pdi_pio_mapped_addr[idx];
 		res->end = addr + size;
 
 		/*
@@ -201,18 +200,12 @@ sn_io_slot_fixup(struct pci_dev *dev)
 		else
 			insert_resource(&iomem_resource, res);
 		/*
-		 * If ROM, set the actual ROM image size, and mark as
-		 * shadowed in PROM.
+		 * If ROM, mark as shadowed in PROM.
 		 */
 		if (idx == PCI_ROM_RESOURCE) {
-			size_t image_size;
-			void __iomem *rom;
-
-			rom = ioremap(pci_resource_start(dev, PCI_ROM_RESOURCE),
-				      size + 1);
-			image_size = pci_get_rom_size(dev, rom, size + 1);
-			res->end = res->start + image_size - 1;
-			res->flags |= IORESOURCE_ROM_BIOS_COPY;
+			pci_disable_rom(dev);
+			res->flags = IORESOURCE_MEM | IORESOURCE_ROM_SHADOW |
+				     IORESOURCE_PCI_FIXED;
 		}
 	}
 
