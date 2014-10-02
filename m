Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foo.masarand.uk ([69.164.217.139]:56335 "EHLO foo.masarand.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751031AbaJBD70 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 1 Oct 2014 23:59:26 -0400
From: matt@masarand.com
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, Vality <matt@masarand.com>
Subject: [PATCH 01/18] Added way to register deferred PCI IRQ assignment handlers
Date: Thu,  2 Oct 2014 04:50:20 +0100
Message-Id: <1412221837-17452-2-git-send-email-matt@masarand.com>
In-Reply-To: <1412221837-17452-1-git-send-email-matt@masarand.com>
References: <1412221837-17452-1-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Vality <matt@masarand.com>

These are the main infrastructure changes to allow the registration of
PCI IRQ assignment functions which can then be called during the device
enabling stage. This replaces the pre-initialisation of PCI IRQs at boot
time which caused limitations such as failing for devices which are
hot-plugged after the machine has booted and resulted in highly
fragmented PCI initialisation paths.

The pdev_assign_irq function becomes a centralised method of assigning
IRQs to PCI devices in a non platform specific way. The pci_host_bridge
structure has had some function pointers added to it where the boot code
can register the platform specific ways of assigning PCI IRQs to be used
to allow them to be used by pdev_assign_irq.

Some small adjustements have also been made to makefiles in order to
accomodate these changes.

Note this code completely obsolites the pci_fixup_irqs code path which
has thus been removed.

---
 drivers/of/of_pci_irq.c   |  2 +-
 drivers/pci/Makefile      | 15 ++-------------
 drivers/pci/host-bridge.c |  2 +-
 drivers/pci/pci.c         |  5 ++++-
 drivers/pci/pci.h         |  1 +
 drivers/pci/probe.c       | 12 ------------
 drivers/pci/setup-irq.c   | 34 ++++++++++++++++------------------
 include/linux/pci.h       |  6 ++++--
 8 files changed, 29 insertions(+), 48 deletions(-)

diff --git a/drivers/of/of_pci_irq.c b/drivers/of/of_pci_irq.c
index 1710d9d..205eb7a 100644
--- a/drivers/of/of_pci_irq.c
+++ b/drivers/of/of_pci_irq.c
@@ -97,7 +97,7 @@ EXPORT_SYMBOL_GPL(of_irq_parse_pci);
  * @pin: PCI irq pin number; passed when used as map_irq callback. Unused
  *
  * @slot and @pin are unused, but included in the function so that this
- * function can be used directly as the map_irq callback to pci_fixup_irqs().
+ * function can be used directly as the map_irq callback to pdev_assign_irq().
  */
 int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin)
 {
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index e04fe2d..38c4cb0 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -4,7 +4,8 @@
 
 obj-y		+= access.o bus.o probe.o host-bridge.o remove.o pci.o \
 			pci-driver.o search.o pci-sysfs.o rom.o setup-res.o \
-			irq.o vpd.o setup-bus.o vc.o
+			irq.o vpd.o setup-bus.o vc.o setup-irq.o
+
 obj-$(CONFIG_PROC_FS) += proc.o
 obj-$(CONFIG_SYSFS) += slot.o
 
@@ -31,18 +32,6 @@ obj-$(CONFIG_PCI_ATS) += ats.o
 obj-$(CONFIG_PCI_IOV) += iov.o
 
 #
-# Some architectures use the generic PCI setup functions
-#
-obj-$(CONFIG_ALPHA) += setup-irq.o
-obj-$(CONFIG_ARM) += setup-irq.o
-obj-$(CONFIG_UNICORE32) += setup-irq.o
-obj-$(CONFIG_SUPERH) += setup-irq.o
-obj-$(CONFIG_MIPS) += setup-irq.o
-obj-$(CONFIG_TILE) += setup-irq.o
-obj-$(CONFIG_SPARC_LEON) += setup-irq.o
-obj-$(CONFIG_M68K) += setup-irq.o
-
-#
 # ACPI Related PCI FW Functions
 # ACPI _DSM provided firmware instance and string name
 #
diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
index 0e5f3c9..8ed186f 100644
--- a/drivers/pci/host-bridge.c
+++ b/drivers/pci/host-bridge.c
@@ -16,7 +16,7 @@ static struct pci_bus *find_pci_root_bus(struct pci_bus *bus)
 	return bus;
 }
 
