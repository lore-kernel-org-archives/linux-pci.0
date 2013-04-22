Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ia0-f177.google.com ([209.85.210.177]:33949 "EHLO
	mail-ia0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753507Ab3DVXLW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Apr 2013 19:11:22 -0400
Received: by mail-ia0-f177.google.com with SMTP id y26so8828iab.36
        for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2013 16:11:22 -0700 (PDT)
Subject: [PATCH v4 10/22] PCI: Drop msi_lower_address_reg() and
 msi_upper_address_reg() macros
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Mon, 22 Apr 2013 17:11:20 -0600
Message-ID: <20130422231120.32621.81415.stgit@bhelgaas-glaptop>
In-Reply-To: <20130422230012.32621.15224.stgit@bhelgaas-glaptop>
References: <20130422230012.32621.15224.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

msi_lower_address_reg() and msi_upper_address_reg() don't provide any
useful abstraction, so drop them.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/msi.c |   16 ++++++++--------
 drivers/pci/msi.h |    2 --
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index b1a60e0..7011c5d 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -244,11 +244,11 @@ void __read_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 		int pos = dev->msi_cap;
 		u16 data;
 
-		pci_read_config_dword(dev, msi_lower_address_reg(pos),
-					&msg->address_lo);
+		pci_read_config_dword(dev, pos + PCI_MSI_ADDRESS_LO,
+				      &msg->address_lo);
 		if (entry->msi_attrib.is_64) {
-			pci_read_config_dword(dev, msi_upper_address_reg(pos),
-						&msg->address_hi);
+			pci_read_config_dword(dev, pos + PCI_MSI_ADDRESS_HI,
+					      &msg->address_hi);
 			pci_read_config_word(dev, msi_data_reg(pos, 1), &data);
 		} else {
 			msg->address_hi = 0;
@@ -304,11 +304,11 @@ void __write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 		msgctl |= entry->msi_attrib.multiple << 4;
 		pci_write_config_word(dev, pos + PCI_MSI_FLAGS, msgctl);
 
-		pci_write_config_dword(dev, msi_lower_address_reg(pos),
-					msg->address_lo);
+		pci_write_config_dword(dev, pos + PCI_MSI_ADDRESS_LO,
+				       msg->address_lo);
 		if (entry->msi_attrib.is_64) {
-			pci_write_config_dword(dev, msi_upper_address_reg(pos),
-						msg->address_hi);
+			pci_write_config_dword(dev, pos + PCI_MSI_ADDRESS_HI,
+					       msg->address_hi);
 			pci_write_config_word(dev, msi_data_reg(pos, 1),
 						msg->data);
 		} else {
diff --git a/drivers/pci/msi.h b/drivers/pci/msi.h
index 6aa7b19..e5b87d6 100644
--- a/drivers/pci/msi.h
+++ b/drivers/pci/msi.h
@@ -6,8 +6,6 @@
 #ifndef MSI_H
 #define MSI_H
 
-#define msi_lower_address_reg(base)	(base + PCI_MSI_ADDRESS_LO)
-#define msi_upper_address_reg(base)	(base + PCI_MSI_ADDRESS_HI)
 #define msi_data_reg(base, is64bit)	\
 	(base + ((is64bit == 1) ? PCI_MSI_DATA_64 : PCI_MSI_DATA_32))
 #define msi_mask_reg(base, is64bit)	\

