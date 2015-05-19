Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp02.au.ibm.com ([202.81.31.144]:59873 "EHLO
	e23smtp02.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753628AbbESKyJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 May 2015 06:54:09 -0400
Received: from /spool/local
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 19 May 2015 20:54:07 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 7DB212CE8050
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2015 20:54:04 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t4JAruu015269976
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2015 20:54:04 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t4JArVmi000427
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2015 20:53:31 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com, bhelgaas@google.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V7 04/10] powerpc/eeh: Trace first 7 BARs in address cache
Date: Tue, 19 May 2015 18:50:06 +0800
Message-Id: <1432032612-21701-5-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1432032612-21701-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1431999312-10517-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1432032612-21701-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

EEH address cache, which helps to locate the PCI device according to
the given (physical) MMIO address, didn't cover PCI bridges. Also, it
shouldn't return PF with address in PF's IOV BARs. Instead, the VFs
should be returned.

The patch restricts the address cache to cover first 7 BARs for the
above purposes.

[gwshan: changelog]
Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh_cache.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/eeh_cache.c b/arch/powerpc/kernel/eeh_cache.c
index eeabeab..f6c5f05 100644
--- a/arch/powerpc/kernel/eeh_cache.c
+++ b/arch/powerpc/kernel/eeh_cache.c
@@ -196,7 +196,7 @@ static void __eeh_addr_cache_insert_dev(struct pci_dev *dev)
 	}
 
 	/* Walk resources on this device, poke them into the tree */
-	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
+	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
 		unsigned long start = pci_resource_start(dev,i);
 		unsigned long end = pci_resource_end(dev,i);
 		unsigned int flags = pci_resource_flags(dev,i);
-- 
1.7.9.5

