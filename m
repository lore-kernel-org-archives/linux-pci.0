Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ia0-f175.google.com ([209.85.210.175]:52038 "EHLO
	mail-ia0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753063Ab3DVXL4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Apr 2013 19:11:56 -0400
Received: by mail-ia0-f175.google.com with SMTP id i38so11563iae.6
        for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2013 16:11:56 -0700 (PDT)
Subject: [PATCH v4 15/22] PCI: Drop msi_mask_reg() and remove drivers/pci/msi.h
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Mon, 22 Apr 2013 17:11:54 -0600
Message-ID: <20130422231154.32621.3444.stgit@bhelgaas-glaptop>
In-Reply-To: <20130422230012.32621.15224.stgit@bhelgaas-glaptop>
References: <20130422230012.32621.15224.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

msi_mask_reg() doesn't provide any useful abstraction, do drop it.

Remove the now-empty drivers/pci/msi.h.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/msi.c |    4 ++--
 drivers/pci/msi.h |   12 ------------
 2 files changed, 2 insertions(+), 14 deletions(-)
 delete mode 100644 drivers/pci/msi.h

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 06c5f6e..afdc388 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -22,7 +22,6 @@
 #include <linux/slab.h>
 
 #include "pci.h"
-#include "msi.h"
 
 static int pci_msi_enable = 1;
 
@@ -564,7 +563,8 @@ static int msi_capability_init(struct pci_dev *dev, int nvec)
 	entry->msi_attrib.default_irq	= dev->irq;	/* Save IOAPIC IRQ */
 	entry->msi_attrib.pos		= dev->msi_cap;
 
-	entry->mask_pos = msi_mask_reg(dev->msi_cap, entry->msi_attrib.is_64);
+	entry->mask_pos = dev->msi_cap + (control & PCI_MSI_FLAGS_64BIT) ?
+		PCI_MSI_MASK_64 : PCI_MSI_MASK_32;
 	/* All MSIs are unmasked by default, Mask them all */
 	if (entry->msi_attrib.maskbit)
 		pci_read_config_dword(dev, entry->mask_pos, &entry->masked);
diff --git a/drivers/pci/msi.h b/drivers/pci/msi.h
deleted file mode 100644
index df12830..0000000
--- a/drivers/pci/msi.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/*
- * Copyright (C) 2003-2004 Intel
- * Copyright (C) Tom Long Nguyen (tom.l.nguyen@intel.com)
- */
-
-#ifndef MSI_H
-#define MSI_H
-
-#define msi_mask_reg(base, is64bit)	\
-	(base + ((is64bit == 1) ? PCI_MSI_MASK_64 : PCI_MSI_MASK_32))
-
-#endif /* MSI_H */

