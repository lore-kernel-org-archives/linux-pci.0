Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:35641 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753063Ab3DVXMD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Apr 2013 19:12:03 -0400
Received: by mail-ie0-f173.google.com with SMTP id k5so15080iea.18
        for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2013 16:12:03 -0700 (PDT)
Subject: [PATCH v4 16/22] PCI: Use PCI_MSIX_TABLE_BIR,
 not PCI_MSIX_FLAGS_BIRMASK
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Mon, 22 Apr 2013 17:12:01 -0600
Message-ID: <20130422231201.32621.97345.stgit@bhelgaas-glaptop>
In-Reply-To: <20130422230012.32621.15224.stgit@bhelgaas-glaptop>
References: <20130422230012.32621.15224.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI_MSIX_FLAGS_BIRMASK is mis-named because the BIR mask is in the
Table Offset register, not the flags ("Message Control" per spec)
register.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/msi.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index afdc388..f8a1f39 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -605,8 +605,8 @@ static void __iomem *msix_map_region(struct pci_dev *dev, unsigned nr_entries)
 
 	pci_read_config_dword(dev, dev->msix_cap + PCI_MSIX_TABLE,
 			      &table_offset);
-	bir = (u8)(table_offset & PCI_MSIX_FLAGS_BIRMASK);
-	table_offset &= ~PCI_MSIX_FLAGS_BIRMASK;
+	bir = (u8)(table_offset & PCI_MSIX_TABLE_BIR);
+	table_offset &= PCI_MSIX_TABLE_OFFSET;
 	phys_addr = pci_resource_start(dev, bir) + table_offset;
 
 	return ioremap_nocache(phys_addr, nr_entries * PCI_MSIX_ENTRY_SIZE);

