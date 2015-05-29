Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:50967 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754759AbbE2FkV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 29 May 2015 01:40:21 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] PCI: keep resource size during alignment reordering
Date: Thu, 28 May 2015 22:40:00 -0700
Message-Id: <1432878000-10921-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In d74b9027a4da ("PCI: Consider additional PF's IOV BAR alignment in sizing
and assigning"), it stores additional alignment in realloc_head and takes
this into consideration for assignment.
During update the resource before reordering, it does not calculate
resource end correctly.

We need to keep the original resource size before updating start.
otherwise we will smaller size during updating end.

Fixes: d74b9027a4da ("PCI: Consider additional PF's IOV BAR alignment in sizing and assigning")
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

---
 drivers/pci/setup-bus.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/pci/setup-bus.c
===================================================================
--- linux-2.6.orig/drivers/pci/setup-bus.c
+++ linux-2.6/drivers/pci/setup-bus.c
@@ -428,9 +428,10 @@ static void __assign_resources_sorted(st
 		 * consistent.
 		 */
 		if (add_align > dev_res->res->start) {
+			resource_size_t r_size = resource_size(dev_res->res);
+
 			dev_res->res->start = add_align;
-			dev_res->res->end = add_align +
-				            resource_size(dev_res->res);
+			dev_res->res->end = add_align + r_size - 1;
 
 			list_for_each_entry(dev_res2, head, list) {
 				align = pci_resource_alignment(dev_res2->dev,
