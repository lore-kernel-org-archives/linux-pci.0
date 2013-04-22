Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:46240 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752616Ab3DVXLg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Apr 2013 19:11:36 -0400
Received: by mail-ie0-f179.google.com with SMTP id 16so11864iea.38
        for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2013 16:11:35 -0700 (PDT)
Subject: [PATCH v4 12/22] PCI: Drop is_64bit_address() and
 is_mask_bit_support() macros
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Mon, 22 Apr 2013 17:11:34 -0600
Message-ID: <20130422231134.32621.91788.stgit@bhelgaas-glaptop>
In-Reply-To: <20130422230012.32621.15224.stgit@bhelgaas-glaptop>
References: <20130422230012.32621.15224.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

is_64bit_address() and is_mask_bit_support() don't provide any useful
abstraction, so drop them.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/msi.c |    4 ++--
 drivers/pci/msi.h |    2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 1688c26..aaaf954 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -555,9 +555,9 @@ static int msi_capability_init(struct pci_dev *dev, int nvec)
 		return -ENOMEM;
 
 	entry->msi_attrib.is_msix	= 0;
-	entry->msi_attrib.is_64		= is_64bit_address(control);
+	entry->msi_attrib.is_64		= !!(control & PCI_MSI_FLAGS_64BIT);
 	entry->msi_attrib.entry_nr	= 0;
-	entry->msi_attrib.maskbit	= is_mask_bit_support(control);
+	entry->msi_attrib.maskbit	= !!(control & PCI_MSI_FLAGS_MASKBIT);
 	entry->msi_attrib.default_irq	= dev->irq;	/* Save IOAPIC IRQ */
 	entry->msi_attrib.pos		= dev->msi_cap;
 
diff --git a/drivers/pci/msi.h b/drivers/pci/msi.h
index d2c6cd9..bc5cd99 100644
--- a/drivers/pci/msi.h
+++ b/drivers/pci/msi.h
@@ -8,8 +8,6 @@
 
 #define msi_mask_reg(base, is64bit)	\
 	(base + ((is64bit == 1) ? PCI_MSI_MASK_64 : PCI_MSI_MASK_32))
-#define is_64bit_address(control)	(!!(control & PCI_MSI_FLAGS_64BIT))
-#define is_mask_bit_support(control)	(!!(control & PCI_MSI_FLAGS_MASKBIT))
 
 #define msix_table_offset_reg(base)	(base + PCI_MSIX_TABLE)
 #define msix_pba_offset_reg(base)	(base + PCI_MSIX_PBA)

