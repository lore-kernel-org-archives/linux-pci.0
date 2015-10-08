Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:27894 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964894AbbJHVk6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Oct 2015 17:40:58 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v7 33/60] PCI: Add debug printout during releasing partial assigned resources
Date: Thu,  8 Oct 2015 14:38:52 -0700
Message-Id: <1444340359-8011-34-git-send-email-yinghai@kernel.org>
In-Reply-To: <1444340359-8011-1-git-send-email-yinghai@kernel.org>
References: <1444340359-8011-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We try to assign required+optional at first, and we only accept the result
if all resources get allocated. Otherwise will release assigned in the
list, and try to assign required and expand to optional.

We have to do that to make sure any required has priority over any optional.

When that happens, we only print out "assigned" info, that is confusing
as it looks like same range is assigned to two peer resources at the same
time.

Add printout for releasing so we have whole picture in debug messages.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index d2d38bc..c9dfd1c 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -526,9 +526,17 @@ static void __assign_resources_sorted(struct list_head *head,
 
 	free_list(&local_fail_head);
 	/* Release assigned resource */
-	list_for_each_entry(dev_res, head, list)
-		if (dev_res->res->parent)
-			release_resource(dev_res->res);
+	list_for_each_entry(dev_res, head, list) {
+		struct resource *res = dev_res->res;
+
+		if (res->parent) {
+			dev_printk(KERN_DEBUG, &dev_res->dev->dev,
+				   "BAR %d: released %pR\n",
+				   (int)(res - &dev_res->dev->resource[0]),
+				   res);
+			release_resource(res);
+		}
+	}
 	/* Restore start/end/flags from saved list */
 	list_for_each_entry(save_res, &save_head, list) {
 		struct resource *res = save_res->res;
-- 
1.8.4.5

