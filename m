Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:49978 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756530AbbGFXmC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jul 2015 19:42:02 -0400
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
Subject: [PATCH 30/36] PCI: Treat optional as must in first try for bridge rescan
Date: Mon,  6 Jul 2015 16:39:20 -0700
Message-Id: <1436225966-27247-31-git-send-email-yinghai@kernel.org>
In-Reply-To: <1436225966-27247-1-git-send-email-yinghai@kernel.org>
References: <1436225966-27247-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

For rescan bridge/bus that children are removed before, we should treat
optional as must just like root bus the boot time in 19aa7ee432ce
(PCI: make re-allocation try harder by reassigning ranges higher in
the heirarchy).

The reason: allocate must and expand to optional path do not
put failed resource to fail list, so will lose must info before
next try.

So we are using following way:
1. First and following try before last try:
   We don't keep realloc list so treat every optional as must.
   allocate for must+optional and put failed in the fail list.
   then size info (include must and optonal separatedly) will be kept
   for next try.
2. last try:
   a: try to allocate must+optional to see if all get allocated.
   b: try to allocate must then expand to optional.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 8f8b4c7..5b2944a 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2300,25 +2300,34 @@ void __init pci_assign_unassigned_resources(void)
 void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
 {
 	struct pci_bus *parent = bridge->subordinate;
-	LIST_HEAD(add_list); /* list of resources that
+	LIST_HEAD(realloc_head); /* list of resources that
 					want additional resources */
+	struct list_head *add_list = NULL;
 	int tried_times = 0;
 	LIST_HEAD(fail_head);
 	struct pci_dev_resource *fail_res;
 	int retval;
 	unsigned long type_mask = IORESOURCE_IO | IORESOURCE_MEM |
 				  IORESOURCE_PREFETCH | IORESOURCE_MEM_64;
+	int pci_try_num = 2;
 
 again:
-	__pci_bus_size_bridges(parent, &add_list);
-	__pci_bridge_assign_resources(bridge, &add_list, &fail_head);
-	__pci_bus_check_realloc(&add_list);
+	/*
+	 * last try will use add_list, otherwise will try good to have as
+	 * must have, so can realloc parent bridge resource
+	 */
+	if (tried_times + 1 == pci_try_num)
+		add_list = &realloc_head;
+	__pci_bus_size_bridges(parent, add_list);
+	__pci_bridge_assign_resources(bridge, add_list, &fail_head);
+	if (add_list)
+		__pci_bus_check_realloc(add_list);
 	tried_times++;
 
 	if (list_empty(&fail_head))
 		goto enable_all;
 
-	if (tried_times >= 2) {
+	if (tried_times >= pci_try_num) {
 		/* still fail, don't need to try more */
 		free_list(&fail_head);
 		goto enable_all;
-- 
1.8.4.5

