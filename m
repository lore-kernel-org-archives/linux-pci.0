Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:46291 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044AbbBXIfV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 Feb 2015 03:35:21 -0500
Received: by pabkx10 with SMTP id kx10so34334384pab.13
        for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2015 00:35:21 -0800 (PST)
Subject: [PATCH v12 20/21] powerpc/pci: Remove unused struct pci_dn.pcidev
 field
To: Wei Yang <weiyang@linux.vnet.ibm.com>, benh@au1.ibm.com,
	gwshan@linux.vnet.ibm.com
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 24 Feb 2015 02:35:19 -0600
Message-ID: <20150224083519.32124.15959.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150224082939.32124.45744.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150224082939.32124.45744.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Wei Yang <weiyang@linux.vnet.ibm.com>

In struct pci_dn, the pcidev field is assigned but not used, so remove it.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pci-bridge.h     |    1 -
 arch/powerpc/platforms/powernv/pci-ioda.c |    1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 958ea8675691..109efbaf384d 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -168,7 +168,6 @@ struct pci_dn {
 
 	int	pci_ext_config_space;	/* for pci devices */
 
-	struct	pci_dev *pcidev;	/* back-pointer to the pci device */
 #ifdef CONFIG_EEH
 	struct eeh_dev *edev;		/* eeh device */
 #endif
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index b265d5da601b..58d4ca01bfd9 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1024,7 +1024,6 @@ static void pnv_ioda_setup_same_PE(struct pci_bus *bus, struct pnv_ioda_pe *pe)
 				pci_name(dev));
 			continue;
 		}
-		pdn->pcidev = dev;
 		pdn->pe_number = pe->pe_number;
 		pe->dma_weight += pnv_ioda_dma_weight(dev);
 		if ((pe->flags & PNV_IODA_PE_BUS_ALL) && dev->subordinate)

