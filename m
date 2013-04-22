Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ia0-f175.google.com ([209.85.210.175]:47599 "EHLO
	mail-ia0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474Ab3DVXLt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Apr 2013 19:11:49 -0400
Received: by mail-ia0-f175.google.com with SMTP id i38so9047iae.34
        for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2013 16:11:49 -0700 (PDT)
Subject: [PATCH v4 14/22] PCI: Use msix_table_size() directly,
 drop multi_msix_capable()
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Mon, 22 Apr 2013 17:11:47 -0600
Message-ID: <20130422231147.32621.26551.stgit@bhelgaas-glaptop>
In-Reply-To: <20130422230012.32621.15224.stgit@bhelgaas-glaptop>
References: <20130422230012.32621.15224.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The users of multi_msix_capable() are really interested in the table
size, so just say what we mean.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/msi.c |    7 +++++--
 drivers/pci/msi.h |    3 ---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index fb07e05..06c5f6e 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -26,6 +26,9 @@
 
 static int pci_msi_enable = 1;
 
+#define msix_table_size(flags)	((flags & PCI_MSIX_FLAGS_QSIZE) + 1)
+
+
 /* Arch hooks */
 
 #ifndef arch_msi_check_device
@@ -681,7 +684,7 @@ static int msix_capability_init(struct pci_dev *dev,
 	pci_write_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, control);
 
 	/* Request & Map MSI-X table region */
-	base = msix_map_region(dev, multi_msix_capable(control));
+	base = msix_map_region(dev, msix_table_size(control));
 	if (!base)
 		return -ENOMEM;
 
@@ -904,7 +907,7 @@ int pci_msix_table_size(struct pci_dev *dev)
 		return 0;
 
 	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &control);
-	return multi_msix_capable(control);
+	return msix_table_size(control);
 }
 
 /**
diff --git a/drivers/pci/msi.h b/drivers/pci/msi.h
index d76c7b2..df12830 100644
--- a/drivers/pci/msi.h
+++ b/drivers/pci/msi.h
@@ -9,7 +9,4 @@
 #define msi_mask_reg(base, is64bit)	\
 	(base + ((is64bit == 1) ? PCI_MSI_MASK_64 : PCI_MSI_MASK_32))
 
-#define msix_table_size(control) 	((control & PCI_MSIX_FLAGS_QSIZE)+1)
-#define multi_msix_capable(control)	msix_table_size((control))
-
 #endif /* MSI_H */

