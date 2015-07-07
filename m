Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:52030 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932484AbbGGSLZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 7 Jul 2015 14:11:25 -0400
From: Guenter Roeck <linux@roeck-us.net>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [RFC PATCH v2] PCI: Only enable IO window if supported
Date: Tue,  7 Jul 2015 11:11:20 -0700
Message-Id: <1436292680-25111-1-git-send-email-linux@roeck-us.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCI subsystem always assumes that I/O is supported on PCIe bridges
and tries to assign an I/O window to each child bus even if that is not
the case.

This may result in messages such as

pcieport 0000:02:00.0: res[7]=[io  0x1000-0x0fff]
					get_res_add_size add_size 1000
pcieport 0000:02:00.0: BAR 7: no space for [io  size 0x1000]
pcieport 0000:02:00.0: BAR 7: failed to assign [io  size 0x1000]

for each bridge port, even if a bus or its parent does not support
I/O in the first place.

To avoid this message, check if a bus supports I/O before trying to
enable it. Also check if the root bus has an IO window assigned;
if not, it does not make sense to try to assign one to any of its
child busses.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Use a new bus flag to indicate if IO is supported on a bus or not.
    Using IORESOURCE_DISABLED in resource flags turned out to be futile,
    since the term "!res->flags" is widely used to detect if a resource
    window is enabled or not, and setting IORESOURCE_DISABLED would
    affect all this code.

This patch depends on 'PCI: move pci_read_bridge_bases to the generic
PCI layer' by Lorenzo Pieralisi; without it, pci_read_bridge_io()
is not always called.

With this version of the patch, pci_bridge_check_ranges() still sets
IORESOURCE_IO. Moving this into pci_read_bridge_io() had undesirable
side effects and resulted in missing IO window assignments on one of
the x86 platforms I tested with. I'll have to explore this further.

 drivers/pci/probe.c     | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/setup-bus.c |  9 +--------
 include/linux/pci.h     |  1 +
 3 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index cefd636681b6..b21cba7aeb79 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -332,6 +332,35 @@ static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
 	}
 }
 
+static bool pci_bus_supports_io(struct pci_bus *bus)
+{
+	struct pci_dev *dev = bus->self;
+	u16 io;
+
+	pci_read_config_word(dev, PCI_IO_BASE, &io);
+	if (!io) {
+		pci_write_config_word(dev, PCI_IO_BASE, 0xe0f0);
+		pci_read_config_word(dev, PCI_IO_BASE, &io);
+		pci_write_config_word(dev, PCI_IO_BASE, 0x0);
+	}
+	return !!io;
+}
+
+static bool pci_root_has_io_resource(struct pci_bus *bus)
+{
+	struct resource *res;
+	int i;
+
+	while (bus->parent)
+		bus = bus->parent;
+
+	 pci_bus_for_each_resource(bus, res, i) {
+		if (res && (res->flags & IORESOURCE_IO))
+			return true;
+	 }
+	 return false;
+}
+
 static void pci_read_bridge_io(struct pci_bus *child)
 {
 	struct pci_dev *dev = child->self;
@@ -340,6 +369,23 @@ static void pci_read_bridge_io(struct pci_bus *child)
 	struct pci_bus_region region;
 	struct resource *res;
 
+	if (child->bus_flags & PCI_BUS_FLAGS_NO_IO)
+		return;
+
+	if (!pci_bus_supports_io(child)) {
+		dev_printk(KERN_DEBUG, &dev->dev,
+			   "  bus does not support IO\n");
+		child->bus_flags |= PCI_BUS_FLAGS_NO_IO;
+		return;
+	}
+
+	if (!pci_root_has_io_resource(child)) {
+		dev_printk(KERN_DEBUG, &dev->dev,
+			   "  no IO window on root bus\n");
+		child->bus_flags |= PCI_BUS_FLAGS_NO_IO;
+		return;
+	}
+
 	io_mask = PCI_IO_RANGE_MASK;
 	io_granularity = 0x1000;
 	if (dev->io_window_1k) {
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 508cc56130e3..c8c7eecadbfe 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -744,7 +744,6 @@ int pci_claim_bridge_resource(struct pci_dev *bridge, int i)
    base/limit registers must be read-only and read as 0. */
 static void pci_bridge_check_ranges(struct pci_bus *bus)
 {
-	u16 io;
 	u32 pmem;
 	struct pci_dev *bridge = bus->self;
 	struct resource *b_res;
@@ -752,13 +751,7 @@ static void pci_bridge_check_ranges(struct pci_bus *bus)
 	b_res = &bridge->resource[PCI_BRIDGE_RESOURCES];
 	b_res[1].flags |= IORESOURCE_MEM;
 
-	pci_read_config_word(bridge, PCI_IO_BASE, &io);
-	if (!io) {
-		pci_write_config_word(bridge, PCI_IO_BASE, 0xe0f0);
-		pci_read_config_word(bridge, PCI_IO_BASE, &io);
-		pci_write_config_word(bridge, PCI_IO_BASE, 0x0);
-	}
-	if (io)
+	if (!(bus->bus_flags & PCI_BUS_FLAGS_NO_IO))
 		b_res[0].flags |= IORESOURCE_IO;
 
 	/*  DECchip 21050 pass 2 errata: the bridge may miss an address
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8a0321a8fb59..b910ed04aa0b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -191,6 +191,7 @@ typedef unsigned short __bitwise pci_bus_flags_t;
 enum pci_bus_flags {
 	PCI_BUS_FLAGS_NO_MSI   = (__force pci_bus_flags_t) 1,
 	PCI_BUS_FLAGS_NO_MMRBC = (__force pci_bus_flags_t) 2,
+	PCI_BUS_FLAGS_NO_IO    = (__force pci_bus_flags_t) 4,
 };
 
 /* These values come from the PCI Express Spec */
-- 
2.1.0

