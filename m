Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148]:58643 "EHLO
	e23smtp06.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754289AbbESGZX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 May 2015 02:25:23 -0400
Received: from /spool/local
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 19 May 2015 16:25:20 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id E8F843578056
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2015 16:25:17 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t4J6PAxK27328616
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2015 16:25:18 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t4J6OjOo018595
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2015 16:24:45 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH] PCI: break when finding the first smaller resource
Date: Tue, 19 May 2015 14:24:17 +0800
Message-Id: <1432016657-16816-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In commit d74b9027a4da(PCI: Consider additional PF's IOV BAR alignment in
sizing and assigning), it stores additional alignment in realloc_head and
take this into consideration for assignment.

After getting the additional alignment, it will re-order the head list to
make sure resources with bigger alignment is ahead of the resources with
smaller assignment in the head list. To make it happen, it iterate on the
head list and find a smaller alignment resource and insert ahead of it.
This should be done for the first occurrence, while the code now will
iterate on the whole list.

This patch fixes this behavior by break when finding the first smaller
resource in the head list.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 drivers/pci/setup-bus.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 4fd0cac..aa281d9 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -435,9 +435,11 @@ static void __assign_resources_sorted(struct list_head *head,
 			list_for_each_entry(dev_res2, head, list) {
 				align = pci_resource_alignment(dev_res2->dev,
 							       dev_res2->res);
-				if (add_align > align)
+				if (add_align > align) {
 					list_move_tail(&dev_res->list,
 						       &dev_res2->list);
+					break;
+				}
 			}
                }
 
-- 
1.7.9.5

