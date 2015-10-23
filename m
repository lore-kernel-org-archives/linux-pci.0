Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foo.masarand.uk ([104.200.29.153]:36203 "EHLO foo.masarand.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751096AbbJWFFr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 23 Oct 2015 01:05:47 -0400
From: Matthew Minter <matt@masarand.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	lorenzo.pieralisi@arm.com
Cc: Matthew Minter <matt@masarand.com>
Subject: [PATCH V4 05/29] PCI: Add pci_assign_irq function and have pci_fixup_irqs use it
Date: Fri, 23 Oct 2015 06:03:38 +0100
Message-Id: <1445576642-29624-6-git-send-email-matt@masarand.com>
In-Reply-To: <1445576642-29624-1-git-send-email-matt@masarand.com>
References: <1445576642-29624-1-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Here we delete the static pdev_fixup_irq function which is currently
what pci_fixup_irqs uses to actually assign the irqs and replace it
with the pci_assign_irq function which changes the interface and
makes use of the new function pointers stored in the host bridge
structure.

Eventually this will allow pci_fixup_irqs to be removed entirely
and the new deffered assignment code path will call pci_assign_irq
directly. However to ensure current users continue to work a
new implementation of pci_fixup_irqs is introduced which simply
wraps the functionality of pci_assign_irq.

Signed-off-by: Matthew Minter <matt@masarand.com>
---
 drivers/pci/setup-irq.c | 35 ++++++++++++++++++++++++++---------
 include/linux/pci.h     |  1 +
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/setup-irq.c b/drivers/pci/setup-irq.c
index c7d9f26..a9b7a30 100644
--- a/drivers/pci/setup-irq.c
+++ b/drivers/pci/setup-irq.c
@@ -15,6 +15,7 @@
 #include <linux/errno.h>
 #include <linux/ioport.h>
 #include <linux/cache.h>
+#include "pci.h"
 
 void __weak pcibios_update_irq(struct pci_dev *dev, int irq)
 {
@@ -22,12 +23,17 @@ void __weak pcibios_update_irq(struct pci_dev *dev, int irq)
 	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
 }
 
-static void pdev_fixup_irq(struct pci_dev *dev,
-			   u8 (*swizzle)(struct pci_dev *, u8 *),
-			   int (*map_irq)(const struct pci_dev *, u8, u8))
+void pci_assign_irq(struct pci_dev *dev)
 {
-	u8 pin, slot;
+	u8 pin;
+	u8 slot = -1;
 	int irq = 0;
+	struct pci_host_bridge *hbrg = pci_find_host_bridge(dev->bus);
+
+	if (!(hbrg->map_irq)) {
+		dev_dbg(&dev->dev, "runtime irq mapping not provided by arch\n");
+		return;
+	}
 
 	/* If this device is not on the primary bus, we need to figure out
 	   which interrupt pin it will come in on.   We know which slot it
@@ -40,17 +46,19 @@ static void pdev_fixup_irq(struct pci_dev *dev,
 	if (pin > 4)
 		pin = 1;
 
-	if (pin != 0) {
+	if (pin) {
 		/* Follow the chain of bridges, swizzling as we go.  */
-		slot = (*swizzle)(dev, &pin);
+		if(hbrg->swizzle_irq)
+			slot = (*(hbrg->swizzle_irq))(dev, &pin);
 
-		irq = (*map_irq)(dev, slot, pin);
+		/* If a swizzling function is not used map_irq must ignore slot */
+		irq = (*(hbrg->map_irq))(dev, slot, pin);
 		if (irq == -1)
 			irq = 0;
 	}
 	dev->irq = irq;
 
-	dev_dbg(&dev->dev, "fixup irq: got %d\n", dev->irq);
+	dev_dbg(&dev->dev, "assign irq: got %d\n", dev->irq);
 
 	/* Always tell the device, so the driver knows what is
 	   the real IRQ to use; the device does not use it. */
@@ -60,9 +68,18 @@ static void pdev_fixup_irq(struct pci_dev *dev,
 void pci_fixup_irqs(u8 (*swizzle)(struct pci_dev *, u8 *),
 		    int (*map_irq)(struct pci_dev *, u8, u8))
 {
+	/* This code should be removed shortly, but in the mean time
+	   it can wrap the new codepath in order to allow arches
+	   still using it to continue working */
 	struct pci_dev *dev = NULL;
+	struct pci_host_bridge *hbrg = NULL;
 
 	for_each_pci_dev(dev)
-		pdev_fixup_irq(dev, swizzle, map_irq);
+		hbrg = pci_find_host_bridge(dev->bus);
+		hbrg->swizzle_irq = swizzle;
+		hbrg->map_irq = map_irq;
+		pci_assign_irq(dev);
+		hbrg->swizzle_irq = NULL;
+		hbrg->map_irq = NULL;
 }
 EXPORT_SYMBOL_GPL(pci_fixup_irqs);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1073f27..e88ad4f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1122,6 +1122,7 @@ void pdev_enable_device(struct pci_dev *);
 int pci_enable_resources(struct pci_dev *, int mask);
 void pci_fixup_irqs(u8 (*)(struct pci_dev *, u8 *),
 		    int (*)(struct pci_dev *, u8, u8));
+void pci_assign_irq(struct pci_dev *dev);
 #define HAVE_PCI_REQ_REGIONS	2
 int __must_check pci_request_regions(struct pci_dev *, const char *);
 int __must_check pci_request_regions_exclusive(struct pci_dev *, const char *);
-- 
2.6.2

