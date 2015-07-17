Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp03.in.ibm.com ([122.248.162.3]:50594 "EHLO
	e28smtp03.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756736AbbGQGDL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jul 2015 02:03:11 -0400
Received: from /spool/local
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Fri, 17 Jul 2015 11:33:09 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by d28dlp01.in.ibm.com (Postfix) with ESMTP id 4F91CE005E
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2015 11:37:03 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t6H633IM29556844
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2015 11:33:04 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
	by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t6H632mS026936
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2015 11:33:03 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com, bhelgaas@google.com, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V9 05/11] powerpc/eeh: Cache only BARs, not windows or IOV BARs
Date: Fri, 17 Jul 2015 14:02:35 +0800
Message-Id: <1437112961-17275-6-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1437112961-17275-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1437112961-17275-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

EEH address cache, which helps to locate the PCI device according to
the given (physical) MMIO address, didn't cover PCI bridges. Also, it
shouldn't return PF with address in PF's IOV BARs. Instead, the VFs
should be returned.

Also, by doing so, it removes the type check in
eeh_addr_cache_insert_dev(), since bridge's window would not be cached.

The patch restricts the address cache to cover first 7 BARs for the
above purposes.

[gwshan: changelog]
Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh_cache.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_cache.c b/arch/powerpc/kernel/eeh_cache.c
index a1e86e1..e6887f0 100644
--- a/arch/powerpc/kernel/eeh_cache.c
+++ b/arch/powerpc/kernel/eeh_cache.c
@@ -196,7 +196,7 @@ static void __eeh_addr_cache_insert_dev(struct pci_dev *dev)
 	}
 
 	/* Walk resources on this device, poke them into the tree */
-	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
+	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
 		resource_size_t start = pci_resource_start(dev,i);
 		resource_size_t end = pci_resource_end(dev,i);
 		unsigned long flags = pci_resource_flags(dev,i);
@@ -222,10 +222,6 @@ void eeh_addr_cache_insert_dev(struct pci_dev *dev)
 {
 	unsigned long flags;
 
-	/* Ignore PCI bridges */
-	if ((dev->class >> 16) == PCI_BASE_CLASS_BRIDGE)
-		return;
-
 	spin_lock_irqsave(&pci_io_addr_cache_root.piar_lock, flags);
 	__eeh_addr_cache_insert_dev(dev);
 	spin_unlock_irqrestore(&pci_io_addr_cache_root.piar_lock, flags);
-- 
1.7.9.5

