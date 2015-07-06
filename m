Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	David Ahern <david.ahern@oracle.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 15/36] PCI: Bail out early if there is no addon
Date: Mon,  6 Jul 2015 16:39:05 -0700
Message-Id: <1436225966-27247-16-git-send-email-yinghai@kernel.org>
In-Reply-To: <1436225966-27247-1-git-send-email-yinghai@kernel.org>
References: <1436225966-27247-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If the bridge does not support hotplug or no child with sriov support
we could get out early before try must+optional allocation

Also in the loop that update res with optional add info, skip resource
that add_size is 0.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 48f5616..e2aedac 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -466,8 +466,21 @@ static bool __assign_resources_must_add_sorted(struct list_head *head,
 	struct pci_dev_resource *save_res;
 	struct pci_dev_resource *dev_res, *tmp_res;
 	unsigned long fail_type;
-	resource_size_t add_align;
+	resource_size_t add_align, add_size;
 	struct resource *res;
+	int add_count = 0;
+
+	/* check if we have add really */
+	list_for_each_entry(dev_res, head, list) {
+		res = dev_res->res;
+		tmp_res = res_to_dev_res(realloc_head, res);
+		if (!tmp_res || !tmp_res->add_size)
+			continue;
+
+		add_count++;
+	}
+	if (!add_count)
+		return false;
 
 	/* Save original start, end, flags etc at first */
 	list_for_each_entry(dev_res, head, list)
@@ -479,7 +492,12 @@ static bool __assign_resources_must_add_sorted(struct list_head *head,
 	/* Update res in head list with add_size in realloc_head list */
 	list_for_each_entry(dev_res, head, list) {
 		res = dev_res->res;
-		res->end += get_res_add_size(realloc_head, res);
+		add_size = get_res_add_size(realloc_head, res);
+
+		if (!add_size)
+			continue;
+
+		res->end += add_size;
 
 		/*
 		 * There are two kinds of additional resources in the list:
@@ -573,7 +591,7 @@ static void __assign_resources_sorted(struct list_head *head,
 	LIST_HEAD(local_fail_head);
 
 	/* Check must+optional add */
-	if (realloc_head && !list_empty(realloc_head) &&
+	if (realloc_head &&
 	    __assign_resources_must_add_sorted(head, realloc_head))
 		return;
 
-- 
1.8.4.5

