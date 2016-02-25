Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:42379 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759435AbcBYCTA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Feb 2016 21:19:00 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v10 52/59] PCI: Kill macro checking for bus io port sizing
Date: Wed, 24 Feb 2016 18:12:43 -0800
Message-Id: <1456366370-28995-53-git-send-email-yinghai@kernel.org>
In-Reply-To: <1456366370-28995-1-git-send-email-yinghai@kernel.org>
References: <1456366370-28995-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We can use new generic version skip_isa_ioresource_align() instead
of macro, and then kill the marco.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 530fa9b..1de017b 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1160,15 +1160,12 @@ int skip_isa_ioresource_align(struct pci_bus *bus)
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
 
@@ -1237,12 +1234,12 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
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

