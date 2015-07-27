Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:36110 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932255AbbG0XbL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jul 2015 19:31:11 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v3 18/51] PCI: Move comment to pci_need_to_release()
Date: Mon, 27 Jul 2015 16:29:36 -0700
Message-Id: <1438039809-24957-19-git-send-email-yinghai@kernel.org>
In-Reply-To: <1438039809-24957-1-git-send-email-yinghai@kernel.org>
References: <1438039809-24957-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Move comment from caller to callee, as we will have one new caller
for alt_size support later.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 2e3d00b..f8b9a24 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -415,6 +415,20 @@ static unsigned long pci_fail_res_type_mask(struct list_head *fail_head)
 
 static bool pci_need_to_release(unsigned long mask, struct resource *res)
 {
+	/*
+	 * Separate three resource type checking if we need to release
+	 * assigned resource.
+	 *	1. if there is io port assign fail, will release assigned
+	 *	   io port.
+	 *	2. if there is pref mmio assign fail, release assigned
+	 *	   pref mmio.
+	 *	   if assigned pref mmio's parent is non-pref mmio and there
+	 *	   is non-pref mmio assign fail, will release that assigned
+	 *	   pref mmio.
+	 *	3. if there is non-pref mmio assign fail or pref mmio
+	 *	   assigned fail, will release assigned non-pref mmio.
+	 */
+
 	if (res->flags & IORESOURCE_IO)
 		return !!(mask & IORESOURCE_IO);
 
@@ -471,19 +485,8 @@ static void __assign_resources_sorted(struct list_head *head,
 	 *  if could do that, could get out early.
 	 *  if could not do that, we still try to assign requested at first,
 	 *    then try to reassign add_size for some resources.
-	 *
-	 * Separate three resource type checking if we need to release
-	 * assigned resource after requested + add_size try.
-	 *	1. if there is io port assign fail, will release assigned
-	 *	   io port.
-	 *	2. if there is pref mmio assign fail, release assigned
-	 *	   pref mmio.
-	 *	   if assigned pref mmio's parent is non-pref mmio and there
-	 *	   is non-pref mmio assign fail, will release that assigned
-	 *	   pref mmio.
-	 *	3. if there is non-pref mmio assign fail or pref mmio
-	 *	   assigned fail, will release assigned non-pref mmio.
 	 */
+
 	LIST_HEAD(save_head);
 	LIST_HEAD(local_fail_head);
 	struct pci_dev_resource *save_res;
-- 
1.8.4.5

