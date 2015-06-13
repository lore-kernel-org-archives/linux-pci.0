Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:39301 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931AbbFMWj1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 13 Jun 2015 18:39:27 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH] PCI: get correct bridge mmio size with old size checking
Date: Sat, 13 Jun 2015 15:39:02 -0700
Message-Id: <1434235142-2751-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Found allocation request too big size for must+optional during pci
bus rescan via /sys/bus/pci/rescan, and fail with that size.

[ 1217.699800] pci 0000:85:02.0: bridge window [mem 0x00100000-0x001fffff] to [bus 86] add_size 100000 add_align 100000
[ 1217.699821] pci 0000:85:03.0: bridge window [mem 0x00100000-0x001fffff] to [bus 87] add_size 100000 add_align 100000
[ 1217.699907] pci 0000:85:02.0: res[14]=[mem 0x00100000-0x001fffff] res_to_dev_res add_size 100000 min_align 100000
[ 1217.699909] pci 0000:85:03.0: res[14]=[mem 0x00100000-0x001fffff] res_to_dev_res add_size 100000 min_align 100000
[ 1217.699933] pci 0000:85:02.0: BAR 14: assigned [mem 0xedf00000-0xee0fffff]
[ 1217.699936] pci 0000:85:03.0: BAR 14: no space for [mem size 0x00200000]
[ 1217.699939] pci 0000:85:03.0: BAR 14: failed to assign [mem size 0x00200000]

After close look, for 85:02.0 only need 1M for must+optional.

It turns out that there is bug in calculate_memsize() with checking.
We should compare size sum with old size at last instead of partial size.

Actually we have that correct in calculate_iosize(), with this patch
we have mmio and io port size calculation consistent.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>

---
 drivers/pci/setup-bus.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/pci/setup-bus.c
===================================================================
--- linux-2.6.orig/drivers/pci/setup-bus.c
+++ linux-2.6/drivers/pci/setup-bus.c
@@ -857,9 +857,10 @@ static resource_size_t calculate_memsize
 		size = min_size;
 	if (old_size == 1)
 		old_size = 0;
+	size = ALIGN(size + size1, align);
 	if (size < old_size)
 		size = old_size;
-	size = ALIGN(size + size1, align);
+
 	return size;
 }
 
