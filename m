Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ia0-f178.google.com ([209.85.210.178]:34486 "EHLO
	mail-ia0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753761Ab3DVXMX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Apr 2013 19:12:23 -0400
Received: by mail-ia0-f178.google.com with SMTP id j38so8986iad.37
        for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2013 16:12:23 -0700 (PDT)
Subject: [PATCH v4 19/22] xen/pci: Use PCI_MSIX_TABLE_BIR,
 not PCI_MSIX_FLAGS_BIRMASK
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Date: Mon, 22 Apr 2013 17:12:21 -0600
Message-ID: <20130422231221.32621.95466.stgit@bhelgaas-glaptop>
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
CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 arch/x86/pci/xen.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index 0e8a196..b9d1ff2 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -299,7 +299,7 @@ static int xen_initdom_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 
 			pci_read_config_dword(dev, pos + PCI_MSIX_TABLE,
 					      &table_offset);
-			bir = (u8)(table_offset & PCI_MSIX_FLAGS_BIRMASK);
+			bir = (u8)(table_offset & PCI_MSIX_TABLE_BIR);
 			table_offset &= PCI_MSIX_TABLE_OFFSET;
 
 			map_irq.table_base = pci_resource_start(dev, bir) +

