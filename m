Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp02.au.ibm.com ([202.81.31.144]:36752 "EHLO
	e23smtp02.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758748Ab3IFBqN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 5 Sep 2013 21:46:13 -0400
Received: from /spool/local
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Fri, 6 Sep 2013 11:34:30 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id 5C84C357804E
	for <linux-pci@vger.kernel.org>; Fri,  6 Sep 2013 11:46:08 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r861TgTh917822
	for <linux-pci@vger.kernel.org>; Fri, 6 Sep 2013 11:29:42 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id r861k7Wt017138
	for <linux-pci@vger.kernel.org>; Fri, 6 Sep 2013 11:46:07 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH 3/3] PCI: Pass full info for window alignment
Date: Fri,  6 Sep 2013 09:45:58 +0800
Message-Id: <1378431958-7874-3-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1378431958-7874-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1378431958-7874-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When calculating the window_alignment(), type information like IORESOURCE_MEM
and IORESOURCE_PREFETCH is not enough for some platform.

As on powernv platform, one prefetchable window could be IORESOURCE_MEM_64 or
not. The platform will calculate the alignment based on this information.

This patch passes the full info for window alignment.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 drivers/pci/setup-bus.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 989de3c..8781eb1 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -980,7 +980,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	}
 
 	min_align = calculate_mem_align(aligns, max_order);
-	min_align = max(min_align, window_alignment(bus, b_res->flags & mask));
+	min_align = max(min_align, window_alignment(bus, b_res->flags));
 	size0 = calculate_memsize(size, min_size, 0, resource_size(b_res), min_align);
 	if (children_add_size > add_size)
 		add_size = children_add_size;
-- 
1.7.1

