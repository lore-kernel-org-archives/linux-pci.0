Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp07.in.ibm.com ([122.248.162.7]:56689 "EHLO
	e28smtp07.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758081Ab3HBJcb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 2 Aug 2013 05:32:31 -0400
Received: from /spool/local
	by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Fri, 2 Aug 2013 14:54:04 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by d28dlp01.in.ibm.com (Postfix) with ESMTP id AFE1DE0053
	for <linux-pci@vger.kernel.org>; Fri,  2 Aug 2013 15:02:33 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r729WIHm43712714
	for <linux-pci@vger.kernel.org>; Fri, 2 Aug 2013 15:02:18 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
	by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id r729WLiH012993
	for <linux-pci@vger.kernel.org>; Fri, 2 Aug 2013 15:02:21 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: linuxram@us.ibm.com, shangw@linux.vnet.ibm.com,
	Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH 1/4] PCI: optimize pci_bus_get_depth() by enumerating on pci bus hierachy
Date: Fri,  2 Aug 2013 17:31:03 +0800
Message-Id: <1375435866-16332-2-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1375435866-16332-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1375435866-16332-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Normally, on one pci bus there would be more devices than pci buses. When
calculating the depth of pci bus, it would be more time efficient by
enumerating through the child buses instead of the child devices.

Also by doing so, the code seems more self explaining. Previously, it go
through the pci devices and check whether a bridge introduce a child bus or
not, which needs more background knowledge to understand it.

This patch caculating the depth by enumerating on pci bus hierachy.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 drivers/pci/setup-bus.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index d254e23..6dbe562 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1300,15 +1300,12 @@ static void pci_bus_dump_resources(struct pci_bus *bus)
 static int __init pci_bus_get_depth(struct pci_bus *bus)
 {
 	int depth = 0;
-	struct pci_dev *dev;
+	struct pci_bus *child_bus;
 
-	list_for_each_entry(dev, &bus->devices, bus_list) {
+	list_for_each_entry(child_bus, &bus->children, node){
 		int ret;
-		struct pci_bus *b = dev->subordinate;
-		if (!b)
-			continue;
 
-		ret = pci_bus_get_depth(b);
+		ret = pci_bus_get_depth(child_bus);
 		if (ret + 1 > depth)
 			depth = ret + 1;
 	}
-- 
1.7.5.4

