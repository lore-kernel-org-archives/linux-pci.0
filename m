Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:41584 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752874Ab3DVXMa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Apr 2013 19:12:30 -0400
Received: by mail-ie0-f176.google.com with SMTP id x14so12907ief.35
        for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2013 16:12:30 -0700 (PDT)
Subject: [PATCH v4 20/22] xen/pci: Used cached MSI-X capability offset
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Date: Mon, 22 Apr 2013 17:12:28 -0600
Message-ID: <20130422231228.32621.88310.stgit@bhelgaas-glaptop>
In-Reply-To: <20130422230012.32621.15224.stgit@bhelgaas-glaptop>
References: <20130422230012.32621.15224.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We now cache the MSI-X capability offset in the struct pci_dev, so no
need to find the capability again.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 arch/x86/pci/xen.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index b9d1ff2..7b521ef 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -295,8 +295,7 @@ static int xen_initdom_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 			int pos;
 			u32 table_offset, bir;
 
-			pos = pci_find_capability(dev, PCI_CAP_ID_MSIX);
-
+			pos = dev->msix_cap;
 			pci_read_config_dword(dev, pos + PCI_MSIX_TABLE,
 					      &table_offset);
 			bir = (u8)(table_offset & PCI_MSIX_TABLE_BIR);