-static struct pci_host_bridge *find_pci_host_bridge(struct pci_bus *bus)
+struct pci_host_bridge *find_pci_host_bridge(struct pci_bus *bus)
 {
 	struct pci_bus *root_bus = find_pci_root_bus(bus);
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 2c9ac70..2dd28d9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1192,11 +1192,15 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
 	struct pci_dev *bridge;
 	u16 cmd;
 	u8 pin;
+	struct pci_host_bridge *hbrg = find_pci_host_bridge(dev->bus);
 
 	err = pci_set_power_state(dev, PCI_D0);
 	if (err < 0 && err != -EIO)
 		return err;
 
+	pdev_assign_irq(dev, hbrg->swizzle_irq, hbrg->map_irq);
+	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
+
 	bridge = pci_upstream_bridge(dev);
 	if (bridge)
 		pcie_aspm_powersave_config_link(bridge);
@@ -1209,7 +1213,6 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
 	if (dev->msi_enabled || dev->msix_enabled)
 		return 0;
 
-	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
 	if (pin) {
 		pci_read_config_word(dev, PCI_COMMAND, &cmd);
 		if (cmd & PCI_COMMAND_INTX_DISABLE)
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 0601890..a6cf445 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -70,6 +70,7 @@ void pci_config_pm_runtime_put(struct pci_dev *dev);
 void pci_pm_init(struct pci_dev *dev);
 void pci_allocate_cap_save_buffers(struct pci_dev *dev);
 void pci_free_cap_save_buffers(struct pci_dev *dev);
+struct pci_host_bridge *find_pci_host_bridge(struct pci_bus *bus);
 
 static inline void pci_wakeup_event(struct pci_dev *dev)
 {
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 4170113..314e9e3 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1719,18 +1719,6 @@ unsigned int pci_scan_child_bus(struct pci_bus *bus)
 }
 EXPORT_SYMBOL_GPL(pci_scan_child_bus);
 
-/**
- * pcibios_root_bridge_prepare - Platform-specific host bridge setup.
- * @bridge: Host bridge to set up.
- *
- * Default empty implementation.  Replace with an architecture-specific setup
- * routine, if necessary.
- */
-int __weak pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
-{
-	return 0;
-}
-
 void __weak pcibios_add_bus(struct pci_bus *bus)
 {
 }
diff --git a/drivers/pci/setup-irq.c b/drivers/pci/setup-irq.c
index 4e2d595..203bf7e 100644
--- a/drivers/pci/setup-irq.c
+++ b/drivers/pci/setup-irq.c
@@ -22,13 +22,19 @@ void __weak pcibios_update_irq(struct pci_dev *dev, int irq)
 	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
 }
 
-static void pdev_fixup_irq(struct pci_dev *dev,
+void pdev_assign_irq(struct pci_dev *dev,
 			   u8 (*swizzle)(struct pci_dev *, u8 *),
-			   int (*map_irq)(const struct pci_dev *, u8, u8))
+			   int (*map_irq)(struct pci_dev *, u8, u8))
 {
-	u8 pin, slot;
+	u8 pin;
+	u8 slot = -1;
 	int irq = 0;
 
+	if (!map_irq) {
+		dev_dbg(&dev->dev, "runtime irq mapping not provided by arch\n");
+		return;
+	}
+
 	/* If this device is not on the primary bus, we need to figure out
 	   which interrupt pin it will come in on.   We know which slot it
 	   will come in on 'cos that slot is where the bridge is.   Each
@@ -40,28 +46,20 @@ static void pdev_fixup_irq(struct pci_dev *dev,
 	if (pin > 4)
 		pin = 1;
 
-	if (pin != 0) {
-		/* Follow the chain of bridges, swizzling as we go.  */
-		slot = (*swizzle)(dev, &pin);
+	if (pin) {
+		/* Follow the chain of bridges, swizzling as we go. */
+		if(swizzle)
+			slot = (*swizzle)(dev, &pin);
 
+		/* If a swizzling function is not used map_irq must ignore slot */
 		irq = (*map_irq)(dev, slot, pin);
 		if (irq == -1)
 			irq = 0;
 	}
-	dev->irq = irq;
-
-	dev_dbg(&dev->dev, "fixup irq: got %d\n", dev->irq);
 
+	dev_dbg(&dev->dev, "assign irq: got %d\n", dev->irq);
+	dev->irq = irq;
 	/* Always tell the device, so the driver knows what is
 	   the real IRQ to use; the device does not use it. */
 	pcibios_update_irq(dev, irq);
 }
-
-void pci_fixup_irqs(u8 (*swizzle)(struct pci_dev *, u8 *),
-		    int (*map_irq)(const struct pci_dev *, u8, u8))
-{
-	struct pci_dev *dev = NULL;
-
-	for_each_pci_dev(dev)
-		pdev_fixup_irq(dev, swizzle, map_irq);
-}
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 96453f9..5426d11 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -403,6 +403,8 @@ struct pci_host_bridge {
 	struct device dev;
 	struct pci_bus *bus;		/* root bus */
 	struct list_head windows;	/* pci_host_bridge_windows */
+	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* platform irq swizzler */
+	int (*map_irq)(struct pci_dev *, u8, u8);
 	void (*release_fn)(struct pci_host_bridge *);
 	void *release_data;
 };
@@ -1064,8 +1066,8 @@ void pci_assign_unassigned_bus_resources(struct pci_bus *bus);
 void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus);
 void pdev_enable_device(struct pci_dev *);
 int pci_enable_resources(struct pci_dev *, int mask);
-void pci_fixup_irqs(u8 (*)(struct pci_dev *, u8 *),
-		    int (*)(const struct pci_dev *, u8, u8));
+void pdev_assign_irq(struct pci_dev *dev, u8 (*swizzle)(struct pci_dev *, u8 *),
+                     int (*map_irq)(struct pci_dev *, u8, u8));
 #define HAVE_PCI_REQ_REGIONS	2
 int __must_check pci_request_regions(struct pci_dev *, const char *);
 int __must_check pci_request_regions_exclusive(struct pci_dev *, const char *);
-- 
2.1.0

