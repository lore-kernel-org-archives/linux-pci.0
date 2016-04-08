Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:36606 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932591AbcDHAWS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Apr 2016 20:22:18 -0400
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
Subject: [PATCH v11 31/60] PCI: Remove duplicated code for resource sorting
Date: Thu,  7 Apr 2016 17:15:44 -0700
Message-Id: <1460074573-7481-32-git-send-email-yinghai@kernel.org>
In-Reply-To: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
References: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now sort_resources() and pdev_sort_resources() all have sorting
code.

As we are going to call sort_resources() several places later for
alt_size support, so choose to remove related code in
pdev_sort_resources().

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index aed62cc..0e3be10 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -213,9 +213,8 @@ static void pdev_sort_resources(struct pci_dev *dev,
 
 	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
 		struct resource *r;
-		struct pci_dev_resource *dev_res, *tmp;
+		struct pci_dev_resource *tmp;
 		resource_size_t r_align;
-		struct list_head *n;
 
 		r = &dev->resource[i];
 
@@ -238,22 +237,7 @@ static void pdev_sort_resources(struct pci_dev *dev,
 		tmp->res = r;
 		tmp->dev = dev;
 
-		/* fallback is smallest one or list is empty*/
-		n = head;
-		list_for_each_entry(dev_res, head, list) {
-			resource_size_t align;
-
-			align = __pci_resource_alignment(dev_res->dev,
-							 dev_res->res,
-							 realloc_head);
-
-			if (r_align > align) {
-				n = &dev_res->list;
-				break;
-			}
-		}
-		/* Insert it just before n*/
-		list_add_tail(&tmp->list, n);
+		list_add_tail(&tmp->list, head);
 	}
 }
 
@@ -562,9 +546,9 @@ static void __assign_resources_sorted(struct list_head *head,
 	}
 	free_list(&save_head);
 
+requested_and_reassign:
 	sort_resources(head);
 
-requested_and_reassign:
 	/* Satisfy the must-have resource requests */
 	assign_requested_resources_sorted(head, fail_head);
 
-- 
1.8.4.5

