Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:46371 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755863AbcDHAer (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Apr 2016 20:34:47 -0400
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
Subject: [PATCH v11 53/60] PCI: Kill macro checking for bus io port sizing
Date: Thu,  7 Apr 2016 17:16:06 -0700
Message-Id: <1460074573-7481-54-git-send-email-yinghai@kernel.org>
In-Reply-To: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
References: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We can use new generic version skip_isa_ioresource_align() instead
of macro, and then kill the marco.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 5ba4bf5..65a41e7 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1159,15 +1159,12 @@ int skip_isa_ioresource_align(struct pci_bus *bus)
 	return 0;
 }
 
-static resource_size_t size_aligned_for_isa(resource_size_t size)
+static resource_size_t size_aligned_for_isa(resource_size_t size,
+					    struct pci_bus *bus)
 {
-	/*
-	 * To be fixed in 2.5: we should have sort of HAVE_ISA
-	 *  flag in the struct pci_bus.
-	 */
-#if defined(CONFIG_ISA) || defined(CONFIG_EISA)
-	size = (size & 0xff) + ((size & ~0xffUL) << 2);
-#endif
+	if (!skip_isa_ioresource_align(bus))
+		size = (size & 0xff) + ((size & ~0xffUL) << 2);
+
 	return size;
 }
 
@@ -1236,12 +1233,12 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 		}
 	}
 
-	size = size_aligned_for_isa(size);
+	size = size_aligned_for_isa(size, bus);
 	size += size1;
 	if (size || min_size)
 		size0 = calculate_size(size, min_size,
 					resource_size(b_res), min_align);
-	sum_add_size = size_aligned_for_isa(sum_add_size);
+	sum_add_size = size_aligned_for_isa(sum_add_size, bus);
 	sum_add_size += sum_add_size1;
 	if (sum_add_size < min_sum_size)
 		sum_add_size = min_sum_size;
-- 
1.8.4.5

