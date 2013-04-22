Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ia0-f173.google.com ([209.85.210.173]:34868 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753742Ab3DVXLQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Apr 2013 19:11:16 -0400
Received: by mail-ia0-f173.google.com with SMTP id j5so8991iaf.32
        for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2013 16:11:15 -0700 (PDT)
Subject: [PATCH v4 09/22] PCI: Drop msi_control_reg() macro and use
 PCI_MSI_FLAGS directly
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Mon, 22 Apr 2013 17:11:14 -0600
Message-ID: <20130422231113.32621.60385.stgit@bhelgaas-glaptop>
In-Reply-To: <20130422230012.32621.15224.stgit@bhelgaas-glaptop>
References: <20130422230012.32621.15224.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Note the error in pci_msix_table_size() -- we used PCI_MSI_FLAGS to
locate the PCI_MSIX_FLAGS word.  No actual breakage because PCI_MSI_FLAGS
and PCI_MSIX_FLAGS happen to be the same.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/msi.c |    8 ++++----
 drivers/pci/msi.h |    1 -
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 631249e..b1a60e0 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -299,10 +299,10 @@ void __write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 		int pos = dev->msi_cap;
 		u16 msgctl;
 
-		pci_read_config_word(dev, msi_control_reg(pos), &msgctl);
+		pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &msgctl);
 		msgctl &= ~PCI_MSI_FLAGS_QSIZE;
 		msgctl |= entry->msi_attrib.multiple << 4;
-		pci_write_config_word(dev, msi_control_reg(pos), msgctl);
+		pci_write_config_word(dev, pos + PCI_MSI_FLAGS, msgctl);
 
 		pci_write_config_dword(dev, msi_lower_address_reg(pos),
 					msg->address_lo);
@@ -548,7 +548,7 @@ static int msi_capability_init(struct pci_dev *dev, int nvec)
 
 	msi_set_enable(dev, 0);	/* Disable MSI during set up */
 
-	pci_read_config_word(dev, msi_control_reg(dev->msi_cap), &control);
+	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
 	/* MSI Entry Initialization */
 	entry = alloc_msi_entry(dev);
 	if (!entry)
@@ -903,7 +903,7 @@ int pci_msix_table_size(struct pci_dev *dev)
 	if (!dev->msix_cap)
 		return 0;
 
-	pci_read_config_word(dev, msi_control_reg(dev->msix_cap), &control);
+	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &control);
 	return multi_msix_capable(control);
 }
 
diff --git a/drivers/pci/msi.h b/drivers/pci/msi.h
index 65c42f8..6aa7b19 100644
--- a/drivers/pci/msi.h
+++ b/drivers/pci/msi.h
@@ -6,7 +6,6 @@
 #ifndef MSI_H
 #define MSI_H
 
-#define msi_control_reg(base)		(base + PCI_MSI_FLAGS)
 #define msi_lower_address_reg(base)	(base + PCI_MSI_ADDRESS_LO)
 #define msi_upper_address_reg(base)	(base + PCI_MSI_ADDRESS_HI)
 #define msi_data_reg(base, is64bit)	\

