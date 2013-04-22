Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ia0-f169.google.com ([209.85.210.169]:43766 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753778Ab3DVXL3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Apr 2013 19:11:29 -0400
Received: by mail-ia0-f169.google.com with SMTP id l29so12321iag.0
        for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2013 16:11:29 -0700 (PDT)
Subject: [PATCH v4 11/22] PCI: Drop msi_data_reg() macro
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Mon, 22 Apr 2013 17:11:27 -0600
Message-ID: <20130422231127.32621.11313.stgit@bhelgaas-glaptop>
In-Reply-To: <20130422230012.32621.15224.stgit@bhelgaas-glaptop>
References: <20130422230012.32621.15224.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

msi_data_reg() doesn't provide any useful abstraction, so drop it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/msi.c |   12 ++++++------
 drivers/pci/msi.h |    2 --
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 7011c5d..1688c26 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -249,10 +249,10 @@ void __read_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 		if (entry->msi_attrib.is_64) {
 			pci_read_config_dword(dev, pos + PCI_MSI_ADDRESS_HI,
 					      &msg->address_hi);
-			pci_read_config_word(dev, msi_data_reg(pos, 1), &data);
+			pci_read_config_word(dev, pos + PCI_MSI_DATA_64, &data);
 		} else {
 			msg->address_hi = 0;
-			pci_read_config_word(dev, msi_data_reg(pos, 0), &data);
+			pci_read_config_word(dev, pos + PCI_MSI_DATA_32, &data);
 		}
 		msg->data = data;
 	}
@@ -309,11 +309,11 @@ void __write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 		if (entry->msi_attrib.is_64) {
 			pci_write_config_dword(dev, pos + PCI_MSI_ADDRESS_HI,
 					       msg->address_hi);
-			pci_write_config_word(dev, msi_data_reg(pos, 1),
-						msg->data);
+			pci_write_config_word(dev, pos + PCI_MSI_DATA_64,
+					      msg->data);
 		} else {
-			pci_write_config_word(dev, msi_data_reg(pos, 0),
-						msg->data);
+			pci_write_config_word(dev, pos + PCI_MSI_DATA_32,
+					      msg->data);
 		}
 	}
 	entry->msg = *msg;
diff --git a/drivers/pci/msi.h b/drivers/pci/msi.h
index e5b87d6..d2c6cd9 100644
--- a/drivers/pci/msi.h
+++ b/drivers/pci/msi.h
@@ -6,8 +6,6 @@
 #ifndef MSI_H
 #define MSI_H
 
-#define msi_data_reg(base, is64bit)	\
-	(base + ((is64bit == 1) ? PCI_MSI_DATA_64 : PCI_MSI_DATA_32))
 #define msi_mask_reg(base, is64bit)	\
 	(base + ((is64bit == 1) ? PCI_MSI_MASK_64 : PCI_MSI_MASK_32))
 #define is_64bit_address(control)	(!!(control & PCI_MSI_FLAGS_64BIT))

