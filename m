Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:46678 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753063Ab3DVXMR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Apr 2013 19:12:17 -0400
Received: by mail-ie0-f175.google.com with SMTP id a11so16618iee.6
        for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2013 16:12:16 -0700 (PDT)
Subject: [PATCH v4 18/22] xen/pci: Pay attention to PCI_MSIX_TABLE_OFFSET
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Date: Mon, 22 Apr 2013 17:12:14 -0600
Message-ID: <20130422231214.32621.37394.stgit@bhelgaas-glaptop>
In-Reply-To: <20130422230012.32621.15224.stgit@bhelgaas-glaptop>
References: <20130422230012.32621.15224.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The MSI-X Table structure may be at a non-zero offset into the
device BAR, and we should account for that.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 arch/x86/pci/xen.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index 94e7662..0e8a196 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -300,8 +300,10 @@ static int xen_initdom_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 			pci_read_config_dword(dev, pos + PCI_MSIX_TABLE,
 					      &table_offset);
 			bir = (u8)(table_offset & PCI_MSIX_FLAGS_BIRMASK);
+			table_offset &= PCI_MSIX_TABLE_OFFSET;
 
-			map_irq.table_base = pci_resource_start(dev, bir);
+			map_irq.table_base = pci_resource_start(dev, bir) +
+				table_offset;
 			map_irq.entry_nr = msidesc->msi_attrib.entry_nr;
 		}
 

