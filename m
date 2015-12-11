Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:40207 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269AbbLKFH4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Dec 2015 00:07:56 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v9 24/60] PCI: Reuse res_to_dev_res() in reassign_resources_sorted()
Date: Thu, 10 Dec 2015 21:06:20 -0800
Message-Id: <1449810416-2950-25-git-send-email-yinghai@kernel.org>
In-Reply-To: <1449810416-2950-1-git-send-email-yinghai@kernel.org>
References: <1449810416-2950-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now res_to_dev_res() does not print out debug message anymore, so
we can reuse it in reassign_resource_sorted() without confusing printout.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 598254a..6f6cf25 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -240,26 +240,17 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
 {
 	struct resource *res;
 	struct pci_dev_resource *add_res, *tmp;
-	struct pci_dev_resource *dev_res;
 	resource_size_t add_size, align;
 	int idx;
 
 	list_for_each_entry_safe(add_res, tmp, realloc_head, list) {
-		bool found_match = false;
-
 		res = add_res->res;
 		/* skip resource that has been reset */
 		if (!res->flags)
 			goto out;
 
 		/* skip this resource if not found in head list */
-		list_for_each_entry(dev_res, head, list) {
-			if (dev_res->res == res) {
-				found_match = true;
-				break;
-			}
-		}
-		if (!found_match)/* just skip */
+		if (!res_to_dev_res(head, res))
 			continue;
 
 		idx = res - &add_res->dev->resource[0];
-- 
1.8.4.5

