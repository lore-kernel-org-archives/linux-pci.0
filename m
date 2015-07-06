Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:21488 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755815AbbGFX5t (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jul 2015 19:57:49 -0400
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
Subject: [PATCH 08/36] PCI: Rename pdev_sort_resources to pdev_check_resources
Date: Mon,  6 Jul 2015 16:38:58 -0700
Message-Id: <1436225966-27247-9-git-send-email-yinghai@kernel.org>
In-Reply-To: <1436225966-27247-1-git-send-email-yinghai@kernel.org>
References: <1436225966-27247-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We don't do sorting in those functions, so change "sort" to "check"
instead.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index a7dbf54..e976aa2 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -201,8 +201,8 @@ static resource_size_t __pci_resource_alignment(
 	return r_align;
 }
 
-/* Sort resources by alignment */
-static void pdev_sort_resources(struct pci_dev *dev,
+/* check resources and save to the list */
+static void pdev_check_resources(struct pci_dev *dev,
 				 struct list_head *realloc_head,
 				 struct list_head *head)
 {
@@ -238,7 +238,7 @@ static void pdev_sort_resources(struct pci_dev *dev,
 	}
 }
 
-static void __dev_sort_resources(struct pci_dev *dev,
+static void __dev_check_resources(struct pci_dev *dev,
 				 struct list_head *realloc_head,
 				 struct list_head *head)
 {
@@ -256,7 +256,7 @@ static void __dev_sort_resources(struct pci_dev *dev,
 			return;
 	}
 
-	pdev_sort_resources(dev, realloc_head, head);
+	pdev_check_resources(dev, realloc_head, head);
 }
 
 static inline void reset_resource(struct resource *res)
@@ -556,7 +556,7 @@ static void pdev_assign_resources_sorted(struct pci_dev *dev,
 {
 	LIST_HEAD(head);
 
-	__dev_sort_resources(dev, add_head, &head);
+	__dev_check_resources(dev, add_head, &head);
 	__assign_resources_sorted(&head, add_head, fail_head);
 
 }
@@ -569,7 +569,7 @@ static void pbus_assign_resources_sorted(const struct pci_bus *bus,
 	LIST_HEAD(head);
 
 	list_for_each_entry(dev, &bus->devices, bus_list)
-		__dev_sort_resources(dev, realloc_head, &head);
+		__dev_check_resources(dev, realloc_head, &head);
 
 	__assign_resources_sorted(&head, realloc_head, fail_head);
 }
-- 
1.8.4.5

