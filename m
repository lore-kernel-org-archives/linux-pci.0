Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:56813 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751517AbaGJPkz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Jul 2014 11:40:55 -0400
Received: by mail-wi0-f177.google.com with SMTP id ho1so4783729wib.4
        for <linux-pci@vger.kernel.org>; Thu, 10 Jul 2014 08:40:51 -0700 (PDT)
From: matthew_minter@xyratex.com
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: matthew_minter <matthew_minter@xyratex.com>
Subject: [PATCH RFC] Added code to ensure hot-added PCI devices are given an IRQ on rescan
Date: Thu, 10 Jul 2014 16:40:39 +0100
Message-Id: <1405006839-16502-2-git-send-email-matthew_minter@xyratex.com>
In-Reply-To: <1405006839-16502-1-git-send-email-matthew_minter@xyratex.com>
References: <1405006839-16502-1-git-send-email-matthew_minter@xyratex.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: matthew_minter <matthew_minter@xyratex.com>

Signed-off-by: matthew_minter <matthew_minter@xyratex.com>
---
 drivers/pci/bus.c       | 11 +++++++++++
 drivers/pci/setup-irq.c |  2 +-
 include/linux/pci.h     |  2 ++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 73aef51..eb4f93c 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
+#include <linux/of_pci.h>
 #include <linux/errno.h>
 #include <linux/ioport.h>
 #include <linux/proc_fs.h>
@@ -245,6 +246,16 @@ void pci_bus_add_device(struct pci_dev *dev)
 	 * are not assigned yet for some devices.
 	 */
 	pci_fixup_device(pci_fixup_final, dev);
+	/*
+	 * Devices which are hot-added after boot have not
+	 * been assigned an irq by the bios.
+	 */
+	if (unlikely(!dev->irq)) {
+		dev_dbg(&dev->dev,
+			"PCI device missing IRQ, attempting to assign one\n");
+		pdev_fixup_irq(dev, pci_common_swizzle,
+			of_irq_parse_and_map_pci);
+	}
 	pci_create_sysfs_dev_files(dev);
 	pci_proc_attach_device(dev);
 
diff --git a/drivers/pci/setup-irq.c b/drivers/pci/setup-irq.c
index 4e2d595..38c96c8 100644
--- a/drivers/pci/setup-irq.c
+++ b/drivers/pci/setup-irq.c
@@ -22,7 +22,7 @@ void __weak pcibios_update_irq(struct pci_dev *dev, int irq)
 	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
 }
 
-static void pdev_fixup_irq(struct pci_dev *dev,
+void pdev_fixup_irq(struct pci_dev *dev,
 			   u8 (*swizzle)(struct pci_dev *, u8 *),
 			   int (*map_irq)(const struct pci_dev *, u8, u8))
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 466bcd1..4c1b1b3 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1056,6 +1056,8 @@ void pci_assign_unassigned_bus_resources(struct pci_bus *bus);
 void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus);
 void pdev_enable_device(struct pci_dev *);
 int pci_enable_resources(struct pci_dev *, int mask);
+void pdev_fixup_irq(struct pci_dev *, u8 (*)(struct pci_dev *, u8 *),
+		    int (*)(const struct pci_dev *, u8, u8));
 void pci_fixup_irqs(u8 (*)(struct pci_dev *, u8 *),
 		    int (*)(const struct pci_dev *, u8, u8));
 #define HAVE_PCI_REQ_REGIONS	2
-- 
2.0.0

