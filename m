Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp08.in.ibm.com ([122.248.162.8]:54957 "EHLO
	e28smtp08.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633Ab3KSGhL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Nov 2013 01:37:11 -0500
Received: from /spool/local
	by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <yan@linux.vnet.ibm.com>;
	Tue, 19 Nov 2013 12:07:08 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by d28dlp01.in.ibm.com (Postfix) with ESMTP id B2B37E004A
	for <linux-pci@vger.kernel.org>; Tue, 19 Nov 2013 12:09:02 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id rAJ6b08i19726354
	for <linux-pci@vger.kernel.org>; Tue, 19 Nov 2013 12:07:00 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id rAJ6b3cp008704
	for <linux-pci@vger.kernel.org>; Tue, 19 Nov 2013 12:07:04 +0530
From: Guo Chao <yan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, yinghai@kernel.org
Subject: [RFC PATCH 3/3] PCI: do not reset bridge's IORESOURCE_MEM_64 flag for ROM BAR
Date: Tue, 19 Nov 2013 14:36:58 +0800
Message-Id: <1384843018-9479-4-git-send-email-yan@linux.vnet.ibm.com>
In-Reply-To: <1384843018-9479-1-git-send-email-yan@linux.vnet.ibm.com>
References: <1384843018-9479-1-git-send-email-yan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If 32-bit prefetchable BARs detected, the prefetchable resource's
IORESOURCE_MEM_64 flag of its upstream bridge will be reset. This in
turn causes all upstream bridges up to the root bridge have their
IORESOURCE_MEM_64 reset. If prefetchable windows in a system located
above 4G, then they are never used for the sake of 32-bit prefetchable BAR.

Desert 64-bit prefetchable windows for ROM BAR seems unreasonable.
Just don't reset bridge's IORESOURCE_MEM_64 flag in case of ROM BARs.
They will fail to get address from 4G-above prefetchable window and
fall back to non-prefetchable window within 4G.

Signed-off-by: Guo Chao <yan@linux.vnet.ibm.com>
---
 drivers/pci/setup-bus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 4ce83b2..e9006b9 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -974,7 +974,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 				aligns[order] += align;
 			if (order > max_order)
 				max_order = order;
-			mem64_mask &= r->flags & IORESOURCE_MEM_64;
+			if (i != PCI_ROM_RESOURCE)
+				mem64_mask &= r->flags & IORESOURCE_MEM_64;
 
 			if (realloc_head)
 				children_add_size += get_res_add_size(realloc_head, r);
-- 
1.8.3.2

