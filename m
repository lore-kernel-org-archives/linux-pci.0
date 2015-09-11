Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:34893 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754216AbbIKXWG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Sep 2015 19:22:06 -0400
From: David Daney <ddaney.cavm@gmail.com>
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Grant Likely <grant.likely@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	linux-arm-kernel@lists.infradead.org
Cc: David Daney <david.daney@cavium.com>
Subject: [PATCH 1/6] PCI: Make global and export pdev_fixup_irq().
Date: Fri, 11 Sep 2015 16:21:54 -0700
Message-Id: <1442013719-5001-2-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1442013719-5001-1-git-send-email-ddaney.cavm@gmail.com>
References: <1442013719-5001-1-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Daney <david.daney@cavium.com>

Follow-on patch will use pdev_fixup_irq().  So, make it visible and
export it.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 drivers/pci/setup-irq.c | 7 ++++---
 include/linux/pci.h     | 3 +++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/setup-irq.c b/drivers/pci/setup-irq.c
index 95c225b..ac7ffaf 100644
--- a/drivers/pci/setup-irq.c
+++ b/drivers/pci/setup-irq.c
@@ -22,9 +22,9 @@ void __weak pcibios_update_irq(struct pci_dev *dev, int irq)
 	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
 }
 
-static void pdev_fixup_irq(struct pci_dev *dev,
-			   u8 (*swizzle)(struct pci_dev *, u8 *),
-			   int (*map_irq)(const struct pci_dev *, u8, u8))
+void pdev_fixup_irq(struct pci_dev *dev,
+		    u8 (*swizzle)(struct pci_dev *, u8 *),
+		    int (*map_irq)(const struct pci_dev *, u8, u8))
 {
 	u8 pin, slot;
 	int irq = 0;
@@ -56,6 +56,7 @@ static void pdev_fixup_irq(struct pci_dev *dev,
 	   the real IRQ to use; the device does not use it. */
 	pcibios_update_irq(dev, irq);
 }
+EXPORT_SYMBOL_GPL(pdev_fixup_irq);
 
 void pci_fixup_irqs(u8 (*swizzle)(struct pci_dev *, u8 *),
 		    int (*map_irq)(const struct pci_dev *, u8, u8))
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e90eb22..50e66ab 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1120,6 +1120,9 @@ void pdev_enable_device(struct pci_dev *);
 int pci_enable_resources(struct pci_dev *, int mask);
 void pci_fixup_irqs(u8 (*)(struct pci_dev *, u8 *),
 		    int (*)(const struct pci_dev *, u8, u8));
+void pdev_fixup_irq(struct pci_dev *,
+		    u8 (*)(struct pci_dev *, u8 *),
+		    int (*)(const struct pci_dev *, u8, u8));
 #define HAVE_PCI_REQ_REGIONS	2
 int __must_check pci_request_regions(struct pci_dev *, const char *);
 int __must_check pci_request_regions_exclusive(struct pci_dev *, const char *);
-- 
1.7.11.7

