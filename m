Return-Path: <linux-kernel-owner@vger.kernel.org>
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
Subject: [PATCH v11 39/60] PCI: Separate out save_resources()/restore_resources()
Date: Thu,  7 Apr 2016 17:15:52 -0700
Message-Id: <1460074573-7481-40-git-send-email-yinghai@kernel.org>
In-Reply-To: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
References: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We need to save/restore resources several times for alt_size support,
separate the save_resources()/resources() to save some lines later.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 49 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index b5529cc..1571245 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -435,6 +435,29 @@ static bool pci_need_to_release(unsigned long mask, struct resource *res)
 	return false;	/* should not get here */
 }
 
+static bool save_resources(struct list_head *head,
+			   struct list_head *save_head)
+{
+	struct pci_dev_resource *dev_res;
+
+	/* Save original start, end, flags etc at first */
+	list_for_each_entry(dev_res, head, list)
+		if (add_to_list(save_head, dev_res->dev, dev_res->res)) {
+			free_list(save_head);
+			return false;
+		}
+
+	return true;
+}
+
+static void restore_resource(struct pci_dev_resource *save_res,
+			     struct resource *res)
+{
+	res->start = save_res->start;
+	res->end = save_res->end;
+	res->flags = save_res->flags;
+}
+
 static void __assign_resources_sorted(struct list_head *head,
 				 struct list_head *realloc_head,
 				 struct list_head *fail_head)
@@ -472,13 +495,8 @@ static void __assign_resources_sorted(struct list_head *head,
 	if (!realloc_head || list_empty(realloc_head))
 		goto requested_and_reassign;
 
-	/* Save original start, end, flags etc at first */
-	list_for_each_entry(dev_res, head, list) {
-		if (add_to_list(&save_head, dev_res->dev, dev_res->res)) {
-			free_list(&save_head);
-			goto requested_and_reassign;
-		}
-	}
+	if (!save_resources(head, &save_head))
+		goto requested_and_reassign;
 
 	/* Update res in head list with add_size in realloc_head list */
 	list_for_each_entry(dev_res, head, list) {
@@ -547,12 +565,9 @@ static void __assign_resources_sorted(struct list_head *head,
 		}
 	}
 	/* Restore start/end/flags from saved list */
-	list_for_each_entry(save_res, &save_head, list) {
-		res = save_res->res;
-		res->start = save_res->start;
-		res->end = save_res->end;
-		res->flags = save_res->flags;
-	}
+	list_for_each_entry(save_res, &save_head, list)
+		restore_resource(save_res, save_res->res);
+
 	free_list(&save_head);
 
 requested_and_reassign:
@@ -2024,9 +2039,7 @@ again:
 	list_for_each_entry(fail_res, &fail_head, list) {
 		struct resource *res = fail_res->res;
 
-		res->start = fail_res->start;
-		res->end = fail_res->end;
-		res->flags = fail_res->flags;
+		restore_resource(fail_res, res);
 		if (fail_res->dev->subordinate) {
 			res->flags = 0;
 			/* last or third times and later */
@@ -2110,9 +2123,7 @@ again:
 	list_for_each_entry(fail_res, &fail_head, list) {
 		struct resource *res = fail_res->res;
 
-		res->start = fail_res->start;
-		res->end = fail_res->end;
-		res->flags = fail_res->flags;
+		restore_resource(fail_res, res);
 		if (fail_res->dev->subordinate) {
 			res->flags = 0;
 			/* last time */
-- 
1.8.4.5
