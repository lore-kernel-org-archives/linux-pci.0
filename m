Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp01.in.ibm.com ([122.248.162.1]:46102 "EHLO
	e28smtp01.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171Ab3GAPL3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jul 2013 11:11:29 -0400
Received: from /spool/local
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Mon, 1 Jul 2013 20:34:16 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by d28dlp03.in.ibm.com (Postfix) with ESMTP id 52209125804E
	for <linux-pci@vger.kernel.org>; Mon,  1 Jul 2013 20:40:30 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r61FBjYb26542180
	for <linux-pci@vger.kernel.org>; Mon, 1 Jul 2013 20:41:45 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r61FBJ94003519
	for <linux-pci@vger.kernel.org>; Tue, 2 Jul 2013 01:11:21 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: weiyang@linux.vnet.ibm.com, linuxram@us.ibm.com,
	shangw@linux.vnet.ibm.com
Subject: [PATCH 1/4] PCI: optimize pci_bus_get_depth() by enumerating on pci bus hierachy
Date: Mon,  1 Jul 2013 23:10:29 +0800
Message-Id: <1372691432-6440-2-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1372691432-6440-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1372691432-6440-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Normally, on one pci bus there would be more devices than pci buses. When
calculating the depth of pci bus, it would be more time efficient by
enumerating through the child buses instead of the child devices.

Also by doing so, the code seems more self explaining. Previously, it go
through the pci devices and check whether a bridge introduce a child bus or
not, which needs more background knowledge to understand it.

This patch caculating the depth by enumerating on pci bus hierachy in an
iterative way.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Reviewed-by: Gavin Shan <shangw@linux.vnet.ibm.com>
Reviewed-by: Ram Pai <linuxram@us.ibm.com>
Reviewed-by: Xiao Guangrong <xiaoguangrong@linux.vnet.ibm.com>
Reviewed-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>
---
 drivers/pci/setup-bus.c |   43 ++++++++++++++++++++++++++++++++-----------
 1 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 16abaaa..b333f73 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1299,22 +1299,43 @@ static void pci_bus_dump_resources(struct pci_bus *bus)
 
 static int __init pci_bus_get_depth(struct pci_bus *bus)
 {
-	int depth = 0;
-	struct pci_dev *dev;
+	int max_depth, depth;
+	struct pci_bus *parent, *curr;
+	struct list_head *node;
 
-	list_for_each_entry(dev, &bus->devices, bus_list) {
-		int ret;
-		struct pci_bus *b = dev->subordinate;
-		if (!b)
-			continue;
+	/* no child? */
+	if (list_empty(&bus->children))
+		return 0;
 
-		ret = pci_bus_get_depth(b);
-		if (ret + 1 > depth)
-			depth = ret + 1;
+	node = bus->children.next;
+	parent = bus;
+	max_depth = depth = 1;
+
+	while (parent) {
+		/* hit the head, go back to parent level */
+		if (node == &parent->children) {
+			node = parent->node.next;
+			parent = parent->parent;
+			depth--;
+			continue;
+		}
+		curr = list_entry(node, struct pci_bus, node);
+		/* depth first */
+		if (!list_empty(&curr->children)) {
+			node = curr->children.next;
+			parent = curr;
+			depth++;
+			if (max_depth < depth)
+				max_depth = depth;
+		}
+		/* no child, go to the sibling */
+		else
+			node = curr->node.next;
 	}
 
-	return depth;
+	return max_depth;
 }
+
 static int __init pci_get_max_depth(void)
 {
 	int depth = 0;
-- 
1.7.5.4

