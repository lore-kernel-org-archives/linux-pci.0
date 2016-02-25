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
Subject: [PATCH v10 33/59] PCI: Add debug printout during releasing partial assigned resources
Date: Wed, 24 Feb 2016 18:12:24 -0800
Message-Id: <1456366370-28995-34-git-send-email-yinghai@kernel.org>
In-Reply-To: <1456366370-28995-1-git-send-email-yinghai@kernel.org>
References: <1456366370-28995-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
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
index cf6f9f9..9d6a846 100644
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
