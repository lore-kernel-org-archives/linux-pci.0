Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:44568 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754797AbaHEQMP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Aug 2014 12:12:15 -0400
Received: by mail-wg0-f51.google.com with SMTP id b13so1256830wgh.34
        for <linux-pci@vger.kernel.org>; Tue, 05 Aug 2014 09:12:14 -0700 (PDT)
From: matthew_minter@xyratex.com
To: bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: matthew_minter <matthew_minter@xyratex.com>
Subject: [PATCH 22/22] Tidy up including documentation and messages
Date: Tue,  5 Aug 2014 17:11:23 +0100
Message-Id: <1407255083-9356-23-git-send-email-matthew_minter@xyratex.com>
In-Reply-To: <1407255083-9356-1-git-send-email-matthew_minter@xyratex.com>
References: <1407255083-9356-1-git-send-email-matthew_minter@xyratex.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: matthew_minter <matthew_minter@xyratex.com>

---
 drivers/of/of_pci_irq.c | 2 +-
 drivers/pci/setup-irq.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

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
diff --git a/drivers/pci/setup-irq.c b/drivers/pci/setup-irq.c
index 7bb4356..203bf7e 100644
--- a/drivers/pci/setup-irq.c
+++ b/drivers/pci/setup-irq.c
@@ -31,7 +31,7 @@ void pdev_assign_irq(struct pci_dev *dev,
 	int irq = 0;
 
 	if (!map_irq) {
-		dev_dbg(&dev->dev, "map_irq not provided by arch\n", dev->irq);
+		dev_dbg(&dev->dev, "runtime irq mapping not provided by arch\n");
 		return;
 	}
 
@@ -46,7 +46,7 @@ void pdev_assign_irq(struct pci_dev *dev,
 	if (pin > 4)
 		pin = 1;
 
-	if (pin != 0) {
+	if (pin) {
 		/* Follow the chain of bridges, swizzling as we go. */
 		if(swizzle)
 			slot = (*swizzle)(dev, &pin);
@@ -57,7 +57,7 @@ void pdev_assign_irq(struct pci_dev *dev,
 			irq = 0;
 	}
 
-	dev_dbg(&dev->dev, "fixup irq: got %d\n", dev->irq);
+	dev_dbg(&dev->dev, "assign irq: got %d\n", dev->irq);
 	dev->irq = irq;
 	/* Always tell the device, so the driver knows what is
 	   the real IRQ to use; the device does not use it. */
-- 
2.0.4

