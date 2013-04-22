Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ia0-f173.google.com ([209.85.210.173]:54459 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752616Ab3DVXLm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Apr 2013 19:11:42 -0400
Received: by mail-ia0-f173.google.com with SMTP id j5so9280iaf.32
        for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2013 16:11:42 -0700 (PDT)
Subject: [PATCH v4 13/22] PCI: Drop msix_table_offset_reg() and
 msix_pba_offset_reg() macros
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Mon, 22 Apr 2013 17:11:40 -0600
Message-ID: <20130422231140.32621.27788.stgit@bhelgaas-glaptop>
In-Reply-To: <20130422230012.32621.15224.stgit@bhelgaas-glaptop>
References: <20130422230012.32621.15224.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

msix_table_offset_reg() is used only once and adds a useless indirection,
so just use the table offset directly.

msix_pba_offset_reg() is unused, so just delete it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/msi.c |    4 ++--
 drivers/pci/msi.h |    2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index aaaf954..fb07e05 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -600,8 +600,8 @@ static void __iomem *msix_map_region(struct pci_dev *dev, unsigned nr_entries)
 	u32 table_offset;
 	u8 bir;
 
-	pci_read_config_dword(dev,
-		msix_table_offset_reg(dev->msix_cap), &table_offset);
+	pci_read_config_dword(dev, dev->msix_cap + PCI_MSIX_TABLE,
+			      &table_offset);
 	bir = (u8)(table_offset & PCI_MSIX_FLAGS_BIRMASK);
 	table_offset &= ~PCI_MSIX_FLAGS_BIRMASK;
 	phys_addr = pci_resource_start(dev, bir) + table_offset;
diff --git a/drivers/pci/msi.h b/drivers/pci/msi.h
index bc5cd99..d76c7b2 100644
--- a/drivers/pci/msi.h
+++ b/drivers/pci/msi.h
@@ -9,8 +9,6 @@
 #define msi_mask_reg(base, is64bit)	\
 	(base + ((is64bit == 1) ? PCI_MSI_MASK_64 : PCI_MSI_MASK_32))
 
-#define msix_table_offset_reg(base)	(base + PCI_MSIX_TABLE)
-#define msix_pba_offset_reg(base)	(base + PCI_MSIX_PBA)
 #define msix_table_size(control) 	((control & PCI_MSIX_FLAGS_QSIZE)+1)
 #define multi_msix_capable(control)	msix_table_size((control))
 

