Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:43419 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932622AbcDHAWU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Apr 2016 20:22:20 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v11 46/60] PCI: Fix size calculation with old_size on rescan path
Date: Thu,  7 Apr 2016 17:15:59 -0700
Message-Id: <1460074573-7481-47-git-send-email-yinghai@kernel.org>
In-Reply-To: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
References: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On booting path, we don't pass realloc at first, and treat all optional
just as required, in some case we can have smaller size/align with optional
than required only.

  04:00.0 has children bridges: 05:03.0, 05:04.0
pref layout after booting path like followings:

pci 0000:04:00.0: BAR 9: assigned [mem 0x84000000-0x9fffffff 64bit pref]
pci 0000:05:04.0: BAR 9: assigned [mem 0x88000000-0x9fffffff 64bit pref]
pci 0000:05:03.0: BAR 9: assigned [mem 0x84000000-0x841fffff 64bit pref]
pci 0000:05:03.0: PCI bridge to [bus 08-0f]
pci 0000:05:03.0:   bridge window [mem 0x84000000-0x841fffff 64bit pref]
pci 0000:05:04.0: PCI bridge to [bus 10]
pci 0000:05:04.0:   bridge window [mem 0x88000000-0x9fffffff 64bit pref]
pci 0000:04:00.0: PCI bridge to [bus 05-10]
pci 0000:04:00.0:   bridge window [mem 0x84000000-0x9fffffff 64bit pref]

so the old size in rescan for 04:00.0 would be 0x1c000000, and align is 0x4000000

during remove and rescan:

pci 0000:05:03.0: bridge window [mem 0x00000000-0xffffffffffffffff 64bit pref] to [bus 08-0f] add_size 200000 add_align 100000 alt_size 0 alt_align 0 must_size 0 must_align 0
pci 0000:05:03.0: bridge window [mem 0x00000000-0xffffffffffffffff] to [bus 08-0f] add_size 200000 add_align 100000 alt_size 0 alt_align 0 must_size 0 must_align 0
pci 0000:05:04.0: bridge window [mem 0x08000000-0x1fffffff 64bit pref] to [bus 10] add_size 0 add_align 0 alt_size 10100000 alt_align 10000000 must_size 18000000 must_align 8000000
pci 0000:05:03.0: BAR 9: [mem 0x00000000-0xffffffffffffffff 64bit pref] get_res_add_size add_size   200000
pci 0000:05:03.0: BAR 9: [mem 0x00000000-0xffffffffffffffff 64bit pref] get_res_add_align min_align 100000
pci 0000:04:00.0: bridge window [mem 0x08000000-0x27ffffff 64bit pref] to [bus 05-10] add_size 0 add_align 0 alt_size 10100000 alt_align 10000000 must_size 20000000 must_align 8000000

align old size 0x1c000000 to 0x2000000 as size0, 0x1c000000 as size1.
so for 04:00.0 will have big must and no optional size anymore.

So don't align old size, then we will have same size0 and size1,
and use smaller add_align as must align.

After the patch, rescan works properly.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 88557b9..d2712d8 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1133,9 +1133,9 @@ static resource_size_t calculate_memsize(resource_size_t size,
 		size = min_size;
 	if (old_size == 1)
 		old_size = 0;
+	size = ALIGN(size, align);
 	if (size < old_size)
 		size = old_size;
-	size = ALIGN(size, align);
 	return size;
 }
 
@@ -1595,6 +1595,17 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 		b_res->flags = 0;
 		return 0;
 	}
+
+	/*
+	 * It happens when boot path is not passing realloc
+	 * and later rescan is passing realloc.
+	 * The old value from boot path is bigger, and calculate_size will
+	 * use old value as size0 and size1, and also have
+	 * chance optional align is smaller than must only align.
+	 */
+	if(size0 == size1 && min_align > min_add_align)
+		min_align = min_add_align;
+
 	b_res->start = min_align;
 	b_res->end = size0 + min_align - 1;
 	b_res->flags |= IORESOURCE_STARTALIGN;
-- 
1.8.4.5

