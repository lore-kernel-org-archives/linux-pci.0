Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp08.in.ibm.com ([122.248.162.8]:60242 "EHLO
	e28smtp08.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933129AbbKGXbr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 7 Nov 2015 18:31:47 -0500
Received: from /spool/local
	by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Sun, 8 Nov 2015 05:01:45 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by d28dlp01.in.ibm.com (Postfix) with ESMTP id 1CCEDE004C
	for <linux-pci@vger.kernel.org>; Sun,  8 Nov 2015 05:02:02 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id tA7NVfQP6095218
	for <linux-pci@vger.kernel.org>; Sun, 8 Nov 2015 05:01:41 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
	by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id tA7NVfPJ010468
	for <linux-pci@vger.kernel.org>; Sun, 8 Nov 2015 05:01:41 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com, bhelgaas@google.com, mpe@ellerman.id.au,
	aik@ozlabs.ru
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V13 4/9] powerpc/eeh: Cache only BARs, not windows or IOV BARs
Date: Sun,  8 Nov 2015 07:30:30 +0800
Message-Id: <1446939035-2617-5-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1446939035-2617-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1446939035-2617-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This restricts the EEH address cache to use only the first 7 BARs. This
makes __eeh_addr_cache_insert_dev() ignore PCI bridge window and IOV BARs.
As the result of this change, eeh_addr_cache_get_dev() will return VFs from
VF's resource addresses instead of parent PFs.

This removes extra check for a PCI bridge as we limit
__eeh_addr_cache_insert_dev() to 7 BARs and this effectively excludes PCI
bridges from being cached.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh_cache.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_cache.c b/arch/powerpc/kernel/eeh_cache.c
index a1e86e1..ddbcfab 100644
--- a/arch/powerpc/kernel/eeh_cache.c
+++ b/arch/powerpc/kernel/eeh_cache.c
@@ -195,8 +195,11 @@ static void __eeh_addr_cache_insert_dev(struct pci_dev *dev)
 		return;
 	}
 
-	/* Walk resources on this device, poke them into the tree */
-	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
+	/*
+	 * Walk resources on this device, poke the first 7 (6 normal BAR and 1
+	 * ROM BAR) into the tree.
+	 */
+	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
 		resource_size_t start = pci_resource_start(dev,i);
 		resource_size_t end = pci_resource_end(dev,i);
 		unsigned long flags = pci_resource_flags(dev,i);
@@ -222,10 +225,6 @@ void eeh_addr_cache_insert_dev(struct pci_dev *dev)
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
2.5.0

