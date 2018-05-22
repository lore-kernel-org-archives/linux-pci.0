Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v1 1/4] sparc/PCI: Request legacy VGA framebuffer only for
 VGA devices
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Meelis Roos <mroos@linux.ee>
Date: Mon, 21 May 2018 19:30:36 -0500
Message-ID: <152694903600.59585.8756527097089555500.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152694888798.59585.8779818482732387864.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152694888798.59585.8779818482732387864.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Previously we unconditionally requested the legacy VGA framebuffer (bus
address 0xa0000-0xbffff) before we even know what PCI devices are present,
in these paths:

  pci_fire_pbm_init, schizo_pbm_init, pci_sun4v_pbm_init, psycho_pbm_init_common
    pci_determine_mem_io_space
      pci_register_legacy_regions
        p->start = mem_res->start + 0xa0000
        request_resource(mem_res, p)    # claim VGA framebuffer
    pci_scan_one_pbm
      pci_of_scan_bus                   # scan DT for PCI devices
      pci_claim_bus_resources           # claim PCI device BARs

If we found a PCI device with a BAR or bridge window that overlapped the
framebuffer area, we complained about not being able to claim the BAR,
e.g.,

  pci 0000:00:01.0: can't claim BAR 8 [mem 0x1ff00000000-0x1ffbfffffff]: address conflict with Video RAM area [??? 0x1ff000a0000-0x1ff000bffff flags 0x80000000]
  pci 0000:02:01.0: can't claim BAR 8 [mem 0x1ff00100000-0x1ff028fffff]: no compatible bridge window
  pci 0000:03:0f.0: can't claim BAR 8 [mem 0x1ff00100000-0x1ff028fffff]: no compatible bridge window
  pci 0000:04:04.0: can't claim BAR 1 [mem 0x1ff02808000-0x1ff02808fff]: no compatible bridge window

This may make the conflicting device unusable because we try not to enable
devices that have unassigned or conflicting BARs, e.g.,

  qla1280 0000:04:04.0: can't ioremap BAR 1: [mem size 0x00001000]
  qla1280: Unable to map I/O memory

If there is no VGA device in the same PCI segment, there's no reason to
reserve the framebuffer and there's no conflict.  If there *is* a VGA
device in the same segment, both the VGA device and the device with an
overlapping BAR may respond to the framebuffer addresses, which may cause
bus errors.

Request the legacy framebuffer area only when we actually find a VGA
device.  The fact that VGA devices use the legacy framebuffer even though
it's not reported in a BAR is not sparc-specific, so the reservation of
that area could be made more generic in the PCI core eventually.

Note that on some systems, e.g., Blade 100, we still report a conflict
between an ISA bridge (00:07.0) and a VGA device (00:13.0):

  pci_bus 0000:00: root bus resource [mem 0x1ff00000000-0x1ffffffffff] (bus address [0x00000000-0xffffffff])
  pci 0000:00:07.0: reg 0x14: [mem 0x1ff00000000-0x1ff000fffff]
  pci 0000:00:13.0: can't claim VGA legacy [mem 0x1ff000a0000-0x1ff000bffff]: address conflict with 0000:00:07.0 [mem 0x1ff00000000-0x1ff000fffff]

This is probably harmless, but if the VGA device and something behind the
ISA bridge both responded to reads of the framebuffer, it would cause a bus
error.

Link: https://lkml.kernel.org/r/alpine.LRH.2.21.1804112323170.25495@math.ut.ee
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=117191#c35
Reported-by: Meelis Roos <mroos@linux.ee>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/sparc/kernel/pci.c        |   42 ++++++++++++++++++++++++++++++++++++++++
 arch/sparc/kernel/pci_common.c |   19 ------------------
 2 files changed, 42 insertions(+), 19 deletions(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 41b20edb427d..8a04983cf8a1 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -624,6 +624,45 @@ static void pci_bus_register_of_sysfs(struct pci_bus *bus)
 		pci_bus_register_of_sysfs(child_bus);
 }
 
+static void pci_claim_legacy_resources(struct pci_dev *dev)
+{
+	struct pci_bus_region region;
+	struct resource *p, *root, *conflict;
+
+	if ((dev->class >> 8) != PCI_CLASS_DISPLAY_VGA)
+		return;
+
+	p = kzalloc(sizeof(*p), GFP_KERNEL);
+	if (!p)
+		return;
+
+	p->name = "Video RAM area";
+	p->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+
+	region.start = 0xa0000UL;
+	region.end = region.start + 0x1ffffUL;
+	pcibios_bus_to_resource(dev->bus, p, &region);
+
+	root = pci_find_parent_resource(dev, p);
+	if (!root) {
+		pci_info(dev, "can't claim VGA legacy %pR: no compatible bridge window\n", p);
+		goto err;
+	}
+
+	conflict = request_resource_conflict(root, p);
+	if (conflict) {
+		pci_info(dev, "can't claim VGA legacy %pR: address conflict with %s %pR\n",
+			 p, conflict->name, conflict);
+		goto err;
+	}
+
+	pci_info(dev, "VGA legacy framebuffer %pR\n", p);
+	return;
+
+err:
+	kfree(p);
+}
+
 static void pci_claim_bus_resources(struct pci_bus *bus)
 {
 	struct pci_bus *child_bus;
@@ -648,6 +687,8 @@ static void pci_claim_bus_resources(struct pci_bus *bus)
 
 			pci_claim_resource(dev, i);
 		}
+
+		pci_claim_legacy_resources(dev);
 	}
 
 	list_for_each_entry(child_bus, &bus->children, node)
@@ -687,6 +728,7 @@ struct pci_bus *pci_scan_one_pbm(struct pci_pbm_info *pbm,
 	pci_bus_register_of_sysfs(bus);
 
 	pci_claim_bus_resources(bus);
+
 	pci_bus_add_devices(bus);
 	return bus;
 }
diff --git a/arch/sparc/kernel/pci_common.c b/arch/sparc/kernel/pci_common.c
index 38d46bcc8634..9bb6a192ef3f 100644
--- a/arch/sparc/kernel/pci_common.c
+++ b/arch/sparc/kernel/pci_common.c
@@ -329,23 +329,6 @@ void pci_get_pbm_props(struct pci_pbm_info *pbm)
 	}
 }
 
-static void pci_register_legacy_regions(struct resource *io_res,
-					struct resource *mem_res)
-{
-	struct resource *p;
-
-	/* VGA Video RAM. */
-	p = kzalloc(sizeof(*p), GFP_KERNEL);
-	if (!p)
-		return;
-
-	p->name = "Video RAM area";
-	p->start = mem_res->start + 0xa0000UL;
-	p->end = p->start + 0x1ffffUL;
-	p->flags = IORESOURCE_BUSY;
-	request_resource(mem_res, p);
-}
-
 static void pci_register_iommu_region(struct pci_pbm_info *pbm)
 {
 	const u32 *vdma = of_get_property(pbm->op->dev.of_node, "virtual-dma",
@@ -487,8 +470,6 @@ void pci_determine_mem_io_space(struct pci_pbm_info *pbm)
 	if (pbm->mem64_space.flags)
 		request_resource(&iomem_resource, &pbm->mem64_space);
 
-	pci_register_legacy_regions(&pbm->io_space,
-				    &pbm->mem_space);
 	pci_register_iommu_region(pbm);
 }
 
