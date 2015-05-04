Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148]:56673 "EHLO
	e23smtp06.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977AbbEDHJu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 4 May 2015 03:09:50 -0400
Received: from /spool/local
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Mon, 4 May 2015 17:09:47 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id D147B357804F
	for <linux-pci@vger.kernel.org>; Mon,  4 May 2015 17:09:45 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t4479bbg20447378
	for <linux-pci@vger.kernel.org>; Mon, 4 May 2015 17:09:45 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t4479CNT000583
	for <linux-pci@vger.kernel.org>; Mon, 4 May 2015 17:09:13 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com, bhelgaas@google.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V3 4/9] powerpc/eeh: cache address range just for normal device
Date: Mon,  4 May 2015 15:07:33 +0800
Message-Id: <1430723258-21299-5-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1430723258-21299-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1430723258-21299-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The address cache is used to find the related eeh_dev for a given MMIO
address.  From the definition of pci_dev.resource[], it keeps MMIO address
in following order: 6 normal BAR, ROM BAR, 6 IOV BAR, 4 Bridge window.

In the address cache, first it doesn't cache bridge device, second the IOV
BAR range should map to their own VFs separately. This means it just need
to cache the first 7 BARs for a normal device.

This patch restricts the address cache to save the first 7 BARs for a pci
device.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh_cache.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/eeh_cache.c b/arch/powerpc/kernel/eeh_cache.c
index a1e86e1..f0ce2a3 100644
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
-- 
1.7.9.5

