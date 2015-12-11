Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:41980 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754555AbbLKFNJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Dec 2015 00:13:09 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v9 38/60] PCI: Separate out save_resources()/restore_resources()
Date: Thu, 10 Dec 2015 21:06:34 -0800
Message-Id: <1449810416-2950-39-git-send-email-yinghai@kernel.org>
In-Reply-To: <1449810416-2950-1-git-send-email-yinghai@kernel.org>
References: <1449810416-2950-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We need to save/restore resources several times for alt_size support,
separate the save_resources()/resources() to save some lines later.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 49 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 2cc8a1e..9485b03 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -436,6 +436,29 @@ static bool pci_need_to_release(unsigned long mask, struct resource *res)
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
@@ -473,13 +496,8 @@ static void __assign_resources_sorted(struct list_head *head,
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
@@ -548,12 +566,9 @@ static void __assign_resources_sorted(struct list_head *head,
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
@@ -2025,9 +2040,7 @@ again:
 	list_for_each_entry(fail_res, &fail_head, list) {
 		struct resource *res = fail_res->res;
 
-		res->start = fail_res->start;
-		res->end = fail_res->end;
-		res->flags = fail_res->flags;
+		restore_resource(fail_res, res);
 		if (fail_res->dev->subordinate) {
 			res->flags = 0;
 			/* last or third times and later */
@@ -2111,9 +2124,7 @@ again:
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

