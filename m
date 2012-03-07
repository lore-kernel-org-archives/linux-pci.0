Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: [PATCH v3 17/34] PCI: convert bus addresses to resource when reading
	BARs
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arch@vger.kernel.org, linux-pci@vger.kernel.org
Date: Wed, 07 Mar 2012 15:33:31 -0700
Message-ID: <20120307223331.25669.11682.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
References: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some PCI host bridges translate CPU addresses to PCI bus addresses.
Previously, we initialized pci_dev resources with PCI bus addresses,
then converted them to CPU addresses later in arch-specific code
(pcibios_fixup_resources()), which leaves a window of time where the
pci_dev resources are incorrect.

This patch adds support in the core for this address translation.
When the arch creates the root bus, it can supply the host bridge
address translation information, and the core can use it to set the
pci_dev resources correctly from the beginning.

This gives us a way to fix the problem that quirks that run between device
discovery and pcibios_fixup_resources() fail because they use pci_dev
resources that haven't been converted.  The reference below is to one
such problem that affected ARM and ia64.

Note that this patch has no effect until an arch starts using
pci_add_resource_offset() with a non-zero offset: before that, all
all host bridge windows have a zero offset and pci_bus_to_resource()
copies the pci_bus_region directly to the struct resource.

Reference: https://lkml.org/lkml/2009/10/12/405
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c |  130 +++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 105 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 3f07cb6..6713447 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -61,6 +61,63 @@ static struct pci_host_bridge *pci_host_bridge(struct pci_dev *dev)
 	return NULL;
 }
 
+static bool resource_contains(struct resource *res1, struct resource *res2)
+{
+	return res1->start <= res2->start && res1->end >= res2->end;
+}
+
+void pci_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
+			struct resource *res)
+{
+	struct pci_host_bridge *bridge = pci_host_bridge(dev);
+	struct pci_host_bridge_window *window;
+	resource_size_t offset = 0;
+
+	list_for_each_entry(window, &bridge->windows, list) {
+		if (resource_type(res) != resource_type(window->res))
+			continue;
+
+		if (resource_contains(window->res, res)) {
+			offset = window->offset;
+			break;
+		}
+	}
+
+	region->start = res->start - offset;
+	region->end = res->end - offset;
+}
+
+static bool region_contains(struct pci_bus_region *region1,
+			    struct pci_bus_region *region2)
+{
+	return region1->start <= region2->start && region1->end >= region2->end;
+}
+
+void pci_bus_to_resource(struct pci_dev *dev, struct resource *res,
+			 struct pci_bus_region *region)
+{
+	struct pci_host_bridge *bridge = pci_host_bridge(dev);
+	struct pci_host_bridge_window *window;
+	struct pci_bus_region bus_region;
+	resource_size_t offset = 0;
+
+	list_for_each_entry(window, &bridge->windows, list) {
+		if (resource_type(res) != resource_type(window->res))
+			continue;
+
+		bus_region.start = window->res->start - window->offset;
+		bus_region.end = window->res->end - window->offset;
+
+		if (region_contains(&bus_region, region)) {
+			offset = window->offset;
+			break;
+		}
+	}
+
+	res->start = region->start + offset;
+	res->end = region->end + offset;
+}
+
 /*
  * PCI Bus Class
  */
@@ -154,6 +211,7 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 {
 	u32 l, sz, mask;
 	u16 orig_cmd;
+	struct pci_bus_region region;
 
 	mask = type ? PCI_ROM_ADDRESS_MASK : ~0;
 
@@ -233,11 +291,13 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 			/* Address above 32-bit boundary; disable the BAR */
 			pci_write_config_dword(dev, pos, 0);
 			pci_write_config_dword(dev, pos + 4, 0);
-			res->start = 0;
-			res->end = sz64;
+			region.start = 0;
+			region.end = sz64;
+			pci_bus_to_resource(dev, res, &region);
 		} else {
-			res->start = l64;
-			res->end = l64 + sz64;
+			region.start = l64;
+			region.end = l64 + sz64;
+			pci_bus_to_resource(dev, res, &region);
 			dev_printk(KERN_DEBUG, &dev->dev, "reg %x: %pR\n",
 				   pos, res);
 		}
@@ -247,8 +307,9 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 		if (!sz)
 			goto fail;
 
-		res->start = l;
-		res->end = l + sz;
+		region.start = l;
+		region.end = l + sz;
+		pci_bus_to_resource(dev, res, &region);
 
 		dev_printk(KERN_DEBUG, &dev->dev, "reg %x: %pR\n", pos, res);
 	}
@@ -285,7 +346,8 @@ static void __devinit pci_read_bridge_io(struct pci_bus *child)
 	struct pci_dev *dev = child->self;
 	u8 io_base_lo, io_limit_lo;
 	unsigned long base, limit;
-	struct resource *res;
+	struct pci_bus_region region;
+	struct resource *res, res2;
 
 	res = child->resource[0];
 	pci_read_config_byte(dev, PCI_IO_BASE, &io_base_lo);
