Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v8 31/61] PCI: Remove duplicated code for resource sorting
Date: Tue, 27 Oct 2015 13:55:23 -0700
Message-Id: <1445979353-1728-32-git-send-email-yinghai@kernel.org>
In-Reply-To: <1445979353-1728-1-git-send-email-yinghai@kernel.org>
References: <1445979353-1728-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
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
index 5ea06c6..bcf7cba 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -214,9 +214,8 @@ static void pdev_sort_resources(struct pci_dev *dev,
 
 	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
 		struct resource *r;
-		struct pci_dev_resource *dev_res, *tmp;
+		struct pci_dev_resource *tmp;
 		resource_size_t r_align;
-		struct list_head *n;
 
 		r = &dev->resource[i];
 
@@ -239,22 +238,7 @@ static void pdev_sort_resources(struct pci_dev *dev,
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
 
@@ -563,9 +547,9 @@ static void __assign_resources_sorted(struct list_head *head,
 	}
 	free_list(&save_head);
 
+requested_and_reassign:
 	sort_resources(head);
 
-requested_and_reassign:
 	/* Satisfy the must-have resource requests */
 	assign_requested_resources_sorted(head, fail_head);
 
-- 
1.8.4.5

