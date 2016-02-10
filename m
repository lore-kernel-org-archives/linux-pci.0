Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143]:44439 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610AbcBJGEG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 10 Feb 2016 01:04:06 -0500
Received: from localhost
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Wed, 10 Feb 2016 16:04:04 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id B30112CE805B
	for <linux-pci@vger.kernel.org>; Wed, 10 Feb 2016 17:03:56 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u1A63ioA43319520
	for <linux-pci@vger.kernel.org>; Wed, 10 Feb 2016 17:03:53 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u1A63NNZ011814
	for <linux-pci@vger.kernel.org>; Wed, 10 Feb 2016 17:03:24 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, mpe@ellerman.id.au,
	aik@ozlabs.ru, ruscur@russell.cc,
	Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH v14 4/9] powerpc/eeh: Cache normal BARs, not windows or IOV BARs
Date: Wed, 10 Feb 2016 17:02:52 +1100
Message-Id: <1455084177-15525-5-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1455084177-15525-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1455084177-15525-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Wei Yang <weiyang@linux.vnet.ibm.com>

This restricts the EEH address cache to use only the first 7 BARs. This
makes __eeh_addr_cache_insert_dev() ignore PCI bridge window and IOV BARs.
As the result of this change, eeh_addr_cache_get_dev() will return VFs from
VF's resource addresses instead of parent PFs.

This also removes PCI bridge check as we limit __eeh_addr_cache_insert_dev()
to 7 BARs and this effectively excludes PCI bridges from being cached.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
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
2.1.0

