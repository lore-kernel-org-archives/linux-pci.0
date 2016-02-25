Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:38378 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932721AbcBYCN6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Feb 2016 21:13:58 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v10 50/59] PCI: Allow bridge optional only io port resource required size to be 0
Date: Wed, 24 Feb 2016 18:12:41 -0800
Message-Id: <1456366370-28995-51-git-send-email-yinghai@kernel.org>
In-Reply-To: <1456366370-28995-1-git-send-email-yinghai@kernel.org>
References: <1456366370-28995-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When there is no child device under the non hotplug bridge,
We can use 0 for required size, and do not use old size as required size.

That will save some io port range for other bridges, as BIOS could do
some partial assign, and we want to use those not used io port range.

When there is child device, size will not be 0.
when the bridge supports hotplug, min_size will not be 0.
So they will still honor the old size as required size.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index c13ec01..4c595c5 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1230,8 +1230,9 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 
 	size = size_aligned_for_isa(size);
 	size += size1;
-	size0 = calculate_size(size, min_size,
-			resource_size(b_res), min_align);
+	if (size || min_size)
+		size0 = calculate_size(size, min_size,
+					resource_size(b_res), min_align);
 	sum_add_size = size_aligned_for_isa(sum_add_size);
 	sum_add_size += sum_add_size1;
 	if (sum_add_size < min_sum_size)
@@ -1247,7 +1248,7 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 		return;
 	}
 
-	b_res->start = min_align;
+	b_res->start = size0 ? min_align : 0;
 	b_res->end = b_res->start + size0 - 1;
 	b_res->flags |= IORESOURCE_STARTALIGN;
 	if (size1 > size0 && realloc_head) {
-- 
1.8.4.5

