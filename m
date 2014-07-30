Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148]:47461 "EHLO
	e23smtp06.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbaG3IAU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Jul 2014 04:00:20 -0400
Received: from /spool/local
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <yan@linux.vnet.ibm.com>;
	Wed, 30 Jul 2014 18:00:05 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id 3040E3578053
	for <linux-pci@vger.kernel.org>; Wed, 30 Jul 2014 18:00:14 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s6U7bC5J590150
	for <linux-pci@vger.kernel.org>; Wed, 30 Jul 2014 17:37:13 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s6U80CDu027186
	for <linux-pci@vger.kernel.org>; Wed, 30 Jul 2014 18:00:12 +1000
From: Guo Chao <yan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: Guo Chao <yan@linux.vnet.ibm.com>
Subject: [PATCH] PCI: Reset failed bridge resources in PCI realloc
Date: Wed, 30 Jul 2014 16:00:07 +0800
Message-Id: <1406707207-13152-1-git-send-email-yan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We observed a problem on at least two POWER machines with PCIe
devices with very large SR-IOV BARs. The total size is larger than
host bridge MMIO window. We expect normal BARs of this device get address
successfuly, and SR-IOV BARs deserted. However, this only happens if PCI
realloc is disabled (pci=realloc=off or not config at all). Otherwise we
fail to assign both BARs.

Here is what happened when realloc is enabled:
	* SR-IOV resources will NOT be considered as optional until the last
	  round of realloc. Both normal BARs and SR-IOV BARs of this device
	  will be sized and recorded in upstream bridge as initial size.
	* Realloc never works because this bridge is too big, at end of
	  each round, the bridge is restored to the value before
	  assigning, i.e. it keeps its size.
	* At last round, we finally consider SR-IOV resources optional
	  and size them seperately. We should get a small bridge this
	  time.
	* However, in pbus_size_mem() we call calculate_memsize() to
	  calculate the final size. calculate_memsize() never shrinks
	  window, i.e. if old size is larger than newly sized result,
	  old size will be honored. Unfortunately, the old size at this
	  time is the sum of both normal BARs and SR-IOV BARs when doing
	  realloc.
	* The bridge window failed to get address just like previous rounds.

Without PCI realloc, SR-IOV resources are considered as optional
from the beginning and sized seperately. The old size would be 0. We get
a small bridge window and assinged successfully. Everything work as
expected.

I actually don't quite understand what realloc does. Apparently this is
not the right fix ...

Cc: Yinghai Lu <yinghai@kernel.org> 
Signed-off-by: Guo Chao <yan@linux.vnet.ibm.com>
---
 drivers/pci/setup-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index a5a63ec..39837d7 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1623,7 +1623,7 @@ again:
 		res->end = fail_res->end;
 		res->flags = fail_res->flags;
 		if (fail_res->dev->subordinate)
-			res->flags = 0;
+			res->flags = res->start = res->end = 0;
 	}
 	free_list(&fail_head);
 
-- 
1.9.1