@@ -303,10 +365,14 @@ static void __devinit pci_read_bridge_io(struct pci_bus *child)
 
 	if (base && base <= limit) {
 		res->flags = (io_base_lo & PCI_IO_RANGE_TYPE_MASK) | IORESOURCE_IO;
+		res2.flags = res->flags;
+		region.start = base;
+		region.end = limit + 0xfff;
+		pci_bus_to_resource(dev, &res2, &region);
 		if (!res->start)
-			res->start = base;
+			res->start = res2.start;
 		if (!res->end)
-			res->end = limit + 0xfff;
+			res->end = res2.end;
 		dev_printk(KERN_DEBUG, &dev->dev, "  bridge window %pR\n", res);
 	}
 }
@@ -316,6 +382,7 @@ static void __devinit pci_read_bridge_mmio(struct pci_bus *child)
 	struct pci_dev *dev = child->self;
 	u16 mem_base_lo, mem_limit_lo;
 	unsigned long base, limit;
+	struct pci_bus_region region;
 	struct resource *res;
 
 	res = child->resource[1];
@@ -325,8 +392,9 @@ static void __devinit pci_read_bridge_mmio(struct pci_bus *child)
 	limit = (mem_limit_lo & PCI_MEMORY_RANGE_MASK) << 16;
 	if (base && base <= limit) {
 		res->flags = (mem_base_lo & PCI_MEMORY_RANGE_TYPE_MASK) | IORESOURCE_MEM;
-		res->start = base;
-		res->end = limit + 0xfffff;
+		region.start = base;
+		region.end = limit + 0xfffff;
+		pci_bus_to_resource(dev, res, &region);
 		dev_printk(KERN_DEBUG, &dev->dev, "  bridge window %pR\n", res);
 	}
 }
@@ -336,6 +404,7 @@ static void __devinit pci_read_bridge_mmio_pref(struct pci_bus *child)
 	struct pci_dev *dev = child->self;
 	u16 mem_base_lo, mem_limit_lo;
 	unsigned long base, limit;
+	struct pci_bus_region region;
 	struct resource *res;
 
 	res = child->resource[2];
@@ -372,8 +441,9 @@ static void __devinit pci_read_bridge_mmio_pref(struct pci_bus *child)
 					 IORESOURCE_MEM | IORESOURCE_PREFETCH;
 		if (res->flags & PCI_PREF_RANGE_TYPE_64)
 			res->flags |= IORESOURCE_MEM_64;
-		res->start = base;
-		res->end = limit + 0xfffff;
+		region.start = base;
+		region.end = limit + 0xfffff;
+		pci_bus_to_resource(dev, res, &region);
 		dev_printk(KERN_DEBUG, &dev->dev, "  bridge window %pR\n", res);
 	}
 }
@@ -919,6 +989,8 @@ int pci_setup_device(struct pci_dev *dev)
 	u8 hdr_type;
 	struct pci_slot *slot;
 	int pos = 0;
+	struct pci_bus_region region;
+	struct resource *res;
 
 	if (pci_read_config_byte(dev, PCI_HEADER_TYPE, &hdr_type))
 		return -EIO;
@@ -980,20 +1052,28 @@ int pci_setup_device(struct pci_dev *dev)
 			u8 progif;
 			pci_read_config_byte(dev, PCI_CLASS_PROG, &progif);
 			if ((progif & 1) == 0) {
-				dev->resource[0].start = 0x1F0;
-				dev->resource[0].end = 0x1F7;
-				dev->resource[0].flags = LEGACY_IO_RESOURCE;
-				dev->resource[1].start = 0x3F6;
-				dev->resource[1].end = 0x3F6;
-				dev->resource[1].flags = LEGACY_IO_RESOURCE;
+				region.start = 0x1F0;
+				region.end = 0x1F7;
+				res = &dev->resource[0];
+				res->flags = LEGACY_IO_RESOURCE;
+				pci_bus_to_resource(dev, res, &region);
+				region.start = 0x3F6;
+				region.end = 0x3F6;
+				res = &dev->resource[1];
+				res->flags = LEGACY_IO_RESOURCE;
+				pci_bus_to_resource(dev, res, &region);
 			}
 			if ((progif & 4) == 0) {
-				dev->resource[2].start = 0x170;
-				dev->resource[2].end = 0x177;
-				dev->resource[2].flags = LEGACY_IO_RESOURCE;
-				dev->resource[3].start = 0x376;
-				dev->resource[3].end = 0x376;
-				dev->resource[3].flags = LEGACY_IO_RESOURCE;
+				region.start = 0x170;
+				region.end = 0x177;
+				res = &dev->resource[2];
+				res->flags = LEGACY_IO_RESOURCE;
+				pci_bus_to_resource(dev, res, &region);
+				region.start = 0x376;
+				region.end = 0x376;
+				res = &dev->resource[3];
+				res->flags = LEGACY_IO_RESOURCE;
+				pci_bus_to_resource(dev, res, &region);
 			}
 		}
 		break;

