Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147]:43870 "EHLO
	e23smtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332AbbCYF5x (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Mar 2015 01:57:53 -0400
Received: from /spool/local
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Wed, 25 Mar 2015 15:57:52 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id 08690357804C
	for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2015 16:57:51 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t2P5vfQ940829128
	for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2015 16:57:49 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t2P5vFEf031181
	for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2015 16:57:16 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V15 20/21] powerpc/pci: Remove unused struct pci_dn.pcidev field
Date: Wed, 25 Mar 2015 13:44:56 +0800
Message-Id: <1427262297-5694-21-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1427262297-5694-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1427262297-5694-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In struct pci_dn, the pcidev field is assigned but not used, so remove it.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pci-bridge.h     |    1 -
 arch/powerpc/platforms/powernv/pci-ioda.c |    1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index ec83b51..680ae56 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -168,7 +168,6 @@ struct pci_dn {
 
 	int	pci_ext_config_space;	/* for pci devices */
 
-	struct	pci_dev *pcidev;	/* back-pointer to the pci device */
 #ifdef CONFIG_EEH
 	struct eeh_dev *edev;		/* eeh device */
 #endif
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index dc9f401..2505ad1 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1028,7 +1028,6 @@ static void pnv_ioda_setup_same_PE(struct pci_bus *bus, struct pnv_ioda_pe *pe)
 				pci_name(dev));
 			continue;
 		}
-		pdn->pcidev = dev;
 		pdn->pe_number = pe->pe_number;
 		pe->dma_weight += pnv_ioda_dma_weight(dev);
 		if ((pe->flags & PNV_IODA_PE_BUS_ALL) && dev->subordinate)
-- 
1.7.9.5

