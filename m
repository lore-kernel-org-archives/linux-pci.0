Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:52411 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754005AbaHEQMB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Aug 2014 12:12:01 -0400
Received: by mail-wg0-f51.google.com with SMTP id b13so1251149wgh.10
        for <linux-pci@vger.kernel.org>; Tue, 05 Aug 2014 09:11:57 -0700 (PDT)
From: matthew_minter@xyratex.com
To: bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: matthew_minter <matthew_minter@xyratex.com>
Subject: [PATCH 01/22] Added some infrastructure to allow assigning PCI device IRQs at device enable time and removed pci_fixup_irqs as the other change obsolites it.
Date: Tue,  5 Aug 2014 17:11:02 +0100
Message-Id: <1407255083-9356-2-git-send-email-matthew_minter@xyratex.com>
In-Reply-To: <1407255083-9356-1-git-send-email-matthew_minter@xyratex.com>
References: <1407255083-9356-1-git-send-email-matthew_minter@xyratex.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: matthew_minter <matthew_minter@xyratex.com>

---
 drivers/pci/Makefile      | 15 ++-------------
 drivers/pci/host-bridge.c |  2 +-
 drivers/pci/pci.c         |  6 +++++-
 drivers/pci/pci.h         |  1 +
 drivers/pci/probe.c       | 12 ------------
 drivers/pci/setup-irq.c   | 25 +++++++++----------------
 include/linux/pci.h       |  8 ++++----
 7 files changed, 22 insertions(+), 47 deletions(-)

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
index 63a54a3..d51d076 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1197,10 +1197,15 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
 	int err;
 	u16 cmd;
 	u8 pin;
+	struct pci_host_bridge *hbrg = find_pci_host_bridge(dev->bus);
 
 	err = pci_set_power_state(dev, PCI_D0);
 	if (err < 0 && err != -EIO)
 		return err;
+
+	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
+	pdev_assign_irq(dev, hbrg->swizzle_irq, hbrg->map_irq);
+
 	err = pcibios_enable_device(dev, bars);
 	if (err < 0)
 		return err;
@@ -1209,7 +1214,6 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
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
index e3cf8a2..bb9f35c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1729,18 +1729,6 @@ unsigned int pci_scan_child_bus(struct pci_bus *bus)
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
index 38c96c8..a994e07 100644
--- a/drivers/pci/setup-irq.c
+++ b/drivers/pci/setup-irq.c
@@ -22,11 +22,12 @@ void __weak pcibios_update_irq(struct pci_dev *dev, int irq)
 	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
 }
 
-void pdev_fixup_irq(struct pci_dev *dev,
+void pdev_assign_irq(struct pci_dev *dev,
 			   u8 (*swizzle)(struct pci_dev *, u8 *),
-			   int (*map_irq)(const struct pci_dev *, u8, u8))
+			   int (*map_irq)(struct pci_dev *, u8, u8))
 {
-	u8 pin, slot;
+	u8 pin;
+	u8 slot = -1;
 	int irq = 0;
 
 	/* If this device is not on the primary bus, we need to figure out
@@ -41,27 +42,19 @@ void pdev_fixup_irq(struct pci_dev *dev,
 		pin = 1;
 
 	if (pin != 0) {
-		/* Follow the chain of bridges, swizzling as we go.  */
-		slot = (*swizzle)(dev, &pin);
+		/* Follow the chain of bridges, swizzling as we go. */
+		if(swizzle)
+			slot = (*swizzle)(dev, &pin);
 
+		/* If a swizzling function is not used map_irq must ignore slot */
 		irq = (*map_irq)(dev, slot, pin);
 		if (irq == -1)
 			irq = 0;
 	}
-	dev->irq = irq;
 
 	dev_dbg(&dev->dev, "fixup irq: got %d\n", dev->irq);
-
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
index 4c1b1b3..f8b9b95 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -402,6 +402,8 @@ struct pci_host_bridge {
 	struct device dev;
 	struct pci_bus *bus;		/* root bus */
 	struct list_head windows;	/* pci_host_bridge_windows */
+	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* platform irq swizzler */
+	int (*map_irq)(struct pci_dev *, u8, u8);
 	void (*release_fn)(struct pci_host_bridge *);
 	void *release_data;
 };
@@ -1056,10 +1058,8 @@ void pci_assign_unassigned_bus_resources(struct pci_bus *bus);
 void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus);
 void pdev_enable_device(struct pci_dev *);
 int pci_enable_resources(struct pci_dev *, int mask);
-void pdev_fixup_irq(struct pci_dev *, u8 (*)(struct pci_dev *, u8 *),
-		    int (*)(const struct pci_dev *, u8, u8));
-void pci_fixup_irqs(u8 (*)(struct pci_dev *, u8 *),
-		    int (*)(const struct pci_dev *, u8, u8));
+void pdev_assign_irq(struct pci_dev *dev, u8 (*swizzle)(struct pci_dev *, u8 *),
+		     int (*map_irq)(struct pci_dev *, u8, u8));
 #define HAVE_PCI_REQ_REGIONS	2
 int __must_check pci_request_regions(struct pci_dev *, const char *);
 int __must_check pci_request_regions_exclusive(struct pci_dev *, const char *);
-- 
2.0.4

