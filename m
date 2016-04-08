Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:36598 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932589AbcDHAWR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Apr 2016 20:22:17 -0400
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
Subject: [PATCH v11 32/60] PCI: Rename pdev_sort_resources() to pdev_assign_resources_prepare()
Date: Thu,  7 Apr 2016 17:15:45 -0700
Message-Id: <1460074573-7481-33-git-send-email-yinghai@kernel.org>
In-Reply-To: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
References: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
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
index 0e3be10..9cd0411 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -204,8 +204,8 @@ static resource_size_t __pci_resource_alignment(
 	return r_align;
 }
 
-/* Sort resources by alignment */
-static void pdev_sort_resources(struct pci_dev *dev,
+/* check resources and save to the list */
+static void pdev_assign_resources_prepare(struct pci_dev *dev,
 				 struct list_head *realloc_head,
 				 struct list_head *head)
 {
@@ -241,7 +241,7 @@ static void pdev_sort_resources(struct pci_dev *dev,
 	}
 }
 
-static void __dev_sort_resources(struct pci_dev *dev,
+static void __dev_assign_resources_prepare(struct pci_dev *dev,
 				 struct list_head *realloc_head,
 				 struct list_head *head)
 {
@@ -259,7 +259,7 @@ static void __dev_sort_resources(struct pci_dev *dev,
 			return;
 	}
 
-	pdev_sort_resources(dev, realloc_head, head);
+	pdev_assign_resources_prepare(dev, realloc_head, head);
 }
 
 static inline void reset_resource(struct resource *res)
@@ -565,7 +565,7 @@ static void pdev_assign_resources_sorted(struct pci_dev *dev,
 {
 	LIST_HEAD(head);
 
-	__dev_sort_resources(dev, add_head, &head);
+	__dev_assign_resources_prepare(dev, add_head, &head);
 	__assign_resources_sorted(&head, add_head, fail_head);
 
 }
@@ -578,7 +578,7 @@ static void pbus_assign_resources_sorted(const struct pci_bus *bus,
 	LIST_HEAD(head);
 
 	list_for_each_entry(dev, &bus->devices, bus_list)
-		__dev_sort_resources(dev, realloc_head, &head);
+		__dev_assign_resources_prepare(dev, realloc_head, &head);
 
 	__assign_resources_sorted(&head, realloc_head, fail_head);
 }
-- 
1.8.4.5

