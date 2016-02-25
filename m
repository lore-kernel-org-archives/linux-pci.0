Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:39713 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759484AbcBYCSo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Feb 2016 21:18:44 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v10 31/59] PCI: Rename pdev_sort_resources() to pdev_assign_resources_prepare()
Date: Wed, 24 Feb 2016 18:12:22 -0800
Message-Id: <1456366370-28995-32-git-send-email-yinghai@kernel.org>
In-Reply-To: <1456366370-28995-1-git-send-email-yinghai@kernel.org>
References: <1456366370-28995-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pdev_sort_resources() etc was checking devices resources and putting
resources that need to assign to one list in sorted order.

Now we don't do sorting in those functions anymore, so change to
pdev_assign_resources_prepare() instead.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index a93a15b..dc09418 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -205,8 +205,8 @@ static resource_size_t __pci_resource_alignment(
 	return r_align;
 }
 
-/* Sort resources by alignment */
-static void pdev_sort_resources(struct pci_dev *dev,
+/* check resources and save to the list */
+static void pdev_assign_resources_prepare(struct pci_dev *dev,
 				 struct list_head *realloc_head,
 				 struct list_head *head)
 {
@@ -242,7 +242,7 @@ static void pdev_sort_resources(struct pci_dev *dev,
 	}
 }
 
-static void __dev_sort_resources(struct pci_dev *dev,
+static void __dev_assign_resources_prepare(struct pci_dev *dev,
 				 struct list_head *realloc_head,
 				 struct list_head *head)
 {
@@ -260,7 +260,7 @@ static void __dev_sort_resources(struct pci_dev *dev,
 			return;
 	}
 
-	pdev_sort_resources(dev, realloc_head, head);
+	pdev_assign_resources_prepare(dev, realloc_head, head);
 }
 
 static inline void reset_resource(struct resource *res)
@@ -566,7 +566,7 @@ static void pdev_assign_resources_sorted(struct pci_dev *dev,
 {
 	LIST_HEAD(head);
 
-	__dev_sort_resources(dev, add_head, &head);
+	__dev_assign_resources_prepare(dev, add_head, &head);
 	__assign_resources_sorted(&head, add_head, fail_head);
 
 }
@@ -579,7 +579,7 @@ static void pbus_assign_resources_sorted(const struct pci_bus *bus,
 	LIST_HEAD(head);
 
 	list_for_each_entry(dev, &bus->devices, bus_list)
-		__dev_sort_resources(dev, realloc_head, &head);
+		__dev_assign_resources_prepare(dev, realloc_head, &head);
 
 	__assign_resources_sorted(&head, realloc_head, fail_head);
 }
-- 
1.8.4.5

