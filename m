Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:22468 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759591AbcBYDNi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Feb 2016 22:13:38 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v10 23/59] PCI: Cleanup res_to_dev_res() printout
Date: Wed, 24 Feb 2016 18:12:14 -0800
Message-Id: <1456366370-28995-24-git-send-email-yinghai@kernel.org>
In-Reply-To: <1456366370-28995-1-git-send-email-yinghai@kernel.org>
References: <1456366370-28995-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now get_res_add_size() and get_res_add_align() all have same printout
from res_to_dev_res(), and it is confusing.

Move out debug messages printout from res_to_dev_res(),
so later we will reuse res_to_dev_res() in other functions.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 3349a83..49f4a27 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -104,19 +104,9 @@ static struct pci_dev_resource *res_to_dev_res(struct list_head *head,
 {
 	struct pci_dev_resource *dev_res;
 
-	list_for_each_entry(dev_res, head, list) {
-		if (dev_res->res == res) {
-			int idx = res - &dev_res->dev->resource[0];
-
-			dev_printk(KERN_DEBUG, &dev_res->dev->dev,
-				 "res[%d]=%pR res_to_dev_res add_size %llx min_align %llx\n",
-				 idx, dev_res->res,
-				 (unsigned long long)dev_res->add_size,
-				 (unsigned long long)dev_res->min_align);
-
+	list_for_each_entry(dev_res, head, list)
+		if (dev_res->res == res)
 			return dev_res;
-		}
-	}
 
 	return NULL;
 }
@@ -127,7 +117,15 @@ static resource_size_t get_res_add_size(struct list_head *head,
 	struct pci_dev_resource *dev_res;
 
 	dev_res = res_to_dev_res(head, res);
-	return dev_res ? dev_res->add_size : 0;
+	if (!dev_res || !dev_res->add_size)
+		return 0;
+
+	dev_printk(KERN_DEBUG, &dev_res->dev->dev,
+		   "BAR %d: %pR get_res_add_size add_size   %#llx\n",
+		   (int)(res - &dev_res->dev->resource[0]),
+		   res, (unsigned long long)dev_res->add_size);
+
+	return dev_res->add_size;
 }
 
 static resource_size_t get_res_add_align(struct list_head *head,
@@ -136,7 +134,15 @@ static resource_size_t get_res_add_align(struct list_head *head,
 	struct pci_dev_resource *dev_res;
 
 	dev_res = res_to_dev_res(head, res);
-	return dev_res ? dev_res->min_align : 0;
+	if (!dev_res || !dev_res->min_align)
+		return 0;
+
+	dev_printk(KERN_DEBUG, &dev_res->dev->dev,
+		   "BAR %d: %pR get_res_add_align min_align %#llx\n",
+		   (int)(res - &dev_res->dev->resource[0]),
+		   res, (unsigned long long)dev_res->min_align);
+
+	return dev_res->min_align;
 }
 
 
-- 
1.8.4.5

