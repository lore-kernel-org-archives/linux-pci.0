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
Subject: [PATCH v10 41/59] PCI: Skip required+optional if there is no optional
Date: Wed, 24 Feb 2016 18:12:32 -0800
Message-Id: <1456366370-28995-42-git-send-email-yinghai@kernel.org>
In-Reply-To: <1456366370-28995-1-git-send-email-yinghai@kernel.org>
References: <1456366370-28995-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If the bridge does not support hotplug and has no child with sriov support,
We will not have optional resources. We could get out early and
don't try required+optional allocation.

Also in the loop that update res with optional add info, skip resource
that add_size is 0.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 6ed7c85..2f5e4d1 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -450,6 +450,24 @@ static bool pci_need_to_release(unsigned long mask, struct resource *res)
 	return false;	/* should not get here */
 }
 
+static bool has_addon(struct list_head *head,
+			struct list_head *realloc_head)
+{
+	int add_count = 0;
+	struct pci_dev_resource *dev_res, *tmp_res;
+
+	/* check if we have add really */
+	list_for_each_entry(dev_res, head, list) {
+		tmp_res = res_to_dev_res(realloc_head, dev_res->res);
+		if (!tmp_res || !tmp_res->add_size)
+			continue;
+
+		add_count++;
+	}
+
+	return add_count != 0;
+}
+
 static bool save_resources(struct list_head *head,
 			   struct list_head *save_head)
 {
@@ -481,16 +499,24 @@ static bool __assign_resources_required_optional_sorted(struct list_head *head,
 	struct pci_dev_resource *save_res;
 	struct pci_dev_resource *dev_res, *tmp_res;
 	unsigned long fail_type;
-	resource_size_t add_align;
+	resource_size_t add_align, add_size;
 	struct resource *res;
 
+	if (!has_addon(head, realloc_head))
+		return false;
+
 	if (!save_resources(head, &save_head))
 		return false;
 
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
@@ -578,7 +604,7 @@ static void __assign_resources_sorted(struct list_head *head,
 	 */
 
 	/* Check required+optional add */
-	if (realloc_head && !list_empty(realloc_head) &&
+	if (realloc_head &&
 	    __assign_resources_required_optional_sorted(head, realloc_head))
 		return;
 
-- 
1.8.4.5
